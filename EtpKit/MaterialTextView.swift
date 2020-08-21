//
//  UnderlinedTextView.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 30.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable
class MaterialTextView : UITextView
{
    private var placeHolderLabel = UILabel()
    private var underLineView = UIView()
    
    private (set) var placeholderMinimized = false {
        didSet {
            guard (oldValue != placeholderMinimized) else { return }
            
            let transform: CGAffineTransform!
            
            if (placeholderMinimized) {
                let k: CGFloat = 0.7
                let dx = placeHolderLabel.frame.width * (1 - k) / 2
                transform = CGAffineTransform(translationX: -dx, y: -20).scaledBy(x: k, y: k)
            } else {
                transform = .identity
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.placeHolderLabel.layer.setAffineTransform(transform)
            })
        }
    }
    
    private var isActive = false
    
    override var text: String? {
        didSet {
            updateState()
        }
    }
    
    @IBInspectable var placeholder: String! {
        set {
            placeHolderLabel.text = newValue
            placeHolderLabel.sizeToFit()
        }
        get {
            return placeHolderLabel.text
        }
    }
    
    @IBInspectable var placeholderColor: UIColor! {
        didSet {
            placeHolderLabel.textColor = placeholderColor
        }
    }
    @IBInspectable var lineColor: UIColor = .lightGray
    @IBInspectable var lineColorActive: UIColor = .orange
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup(){
        textContainerInset = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: -5)
        self.delegate = self
        clipsToBounds = false
        tintColor = textColor
        placeholderColor = .gray
        sizeToFit()
        
        self.addSubview(placeHolderLabel)
       
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.font = font
        addConstraint(placeHolderLabel.leadingAnchor.constraint(equalTo: leadingAnchor))
        addConstraint(placeHolderLabel.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        //addSubview(underLineView)
        insertSubview(underLineView, at:1)
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = self.lineColor
        var c = NSLayoutConstraint.constraints(withVisualFormat: "|[v]|", options: .alignAllFirstBaseline, metrics: nil, views: ["v": underLineView])
        addConstraints(c)
        c = NSLayoutConstraint.constraints(withVisualFormat: "V:[v(2)]-(-3)-|", options: .alignAllFirstBaseline, metrics: nil, views: ["v": underLineView])
        addConstraints(c)
    }
    func didStartEditing() {
        UIView.animate(withDuration: 0.3) {
            self.underLineView.backgroundColor = self.lineColorActive
        }
        isActive = true
        updateState()
    }
    
    func didEndEditing() {
        UIView.animate(withDuration: 0.3) {
            self.underLineView.backgroundColor = self.lineColor
        }
        isActive = false
        updateState()
    }
    
    func editingChanged() {
        updateState()
    }
    
    func updateState() {
        placeholderMinimized = isActive || !text!.isEmpty
    }
}



extension MaterialTextView : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
       
        let size = CGSize(width: frame.width, height: .infinity)
              var approxSize = textView.sizeThatFits(size)
              if approxSize.height < 46 {
                  approxSize.height = 46
              }
              constraints.forEach {(constraint) in
                  
                  if constraint.firstAttribute == .height{
                      constraint.constant = approxSize.height
                  }
              }
         editingChanged()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        didStartEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        didEndEditing()
    }
}
