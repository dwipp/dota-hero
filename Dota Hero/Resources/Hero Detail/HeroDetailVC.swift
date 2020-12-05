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
    let img = UIImageView()
    
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
        self.title = hero?.localizedName
        self.view.backgroundColor = .systemBackground
//        self.viewmodel.fetchHero(heroID)
    }
    override func viewWillDisappear(_ animated: Bool) {
        containerView.isHidden = true
        blurLayer.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setup()
    }
    
    private func setup(){
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
        containerView.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.5))])
        
        let blur = UIBlurEffect(style: .regular)
        blurLayer.effect = blur
        blurLayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurLayer)
        blurLayer.snp.makeConstraints { (make) in
            make.top.left.right.height.equalTo(containerView)
        }
        
    }

}
