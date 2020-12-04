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
}

class ListVM: ListModelProtocol {
    var action: ListActionProtocol?
    
    func fetchList() {
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        AF.request(APIRouter.heroList).responseDecodable(of: [ListHero].self, decoder: decoder) { response in
            switch response.result{
            case .success(let response):
                print("response: \(response)")
                self.action?.afterFetchList(error: nil)
                break
            case .failure(let error):
                print("error: \(error)")
                self.action?.afterFetchList(error: error)
                break
            }
        }
    }
    
}
