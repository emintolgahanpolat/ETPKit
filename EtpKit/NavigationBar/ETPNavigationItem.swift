//
//  ETPNavigationItem.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit

class ETPNavigationItem: UINavigationItem {
    
    override init(title: String) {
        super.init(title: title)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func  setupUI(){
       
        let backButton = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        backBarButtonItem = backButton
    }
}
