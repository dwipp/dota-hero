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
        btnReload.isHidden = false
        switch statusCode {
        case .error:
            lblmessage.text = "Something went wrong"
            break
        case .noInternet:
            lblmessage.text = "No internet connection"
            break
        case .empty:
            lblmessage.text = "No data available"
            btnReload.isHidden = true
            break
        default:
            break
        }
        
        addSubview(animationView)
        animationView.animation = Animation.named(statusCode.rawValue)
        animationView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.topMargin).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
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
        btnReload.setTitle("Reload", for: .normal)
        btnReload.snp.makeConstraints { (make) in
            make.top.equalTo(lblmessage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        btnReload.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
    }
    
    @objc func didTapReload(){
        delegate?.didTapReload()
    }
    
}
