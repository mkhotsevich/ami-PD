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

class RegisterInfoFillViewController: UIViewController {
    
    @IBOutlet weak var infoPlaceholderView: InfoPlaceholderView!
    
    var registerData: (email: String, password: String)!
    
    var authManager: AuthManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.hideKeyboardWhenTapped()
        authManager = AuthManager()
    }

    @IBAction func startRegisterProccess(_ sender: Any) {
        guard let email = registerData?.email,
            let password = registerData?.password,
            let name = infoPlaceholderView.nameField.text,
            let surname = infoPlaceholderView.surnameField.text,
            let heightStr = infoPlaceholderView.heightField.text,
            let height = Double(heightStr),
            let weightStr = infoPlaceholderView.weightField.text,
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
                             vkId: nil) { (result) in
            switch result {
            case .success(let authData):
                self.showAlert(alertText: "Успешно!", alertMessage: "Ваш ID в системе: \(authData.user.id)\nТокен доступа: \(authData.accessToken)") {
                    print()
                }
            case .failure(let error):
                switch error {
                case .serverFailed(let code, let msg):
                    self.showAlert(alertText: "Ошибка сервера \(code)", alertMessage: msg) {
                        print()
                    }
                default:
                    self.showAlert(alertText: "Сетевая ошибка", alertMessage: error.localizedDescription) {
                        print()
                    }
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
