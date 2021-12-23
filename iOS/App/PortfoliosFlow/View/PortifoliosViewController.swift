//
//  InitialViewController.swift
//  App
//
//  Created by Matheus Lutero on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PortfoliosViewController: UIViewController {
    
    private lazy var portfoliosTableView: UITableView = {
        let portfolios = UITableView(frame: .zero)
        portfolios.register(PortfolioTableViewCell.self, forCellReuseIdentifier: "portifolioCell")
        portfolios.rowHeight = 350
        portfolios.tableFooterView = UIView()
        portfolios.backgroundColor = .clear
        portfolios.translatesAutoresizingMaskIntoConstraints = false
        return portfolios
    }()
    
    // MARK: Varbles & Constants
    private var portfoliosViewModel: PortfoliosViewModel
    private let disposeBag = DisposeBag()
    private let tappedPortfolio = Portfolio()
    
    init(viewModel: PortfoliosViewModel){
        self.portfoliosViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    // MARK: UI Setup
    func buildView() {
        self.view.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        self.buildHierarchy()
        self.buildConstraints()
        self.buildRxBindings()
        self.buildUIActions()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showDetail") {
            let detailsVC = segue.destination as! DetailsViewController
        }
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
            
            var imageData = Data()
            
            if imageData.isEmpty {
                self.portfoliosViewModel.downloadJSONImage(imageUrl: imageUrl).bind { data in
                    DispatchQueue.main.async {
                        imageData = data
                        cell.imagePortfolio.image = UIImage(data: imageData)
                    }
                }.disposed(by: self.disposeBag)
            }
        }.disposed(by: self.disposeBag)
    }
    
    fileprivate func buildUIActions() {
        self.portfoliosTableView.rx.modelSelected(Portfolio.self).bind { portfolio in
            self.performSegue(withIdentifier: "showDetail", sender: self)
        }.disposed(by: self.disposeBag)
    }

}
