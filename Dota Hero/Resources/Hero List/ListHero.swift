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
    @objc dynamic var baseArmor:Double = 0
    @objc dynamic var baseAttackMax:Int = 0
    @objc dynamic var baseAttackMin:Int = 0
    @objc dynamic var baseHealth:Int = 0
    @objc dynamic var baseHealthRegen:Double = 0
    @objc dynamic var baseInt:Int = 0
    @objc dynamic var baseMana:Int = 0
    @objc dynamic var baseManaRegen:Double = 0
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
    @objc dynamic var moveSpeed:Int = 0
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
        secondPick = try container.decode(Int.self, forKey: .secondPick)
        secondWin = try container.decode(Int.self, forKey: .secondWin)
        thirdPick = try container.decode(Int.self, forKey: .thirdPick)
        thirdWin = try container.decode(Int.self, forKey: .thirdWin)
        forthPick = try container.decode(Int.self, forKey: .forthPick)
        forthWin = try container.decode(Int.self, forKey: .forthWin)
        fifthPick = try container.decode(Int.self, forKey: .fifthPick)
        fifthWin = try container.decode(Int.self, forKey: .fifthWin)
        sixthPick = try container.decode(Int.self, forKey: .sixthPick)
        sixthWin = try container.decode(Int.self, forKey: .sixthWin)
        seventhPick = try container.decode(Int.self, forKey: .seventhPick)
        seventhWin = try container.decode(Int.self, forKey: .seventhWin)
        eighthPick = try container.decode(Int.self, forKey: .eighthPick)
        eighthWin = try container.decode(Int.self, forKey: .eighthWin)
        nullPick = try container.decode(Int.self, forKey: .nullPick)
        nullWin = try container.decode(Int.self, forKey: .nullWin)
        agiGain = try container.decode(Double.self, forKey: .agiGain)
        attackRange = try container.decode(Int.self, forKey: .attackRange)
        attackRate = try container.decode(Double.self, forKey: .attackRate)
        attackType = try container.decode(String.self, forKey: .attackType)
        baseAgi = try container.decode(Int.self, forKey: .baseAgi)
        baseArmor = try container.decodeIfPresent(Double.self, forKey: .baseArmor) ?? 0
        baseAttackMax = try container.decode(Int.self, forKey: .baseAttackMax)
        baseAttackMin = try container.decode(Int.self, forKey: .baseAttackMin)
        baseHealth = try container.decode(Int.self, forKey: .baseHealth)
        baseHealthRegen = try container.decodeIfPresent(Double.self, forKey: .baseHealthRegen) ?? 0
        baseInt = try container.decode(Int.self, forKey: .baseInt)
        baseMana = try container.decode(Int.self, forKey: .baseMana)
        baseManaRegen = try container.decodeIfPresent(Double.self, forKey: .baseManaRegen) ?? 0
        baseMr = try container.decode(Int.self, forKey: .baseMr)
        baseStr = try container.decode(Int.self, forKey: .baseStr)
        cmEnabled = try container.decode(Bool.self, forKey: .cmEnabled)
        heroId = try container.decode(Int.self, forKey: .heroId)
        icon = try container.decode(String.self, forKey: .icon)
        id = try container.decode(Int.self, forKey: .id)
        img = try container.decode(String.self, forKey: .img)
        intGain = try container.decode(Double.self, forKey: .intGain)
        legs = try container.decode(Int.self, forKey: .legs)
        localizedName = try container.decode(String.self, forKey: .localizedName)
        moveSpeed = try container.decode(Int.self, forKey: .moveSpeed)
        name = try container.decode(String.self, forKey: .name)
        primaryAttr = try container.decode(String.self, forKey: .primaryAttr)
        proBan = try container.decode(Int.self, forKey: .proBan)
        proPick = try container.decode(Int.self, forKey: .proPick)
        proWin = try container.decode(Int.self, forKey: .proWin)
        projectileSpeed = try container.decode(Int.self, forKey: .projectileSpeed)
        let rolesArray = try container.decode([String].self, forKey: .roles)
        roles.append(objectsIn: rolesArray)
        strGain = try container.decode(Double.self, forKey: .strGain)
        turboPicks = try container.decode(Int.self, forKey: .turboPicks)
        turboWins = try container.decode(Int.self, forKey: .turboWins)
        turnRate = try container.decode(Double.self, forKey: .turnRate)
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
        case agiGain = "agiGain"
        case attackRange = "attackRange"
        case attackRate = "attackRate"
        case attackType = "attackType"
        case baseAgi = "baseAgi"
        case baseArmor = "baseArmor"
        case baseAttackMax = "baseAttackMax"
        case baseAttackMin = "baseAttackMin"
        case baseHealth = "baseHealth"
        case baseHealthRegen = "baseHealthRegen"
        case baseInt = "baseInt"
        case baseMana = "baseMana"
        case baseManaRegen = "baseManaRegen"
        case baseMr = "baseMr"
        case baseStr = "baseStr"
        case cmEnabled = "cmEnabled"
        case heroId = "heroId"
        case icon = "icon"
        case id = "id"
        case img = "img"
        case intGain = "intGain"
        case legs = "legs"
        case localizedName = "localizedName"
        case moveSpeed = "moveSpeed"
        case name = "name"
        case primaryAttr = "primaryAttr"
        case nullWin = "nullWin"
        case nullPick = "nullPick"
        case proBan = "proBan"
        case proPick = "proPick"
        case proWin = "proWin"
        case projectileSpeed = "projectileSpeed"
        case roles = "roles"
        case strGain = "strGain"
        case turboPicks = "turboPicks"
        case turboWins = "turboWins"
        case turnRate = "turnRate"
    }
    
}


