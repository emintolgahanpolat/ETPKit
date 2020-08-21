//
//  Extension.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 29.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


import UIKit



extension UIView{
    
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 4.0]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func onClick(_ handler: @escaping () -> Void){
        isUserInteractionEnabled = true
        let tap = EtpTapGesture(target: self, action: #selector(self.didPressed))
        tap.action = handler
        
        addGestureRecognizer(tap)
    }
    
    func onDoubleClick(numberOfTapsRequired:Int = 2 ,_ handler: @escaping () -> Void){
        isUserInteractionEnabled = true
        let tap = EtpTapGesture(target: self, action: #selector(didPressed))
        tap.action = handler
        tap.numberOfTapsRequired = numberOfTapsRequired
        addGestureRecognizer(tap)
    }
    
    @objc func didPressed(sender: EtpTapGesture) {
        sender.action?()
    }
    
    
    
    
}
class EtpTapGesture: UITapGestureRecognizer {
    var action:(() -> Void)? = nil
}

struct etp{
    #if os(iOS) || os(tvOS)
    
    /// EZSE: Calls action when a screen shot is taken
    public static func detectScreenShot(_ action: @escaping () -> Void) {
        let mainQueue = OperationQueue.main
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { _ in
            // executes after screenshot
            action()
        }
        
        
    }
    
    #endif
}

class ETPView: UIView {
  
}
extension ETPView{
    
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

