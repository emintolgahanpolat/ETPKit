//
//  EtpButton.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 22.05.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


@IBDesignable
class EtpButton: UIButton {
    

    private var bgColor:UIColor? = nil
    @IBInspectable var isTappedSizeAnim: Bool  = false
    @IBInspectable var isVibrate: Bool  = false
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.bgColor = self.backgroundColor
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
        
       
    }

    
    @objc private func animateDown(sender: UIButton) {
        if(isVibrate){
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
            feedbackGenerator.impactOccurred()
        }
        if isTappedSizeAnim {
            animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
        }
        if let mColor = self.bgColor?.lighter(){
            colorAnimate(sender, color: mColor)
        }
        
        
    }
    
    @objc private func animateUp(sender: UIButton) {
        if isTappedSizeAnim {
            animate(sender, transform: .identity)
        }
        if let mColor = self.bgColor{
            colorAnimate(sender, color: mColor)
        }
    }
    
    private func colorAnimate(_ button: UIButton, color: UIColor) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.backgroundColor = color
        }, completion: nil)
        
    }
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
        }, completion: nil)
        
    }
    
}

extension EtpButton{
    
    @IBInspectable var cornerRadius: CGFloat {
         get {
             return layer.cornerRadius
         }
         set {
            layer.cornerRadius = newValue < frame.height / 2 ? newValue : frame.height / 2
           
             
         }
     }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    
}



