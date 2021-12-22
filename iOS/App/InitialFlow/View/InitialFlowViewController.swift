//
//  InitialFlowViewController.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

class InitialFlowViewController: UIViewController {

   private var initialFlowViewModel: InitialFlowViewModel
   
   init(viewModel: InitialFlowViewModel){
       self.initialFlowViewModel = viewModel
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
       self.initialFlowViewModel.startPortfoliosFlow()
   }

}
