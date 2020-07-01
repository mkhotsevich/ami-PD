//
//  SpinnerView.swift
//  UIUtils
//
//  Created by Artem Kufaev on 01.07.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit

open class SpinnerView: UIView {

    // MARK: - Subviews
    public private(set) lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        return indicator
    }()

    public private(set) lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    // MARK: - Configure
    private func setupLayout() {
        self.addSubview(blurView)
        self.addSubview(indicatorView)
        setupConstraints()
    }

    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            self.blurView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.blurView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.blurView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.blurView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

            self.indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }

}
