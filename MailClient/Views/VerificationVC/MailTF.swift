//
//  MailTF.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation
import UIKit

protocol ActionsMailTFProtocol: AnyObject {
    func typingText(text: String)
    func cleenOutTF()
}

class MailTF: UITextField {
    
    weak var textFieldDelegate: ActionsMailTFProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 10
        textColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.2549019608, alpha: 1)
        leftView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: 16,
                                        height: self.frame.height))
        leftViewMode = .always
        clearButtonMode = .always
        returnKeyType = .done
        placeholder = "Введите почту"
        font = UIFont.systemFont(ofSize: 20)
        tintColor = #colorLiteral(red: 0.4823529412, green: 0.5294117647, blue: 0.4196078431, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension MailTF: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let rangeText = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: rangeText, with: string)
            textFieldDelegate?.typingText(text: updateText)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textFieldDelegate?.cleenOutTF()
        return true
    }
}
