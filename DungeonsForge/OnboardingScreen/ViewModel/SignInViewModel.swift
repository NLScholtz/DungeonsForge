//
//  SignInViewModel.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol SignInViewModelDelegate: AnyObject {
    func signInFailed()
    func signInSuccess()
}

class SignInViewModel{
    private weak var delegate: SignInViewModelDelegate?
    private var username = "Admin"
    private var password = "TestPass123"
    
    init(delegate: SignInViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signIn(username: String, password: String) {
        if (username == self.username) && (password == self.password) {
            delegate?.signInSuccess()
        } else {
            delegate?.signInFailed()
        }
    }
}
