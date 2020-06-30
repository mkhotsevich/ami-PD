//
//  TextField+DatePicker.swift
//  UIUtils
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import DesignKit

@IBDesignable
public class DatePickerField: TextField {
    
    public var date: Date {
        datePicker.date
    }
    
    var datePicker: UIDatePicker! {
        didSet {
            inputView = datePicker
        }
    }
    
    var dateFormatter: DateFormatter!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        dateFormatter = DateFormatter()
        configureDatePicker()
        configureToolbar()
        configureDateFormatter()
    }
    
    private func configureDatePicker() {
        datePicker = UIDatePicker()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker.datePickerMode = .date
    }
    
    private func configureToolbar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))

        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        inputAccessoryView = toolBar
    }
    
    private func configureDateFormatter() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
    }
    
    private func setText() {
        text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc
    func dateChanged() {
        setText()
    }
    
    @objc
    func donePressed() {
        setText()
        endEditing(true)
    }
    
}