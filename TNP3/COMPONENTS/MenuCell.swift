//
//  MenuCell.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/30/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import Foundation
import UIKit

class sideMenuCell: UITableViewCell {
    
    var menu_icon: UIImageView = {
        let imgvw = UIImageView()
        return imgvw
    }()
    
    
    var menu_title: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(menu_icon)
        self.addSubview(menu_title)
        self.backgroundColor = UIColor.red
        self.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
