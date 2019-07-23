//
//  RegisterViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/12/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {
    
    //  MARK: - Outlet
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passTextField: UITextField!
    @IBOutlet private weak var confirmPassTextField: UITextField!
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupNotificationKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //  MARK: - Setup View
    private func setupTextField() {
        emailTextField.delegate = self
        passTextField.delegate = self
        confirmPassTextField.delegate = self
    }
    
    private func setupNotificationKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    private func alertError() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Username hoặc Password không được để trống",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if notification.name == UIResponder.keyboardWillChangeFrameNotification || notification.name == UIResponder.keyboardWillShowNotification {
            view.frame.origin.y = -keyboardSize.height
        } else {
            view.frame.origin.y = 0
        }
    }
}

//  MARK: - Extension
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            alertError()
        }
        let nextTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?
        let _ = nextResponder != nil ? nextResponder?.becomeFirstResponder() : textField.resignFirstResponder()
        return false
    }
}
