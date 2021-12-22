//
//  InitialFlowViewController.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class InitialFlowViewController: UIViewController {

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "#Desafio\nWarren"
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.font = UIFont.boldSystemFont(ofSize: 36)
        title.textColor = UIColor.white
        title.textAlignment = .left
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
   lazy var loginButton: UIButton = {
       let button = UIButton()
       button.backgroundColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
       button.layer.cornerRadius = 16
       button.setTitle("Login!", for: .normal)
       button.setTitleColor(.white, for: .normal)
       button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
       button.isEnabled = true
       button.translatesAutoresizingMaskIntoConstraints = false
       return button
   }()
   
    lazy var greyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   // MARK: Varbles & constants
   private var initialFlowViewModel: InitialFlowViewModel
   private let disposeBag = DisposeBag()
    
   init(viewModel: InitialFlowViewModel){
       self.initialFlowViewModel = viewModel
       super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
       super.viewDidLoad()
       self.view.backgroundColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
       self.buildView()
   }
   
   // MARK: UI Setup
   fileprivate func buildView() {
        self.buildHierarchy()
        self.buildConstraints()
        self.buildUIActions()
   }
   
    fileprivate func buildHierarchy() {
        self.view.addSubview(titleLabel)
//        self.view.insertSubview(loginButton, aboveSubview: greyView)
        self.view.addSubview(greyView)
        self.greyView.addSubview(loginButton)
   }
   
    fileprivate func buildConstraints() {
     
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: (self.view.frame.height*0.3)),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            self.loginButton.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 24),
            self.loginButton.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -24),
            self.loginButton.centerYAnchor.constraint(equalTo: self.greyView.centerYAnchor),
            self.loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            self.greyView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.greyView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.greyView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            self.greyView.heightAnchor.constraint(equalToConstant: (self.view.frame.height*0.25))
        ])
   }
    
    fileprivate func buildUIActions() {
      self.loginButton.rx.tap.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            self.initialFlowViewModel.startPortfoliosFlow()
        }).disposed(by: self.disposeBag)
    }

}
