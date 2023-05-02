//
//  LogInAutentication.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

extension UIViewController {
    
    func blockInterface() {
        self.view.alpha = 0.2
    }
    
    func unblockInterface() {
        self.view.alpha = 1.0
    }
    
    func showAlert(with title: String, message: String) {
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueButton = UIAlertAction(title: "OK", style: .default, handler: { (action ) -> Void in
            self.unblockInterface()
            //print("Alert Button pressed")
        })
        alertMessage.addAction(continueButton)
        self.present(alertMessage, animated: true, completion: nil)
    }
}

extension UITextField {
    func togglePasswordVisibility(){
        isSecureTextEntry = !isSecureTextEntry
        
        if let existingText = text, isSecureTextEntry {
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
}
