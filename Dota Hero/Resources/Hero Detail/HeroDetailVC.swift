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
    
    let containerView = UIImageView()
    let blurLayer = UIVisualEffectView()
    let imgBottom = UIImageView()
    
    var detailView = DetailView()
    var statsView = StatsView()
    
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
            self.delaySetup()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        containerView.isHidden = true
        blurLayer.isHidden = true
    }
    
    private func delaySetup(){
        guard let hero = hero else{return}
        
        view.addSubview(containerView)
        containerView.contentMode = .scaleAspectFill
        containerView.contentScaleFactor = 2
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.height.equalTo(UIScreen.main.bounds.width)
        }
        containerView.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.5))], completionHandler:  { result in
            self.showAfterBackground()
            
        })
        
        let blur = UIBlurEffect(style: .regular)
        blurLayer.effect = blur
        blurLayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurLayer)
        blurLayer.snp.makeConstraints { (make) in
            make.top.left.right.height.equalTo(containerView)
        }
    }
    
    private func showAfterBackground(){
        guard let hero = hero else{return}
        self.detailView = DetailView(hero: hero)
        self.blurLayer.contentView.addSubview(self.detailView)
        self.detailView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
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
