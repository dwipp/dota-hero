//
//  ListVM.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import Alamofire

protocol ListActionProtocol {
    func afterFetchList(error:Error?)
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
        serveData()
        AF.request(APIRouter.heroList).responseDecodable(of: [ListHero].self, decoder: Utils().decoder) { response in
            switch response.result{
            case .success(let response):
                self.database.save(response)
                self.serveData()
                break
            case .failure(let error):
                print("error: \(error)")
                self.action?.afterFetchList(error: error)
                break
            }
        }
    }
    
    private func serveData(){
        self.data = self.database.fetch(ListHero.self)
        self.action?.afterFetchList(error: nil)
    }
    
}
