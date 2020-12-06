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
            self.suggestedSetup()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        heroProfile.isHidden = true
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
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        print("isLandscape: \(UIWindow.isLandscape)")
        profileConstraint(isLandscape: UIWindow.isLandscape)
        suggestedConstraint(isLandscape: !UIWindow.isLandscape)
    }
    
    private func profileSetup(){
        guard let hero = hero else{return}
        
        heroProfile = HeroProfile(hero: hero)
        self.view.addSubview(heroProfile)
        profileConstraint(isLandscape: UIWindow.isLandscape)
    }
    
    private func profileConstraint(isLandscape:Bool){
        heroProfile.snp.remakeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            let landscapeHeight = (UIScreen.main.bounds.height/2) + 10
            print("landscapeHeight: \(landscapeHeight)")
            let portraitHeight = (UIScreen.main.bounds.width/2) + 10
            print("portraitHeight: \(portraitHeight)")
            make.height.equalTo(isLandscape ? landscapeHeight : portraitHeight)
        }
    }
    
    func suggestedSetup(){
        suggestedView = SuggestedHero(heroes: self.viewmodel.heroes)
        suggestedView.delegate = self
        self.view.addSubview(suggestedView)
        suggestedConstraint(isLandscape: UIWindow.isLandscape)
    }
    
    func suggestedConstraint(isLandscape:Bool){
        suggestedView.snp.remakeConstraints { (make) in
            make.top.equalTo(isLandscape ? self.view.safeAreaLayoutGuide.snp.topMargin : self.heroProfile.snp.bottom).offset(10)
            if isLandscape {
                make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            }else {
                make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            }
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

