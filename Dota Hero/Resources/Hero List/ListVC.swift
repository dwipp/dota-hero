//
//  ListVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import UIKit
import SnapKit
import SkeletonView

class ListVC: BaseVC, ListActionProtocol, ErrorDelegate {
    var viewmodel: ListModelProtocol
    var collection:UICollectionView?
    var errorView = ErrorView()
    var btnFilter = UIBarButtonItem()
    let refreshControl = UIRefreshControl()
    var isError = false
    
    var role = NSLocalizedString("All", comment: "") {
        didSet {
            btnFilter.title = role
            self.viewmodel.fetchLocalList(isCache: false, role: role)
        }
    }
    
    init() {
        self.viewmodel = ListVM()
        super.init(nibName: nil, bundle: nil)
        self.viewmodel.action = self
    }
    
    required init?(coder: NSCoder) {
        self.viewmodel = ListVM()
        super.init(coder: coder)
        self.viewmodel.action = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.viewmodel.fetchList(role)
    }
    
    private func setup(){
        self.title = NSLocalizedString("Heroes of Dota", comment: "")
        self.navigationItem.backButtonTitle = ""
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 1
        if Utils().deviceWidth < 375 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        }else if Utils().deviceWidth < 414 {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        }else {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        }
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection?.register(UINib(nibName: "HeroCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collection?.backgroundColor = .clear
        view.addSubview(collection!)
        collection?.delegate = self
        collection?.dataSource = self
        collection?.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
        }
        errorView = ErrorView(frame: self.collection!.bounds)
        errorView.delegate = self
        
        btnFilter = UIBarButtonItem(title: role, style: .plain, target: self, action: #selector(self.didTapRoles(_:)))
        
        collection?.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh(){
        self.viewmodel.fetchList(role)
    }
    
    @objc func didTapRoles(_ sender:UIButton){
        let roles = RolesVC()
        roles.selectedRole = role
        roles.delegate = self
        let nav = UINavigationController(rootViewController: roles)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    func afterFetchList(statusCode: Code) {
        refreshControl.endRefreshing()
        errorView.setup(statusCode)
        isError = false
        switch statusCode {
        case .error, .noInternet, .empty:
            if self.viewmodel.data.count == 0 {
                isError = true
                self.collection?.backgroundView = errorView
                self.collection?.reloadData()
            }
            break
        default:
            if self.viewmodel.data.count > 0 {
                self.navigationItem.rightBarButtonItem = btnFilter
            }
            self.collection?.backgroundView = nil
            self.collection?.reloadData()
            break
        }
        
    }
    
    func didTapReload() {
        self.viewmodel.fetchList(role)
    }

}

extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewmodel.data.count > 0 {
            return self.viewmodel.data.count
        }else if isError {
            return 0
        }else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCell
        if self.viewmodel.data.count > 0 {
            cell.hideSkeleton()
            cell.setImage(Constants.ProductionServer.url+self.viewmodel.data[indexPath.row].img)
            cell.lblAttackType.text = self.viewmodel.data[indexPath.row].attackType
            cell.lblName.text = self.viewmodel.data[indexPath.row].localizedName
        }else if !isError {
            cell.showAnimatedGradientSkeleton()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.viewmodel.data.count > 0 {
            let hero = self.viewmodel.data[indexPath.row]
            let vc = HeroDetailVC()
            vc.hero = hero
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}

extension ListVC: RolesDelegate, DetailDelegate {
    func rolesDidSelect(_ role: String) {
        self.role = role
    }
    
    func didSelectSuggested(_ id: Int) {
        self.viewmodel.fetchHero(with: id)
    }
    
    func afterfetchHero(hero: Hero?) {
        guard let hero = hero else {
            return
        }
        let vc = HeroDetailVC()
        vc.hero = hero
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
