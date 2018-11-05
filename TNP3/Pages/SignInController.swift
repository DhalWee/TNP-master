
//
//  SignInController.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit
import SnapKit

class SignInContrroller: UIViewController {
    
    let box:UIView = {
        let view = UIView(frame: .zero)
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
        label.text = "Sign In"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    
    let emailField:TNPTextField = {
        let textfield = TNPTextField(label: "Email", placeholder: "Enter your email", style: StyleTypeTextField.normal)
        textfield.keyboardType = UIKeyboardType.emailAddress
        return textfield
    }()
    
    let password:TNPTextField = {
        let textfiedl = TNPTextField(label: "Password", placeholder: "Your sercret password", style: StyleTypeTextField.normal)
        textfiedl.isSecureTextEntry = true
        return textfiedl
    }()
    
    let getStartedBtn: TNPButton = {
        let btn = TNPButton(title: "Get Started", type: StyleType.brandFade)
        btn.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        return btn
    }()
    
    let signUpLabel: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = "Don’t have an account?"
        lbl.textColor = UIColor.blackFade
        return lbl
    }()
    
    let signUpbtn: UIButton = {
        var btn = UIButton(frame: CGRect.zero)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor.blueDark, for: .normal)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
//        self.box.backgroundColor = UIColor.red
        self.view.addSubview(box)
        self.view.addSubview(tnpImage)
        self.view.addSubview(welcomeTitle)
        self.box.addSubview(emailField)
        self.box.addSubview(password)
        self.box.addSubview(getStartedBtn)
        self.box.addSubview(signUpLabel)
        self.box.addSubview(signUpbtn)

        box.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(270)
            make.centerX.equalToSuperview()
            make.height.greaterThanOrEqualTo(10)
//            make.leading.equalToSuperview().offset(60)
//            make.trailing.equalToSuperview().offset(-60)
        }
        
        tnpImage.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.width.equalTo(40)
            make.left.equalTo(box.snp.left)
            make.top.equalTo(box.snp.top).offset(50)
        }
        
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(tnpImage.snp.bottom).offset(10)
            make.left.equalTo(box.snp.left)
            make.right.equalTo(box.snp.right)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(60)
            make.height.equalTo(70)
            make.left.equalTo(box.snp.left).offset(-15)
            make.right.equalTo(box.snp.right).offset(15)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(10)
            make.height.equalTo(70)
            make.left.equalTo(box.snp.left).offset(-15)
            make.right.equalTo(box.snp.right).offset(15)
        }
        getStartedBtn.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(20)
            make.left.equalTo(box.snp.left)
            make.width.equalTo(170)
        }
        
        signUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(getStartedBtn.snp.bottom).offset(30)
            make.left.equalTo(box.snp.left)
            make.right.equalTo(box.snp.right)
        }
        signUpbtn.snp.makeConstraints { (make) in
            make.top.equalTo(signUpLabel.snp.bottom).offset(0)
            make.height.equalTo(40)
            make.left.equalTo(box.snp.left)
            make.width.equalTo(100)
            make.bottom.equalTo(box.snp.bottom)
        }
    }
    
    
    
    @objc func getStartedTapped(sender: UIButton!) {
        let mainController = UINavigationController(rootViewController: MainController())
        self.show(mainController, sender: nil)
    }
    
    @objc func signUpTapped(sender: UIButton!) {
        let mainController = SignUpContrroller()
        self.show(mainController, sender: nil)
    }
}
