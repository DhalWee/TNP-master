//
//  ViewController.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit
import SnapKit

class WelcomeController: UIViewController {
    
    let signInBtn: TNPButton = {
        let btn = TNPButton(title: "Sign In", type: StyleType.brand)
        btn.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return btn
    }()
    
    let signUpBtn: TNPButton = {
        let btn = TNPButton(title: "Sign Up", type: StyleType.brandFade)
        btn.addTarget(self, action: #selector(sigUpTapped), for: .touchUpInside)
        return btn
    }()

    
    let welcomeBox: UIView = {
        let view = UIView()
        return view
    }()
    
    let tnpImage: UIImageView = {
        let image = UIImageView(image:UIImage(named:"tnp_logo"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let welcomeTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.fontBold
        label.text = "Welcome to TNP"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
       
        self.view.addSubview(welcomeBox)
        self.welcomeBox.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalTo(self.view.snp.centerY)
        }

        self.welcomeBox.addSubview(tnpImage)
        self.welcomeBox.addSubview(welcomeTitle)
        self.welcomeBox.addSubview(signInBtn)
        self.welcomeBox.addSubview(signUpBtn)

        self.tnpImage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(self.welcomeBox.snp.top)
            make.height.equalTo(151)
            make.width.equalTo(100)
        }

        self.welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(tnpImage.snp.bottom).offset(20)
            make.width.equalTo(welcomeBox.snp.width)
        }
        
        self.signInBtn.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(20)
            make.width.equalTo(welcomeBox.snp.width)
        }
        
        self.signUpBtn.snp.makeConstraints { (make) in
            make.top.equalTo(signInBtn.snp.bottom).offset(10)
            make.width.equalTo(welcomeBox.snp.width)
            make.bottom.equalTo(welcomeBox.snp.bottom)
        }
    }
    
    
    @objc func signInTapped(sender: UIButton!) {
        self.show(SignInContrroller(), sender: nil)
    }
    
    @objc func sigUpTapped(sender: UIButton!) {
        self.show(SignUpContrroller(), sender: nil)
    }
    
    
    
    
    
    
    
    
}

