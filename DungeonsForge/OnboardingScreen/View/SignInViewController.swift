//
//  SignInViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import UIKit

class SignInViewController: BaseViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private lazy var viewModel = SignInViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func passwordVisibility(_ sender: UIButton) {
        passwordTextField.togglePasswordVisibility()
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        viewModel.signIn(username: usernameTextField.text ?? "Admin", password: passwordTextField.text ?? "Pass123")
//        UserDefaults.standard.set(usernameTextField.text, forKey: "Username")
//        UserDefaults.standard.set(passwordTextField.text, forKey: "Password")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showContainer") {
            let landingViewController = segue.destination as! ContainerViewController
            landingViewController.username = usernameTextField.text
        }
    }
}

extension SignInViewController: SignInViewModelDelegate {
    func signInFailed() {
        blockInterface()
        showAlert(with: "Invalid User", message: "Please fill in the correct details")
    }
    
    func signInSuccess() {
        blockInterface()
        self.performSegue(withIdentifier: "showContainer", sender: self)
    }

}
