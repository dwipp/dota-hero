//
//  HeroDetailVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import UIKit
import Kingfisher

class HeroDetailVC: BaseVC, DetailActionProtocol, SuggestedDelegate {
    private var viewmodel: DetailModelProtocol
    var delegate: DetailDelegate?
    var hero: Hero?
    let imgBottom = UIImageView()
    var heroProfile = HeroProfile()
    var suggestedView = SuggestedHero()
    
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
            self.collectionSetup()
        }
    }
    /*
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        heroProfile.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            let landscapeHeight = (UIScreen.main.bounds.height/2) + 10
            let portraitHeight = (UIScreen.main.bounds.width/2) + 10
            make.height.equalTo(isLandscape ? landscapeHeight : portraitHeight)
        }
        
//        collection?.snp.makeConstraints { (make) in
//            if isLandscape {
//                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(10)
//                make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin).inset(10)
//                make.left.greaterThanOrEqualToSuperview()
//            }else {
//                make.top.equalTo(isLandscape ? self.view.safeAreaLayoutGuide.snp.topMargin : self.lblSuggested.snp.bottom).offset(10)
//                make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
//                make.right.greaterThanOrEqualToSuperview()
//            }
//
//        }
    }
    */
    override func viewWillDisappear(_ animated: Bool) {
        heroProfile.isHidden = true
    }
    
    private func profileSetup(){
        guard let hero = hero else{return}
        
        let isLandscape = UIDevice.current.orientation.isLandscape
        heroProfile = HeroProfile(hero: hero)
        self.view.addSubview(heroProfile)
        heroProfile.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            let landscapeHeight = (UIScreen.main.bounds.height/2) + 10
            let portraitHeight = (UIScreen.main.bounds.width/2) + 10
            make.height.equalTo(isLandscape ? landscapeHeight : portraitHeight)
        }
    }
    
    private func setup(){
        guard let hero = hero else{return}
        self.viewmodel.fetchSuggestedHeroes(by: hero)
        
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
    
    func collectionSetup(){
        suggestedView = SuggestedHero(heroes: self.viewmodel.heroes)
        suggestedView.delegate = self
        self.view.addSubview(suggestedView)
        suggestedView.snp.makeConstraints { (make) in
            make.top.equalTo(self.heroProfile.snp.bottom).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.lessThanOrEqualToSuperview()
            make.height.equalTo(180)
            make.width.equalTo(320)
        }
    }
    
    func afterFetchSuggestedHeroes() {
        print("dapat: \(self.viewmodel.heroes)")
        suggestedView.updateData(heroes: self.viewmodel.heroes)
        
    }
    
    func suggested(didSelectHero id: Int) {
        self.navigationController?.popViewController(animated: false)
        self.delegate?.didSelectSuggested(id)
    }

}
