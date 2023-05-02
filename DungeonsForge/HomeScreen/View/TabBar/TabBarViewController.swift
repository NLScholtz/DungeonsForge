//
//  TabBarViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    var username: String?
    private var menuButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !hidesBottomBarWhenPushed {
            self.setupMiddleButton()
        } else {
            removeMiddleButton()
        }
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = 3
    }
    
    func setupMiddleButton() {
        menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        
        guard let menu = menuButton else { return }
        
        var menuButtonFrame = menu.frame
        menuButtonFrame.origin.y = self.tabBar.bounds.height - (menuButtonFrame.height)*0.95
        menuButtonFrame.origin.x = self.view.bounds.width/2 - (menuButtonFrame.size.width)/2
        menu.frame = menuButtonFrame
        
        menu.setImage(UIImage(named: "Regular-S"), for: UIControl.State.normal)
        menu.contentMode = .scaleAspectFit
        menu.addTarget(self, action: #selector(TabBarViewController.menuButtonAction(sender:)), for: UIControl.Event.touchUpInside)
        tabBar.addSubview(menu)
        self.view.layoutIfNeeded()
    }
    
    func removeMiddleButton() {
        self.menuButton?.removeFromSuperview()
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2
    }

}
