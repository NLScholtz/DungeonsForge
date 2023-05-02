//
//  ContainerViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class ContainerViewController: UIViewController {

    var username: String?
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    private var sideMenuOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTabBar") {
            let landingViewController = segue.destination as! TabBarViewController
            landingViewController.username = username
        }
    }
    
    @objc func toggleSideMenu() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6) {
            if self.sideMenuOpen {
                self.sideMenuOpen = false
                self.sideMenuConstraint.constant = -320
            } else {
                self.sideMenuOpen = true
                self.sideMenuConstraint.constant = 0
            }
            self.view.layoutIfNeeded()
        }
    }
}
