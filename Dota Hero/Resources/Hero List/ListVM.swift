//
//  ListVM.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import Alamofire

protocol ListActionProtocol {
    func afterFetchList(statusCode:Code)
    func afterfetchHero(hero:Hero?)
}

protocol ListModelProtocol {
    var action: ListActionProtocol? {get set}
    func fetchList()
    func fetchList(withRole role:String)
    func fetchHero(with id:Int)
    var data:[Hero] {get}
}

class ListVM: ListModelProtocol {
    var action: ListActionProtocol?
    private (set) var data = [Hero]()
    private var database = Database()
    
    func fetchList() {
        serveData(isCache: true)
        guard Utils().isReachable() else {
            // no internet connection
            self.action?.afterFetchList(statusCode: Code.noInternet)
            return
        }
        AF.request(APIRouter.heroList).responseDecodable(of: [Hero].self, decoder: Utils().decoder) { response in
            switch response.result{
            case .success(let response):
                self.database.save(response)
                self.serveData(isCache: false)
                break
            case .failure(_):
                self.action?.afterFetchList(statusCode: Code.error)
                break
            }
        }
    }
    
    func fetchList(withRole role: String) {
        data = database.fetch(Hero.self)
        if role != NSLocalizedString("All", comment: "") {
            data = data.filter{$0.roles.contains(role)}
        }
        self.action?.afterFetchList(statusCode: Code.success)
    }
    
    private func serveData(isCache:Bool){
        self.data = self.database.fetch(Hero.self)
        if self.data.count == 0 && isCache {
            self.action?.afterFetchList(statusCode: Code.success)
        }else if self.data.count == 0 {
            self.action?.afterFetchList(statusCode: Code.empty)
        }else {
            self.action?.afterFetchList(statusCode: Code.success)
        }
    }
    
    func fetchHero(with id: Int) {
        let hero = database.fetch(Hero.self, with: id)
        self.action?.afterfetchHero(hero: hero)
    }
    
}
