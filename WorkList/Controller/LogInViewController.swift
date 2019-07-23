//
//  LogInViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/9/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class LogInViewController: UIViewController {

    //  MARK: - Outlet
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    //  MARK: - Setup View
    private func setupTextFields() {
        userNameTextField.delegate = self
        passWordTextField.delegate = self
    }
    
    //  MARK: - Action
    @IBAction func backToPrevious(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func alertError() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Username hoặc Password không được để trống",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension LogInViewController: UITextFieldDelegate {
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
