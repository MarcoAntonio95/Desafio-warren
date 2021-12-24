//
//  PortfoliosViewController.swift
//  App
//
//  Created by Marco Antonio on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PortfoliosViewController: UIViewController {
    // MARK: UI Components
    private lazy var portfoliosTableView: UITableView = {
        let portfolios = UITableView(frame: .zero)
        portfolios.register(PortfolioTableViewCell.self, forCellReuseIdentifier: "portifolioCell")
        portfolios.rowHeight = 350
        portfolios.backgroundColor = .clear
        portfolios.translatesAutoresizingMaskIntoConstraints = false
        return portfolios
    }()
    
    // MARK: Varbles & Constants
    private var portfoliosViewModel: PortfoliosViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: View Init
    init(viewModel: PortfoliosViewModel){
        self.portfoliosViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buildNavegationBar()
        self.buildRxNavigationAction()
    }
    
    // MARK: UI Setup
    func buildView() {
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.buildHierarchy()
        self.buildConstraints()
        self.buildRxBindings()
        self.buildUIActions()
    }
    
    // MARK: Privated functions
    fileprivate func buildNavegationBar() {
        let customNavBarAppearance = UINavigationBarAppearance()
        customNavBarAppearance.configureWithOpaqueBackground()
        customNavBarAppearance.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        customNavBarAppearance.shadowImage = nil
        customNavBarAppearance.shadowColor = nil
        
        self.navigationItem.title = "Portfolios"
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController!.navigationBar.standardAppearance = customNavBarAppearance
        self.navigationController!.navigationBar.scrollEdgeAppearance = customNavBarAppearance
        
        let logOutIcon = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: logOutIcon, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
    }
    
    fileprivate func buildRxNavigationAction(){
        self.navigationItem.rightBarButtonItem?.rx.tap.subscribe(onNext: {
              [weak self] in
              guard let `self` = self else { return }
            self.portfoliosViewModel.returnToInitialFlow()
          }).disposed(by: self.disposeBag)
    }
    
    fileprivate func buildHierarchy() {
        self.view.addSubview(portfoliosTableView)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.portfoliosTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.portfoliosTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.portfoliosTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.portfoliosTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    fileprivate func buildRxBindings() {
        self.portfoliosViewModel.getAllPortfolios().bind(to: self.portfoliosTableView.rx.items(cellIdentifier: "portifolioCell",cellType: PortfolioTableViewCell.self)){
            row,item,cell in
            
            cell.titlePortfolio.text = item.name
            
            guard let imageUrl = item.background["small"] else { return }
            
            let loadingFactory = LoadingFactory()
            loadingFactory.showLoadingInImageView(currentImageView: cell.imagePortfolio)
            
            self.portfoliosViewModel.downloadJSONImage(imageUrl: imageUrl).bind { data in
                DispatchQueue.main.async {
                    loadingFactory.hideLoading()
                    cell.imagePortfolio.image = UIImage(data: data)
                }
            }.disposed(by: self.disposeBag)
        }.disposed(by: self.disposeBag)
    }
    
    fileprivate func buildUIActions() {
        self.portfoliosTableView.rx.modelSelected(Portfolio.self).bind { portfolio in
            let portfoliodata = portfolio as Any
            self.portfoliosViewModel.startDetailsFlow(currentPortfolio: portfoliodata)
        }.disposed(by: self.disposeBag)
    }

}
