//
//  SuggestedHero.swift
//  Dota Hero
//
//  Created by Dwi Putra on 06/12/20.
//

import UIKit

protocol SuggestedDelegate {
    func suggested(didSelectHero id:Int)
}

class SuggestedHero: UIView {
    var heroes:[Hero]
    let lblSuggested = UILabel()
    var collection: UICollectionView?
    var delegate: SuggestedDelegate?
    
    init() {
        self.heroes = []
        super.init(frame: CGRect.zero)
    }
    
    init(heroes:[Hero]) {
        self.heroes = heroes
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        self.heroes = []
        super.init(coder: coder)
    }
    
    func updateData(heroes: [Hero]){
        self.heroes = heroes
        collection?.reloadData()
    }
    
    private func setup(){
        lblSuggested.properties(parent: self, text: "Suggested Heroes", size: 18, weight: .regular)
        lblSuggested.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(22)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
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
        collection?.isScrollEnabled = false
        self.addSubview(collection!)
        collection?.delegate = self
        collection?.dataSource = self
        let isLandscape = UIDevice.current.orientation.isLandscape
        collection?.snp.makeConstraints { (make) in
            if isLandscape {
                make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(10)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.rightMargin).inset(10)
                make.left.greaterThanOrEqualToSuperview()
            }else {
                make.top.equalTo(self.lblSuggested.snp.bottom).offset(10)
                make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin)
                make.right.greaterThanOrEqualToSuperview()
            }
            make.height.equalTo(130)
            make.width.equalTo(320)
            
        }
    }
    
}

extension SuggestedHero: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("hero: \(self.heroes.count)")
        return self.heroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCell
        cell.hideSkeleton()
        cell.setImage(Constants.ProductionServer.url+self.heroes[indexPath.row].img)
        cell.lblAttackType.text = self.heroes[indexPath.row].attackType
        cell.lblName.text = self.heroes[indexPath.row].localizedName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = self.heroes[indexPath.row]
        self.delegate?.suggested(didSelectHero: selectedHero.id)
    }
}
