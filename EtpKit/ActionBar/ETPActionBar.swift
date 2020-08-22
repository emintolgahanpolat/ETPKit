//
//  ETPActionBar.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 20.06.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


import UIKit


@IBDesignable
class ETPActionBar: UIView{
    
    
    @IBInspectable var title: String = ""{
        didSet{
            titleLabel.text = title
        }
    }
    @IBInspectable var textColor: UIColor = .black  {
        didSet{
            titleLabel.textColor = textColor
        }
    }
    
   
    lazy var titleLabel:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    
    private var contentStackView :UIStackView = {
        var view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution  = .fill
        view.alignment = .fill
        view.spacing   = 10.0
        view.axis  = .horizontal
        return view
    }()
    
    
    
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    override func layoutSubviews() {
         super.layoutSubviews()
        subviews.forEach{(item) in
            Log.i(tag: "SubView", msg:"\( item.classForCoder == UIButton.self)")
            
            if  item.classForCoder == UIButton.self {
                    
                item.frame.size.height = 48
                item.frame.size.width = 48
                 self.contentStackView.addArrangedSubview(item)
                
            }
       
        }
       
    
        
        
     
    }
    
    
    func setupUI() {
        
        addSubview(titleLabel)
        addSubview(contentStackView)
        
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentStackView.leftAnchor).isActive = true
        
        
        
        contentStackView.rightAnchor.constraint(equalTo: rightAnchor,constant: -20).isActive = true
        contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
}
