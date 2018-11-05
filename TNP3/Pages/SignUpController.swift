
//
//  SignInController.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit
import SnapKit

class SignUpContrroller: UIViewController {
    
    
    
    let box:UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    let tnpImage: UIImageView = {
        let image = UIImageView(image:UIImage(named:"tnp_logo_white"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let welcomeTitle:UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    let emailField:TNPTextField = {
        let textfield = TNPTextField(label: "Email", placeholder: "Enter your email", style: StyleTypeTextField.brand_dark)
        textfield.keyboardType = UIKeyboardType.emailAddress
        return textfield
    }()
    
    let password:TNPTextField = {
        let textfiedl = TNPTextField(label: "Password", placeholder: "Your sercret password", style: StyleTypeTextField.brand_dark)
        textfiedl.isSecureTextEntry = true
        return textfiedl
    }()
    
    let password2:TNPTextField = {
        let textfiedl = TNPTextField(label: "Repeat Password", placeholder: "Repeat your password", style: StyleTypeTextField.brand_dark)
        textfiedl.isSecureTextEntry = true
        return textfiedl
    }()
    
    let getStartedBtn: TNPButton = {
        let btn = TNPButton(title: "Get Started", type: StyleType.white)
        btn.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        return btn
    }()
    
    let signUpLabel: UILabel = {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = "Do you have an account?"
        lbl.textColor = UIColor.whiteFade
        return lbl
    }()
    
    let signUpbtn: UIButton = {
        var btn = UIButton(frame: CGRect.zero)
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        btn.addTarget(self, action: #selector(getStartedTapped), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueDark
        //        self.box.backgroundColor = UIColor.red
        self.view.addSubview(box)
        self.view.addSubview(tnpImage)
        self.view.addSubview(welcomeTitle)
        self.box.addSubview(emailField)
        self.box.addSubview(password)
        self.box.addSubview(password2)
        self.box.addSubview(getStartedBtn)
        self.box.addSubview(signUpLabel)
        self.box.addSubview(signUpbtn)
        
        box.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
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
            make.top.equalTo(box.snp.top)
        }
        
        welcomeTitle.snp.makeConstraints { (make) in
            make.top.equalTo(tnpImage.snp.bottom).offset(10)
            make.left.equalTo(box.snp.left)
            make.right.equalTo(box.snp.right)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(15)
            make.height.equalTo(70)
            make.left.equalTo(box.snp.left).offset(-15)
            make.right.equalTo(box.snp.right).offset(15)
        }
        
        password.snp.makeConstraints { (make) in
            make.top.equalTo(emailField.snp.bottom).offset(5)
            make.height.equalTo(70)
            make.left.equalTo(box.snp.left).offset(-15)
            make.right.equalTo(box.snp.right).offset(15)
        }
        
        password2.snp.makeConstraints { (make) in
            make.top.equalTo(password.snp.bottom).offset(5)
            make.height.equalTo(70)
            make.left.equalTo(box.snp.left).offset(-15)
            make.right.equalTo(box.snp.right).offset(15)
        }
        
        getStartedBtn.snp.makeConstraints { (make) in
            make.top.equalTo(password2.snp.bottom).offset(10)
            make.left.equalTo(box.snp.left)
            make.width.equalTo(170)
        }
        
        signUpLabel.snp.makeConstraints { (make) in
            make.top.equalTo(getStartedBtn.snp.bottom).offset(20)
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
        let mainController = SignInContrroller()
        self.show(mainController, sender: nil)
    }
    
    @objc func signUpTapped(sender: UIButton!) {
        let mainController = SignInContrroller()
        self.show(mainController, sender: nil)
    }
}
