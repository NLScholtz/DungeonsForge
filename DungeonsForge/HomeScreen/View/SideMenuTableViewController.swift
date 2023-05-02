//
//  SideMenuTableViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showSettings", sender: self)
        case 1:
            performSegue(withIdentifier: "showAttributes", sender: self)
        case 2:
            print("signed out")
            performSegue(withIdentifier: "", sender: self)
        default: break
        }
    }
}
