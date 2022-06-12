//
//  VerificationButton.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation
import UIKit

class VerificationButton: UIButton {
    
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
        backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        setTitle("Проверка", for: .normal)
        let color = #colorLiteral(red: 0.1764705882, green: 0.1843137255, blue: 0.1568627451, alpha: 1)
        setTitleColor(color, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        isEnabled = false
        alpha = 0.5
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setNotValidSettings() {
        isEnabled = false
        alpha = 0.5
    }
    
    private func setValidSettings() {
        isEnabled = true
        alpha = 1
    }
    
    public func setDefaultSettings() {
        configure()
    }
}
