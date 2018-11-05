//
//  TNPButton.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/24/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import UIKit

enum StyleType: Int {
    case normal, brand, brandFade, white
    
    var backgroundColor: UIColor {
        switch self {
        case .brand:
            return UIColor.blueDefault
        case .brandFade:
            return UIColor.blueFadeLight
        case .normal:
            return UIColor.blackFadeLight
        case .white:
            return UIColor.whiteFadeLight
        }
    }
    
    var tintColor : UIColor {
        switch self {
        case .brand:
            return .white
        case .brandFade:
            return UIColor.blueDefault
        case .normal:
            return UIColor.blackDefault
        case .white:
            return UIColor.white
        }
    }
    
}



class TNPButton: UIButton {

    let borderRadius = CGFloat(integerLiteral: 7)

    required init(title: String , icon: UIImage = UIImage() , type: StyleType , shadow: Bool = false ) {
        super.init(frame: .zero)
        
        
        //tint
        self.tintColor = type.tintColor
        
        // radius
        self.layer.cornerRadius = self.borderRadius;
        
        // tint and background
        self.backgroundColor = type.backgroundColor
        
        // title
        self.setTitle(title, for: UIControl.State.normal)
//        self.setTitleColor(UIColor.gray, for: .highlighted)
        self.contentEdgeInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        //icon
        let btnIcon = icon.withRenderingMode(.alwaysTemplate)
        self.setImage(btnIcon, for: .normal)
        self.setTitleColor(self.tintColor, for: .normal)
        
        //shadow
        if (shadow) {
            self.layer.shadowColor = type.backgroundColor.cgColor
            self.layer.masksToBounds = false;
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 10;
            self.layer.shadowOffset = CGSize(width: 0 , height: 10)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buttonTouchedIn() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.8
            self.layoutIfNeeded()
        })
    }
    
    private func buttonTouchedOut() {
        UIView.commitAnimations()
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 1
            self.layoutIfNeeded()
        })
    }
    
    private func updateAppearance() {
        if (isSelected || isHighlighted) && isEnabled {
            buttonTouchedIn()
        } else {
            buttonTouchedOut()
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            if oldValue != isHighlighted {
                updateAppearance()
            }
        }
    }
    
}
