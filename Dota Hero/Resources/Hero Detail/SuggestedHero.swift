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
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(22)
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 1
        
        if Utils().deviceWidth < 375 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }else if Utils().deviceWidth < 414 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
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
        collection?.snp.makeConstraints { (make) in
            make.top.equalTo(self.lblSuggested.snp.bottom)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin)
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
        if Utils().deviceWidth < 375 {
            return CGSize(width: 70, height: 84)
        }else if Utils().deviceWidth < 414 {
            return CGSize(width: 80, height: 96)
        }else {
            return CGSize(width: 100, height: 120)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedHero = self.heroes[indexPath.row]
        self.delegate?.suggested(didSelectHero: selectedHero.id)
    }
}
