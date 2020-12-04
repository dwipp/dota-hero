//
//  ListVC.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import UIKit

class ListVC: BaseVC, ListActionProtocol {
    var viewmodel: ListModelProtocol
    
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
        self.viewmodel.fetchList()
    }
    
    func afterFetchList(error: Error?) {
        print("yey: \(error)")
    }

}
