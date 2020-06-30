//
//  TextField.swift
//  DesignKit
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

@IBDesignable
open class TextField: UITextField, UITextFieldDelegate {
    
    public enum Style {
        case active
        case writing
        case wrote
    }
    
    let padding = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
    
    @IBInspectable
    var defaultColor: UIColor? {
       didSet {
           textColor = defaultColor
           configStyle()
       }
   }
    
    @IBInspectable
    var secondaryColor: UIColor? {
       didSet {
           configurePlaceholder()
           configStyle()
       }
   }
    
    @IBInspectable
    var invalidColor: UIColor? {
       didSet {
           configStyle()
       }
    }
    
    private var style: Style = .active {
        didSet {
            configStyle()
        }
    }
    
    public var isValid: Bool? {
        didSet {
            configStyle()
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
        configStyle()
        configurePlaceholder()
        
        addTarget(self, action: #selector(onFocus), for: .editingDidBegin)
        addTarget(self, action: #selector(onDismiss), for: .editingDidEnd)
        
        cornerRadius = frame.height / 2
        borderWidth = 2
    }
    
    private func configurePlaceholder() {
        guard let color = secondaryColor else { return }
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "",
                                                   attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    @objc
    private func onFocus() {
        style = .writing
    }
    
    @objc
    private func onDismiss() {
        if let text = text,
            !text.isEmpty {
            style = .wrote
        } else {
            style = .active
        }
    }
    
    @objc
    private func configStyle() {
        if let isValid = isValid, !isValid {
            borderColor = invalidColor
            textColor = invalidColor
            return
        }
        textColor = defaultColor
        switch style {
        case .active, .wrote:
            borderColor = secondaryColor
        case .writing:
            borderColor = defaultColor
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
