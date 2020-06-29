//
//  Button.swift
//  Button
//
//  Created by Artem Kufaev on 30.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

@IBDesignable
public class Button: UIButton {
    
    @IBInspectable
    public var normalBackgroundColor: UIColor? {
        didSet {
            updateBackgroundColor()
        }
    }
    
    @IBInspectable
    public var disabledBackgroundColor: UIColor? {
        didSet {
            updateBackgroundColor()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureUI()
    }
    
    private func configureUI() {
        cornerRadius = 5.0
    }
    
    public func setEnabled(_ isEnabled: Bool) {
        self.isEnabled = isEnabled
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        backgroundColor = isEnabled ? normalBackgroundColor : disabledBackgroundColor
    }
    
}
