//
//  UIViewController+Loading.swift
//  UIUtils
//
//  Created by Artem Kufaev on 01.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

public protocol Loading {
    func showSpinner()
    func hideSpinner()
}

private let spinnerSize: CGFloat = 100
private let spinnerTag = 413

extension Loading where Self: UIViewController {

    public func showSpinner() {
        DispatchQueue.main.async {
            let windowFrame = UIScreen.main.bounds
            let frame = CGRect(x: windowFrame.width / 2 - spinnerSize / 2,
                               y: windowFrame.height / 2 - spinnerSize / 2,
                               width: spinnerSize,
                               height: spinnerSize)
            let spinnerView = SpinnerView(frame: frame)
            spinnerView.indicatorView.startAnimating()
            spinnerView.tag = spinnerTag
            self.view.isUserInteractionEnabled = false
            self.view.addSubview(spinnerView)
        }
    }

    public func hideSpinner() {
        DispatchQueue.main.async {
            guard let spinnerView = self.view.viewWithTag(spinnerTag) as? SpinnerView else { return }
            spinnerView.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            spinnerView.removeFromSuperview()
        }
    }

}
