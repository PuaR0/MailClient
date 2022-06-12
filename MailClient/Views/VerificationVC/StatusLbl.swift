//
//  StatusLbl.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation
import UIKit

class StatusLbl: UILabel {
    
    public var isValid = false {
        didSet {
            if self.isValid {
                setValidSettings()
            } else {
                setNotValidSettings()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Проверь свою почту"
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        font = UIFont.systemFont(ofSize: 16)
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setNotValidSettings() {
        text = "Почта не действительна! Попробуйте: name@domein.com"
        textColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
    }
    
    private func setValidSettings() {
        text = "Почта не корректна!"
        textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    }
    
    public func setDefaultSettings() {
        configure()
    }
}
