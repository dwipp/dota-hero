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
    var role = NSLocalizedString("All", comment: "") {
        didSet {
            btnFilter.title = role
            self.viewmodel.fetchList(withRole: role)
            self.collection?.reloadData()
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
        self.viewmodel.fetchList()
    }
    
    private func setup(){
        self.title = NSLocalizedString("Heroes of Dota", comment: "")
        self.navigationItem.backButtonTitle = ""
        
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
        self.navigationItem.rightBarButtonItem = btnFilter
    }
    
    @objc func didTapRoles(_ sender:UIButton){
        let roles = RolesVC()
        roles.selectedRole = role
        roles.delegate = self
        let nav = UINavigationController(rootViewController: roles)
        self.navigationController?.present(nav, animated: true, completion: nil)
    }
    
    func afterFetchList(statusCode: Code) {
        errorView.setup(statusCode)
        switch statusCode {
        case .error, .noInternet, .empty:
            if self.viewmodel.data.count == 0 {
                self.collection?.backgroundView = errorView
            }
            break
        default:
            self.collection?.backgroundView = nil
            self.collection?.reloadData()
            break
        }
        
    }
    
    func didTapReload() {
        self.viewmodel.fetchList()
    }

}

extension ListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.viewmodel.data.count > 0 {
            return self.viewmodel.data.count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HeroCell
        if self.viewmodel.data.count > 0 {
            cell.hideSkeleton()
            cell.setImage(Constants.ProductionServer.url+self.viewmodel.data[indexPath.row].img)
            cell.lblAttackType.text = self.viewmodel.data[indexPath.row].attackType
            cell.lblName.text = self.viewmodel.data[indexPath.row].localizedName
        }else {
            cell.showAnimatedGradientSkeleton()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = self.viewmodel.data[indexPath.row]
        let vc = HeroDetailVC()
        vc.hero = hero
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
}

extension ListVC: RolesDelegate {
    func rolesDidSelect(_ role: String) {
        self.role = role
    }
}