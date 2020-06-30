//
//  LabelTextField.swift
//  DesignKit
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import SwiftUI
import UIUtils

public struct LabelTextField: View {
    
    var keyboardType: UIKeyboardType
    var returnKeyType: UIReturnKeyType
    let textContentType: UITextContentType
    var tag: Int
    @State var content: String
    var placeHolder: String
    var isSecure: Bool
    
    public init(keyboardType: UIKeyboardType,
                returnKeyType: UIReturnKeyType,
                textContentType: UITextContentType,
                tag: Int,
                content: String,
                placeHolder: String,
                isSecure: Bool) {
        self.keyboardType = keyboardType
        self.returnKeyType = returnKeyType
        self.textContentType = textContentType
        self.tag = tag
        self.placeHolder = placeHolder
        self.isSecure = isSecure
        _content = State(initialValue: content)
    }
 
    public var body: some View {
        TextFieldTyped(keyboardType: .asciiCapable,
                       returnVal: returnKeyType,
                       textContentType: textContentType,
                       tag: tag,
                       isSecure: isSecure,
                       text: $content,
                       placeholder: placeHolder)
            .padding(.all, 13)
            .overlay(RoundedRectangle(cornerRadius: 50).stroke(ColorPalette.secondary.color(), lineWidth: 2))
    }
}

struct LabelTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabelTextField(keyboardType: .default, returnKeyType: .continue, textContentType: .username, tag: 0, content: "Some", placeHolder: "Set it!", isSecure: false)
    }
}

public struct TextFieldTyped: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    let returnVal: UIReturnKeyType
    let textContentType: UITextContentType
    let tag: Int
    let isSecure: Bool
    
    @Binding var text: String
    let placeholder: String

    public func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnVal
        textField.textContentType = textContentType
        textField.tag = tag
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure

        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {
        return
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldTyped

        init(_ textField: TextFieldTyped) {
            self.parent = textField
        }

        func updatefocus(textfield: UITextField) {
            textfield.becomeFirstResponder()
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }

    }
}
