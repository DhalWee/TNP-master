//
//  ProfileViewController.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/30/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController {
    
    var cell_info: UIView = {
        var cell = UIView(frame: CGRect.zero)
        cell.backgroundColor = UIColor.white
        return cell
    }()
    
    var img_info = UIImageView(image: UIImage(named: "info"))
    var label_info = UILabel(frame: CGRect.zero)
    
    var box: UIView = {
        var box = UIView()
        box.backgroundColor = UIColor.white
        return box
    }()
    
    var userLogo: UIImageView = {
        var image = UIImageView(image:UIImage(named:"user"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var full_name: UILabel = {
        var lbl = UILabel()
        lbl.text = "Alisher Toleberdyyev"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return lbl
    }()
    
    var email: UILabel = {
        var lbl = UILabel()
        lbl.text = "fredcolin079@gmail.com"
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueFadeLight
        

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        self.view.addSubview(box)
        self.box.addSubview(userLogo)
        self.box.addSubview(full_name)
        self.box.addSubview(email)
        
        
        box.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        userLogo.snp.makeConstraints { (make) in
            make.top.equalTo(box).offset(150)
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.centerX.equalTo(box)
        }
        
        full_name.snp.makeConstraints { (make) in
            make.top.equalTo(userLogo.snp.bottom).offset(20)
            make.centerX.equalTo(box)
            make.width.equalTo(270)
        }
        
        email.snp.makeConstraints { (make) in
            make.top.equalTo(full_name.snp.bottom).offset(2)
            make.centerX.equalTo(box)
            make.width.equalTo(270)
            make.bottom.equalTo(box).inset(100)
        }
        
    }
    
    
}
