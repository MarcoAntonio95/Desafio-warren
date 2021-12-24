//
//  LoginViewController.swift
//  App
//
//  Created by Marco Antonio on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: UI Components
    private lazy var titleLabel: UILabel = {
        let title = UILabel(frame: .zero)
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.textAlignment = .center
        title.text = "Welcome!"
        title.font = UIFont(name: "DIN Alternate Bold", size: 22)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var errorLabel: UILabel = {
        let error = UILabel(frame: .zero)
        error.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        error.textAlignment = .center
        error.numberOfLines = 3
        error.lineBreakMode = .byWordWrapping
        error.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        error.isHidden = true
        error.translatesAutoresizingMaskIntoConstraints = false
        return error
      }()
    
    private lazy var emailTextField: UITextField = {
        let email = UITextField(frame: .zero)
        email.layer.borderWidth = 2.0
        email.layer.borderColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        email.placeholder = "  email:"
        email.layer.cornerRadius = 20
        email.text = "mobile_test@warrenbrasil.com"
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField(frame: .zero)
        password.layer.borderWidth = 2.0
        password.layer.borderColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        password.placeholder = "  password:"
        password.layer.cornerRadius = 20
        password.isEnabled = true
        password.isSecureTextEntry = true
        password.text = "Warren123!"
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        button.layer.cornerRadius = 24
        button.setTitle("Login!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var greyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Varbles & Constants
    private var loginViewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: Initialization
    init(viewModel: LoginViewModel){
        self.loginViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
    }
    
    // MARK: UI Setup
    fileprivate func buildView() {
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.buildHierarchy()
        self.buildConstraints()
        self.buildRxBindings()
        self.buildUIActions()
    }
    
    fileprivate func buildHierarchy() {
        self.view.addSubview(greyView)
        self.greyView.addSubview(titleLabel)
        self.greyView.addSubview(errorLabel)
        self.greyView.addSubview(emailTextField)
        self.greyView.addSubview(passwordTextField)
        self.greyView.addSubview(loginButton)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate ([
            self.greyView.heightAnchor.constraint(equalToConstant: (self.view.frame.height*0.45)),
            self.greyView.widthAnchor.constraint(equalToConstant: (self.view.frame.width*0.8)),
            self.greyView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.greyView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.errorLabel.topAnchor, constant: -8),
            
            self.errorLabel.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 16),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -16),
            self.errorLabel.bottomAnchor.constraint(equalTo: self.emailTextField.topAnchor, constant: -16),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.greyView.topAnchor, constant: (self.view.frame.height*0.5)*(0.35)),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 16),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -16),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 8),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 16),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -16),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 48),

            self.loginButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 16),
            self.loginButton.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 24),
            self.loginButton.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -24),
            self.loginButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    fileprivate func buildRxBindings(){
        self.emailTextField.rx.text.bind(to: self.loginViewModel.emailSubject).disposed(by: self.disposeBag)
        self.passwordTextField.rx.text.bind(to: self.loginViewModel.passwordSubject).disposed(by: self.disposeBag)
        self.loginViewModel.isValidForm.bind(to: self.loginButton.rx.isEnabled).disposed(by: self.disposeBag)
    }
    
    fileprivate func buildUIActions() {
      self.loginButton.rx.tap.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
          
          LoadingFactory.sharedInstance.showIndicatorInView(currentView: self.view)
          
          self.loginViewModel.login(email: self.emailTextField.text!, password: self.passwordTextField.text!).subscribe(
              onNext: { _ in
                  self.loginViewModel.goToPortfoliosFlow()
              },
              onError: { errorMsg in
                  LoadingFactory.sharedInstance.hideLoading()
                  DispatchQueue.main.async {
                      self.errorLabel.text = errorMsg.localizedDescription
                      self.errorLabel.isHidden = false
                  }
              }
          ).disposed(by: self.disposeBag)
        }).disposed(by: self.disposeBag)
    }
}
