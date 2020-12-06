//
//  HeroDetailVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import UIKit
import Kingfisher

class HeroDetailVC: BaseVC, DetailActionProtocol {
    private var viewmodel: DetailModelProtocol
    var hero: Hero?
    let imgBottom = UIImageView()
    var heroProfile = HeroProfile()
    
    init() {
        self.viewmodel = HeroDetailVM()
        super.init(nibName: nil, bundle: nil)
        self.viewmodel.action = self
    }
    
    required init?(coder: NSCoder) {
        self.viewmodel = HeroDetailVM()
        super.init(coder: coder)
        self.viewmodel.action = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.profileSetup()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        heroProfile.isHidden = true
    }
    
    private func profileSetup(){
        guard let hero = hero else{return}
        
        heroProfile = HeroProfile(hero: hero)
        self.view.addSubview(heroProfile)
        heroProfile.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.height.equalTo(UIScreen.main.bounds.width)
        }
    }
    
    private func setup(){
        guard let hero = hero else{return}
        
        let titleImg = UIImageView()
        titleImg.kf.setImage(with: URL(string: Constants.ProductionServer.url + hero.icon))
        titleImg.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        self.navigationItem.titleView = titleImg
        
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(imgBottom)
        imgBottom.contentMode = .scaleAspectFit
        imgBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
        }
        imgBottom.image = #imageLiteral(resourceName: "logo_dota")
        
    }

}
