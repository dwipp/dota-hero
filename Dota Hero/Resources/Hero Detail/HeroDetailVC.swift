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
    let imgBottom = UIImageView()
    
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
        containerView.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.5))])
        
        let blur = UIBlurEffect(style: .regular)
        blurLayer.effect = blur
        blurLayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurLayer)
        blurLayer.snp.makeConstraints { (make) in
            make.top.left.right.height.equalTo(containerView)
        }
        
        blurLayer.contentView.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 5
        img.kf.setImage(with: URL(string: Constants.ProductionServer.url+hero.img), options: [.forceTransition, .transition(.fade(0.5))])
        img.snp.makeConstraints { (make) in
            make.top.equalTo(blurLayer.snp.top).offset(10)
            make.left.equalTo(blurLayer.snp.left).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        
    }
    
    private func setup(){
        guard let hero = hero else{return}
        
        self.title = hero.localizedName
        self.view.backgroundColor = .systemBackground
        
        view.addSubview(imgBottom)
        imgBottom.contentMode = .scaleAspectFit
        imgBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        imgBottom.image = #imageLiteral(resourceName: "logo_dota")
        
    }

}
