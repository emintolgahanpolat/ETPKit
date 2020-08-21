//
//  ETPNavigationBar.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

class ETPNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override var intrinsicContentSize: CGSize{
        return CGSize(width: frame.width, height: 200)
    }
    private func setupUI(){
        log.i(tag: "ETPNavigationBar", msg: "setupUI")
       
        let backIndicator = UIImage(systemName: "arrow.left")?.withAlignmentRectInsets( UIEdgeInsets(top: 0, left: 0, bottom: 3, right: 0))
        tintColor = .black
        backIndicatorImage = backIndicator
        backIndicatorTransitionMaskImage = backIndicator
        //shadowImage = UIImage()
        titleTextAttributes = [NSAttributedString.Key.font: UIFont.init(name: .Helvetica, type: .Bold, size: 17)!]
      
        
        
        
    }
}
