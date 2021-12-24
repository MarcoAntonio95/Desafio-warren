//
//  DetailViewController.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {

    lazy var portfolioImage : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.layer.cornerRadius = 16
        name.layer.masksToBounds = true
        name.textColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        name.textAlignment = .center
        name.backgroundColor = .clear
        name.layer.cornerRadius = 16
        name.font = UIFont(name: "DIN Alternate Bold", size: 24)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var totalBalanceLabel: UILabel = {
        let totalBalance = UILabel(frame: .zero)
        totalBalance.layer.cornerRadius = 16
        totalBalance.layer.masksToBounds = true
        totalBalance.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        totalBalance.textAlignment = .center
        totalBalance.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        totalBalance.layer.cornerRadius = 16
        totalBalance.font = UIFont(name: "DIN Alternate Bold", size: 18)
        totalBalance.translatesAutoresizingMaskIntoConstraints = false
        return totalBalance
    }()
    
    private lazy var goalAmountLabel: UILabel = {
        let goalAmount = UILabel(frame: .zero)
        goalAmount.layer.cornerRadius = 16
        goalAmount.layer.masksToBounds = true
        goalAmount.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        goalAmount.textAlignment = .center
        goalAmount.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        goalAmount.layer.cornerRadius = 16
        goalAmount.font = UIFont(name: "DIN Alternate Bold", size: 18)
        goalAmount.translatesAutoresizingMaskIntoConstraints = false
        return goalAmount
    }()
    
    private lazy var goalDateLabel: UILabel = {
        let goalDate = UILabel(frame: .zero)
        goalDate.layer.cornerRadius = 16
        goalDate.layer.masksToBounds = true
        goalDate.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        goalDate.textAlignment = .center
        goalDate.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        goalDate.font = UIFont(name: "DIN Alternate Bold", size: 18)
        goalDate.translatesAutoresizingMaskIntoConstraints = false
        return goalDate
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        button.layer.cornerRadius = 24
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Varbles & Constants
    private var detailsViewModel: DetailsViewModel
    private let disposeBag = DisposeBag()
    var currentPortfolio = Portfolio()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        if self.portfolioImage.image?.pngData() == nil {
            LoadingView.sharedInstance.showLoadingInImageView(currentImageView: portfolioImage)
        }
    }
    
    // MARK: UI Setup
    func buildView() {
        self.view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.buildHierarchy()
        self.buildConstraints()
        self.bindDataInView()
        self.buildRxBindings()
        self.buildUIActions()
    }
    
    fileprivate func buildHierarchy() {
        self.view.addSubview(self.portfolioImage)
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.goalDateLabel)
        self.view.addSubview(self.totalBalanceLabel)
        self.view.addSubview(self.goalAmountLabel)
        self.view.addSubview(self.backButton)
    }
    
    fileprivate func buildConstraints() {
        NSLayoutConstraint.activate([
            self.portfolioImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: (self.view.frame.height*0.16)),
            self.portfolioImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.portfolioImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.portfolioImage.heightAnchor.constraint(equalToConstant: (self.view.frame.height*0.3)),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.portfolioImage.bottomAnchor, constant: 16),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 32),
            
            self.goalDateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
            self.goalDateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.goalDateLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.goalDateLabel.heightAnchor.constraint(equalToConstant: 32),
            
            self.totalBalanceLabel.topAnchor.constraint(equalTo: self.goalDateLabel.bottomAnchor, constant: 16),
            self.totalBalanceLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.totalBalanceLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.totalBalanceLabel.heightAnchor.constraint(equalToConstant: 32),
            
            self.goalAmountLabel.topAnchor.constraint(equalTo: self.totalBalanceLabel.bottomAnchor, constant: 16),
            self.goalAmountLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.goalAmountLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.goalAmountLabel.heightAnchor.constraint(equalToConstant: 32),
            
            self.backButton.topAnchor.constraint(equalTo: self.goalAmountLabel.bottomAnchor, constant: 16),
            self.backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.backButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.backButton.heightAnchor.constraint(equalToConstant: 48),
            
        ])
    }
    
    fileprivate func bindDataInView() {
        self.nameLabel.text = String(self.currentPortfolio.name)
        self.goalDateLabel.text = String(self.currentPortfolio.goalDate)
        self.totalBalanceLabel.text = String(self.currentPortfolio.totalBalance)
        self.goalAmountLabel.text = String(self.currentPortfolio.goalAmount)
    }
    
    fileprivate func buildRxBindings(){
        guard let imgUrl = self.currentPortfolio.background["regular"] else {return}
        
        self.detailsViewModel.downloadPortfolioImage(imageUrl: imgUrl).bind { data in
            DispatchQueue.main.async {
                if self.portfolioImage.image?.pngData() == nil {
                    LoadingView.sharedInstance.hideLoadingInImageView()
                }
                self.portfolioImage.image = UIImage(data: data)
            }
        }.disposed(by: self.disposeBag)
        
    }

    fileprivate func buildUIActions() {
        self.backButton.rx.tap.subscribe(onNext: {
              [weak self] in
              guard let `self` = self else { return }
            self.detailsViewModel.returnToPortfolios()
        }).disposed(by: self.disposeBag)
    }
}
