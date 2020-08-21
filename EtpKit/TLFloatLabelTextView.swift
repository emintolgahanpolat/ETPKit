//
//  ETView.swift
//  PickerViewEx
//
//  Created by Emin Tolgahan Polat on 24.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//

import UIKit


class FloatLabelTextView: UITextView {
    
    let animationDuration = 0.3
    var title = UILabel()
    
    
    @IBInspectable var placeholder:String? {
        didSet {
            text = placeholder
            textColor = UIColor.lightGray
            title.text = placeholder
            title.sizeToFit()
        }
    }
    
    var textFont:UIFont = UIFont.init(name: "HelveticaNeue-Bold", size: 14)! {
        didSet {
            setup()
        }
    }
    var titleFont:UIFont = UIFont.init(name: "HelveticaNeue-Italic", size: 12)! {
        didSet {
            setup()
        }
    }
    
    @IBInspectable var activeColor:UIColor = UIColor.orange {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var defaultColor:UIColor = UIColor.gray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    
    
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.size.width, height: 46)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func  setup(){
        
        
        textContainerInset = UIEdgeInsets(top: 10, left: -5, bottom: 10, right: -5)
        delegate = self
        backgroundColor = .clear
        font = textFont
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .white
        // Set up title label
        title.alpha = 0.0
        title.font = titleFont
        title.textColor = activeColor
        if let str = placeholder , !str.isEmpty {
            title.text = str
            title.sizeToFit()
        }
        self.addSubview(title)
        
        
        
        
    }
    @IBInspectable var underLineWidth: CGFloat = 2.0
    var underlineView = UIView(frame: CGRect.zero)
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLine()
    }
    func drawLine() {
        let underLine = UIView(frame:CGRect(x: 0, y: bounds.height - underLineWidth, width: bounds.width, height: underLineWidth))
        
        underLine.backgroundColor = activeColor
        
        underlineView = underLine
        self.addSubview(underlineView)
    }
    

    
    
    @IBInspectable var hintYPadding:CGFloat = 0.0
    
    @IBInspectable var titleYPadding:CGFloat = -3.0 {
        didSet {
            var r = title.frame
            r.origin.y = titleYPadding
            title.frame = r
        }
    }
    
    fileprivate func showTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseOut], animations:{
            // Animation
            self.title.alpha = 1.0
            var r = self.title.frame
            r.origin.y = self.titleYPadding
            self.title.frame = r
        }, completion:nil)
    }
    
    fileprivate func hideTitle(_ animated:Bool) {
        let dur = animated ? animationDuration : 0
        UIView.animate(withDuration: dur, delay:0, options: [UIView.AnimationOptions.beginFromCurrentState, UIView.AnimationOptions.curveEaseIn], animations:{
            // Animation
            self.title.alpha = 0.0
            var r = self.title.frame
            r.origin.y = self.title.font.lineHeight + self.hintYPadding
            self.title.frame = r
        }, completion:nil)
    }
}


extension FloatLabelTextView : UITextViewDelegate{
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
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      if textColor == UIColor.lightGray {
          text = nil
          textColor = UIColor.black
          showTitle(true)
      }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
       if text.isEmpty {
           text = placeholder
           textColor = UIColor.lightGray
           hideTitle(true)
       }
    }
}


extension FloatLabelTextView{
    func addDoneButtonOnKeyboard()
    {
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        toolBar.setItems([flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
        
        
        
    }
    
    @objc private func donePicker() {
        self.resignFirstResponder()
        
    }
}
