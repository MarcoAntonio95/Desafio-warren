//
//  PortfolioTableViewCell.swift
//  App
//
//  Created by Marco Antonio on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    // MARK: UI Components
    lazy var imagePortfolio : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var  titlePortfolio : UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        title.font = UIFont(name: "DIN Alternate Bold", size: 24)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    lazy var greyView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.buildHierarchy()
        self.buildConstraints()
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
   }
    
    // MARK: Privated functions
    fileprivate func buildHierarchy(){
        self.contentView.addSubview(self.greyView)
        self.greyView.addSubview(self.titlePortfolio)
        self.greyView.addSubview(self.imagePortfolio)
    }
    
    fileprivate func buildConstraints(){
        NSLayoutConstraint.activate([
            self.greyView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            self.greyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            self.greyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            self.greyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            self.imagePortfolio.topAnchor.constraint(equalTo: self.greyView.topAnchor, constant: 24),
            self.imagePortfolio.leadingAnchor.constraint(equalTo: self.greyView.leadingAnchor, constant: 24),
            self.imagePortfolio.trailingAnchor.constraint(equalTo: self.greyView.trailingAnchor, constant: -24),
            
            self.titlePortfolio.topAnchor.constraint(equalTo: self.imagePortfolio.bottomAnchor, constant: 16),
            self.titlePortfolio.heightAnchor.constraint(equalToConstant: 32),
            self.titlePortfolio.centerXAnchor.constraint(equalTo: self.self.greyView.centerXAnchor),
            self.titlePortfolio.bottomAnchor.constraint(equalTo: self.greyView.bottomAnchor, constant: -24)
        ])
    }
}
