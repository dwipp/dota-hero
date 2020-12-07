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
    func fetchList(_ role:String)
    func fetchLocalList(isCache:Bool, role:String)
    func fetchHero(with id:Int)
    var data:[Hero] {get}
}

class ListVM: ListModelProtocol {
    var action: ListActionProtocol?
    private (set) var data = [Hero]()
    private var database = Database()
    
    func fetchList(_ role: String) {
        fetchLocalList(isCache: true, role: role)
        guard Utils().isReachable() else {
            // no internet connection
            self.action?.afterFetchList(statusCode: Code.noInternet)
            return
        }
        AF.request(APIRouter.heroList).responseDecodable(of: [Hero].self, decoder: Utils().decoder) { response in
            switch response.result{
            case .success(let response):
                self.database.save(response)
                self.fetchLocalList(isCache: false, role: role)
                break
            case .failure(_):
                self.action?.afterFetchList(statusCode: Code.error)
                break
            }
        }
    }
    
    func fetchLocalList(isCache:Bool, role:String){
        self.data = self.database.fetch(Hero.self)
        if role != NSLocalizedString("All", comment: "") {
            data = data.filter{$0.roles.contains(role)}
        }
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
