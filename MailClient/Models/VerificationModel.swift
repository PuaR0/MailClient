//
//  VerificationModel.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation

class VerificationModel {
    
    private let mailsDomeinArrey = ["@gmail.com", "@mail.ru", "@yahoo.com", "@yandex.ru"]
    
    public var mailsName = String()
    public var filtredMailsDomeinArrey = [String]()
    
    private func filtringMails(text: String) {
        
        var domeinMail = String()
        filtredMailsDomeinArrey = []
        
        guard let firstIdex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: text.endIndex)
        let range = text[firstIdex...endIndex]
        domeinMail = String(range)
        
        mailsDomeinArrey.forEach { mail in
            if mail.contains(domeinMail) {
                if !filtredMailsDomeinArrey.contains(mail) {
                    filtredMailsDomeinArrey.append(mail)
                }
            }
        }
    }
    
    private func deriveNameMale(text: String) {
        guard let atSimbolIndex = text.firstIndex(of: "@") else { return }
        let endIndex = text.index(before: atSimbolIndex)
        let firstIndex = text.startIndex
        let range = text[firstIndex...endIndex]
        mailsName = String(range)
    }
    
    public func getFiltredMail(text: String) {
        filtringMails(text: text)
    }
    
    public func getMailName(text: String) {
        deriveNameMale(text: text)
    }
}
