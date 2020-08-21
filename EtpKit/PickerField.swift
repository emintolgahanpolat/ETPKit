//
//  PickerField.swift
//  EtpKit
//
//  Created by Emin Tolgahan Polat on 29.03.2020.
//  Copyright © 2020 Emin Tolgahan Polat. All rights reserved.
//


import UIKit


class PickerField: UITextField {
    var data:[String]?
    private var currentPosition = 0
    public typealias DoneHandler = (_ pos:Int) -> Void
    public typealias CancelHandler = (() -> Void)
    fileprivate var doneHandler: DoneHandler = {_ in }
    fileprivate var cancelHandler: CancelHandler?
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
  
}

extension PickerField {
    
    func setInputViewDatePicker(doneHandler: @escaping DoneHandler,cancelHandler: CancelHandler? = nil) {
        self.tintColor = .clear
        // Create a UIDatePicker object and assign to inputView
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 3))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        
        setupToolbar()
    }
    
    private func setupToolbar(){
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPicker))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePicker))
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    func setInputViewStringPicker(doneHandler: @escaping DoneHandler,cancelHandler: CancelHandler? = nil) {
        
        self.tintColor = .clear
        self.doneHandler = doneHandler
        self.cancelHandler = cancelHandler
        
        
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let stringPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: UIScreen.main.bounds.height / 3))
        stringPicker.dataSource = self
        stringPicker.delegate = self
        self.inputView = stringPicker
        
        setupToolbar()
        
        
    }
    
    @objc func donePicker() {
        self.text = data?[currentPosition]
        self.resignFirstResponder()
        self.doneHandler(currentPosition)
        
    }
    
    @objc func cancelPicker() {
        self.resignFirstResponder()
        self.cancelHandler?()
        
    }
}


extension PickerField: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data?[row] ?? nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPosition = row
    }
    
}
