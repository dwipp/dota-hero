//
//  ErrorView.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation
import UIKit
import Lottie

protocol ErrorDelegate {
    func didTapReload()
}

class ErrorView:UIView {
    var delegate: ErrorDelegate?
    let lblmessage = UILabel()
    let btnReload = UIButton()
    let animationView = AnimationView()
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
    func setup(_ statusCode:Code){
        switch statusCode {
        case .error:
            lblmessage.text = NSLocalizedString("Something went wrong", comment: "")
            break
        case .noInternet:
            lblmessage.text = NSLocalizedString("No internet connection", comment: "")
            break
        case .empty:
            lblmessage.text = NSLocalizedString("No data available", comment: "")
            break
        default:
            break
        }
        
        addSubview(animationView)
        animationView.animation = Animation.named(statusCode.rawValue)
        animationView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        animationView.loopMode = .loop
        animationView.play()
        
        addSubview(lblmessage)
        lblmessage.font = UIFont.systemFont(ofSize: 16)
        lblmessage.textAlignment = .center
        lblmessage.snp.makeConstraints { (make) in
            make.top.equalTo(animationView.snp.bottom)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        addSubview(btnReload)
        btnReload.backgroundColor = .systemBlue
        btnReload.layer.cornerRadius = 5
        btnReload.setTitle(NSLocalizedString("Reload", comment: ""), for: .normal)
        btnReload.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        btnReload.snp.makeConstraints { (make) in
            make.top.equalTo(lblmessage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        btnReload.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
    }
    
    @objc func didTapReload(){
        delegate?.didTapReload()
    }
    
}
