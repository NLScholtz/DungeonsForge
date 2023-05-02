//
//  SignUpViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var usernameSignUpTextField: UITextField!
    @IBOutlet weak var emailSignUpTextField: UITextField!
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    private lazy var viewModel = SignUpViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordSignUpTextField.isSecureTextEntry = true
    }
    
    @IBAction func passwordVisibilityAction(_ sender: UIButton) {
        passwordSignUpTextField.togglePasswordVisibility()
    }

    @IBAction func signUpAction(_ sender: UIButton) {
        viewModel.signUp(username: usernameSignUpTextField.text ?? "", password: passwordSignUpTextField.text ?? "", email: emailSignUpTextField.text ?? "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showLanding1") {
            let landingViewController = segue.destination as! TabBarViewController
            landingViewController.username = usernameSignUpTextField.text
        }
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    func signUpSuccess() {
        blockInterface()
        self.performSegue(withIdentifier: "showLanding1", sender: self)
    }
    
    func signUpFailed() {
        blockInterface()
        showAlert(with: "Invalid Information", message: "Please fill in the necessary details required")
    }

}
