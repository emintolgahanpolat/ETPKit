//
//  ANLoader.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 22.08.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class ETPLoading {
    static let sharedInstance = ETPLoading()
    
    var container = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    var subContainer = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH / 3.0, height: SCREEN_WIDTH / 4.0))

    var activityIndicatorView = UIActivityIndicatorView()
    
    init() {
        //Main Container
        container.backgroundColor = UIColor.clear
        
        //Sub Container
        subContainer.layer.cornerRadius = 5.0
        subContainer.layer.masksToBounds = true
        subContainer.backgroundColor = UIColor.clear
        
        //Activity Indicator
        activityIndicatorView.hidesWhenStopped = true
     
    }
    
    func show() -> Void {
        
        container.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        activityIndicatorView.style = UIActivityIndicatorView.Style.large
        activityIndicatorView.center = CGPoint(x: SCREEN_WIDTH / 2, y: SCREEN_HEIGHT / 2)
        activityIndicatorView.color = UIColor.white
        
        activityIndicatorView.startAnimating()
        container.addSubview(activityIndicatorView)
       if let window = getKeyWindow() {
            window.addSubview(container)
        }
        container.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 1.0
        })
    }
    
  
    
    func hide() {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.container.alpha = 0.0
        }) { finished in
            self.activityIndicatorView.stopAnimating()
            
            self.activityIndicatorView.removeFromSuperview()
         
            self.subContainer.removeFromSuperview()
           
            self.container.removeFromSuperview()
        }
    }
    

    private func getKeyWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return window
    }
}
