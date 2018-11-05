//
//  File.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit
import SnapKit

struct TNPColorsTheme {
    var DEFAULT: UIColor
    var ACTIVE: UIColor
    var DONE: UIColor
}

enum StyleTypeTextField: Int {
    case normal, brand_dark
    var titleColors: TNPColorsTheme {
        switch self {
        case .normal: return TNPColorsTheme.init(DEFAULT: UIColor.blackFade, ACTIVE: UIColor.blackDefault, DONE: UIColor.blackDefault);
        case .brand_dark: return TNPColorsTheme.init(DEFAULT: UIColor.whiteFade, ACTIVE: UIColor.whiteFade, DONE: UIColor.whiteDefautl);
        }
    }
    var textColors: TNPColorsTheme {
        switch self {
        case .normal: return TNPColorsTheme(DEFAULT: UIColor.blackFadeLight, ACTIVE: UIColor.blackDefault, DONE: UIColor.blueDark);
        case .brand_dark: return TNPColorsTheme.init(DEFAULT: UIColor.whiteFade, ACTIVE: UIColor.whiteFade, DONE: UIColor.whiteDefautl);
        }
    }
    var bgColors: UIColor {
        switch self {
        case .normal:
            return UIColor.white
        case .brand_dark:
            return UIColor.blueDark
        }
    }
}
class TNPTextField: UITextField {
    
    let tnp_title : UILabel = UILabel()
    var global_type: StyleTypeTextField = StyleTypeTextField.normal
    
    required init(label: String, placeholder: String = "Enter here", style: StyleTypeTextField = StyleTypeTextField.normal) {
        super.init(frame:.zero)
        
//        GLOBAL TYPE SETTING
        self.global_type = style
        
//       Setting value TITLE AND PLACEHOLDER
        self.tnp_title.text = label
        self.addSubview(tnp_title)
        
//       STYLE SETTING
        self.setView(placeholder: placeholder, type: style)
        self.setTypedDesign(stage: 0)
        
//       CONSTRAINTS
        tnp_title.snp.makeConstraints { (make) in
            make.leading.equalTo(self.snp.leading).offset(15)
            make.trailing.equalTo(self.snp.trailing).offset(15)
            make.top.equalTo(self.snp.top).offset(10)
        }
    }
    
//    DESIGN TYPE STATE SETTING
    func setTypedDesign(stage: Int = 0 ) {
        self.backgroundColor = global_type.bgColors
        self.tnp_title.textColor = (stage == 2) ? global_type.titleColors.DONE : (stage == 1 ) ? global_type.titleColors.ACTIVE : global_type.titleColors.DEFAULT
        self.textColor = ((stage == 2) ? global_type.textColors.DONE : (stage == 1 ) ? global_type.textColors.ACTIVE : global_type.textColors.DEFAULT)
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = (stage == 1) ? 0.0 : 1.0
        animation.toValue = (stage == 1) ? 1.0 : 0.0
        animation.duration = 0.3
        self.layer.add(animation, forKey: animation.keyPath)
        self.layer.shadowOpacity = (stage == 1) ? 1.0 : 0.0
    }
    
    
//    SHADOWS
    func setView(placeholder: String, type: StyleTypeTextField){
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: type.textColors.DEFAULT])
        self.tnp_title.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        self.layer.shadowOpacity = 0.0
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.blackFadeLight.cgColor
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 10;
        self.layer.shadowOffset = CGSize(width: 0 , height: 10)
        self.layer.masksToBounds = false;
    }
    
    
//    TEXTFIELD RESIGN
    override func becomeFirstResponder() -> Bool {
        self.setTypedDesign(stage: 1)
        super.becomeFirstResponder()
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        if (!self.text!.isEmpty) {
            self.setTypedDesign(stage: 2)
        } else {
            self.setTypedDesign(stage: 0)
        }
        super.resignFirstResponder()
        return true
    }
    
    
//    PADDINGS
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 15 , y: 27, width: self.frame.width - 20, height: self.frame.height)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 15, y: 13, width: self.frame.width - 20 , height: self.frame.height)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 15, y: 27, width: self.frame.width - 20, height: self.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


