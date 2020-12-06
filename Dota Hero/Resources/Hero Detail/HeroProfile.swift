//
//  DetailContainerView.swift
//  Dota Hero
//
//  Created by Dwi Putra on 06/12/20.
//

import UIKit

class HeroProfile: UIView {
    let hero: Hero
    let containerView = UIImageView()
    let blurLayer = UIVisualEffectView()
    var detailView = DetailView()
    var statsView = StatsView()
    
    init() {
        self.hero = Hero()
        super.init(frame: CGRect.zero)
    }
    
    init(hero: Hero) {
        self.hero = hero
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.hero = Hero()
        super.init(coder: coder)
    }
    
    private func setup(){
        self.addSubview(containerView)
        containerView.contentMode = .scaleAspectFill
        containerView.clipsToBounds = true
        containerView.contentScaleFactor = 2
        containerView.snp.makeConstraints { (make) in
            make.top.left.right.height.equalToSuperview()
        }
        containerView.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.5))], completionHandler:  { result in
            self.showAfterBackground()
            
        })
        
        let blur = UIBlurEffect(style: .regular)
        blurLayer.effect = blur
        blurLayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurLayer)
        blurLayer.snp.makeConstraints { (make) in
            make.top.left.right.height.equalToSuperview()
        }
    }

    private func showAfterBackground(){
        self.detailView = DetailView(hero: hero)
        self.blurLayer.contentView.addSubview(self.detailView)
        self.detailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(self.detailView.img.snp.width).offset(10)
            make.height.equalTo(self.blurLayer.snp.height)
        }
        
        self.statsView = StatsView(hero: hero)
        self.blurLayer.contentView.addSubview(self.statsView)
        self.statsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            if UIScreen.main.bounds.width < 375 {
                make.left.equalTo(self.detailView.snp.right).offset(30)
            }else if UIScreen.main.bounds.width < 414 {
                make.left.equalTo(self.detailView.snp.right).offset(50)
            }else {
                make.left.equalTo(self.detailView.snp.right).offset(70)
            }
            make.width.equalTo(170)
            make.height.equalTo(self.blurLayer.snp.height)
        }
    }
    
}
