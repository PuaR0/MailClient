//
//  MailCollectionVCell.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation
import UIKit

class MailCollectionVCell: UICollectionViewCell {
    
    private let domainLbl: UILabel = {
        let label = UILabel()
        label.text = "@gmail.com"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.alpha = 0.5
        contentView.layer.cornerRadius = 10
        
        addSubview(domainLbl)
    }
    
    private func configure(mailLabelText: String) {
        domainLbl.text = mailLabelText
    }
    
    public func cellConfigure(mailLabelText: String) {
        configure(mailLabelText: mailLabelText)
    }
}


extension MailCollectionVCell {
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            domainLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            domainLbl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}




