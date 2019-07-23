//
//  ForgotViewController.swift
//  WorkList
//
//  Created by CuongVX-D1 on 7/11/19.
//  Copyright © 2019 CuongVX-D1. All rights reserved.
//

import UIKit

final class ForgotViewController: UIViewController {

    //  MARK: - Outlet
    @IBOutlet private weak var emailTextField: UITextField!
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //  MARK: - Action
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendRequestAction(_ sender: Any) {
        
    }
}
