//
//  BaseViewController.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewY: NSLayoutConstraint!
    @IBOutlet weak var stackViewX: NSLayoutConstraint!
    @IBOutlet weak var parentView: UIView!

override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)

    displayTraitCollection(stackView: stackView, stackViewY: stackViewY)
    scrollView.contentSize = CGSize(width: parentView.frame.width, height: 300)
}

override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    displayTraitCollection(stackView: stackView, stackViewY: stackViewY)
}

@objc func keyboardDidShow(notification: NSNotification) {
    let info = notification.userInfo
    let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
    scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
}

@objc func keyboardDidHide(notification: NSNotification) {
    scrollView.contentInset = UIEdgeInsets.zero
    scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
}

func displayTraitCollection(stackView: UIStackView, stackViewY: NSLayoutConstraint) {
    if traitCollection.horizontalSizeClass == .regular {
        stackView.axis = .horizontal
    }
    if traitCollection.verticalSizeClass == .compact {
        stackViewY.constant = 0
    } else {
        stackView.axis = .vertical
        updateViewConstraints()
    }
}
}

extension BaseViewController: UITextViewDelegate, UITextFieldDelegate {
public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return false
}
}
