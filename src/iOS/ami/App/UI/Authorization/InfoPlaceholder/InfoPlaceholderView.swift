//
//  InfoPlaceholderView.swift
//  ami
//
//  Created by Artem Kufaev on 29.06.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import UIKit
import UIUtils
import DesignKit

class InfoPlaceholderView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var nameField: TextField!
    @IBOutlet weak var surnameField: TextField!
    @IBOutlet weak var birthdateField: DatePickerField!
    @IBOutlet weak var heightField: TextField!
    @IBOutlet weak var weightField: TextField!
    
//    static func loadViewFromNib() -> InfoPlaceholderView {
//        let bundle = Bundle(for: self)
//        let nib = UINib(nibName: "InfoPlaceholderView", bundle: bundle)
//        return nib.instantiate(withOwner: nil, options: nil).first {
//            ($0 as? UIView)?.restorationIdentifier == "InfoPlaceholderView"
//        }! as! InfoPlaceholderView
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibInit()
    }
    
    private func xibInit() {
        Bundle.main.loadNibNamed("InfoPlaceholderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
}
