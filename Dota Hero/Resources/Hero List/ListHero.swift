//
//  List.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import RealmSwift

class ListHero: Object, Decodable {
    @objc dynamic var firstPick:Int = 0
    @objc dynamic var firstWin:Int = 0
    @objc dynamic var secondPick:Int = 0
    @objc dynamic var secondWin:Int = 0
    @objc dynamic var thirdPick:Int = 0
    @objc dynamic var thirdWin:Int = 0
    @objc dynamic var forthPick:Int = 0
    @objc dynamic var forthWin:Int = 0
    @objc dynamic var fifthPick:Int = 0
    @objc dynamic var fifthWin:Int = 0
    @objc dynamic var sixthPick:Int = 0
    @objc dynamic var sixthWin:Int = 0
    @objc dynamic var seventhPick:Int = 0
    @objc dynamic var seventhWin:Int = 0
    @objc dynamic var eighthPick:Int = 0
    @objc dynamic var eighthWin:Int = 0
    @objc dynamic var agiGain:Double = 0
    @objc dynamic var attackRange:Int = 0
    @objc dynamic var attackRate:Double = 0
    @objc dynamic var attackType:String = ""
    @objc dynamic var baseAgi:Int = 0
    @objc dynamic var baseArmor:Int = 0
    @objc dynamic var baseAttackMax:Int = 0
    @objc dynamic var baseAttackMin:Int = 0
    @objc dynamic var baseHealth:Int = 0
    @objc dynamic var baseHealthRegen:Int = 0
    @objc dynamic var baseInt:Int = 0
    @objc dynamic var baseMana:Int = 0
    @objc dynamic var baseManaRegen:Int = 0
    @objc dynamic var baseMr:Int = 0
    @objc dynamic var baseStr:Int = 0
    @objc dynamic var cmEnabled:Bool = false
    @objc dynamic var heroId:Int = 0
    @objc dynamic var icon:String = ""
    @objc dynamic var id:Int = 0
    @objc dynamic var img:String = ""
    @objc dynamic var intGain:Double = 0
    @objc dynamic var legs:Int = 0
    @objc dynamic var localizedName:String = ""
    @objc dynamic var moveSped:Int = 0
    @objc dynamic var name:String = ""
    @objc dynamic var nullPick:Int = 0
    @objc dynamic var nullWin:Int = 0
    @objc dynamic var primaryAttr:String = ""
    @objc dynamic var proBan:Int = 0
    @objc dynamic var proPick:Int = 0
    @objc dynamic var proWin:Int = 0
    @objc dynamic var projectileSpeed:Int = 0
    var roles = List<String>()
    @objc dynamic var strGain:Double = 0
    @objc dynamic var turboPicks:Int = 0
    @objc dynamic var turboWins:Int = 0
    @objc dynamic var turnRate:Double = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init(from decoder:Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstPick = try container.decode(Int.self, forKey: .firstPick)
        firstWin = try container.decode(Int.self, forKey: .firstWin)
        id = try container.decode(Int.self, forKey: .id)
        localizedName = try container.decode(String.self, forKey: .localizedName)
        let rolesArray = try container.decode([String].self, forKey: .roles)
        roles.append(objectsIn: rolesArray)
    }
    
    private enum CodingKeys: String, CodingKey {
        case firstPick = "1Pick"
        case firstWin = "1Win"
        case secondPick = "2Pick"
        case secondWin = "2Win"
        case thirdPick = "3Pick"
        case thirdWin = "3Win"
        case forthPick = "4Pick"
        case forthWin = "4Win"
        case fifthPick = "5Pick"
        case fifthWin = "5Win"
        case sixthPick = "6Pick"
        case sixthWin = "6Win"
        case seventhPick = "7Pick"
        case seventhWin = "7Win"
        case eighthPick = "8Pick"
        case eighthWin = "8Win"
        case id = "id"
        case localizedName = "localizedName"
        case roles = "roles"
    }
    
}


