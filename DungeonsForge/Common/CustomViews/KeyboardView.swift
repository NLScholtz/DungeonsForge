//
//  KeyboardView.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

class KeyboardView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension KeyboardView: UITextViewDelegate, UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
