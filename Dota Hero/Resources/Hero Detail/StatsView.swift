//
//  StatsView.swift
//  Dota Hero
//
//  Created by Dwi Putra on 06/12/20.
//

import UIKit

class StatsView: UIView {
    let hero: Hero
    let lblAttr = UILabel()
    let lblValueAttr = UILabel()
    let lblHealth = UILabel()
    let lblValueHealth = UILabel()
    let lblAttack = UILabel()
    let lblValueAttack = UILabel()
    let lblSpeed = UILabel()
    let lblValueSpeed = UILabel()
    let lblRoles = UILabel()
    let lblValueRoles = UILabel()
    var stats = [[UILabel]]()
    
    init() {
        self.hero = Hero()
        super.init(frame: CGRect.zero)
    }
    
    init(hero:Hero) {
        self.hero = hero
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.hero = Hero()
        super.init(coder: coder)
    }
    
    private func setup(){
        lblAttr.text = NSLocalizedString("Attribute", comment: "")
        lblValueAttr.text = "\(hero.primaryAttr.value?.rawValue.uppercased() ?? NSLocalizedString("Unknown", comment: ""))"
        lblHealth.text = NSLocalizedString("Health", comment: "")
        lblValueHealth.text = "\(hero.baseHealth)"
        lblAttack.text = NSLocalizedString("Max Attack", comment: "")
        lblValueAttack.text = "\(hero.baseAttackMax)"
        lblSpeed.text = NSLocalizedString("Speed", comment: "")
        lblValueSpeed.text = "\(hero.moveSpeed)"
        lblRoles.text = NSLocalizedString("Roles", comment: "")
        lblValueRoles.text = "\(hero.roles.joined(separator: ", "))"
        
        stats = [
            [lblAttr, lblValueAttr],
            [lblHealth, lblValueHealth],
            [lblAttack, lblValueAttack],
            [lblSpeed, lblValueSpeed],
            [lblRoles, lblValueRoles]]
        
        generateStats(stats: stats)
    }
    
    private func generateStats(stats:[[UILabel]]){
        for i in 0..<stats.count {
            stats[i][0].properties(parent: self, text: nil, size: 14, weight: .regular)
            stats[i][0].snp.makeConstraints { (make) in
                if i == 0 {
                    make.top.equalTo(self.snp.top).offset(10)
                }else {
                    make.top.equalTo(stats[i-1][0].snp.bottom).offset(5)
                }
                make.left.equalTo(self.snp.left)
                
                make.height.equalTo(18)
            }
            
            stats[i][1].textAlignment = .right
            stats[i][1].numberOfLines = 0
            stats[i][1].properties(parent: self, text: nil, size: 14, weight: .regular)
            stats[i][1].snp.makeConstraints { (make) in
                make.top.equalTo(stats[i][0])
                make.right.equalToSuperview()
                if stats[i][1] == lblValueRoles {
                    make.width.equalTo(110)
                }
            }
        }
    }

}
