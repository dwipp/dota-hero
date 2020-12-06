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
    let lblAgi = UILabel()
    let lblValueAgi = UILabel()
    let lblStr = UILabel()
    let lblValueStr = UILabel()
    let lblInt = UILabel()
    let lblValueInt = UILabel()
    let lblHealth = UILabel()
    let lblValueHealth = UILabel()
    let lblAttack = UILabel()
    let lblValueAttack = UILabel()
    let lblSpeed = UILabel()
    let lblValueSpeed = UILabel()
    let lblRoles = UILabel()
    let lblValueRoles = UILabel()
    
    var stats = [[UILabel]]()
    var detailView = DetailView()
    
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
        self.setupStats()
        
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
            self.generateStats(stats: self.stats)
        })
        
        let blur = UIBlurEffect(style: .regular)
        blurLayer.effect = blur
        blurLayer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurLayer)
        blurLayer.snp.makeConstraints { (make) in
            make.top.left.right.height.equalTo(containerView)
        }
    }
    
    private func setupStats(){
        guard let hero = hero else {return}
        
        lblAgi.text = NSLocalizedString("Agi", comment: "")
        lblValueAgi.text = "\(hero.baseAgi)"
        lblStr.text = NSLocalizedString("Str", comment: "")
        lblValueStr.text = "\(hero.baseStr)"
        lblInt.text = NSLocalizedString("Int", comment: "")
        lblValueInt.text = "\(hero.baseInt)"
        lblHealth.text = NSLocalizedString("Health", comment: "")
        lblValueHealth.text = "\(hero.baseHealth)"
        lblAttack.text = NSLocalizedString("Max Attack", comment: "")
        lblValueAttack.text = "\(hero.baseAttackMax)"
        lblSpeed.text = NSLocalizedString("Speed", comment: "")
        lblValueSpeed.text = "\(hero.moveSpeed)"
        lblRoles.text = NSLocalizedString("Roles", comment: "")
        lblValueRoles.text = "\(hero.roles.joined(separator: ", "))"
        
        stats = [
            [lblAgi, lblValueAgi],
            [lblStr, lblValueStr],
            [lblInt, lblValueInt],
            [lblHealth, lblValueHealth],
            [lblAttack, lblValueAttack],
            [lblSpeed, lblValueSpeed],
            [lblRoles, lblValueRoles]]
    }
    
    private func generateStats(stats:[[UILabel]]){
        for i in 0..<stats.count {
            stats[i][0].properties(parent: blurLayer.contentView, text: nil, size: 14, weight: .regular)
            stats[i][0].snp.makeConstraints { (make) in
                if i == 0 {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin).offset(10)
                }else {
                    make.top.equalTo(stats[i-1][0].snp.bottom).offset(5)
                }
                
                if UIScreen.main.bounds.width < 375 {
                    make.left.equalTo(detailView.snp.right).offset(30)
                }else if UIScreen.main.bounds.width < 414 {
                    make.left.equalTo(detailView.snp.right).offset(50)
                }else {
                    make.left.equalTo(detailView.snp.right).offset(70)
                }
                
                make.height.equalTo(18)
            }
            
            stats[i][1].textAlignment = .right
            stats[i][1].numberOfLines = 3
            stats[i][1].properties(parent: blurLayer.contentView, text: nil, size: 14, weight: .regular)
            stats[i][1].snp.makeConstraints { (make) in
                make.top.equalTo(stats[i][0])
                make.right.equalTo(stats[i][0].snp.left).inset(170)
                if stats[i][1] == lblValueRoles {
                    make.width.equalTo(110)
                }
            }
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
