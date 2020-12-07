//
//  RolesVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import UIKit

class RolesVC: BaseVC, RolesActionProtocol {
    var delegate: RolesDelegate?
    var viewmodel: RolesModelProtocol
    let tableview = UITableView()
    var selectedRole = NSLocalizedString("All", comment: "")
    
    init() {
        self.viewmodel = RolesVM()
        super.init(nibName: nil, bundle: nil)
        self.viewmodel.action = self
    }
    
    required init?(coder: NSCoder) {
        self.viewmodel = RolesVM()
        super.init(coder: coder)
        self.viewmodel.action = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.viewmodel.fetchRoles()
    }
    
    private func setup(){
        self.title = NSLocalizedString("Filter by Role", comment: "")
        
        view.addSubview(tableview)
        tableview.tableFooterView = UIView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.topMargin)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    func afterFetchRoles() {
        self.tableview.reloadData()
    }
    
}

extension RolesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewmodel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(self.viewmodel.data[indexPath.row])"
        if selectedRole == self.viewmodel.data[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.rolesDidSelect(self.viewmodel.data[indexPath.row])
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
}
