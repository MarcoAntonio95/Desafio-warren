//
//  PortfolioTableViewCell.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    lazy var imagePortfolio : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var  titlePortfolio : UILabel = {
        let title = UILabel()
        title.textColor = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        title.font = UIFont(name: "DIN Alternate Bold", size: 22)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.contentView.backgroundColor = #colorLiteral(red: 0.1802104115, green: 0.1840381324, blue: 0.2006301582, alpha: 1) 
            self.buildHierarchy()
            self.buildConstraints()
    }
    
    fileprivate func buildHierarchy(){
            self.contentView.addSubview(self.titlePortfolio)
            self.contentView.addSubview(self.imagePortfolio)
    }
    
    fileprivate func buildConstraints(){
        NSLayoutConstraint.activate([
            self.imagePortfolio.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            self.imagePortfolio.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            self.imagePortfolio.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            self.titlePortfolio.topAnchor.constraint(equalTo: self.imagePortfolio.bottomAnchor, constant: 24),
            self.titlePortfolio.heightAnchor.constraint(equalToConstant: 32),
            self.titlePortfolio.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.titlePortfolio.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
   }

}
