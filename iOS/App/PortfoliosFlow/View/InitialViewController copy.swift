//
//  InitialViewController.swift
//  App
//
//  Created by Matheus Lutero on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    lazy var okButton: UIButton = {
            let button = UIButton()
            button.setTitle("Finalizar Tela", for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return button
    }()
    
    private var initialViewModel: InitialViewModel
    
    init(viewModel: InitialViewModel){
        self.initialViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        buildView()
    }
    
    func buildView() {
        buildHierarchy()
        buildConstraints()
    }
    
    func buildHierarchy() {
        view.addSubview(okButton)
    }
    
    func buildConstraints() {
        okButton.translatesAutoresizingMaskIntoConstraints = false
        let centerX = NSLayoutConstraint(item: okButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: okButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        
        view.addConstraints([centerX, centerY])
    }
    
    @objc
    func buttonAction() {
        self.initialViewModel.startPortifoliosFlow()
    }

}
