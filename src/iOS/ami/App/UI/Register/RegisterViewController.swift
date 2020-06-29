//
//  RegisterViewController.swift
//  ami
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UIUtils
import Validator
import DesignKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: TextField!
    @IBOutlet weak var confirmPasswordField: TextField!
    
    @IBOutlet weak var continueButton: Button!
    
    var router: RegisterRouter!
    private weak var selectedField: TextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        
        router = RegisterRouter(controller: self)
        view.hideKeyboardWhenTapped()
        validateForm()
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjustForKeyboard),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(adjustForKeyboard),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let keyboardHeight = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
            scrollView.contentOffset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    @IBAction func continueRegister(_ sender: Any) {
        guard let email = emailField.text,
            let password = passwordField.text else { return }
        router.toInfoPlaceholder(email: email, password: password)
    }
    
    private func validateForm() {
        let isValidEmail = validateEmail(emailField)
        let isValidPassword = validatePassword(passwordField)
        let isValidConfirmPassword = validateConfirmPassword(password: passwordField,
                                                             confirmPassword: confirmPasswordField)
        
        continueButton.setEnabled(isValidEmail && isValidPassword && isValidConfirmPassword)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    enum ValidationErrors: String, ValidationError {
        case emailInvalid = "Email не корректен"
        case passwordInvalid = "Слабый пароль"
        case passwordNotConfirm = "Пароли не совпадают"
        var message: String { return self.rawValue }
    }
    
    private func validateEmail(_ email: UITextField) -> Bool {
        let rule = ValidationRulePattern(pattern: EmailValidationPattern.standard,
                                         error: ValidationErrors.emailInvalid)
        return email.validate(rule: rule).isValid
    }
    
    private func validatePassword(_ password: UITextField) -> Bool {
        let rule = ValidationRuleLength(min: 5,
                                        max: 20,
                                        error: ValidationErrors.passwordInvalid)
        return password.validate(rule: rule).isValid
    }
    
    private func validateConfirmPassword(password: UITextField,
                                         confirmPassword: UITextField) -> Bool {
        let rule = ValidationRuleEquality<String>(dynamicTarget: {
            return password.text ?? ""
        }, error: ValidationErrors.passwordNotConfirm)
        return confirmPassword.validate(rule: rule).isValid
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let textField = textField as? TextField else { return }
        
        let isValidEmail = validateEmail(emailField)
        let isValidPassword = validatePassword(passwordField)
        let isValidConfirmPassword = validateConfirmPassword(password: passwordField,
                                                             confirmPassword: confirmPasswordField)
        switch textField {
        case emailField:
            guard emailField.isValid != nil else { return }
            emailField.isValid = isValidEmail
        case passwordField:
            guard passwordField.isValid != nil else { return }
            passwordField.isValid = isValidPassword
        case confirmPasswordField:
            guard confirmPasswordField.isValid != nil else { return }
            confirmPasswordField.isValid = isValidConfirmPassword
        default: fatalError()
        }
        
        continueButton.setEnabled(isValidEmail && isValidPassword && isValidConfirmPassword)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isValidEmail = validateEmail(emailField)
        let isValidPassword = validatePassword(passwordField)
        let isValidConfirmPassword = validateConfirmPassword(password: passwordField,
                                                             confirmPassword: confirmPasswordField)
        switch textField {
        case emailField:
            emailField.isValid = isValidEmail
        case passwordField:
            passwordField.isValid = isValidPassword
        case confirmPasswordField:
            confirmPasswordField.isValid = isValidConfirmPassword
        default: fatalError()
        }
        
        continueButton.setEnabled(isValidEmail && isValidPassword && isValidConfirmPassword)
    }
    
}
