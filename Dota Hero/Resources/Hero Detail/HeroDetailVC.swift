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
    var delegate: DetailDelegate?
    var hero: Hero?
    let imgBottom = UIImageView()
    var heroProfile = HeroProfile()
    let lblSuggested = UILabel()
    var collection: UICollectionView?
    
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
    
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.willTransition(to: newCollection, with: coordinator)
//        let isLandscape = UIDevice.current.orientation.isLandscape
//        collection?.snp.updateConstraints({ (update) in
//            if isLandscape {
//                update.right.equalToSuperview()
//                update.top.equalToSuperview()
////                make.left.equalTo(heroProfile.statsView.snp.right).offset(10)
//            }else {
//                update.bottom.left.right.equalToSuperview()
//            }
//            update.height.equalTo(130)
//        })
//    }
    
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
    
    private func collectionSetup(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 1
        if UIScreen.main.bounds.width < 375 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }else if UIScreen.main.bounds.width < 414 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        }else {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        }
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection?.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collection?.backgroundColor = .clear
        heroProfile.blurLayer.contentView.addSubview(collection!)
        collection?.delegate = self
        collection?.dataSource = self
        collection?.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(130)
        }
        
        lblSuggested.properties(parent: heroProfile.blurLayer.contentView, text: "Suggested Heroes", size: 18, weight: .regular)
        lblSuggested.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalTo(collection!.snp.top)
            make.height.equalTo(22)
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
    
    func afterFetchSuggestedHeroes() {
        print("dapat: \(self.viewmodel.heroes)")
        self.collection?.reloadData()
    }

}

extension HeroDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hero: \(self.viewmodel.heroes.count)")
        return self.viewmodel.heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCell
        cell.hideSkeleton()
        cell.setImage(Constants.ProductionServer.url+self.viewmodel.heroes[indexPath.row].img)
        cell.lblAttackType.text = self.viewmodel.heroes[indexPath.row].attackType
        cell.lblName.text = self.viewmodel.heroes[indexPath.row].localizedName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = self.viewmodel.heroes[indexPath.row]
        self.navigationController?.popViewController(animated: false)
        self.delegate?.didSelectSuggested(selectedHero.id)
    }
}
