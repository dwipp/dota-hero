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
}

protocol ListModelProtocol {
    var action: ListActionProtocol? {get set}
    func fetchList()
    var data:[ListHero] {get}
}

class ListVM: ListModelProtocol {
    var action: ListActionProtocol?
    private (set) var data = [ListHero]()
    private var database = Database()
    
    func fetchList() {
        serveData(isCache: true)
        guard Utils().isReachable() else {
            // no internet connection
            self.action?.afterFetchList(statusCode: Code.noInternet)
            return
        }
        AF.request(APIRouter.heroList).responseDecodable(of: [ListHero].self, decoder: Utils().decoder) { response in
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
    
    private func serveData(isCache:Bool){
        self.data = self.database.fetch(ListHero.self)
        if self.data.count == 0 && isCache {
            self.action?.afterFetchList(statusCode: Code.success)
        }else if self.data.count == 0 {
            self.action?.afterFetchList(statusCode: Code.empty)
        }else {
            self.action?.afterFetchList(statusCode: Code.success)
        }
    }
    
}
