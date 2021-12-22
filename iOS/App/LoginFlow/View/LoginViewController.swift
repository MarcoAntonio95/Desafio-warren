//
//  LoginViewController.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private var loginViewModel: LoginViewModel
    
    init(viewModel: LoginViewModel){
        self.loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    func buildView() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
    }
    
    func buildConstraints() {
    }
    
    @objc
    func buttonAction() {
        self.loginViewModel.finishFlow()
    }

}
