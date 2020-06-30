//
//  RegisterInfoFillViewController.swift
//  ami
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UIUtils
import DataManager
import NetworkCore

// MARK: - Builder

class RegisterInfoFillViewControllerBuilder {
    
    static func build(email: String, password: String) -> RegisterInfoFillViewController {
        let controller = RegisterInfoFillViewController()
        controller.registerData = (email, password)
        controller.authManager = AuthManager()
        controller.errorParser = NetworkErrorParser()
        controller.router = BaseRouter(controller: controller)
        return controller
    }
    
}

class RegisterInfoFillViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var infoPlaceholderView: InfoPlaceholderView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    
    var registerData: (email: String, password: String)!
    
    // MARK: Dependences
    
    var authManager: AuthManager!
    var router: BaseRouter!
    var keyboardHelper: KeyboardHelper!
    var errorParser: NetworkErrorParser!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hideKeyboardWhenTapped()
        errorParser.delegate = self
        keyboardHelper = KeyboardHelper(view: view,
                                        scrollView: scrollView)
        keyboardHelper.startObserve()
    }
    
    deinit {
        keyboardHelper.stopObserve()
    }
    
    // MARK: - Actions

    @IBAction func startRegisterProccess(_ sender: Any) {
        guard let email = registerData?.email,
            let password = registerData?.password,
            let name = infoPlaceholderView.nameField.text,
            let surname = infoPlaceholderView.surnameField.text,
            let heightStr = infoPlaceholderView.heightField.text?.replacingOccurrences(of: ",", with: "."),
            let height = Double(heightStr),
            let weightStr = infoPlaceholderView.weightField.text?.replacingOccurrences(of: ",", with: "."),
            let weight = Double(weightStr) else {
                return
        }
        let birthdate = infoPlaceholderView.birthdateField.date
        authManager.register(email: email,
                             password: password,
                             name: name,
                             surname: surname,
                             birthdate: birthdate,
                             weight: weight,
                             height: height,
                             appleId: nil,
                             vkId: nil) {
            self.proccessRegisterResponse($0)
        }
    }
    
    // MARK: - Private
    
    private func proccessRegisterResponse(_ response: NetworkResultWithModel<AuthData>) {
        switch response {
        case .success(let authData):
            showAlert(alertText: "Успешно!",
                      alertMessage: "Ваш ID в системе: \(authData.user.id)\nТокен доступа: \(authData.accessToken)") {
                self.toMain()
            }
        case .failure(let error):
            errorParser.parse(error)
        }
    }

}

// MARK: - NetworkErrorParserDelegate

extension RegisterInfoFillViewController: NetworkErrorParserDelegate {
    
    func showMessage(_ message: String) {
        showAlert(alertText: "Ошибка", alertMessage: message)
        DispatchQueue.main.async {
            self.router.pop(animated: true)
        }
    }
    
    func goToAuth() { }
    
}
