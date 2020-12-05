//
//  ListVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import UIKit
import SnapKit

class ListVC: BaseVC, ListActionProtocol, ErrorDelegate {
    var viewmodel: ListModelProtocol
    let tableview = UITableView()
    var errorView = ErrorView()
    
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
        self.title = "Heros of Dota"
        
        view.addSubview(tableview)
        tableview.tableFooterView = UIView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.bottom.right.equalToSuperview()
        }
        errorView = ErrorView(frame: self.tableview.bounds)
        errorView.delegate = self
    }
    
    func afterFetchList(statusCode: Code) {
        errorView.setup(statusCode)
        switch statusCode {
        case .error, .noInternet, .empty:
            self.tableview.backgroundView = errorView
            break
        default:
            self.tableview.backgroundView = nil
            self.tableview.reloadData()
            break
        }
        
    }
    
    func didTapReload() {
        self.viewmodel.fetchList()
    }

}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewmodel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1). \(self.viewmodel.data[indexPath.row].localizedName)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
