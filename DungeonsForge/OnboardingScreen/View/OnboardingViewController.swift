//
//  OnboardingViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class OnboardingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showSignInAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signIn", sender: self)
    }
    
    @IBAction func showSignUpAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "signUp", sender: self)
    }

}
