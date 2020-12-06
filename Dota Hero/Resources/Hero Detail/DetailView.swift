//
//  DetailView.swift
//  Dota Hero
//
//  Created by Dwi Putra on 06/12/20.
//

import UIKit

class DetailView: UIView {
    let img = UIImageView()
    let lblName = UILabel()
    let lblAttackType = UILabel()
    let hero: Hero
    
    init() {
        self.hero = Hero()
        super.init(frame: CGRect.zero)
    }
    
    init(hero:Hero) {
        self.hero = hero
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        self.hero = Hero()
        super.init(coder: coder)
    }
    
    private func setup(){
        self.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 5
        self.img.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.2))])
        img.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            if UIScreen.main.bounds.width < 375 {
                make.width.equalTo(100)
                make.height.equalTo(100)
            }else if UIScreen.main.bounds.width < 414 {
                make.width.equalTo(130)
                make.height.equalTo(130)
            }else {
                make.width.equalTo(150)
                make.height.equalTo(150)
            }
        }
        
        self.lblName.properties(parent: self, text: hero.localizedName, size: 18, weight: .bold)
        self.lblName.adjustsFontSizeToFitWidth = true
        self.lblName.snp.makeConstraints { (make) in
            make.top.equalTo(self.img.snp.bottom).offset(10)
            make.left.equalTo(self.img.snp.left)
            make.height.equalTo(22)
            make.width.equalTo(self.img.snp.width)
        }
        
        self.lblAttackType.properties(parent: self, text: hero.attackType, size: 14, weight: .regular)
        self.lblAttackType.snp.makeConstraints { (make) in
            make.top.equalTo(self.lblName.snp.bottom).offset(2)
            make.left.equalTo(self.img.snp.left)
            make.height.equalTo(18)
        }
    }
    
}
