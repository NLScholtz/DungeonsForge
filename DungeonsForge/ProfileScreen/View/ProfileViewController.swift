//
//  ProfileViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class ProfileViewController: NotificationViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var spinningIndicator: UIActivityIndicatorView!
    
    var username : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = (self.tabBarController as! TabBarViewController).username
    }
    
    @IBAction func signOutUserAction(_ sender: UIButton) {
        showAlertWithDestructiveBtn()
    }
}

extension ProfileViewController {
    func showAlertWithDestructiveBtn() {
        let alert = UIAlertController(title: "Sign Out?", message: "Are you sure you want to sign out? You can login back to access your characters again.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        
        alert.addAction(UIAlertAction(title: "Sign Out",
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            //Sign out action
            self.blockInterface()
            DispatchQueue.main.asyncAfter(deadline: .now()){
                //        UserDefaults.standard.set(false, forKey: "Username")
                //        UserDefaults.standard.set(false, forKey: "Password")
                //        UserDefaults.standard.synchronize()
                //        self.blockInterface()
                self.spinningIndicator.isHidden = false
                self.spinningIndicator.startAnimating()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.performSegue(withIdentifier: "signUserOut", sender: self)
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: false, completion: nil)
        }
    }
}
