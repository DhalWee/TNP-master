
//
//  SlideMenuController.swift
//  TNP3
//
//  Created by alisher toleberdyyev on 10/28/18.
//  Copyright © 2018 alisher toleberdyyev. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

class SlideMenuController: UITableViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }
        
       self.tableView.backgroundColor = UIColor.blue
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
        
        cell.blurEffectStyle = SideMenuManager.default.menuBlurEffectStyle
        
        return cell
    }
}
