//
//  Database.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import RealmSwift

final class Database {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func save<T: Object>(_ objects: [T]) {
        try! realm.write{
            for object in objects {
                realm.add(object, update: .all)
            }
        }
        
    }
    
    func fetch<T: Object>(_ type: T.Type) -> [T] {
        let objects = realm.objects(type)
        var arrData = [T]()
        for data in objects {
            arrData.append(data)
        }
        return arrData
    }
    
    func delete<T: Object>(_ type:T.Type, with primaryKey:Int) {
        let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
        if let object = object {
            try! realm.write{
                realm.delete(object)
            }
        }
    }
    
    func deleteAllData(){
        try! realm.write{
            realm.deleteAll()
        }
    }
}
