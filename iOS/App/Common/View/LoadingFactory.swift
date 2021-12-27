//
//  LoadingView.swift
//  App
//
//  Created by Marco Antonio on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

public class LoadingFactory {
    
    // MARK: Varbles & Constants
    public static let sharedInstance = LoadingFactory()
    fileprivate let blurImg = UIImageView()
    fileprivate let indicator = UIActivityIndicatorView()

    // MARK: View lifecycle & UI Setup
    init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.color = #colorLiteral(red: 0.8682464957, green: 0.1781739593, blue: 0.3401823342, alpha: 1)
        indicator.startAnimating()
    }
    
    // MARK: Public functions
    func showLoading(){
        DispatchQueue.main.async {
            UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(self.blurImg)
            UIApplication.shared.windows.first { $0.isKeyWindow }?.addSubview(self.indicator)
        }
    }
    
    func hideLoading(){
        DispatchQueue.main.async {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
        }
    }
    
    func showIndicatorInView(currentView: UIView){
        DispatchQueue.main.async {
            self.indicator.center = currentView.center
            currentView.addSubview(self.blurImg)
            currentView.addSubview(self.indicator)
        }
    }
    
    func showLoadingInImageView(currentImageView: UIImageView){
        DispatchQueue.main.async {
            currentImageView.addSubview(self.blurImg)
            self.indicator.style = .large
            self.indicator.startAnimating()
            self.indicator.center.y = (currentImageView.frame.height/2)
            self.indicator.center.x = (currentImageView.frame.width/2)
            currentImageView.addSubview(self.indicator)
        }
    }
}

