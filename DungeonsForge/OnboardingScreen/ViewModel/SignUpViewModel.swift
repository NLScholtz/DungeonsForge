//
//  SignUpViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    func signUpSuccess()
    func signUpFailed()
}

class SignUpViewModel {
    private weak var delegate: SignUpViewModelDelegate?

    init(delegate: SignUpViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func signUp(username: String, password: String, email: String){
        if (username != "") && (password != "") && (validateEmail(email: email)) {
            delegate?.signUpSuccess()
        } else {
            delegate?.signUpFailed()
        }
    }
}
