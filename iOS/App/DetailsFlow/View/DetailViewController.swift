//
//  DetailViewController.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    private var detailsViewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel){
        self.detailsViewModel = viewModel
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
        self.detailsViewModel.finishFlow()
    }

}
