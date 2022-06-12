//
//  ViewController.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private let backGrndImageVeiw: UIImageView = {
        let imageVeiw = UIImageView()
        imageVeiw.image = UIImage(named: "фон")
        imageVeiw.contentMode = .scaleAspectFit
        imageVeiw.translatesAutoresizingMaskIntoConstraints = false
        return imageVeiw
    }()
    
    private let statusLbl = StatusLbl()
    private let mailTF = MailTF()
    private let verificationButton = VerificationButton()
    private let collectionView = MailsCollectionView(frame: .zero,
                                                     collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var stackView = UIStackView(arrangedSubviews: [mailTF,
                                                                verificationButton,
                                                                collectionView],
                                             axis: .vertical,
                                             spacing: 20)
    
    private let verificationModel = VerificationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setVeiws()
        setDelegates()
        setConstrains()
    }
    
    private func setVeiws() {
        view.addSubview(backGrndImageVeiw)
        view.addSubview(statusLbl)
        view.addSubview(stackView)
        verificationButton.addTarget(self,
                                     action: #selector(verificationButtonTapped),
                                     for: .touchUpInside)
    }
    
    private func setDelegates() {
        collectionView.dataSource = self
        collectionView.selectMailDelegate = self
        mailTF.textFieldDelegate = self
    }
    
    @objc private func verificationButtonTapped() {
        
        guard let mail = mailTF.text else { return }
        
        NetworkDataFetch.shared.fatchMail(verifaibleMale: mail) { result, error in
            
            if error == nil {
                guard let result = result else { return }
                if result.success {
                    guard let didYouMeanError = result.did_you_mean else {
                        Alert.showResultAlert(vc: self,
                                              massage: "Mail status \(result.result) \n \(result.reasonDescription)")
                        return
                    }
                    Alert.showErrorAlert(vc: self,
                                         massage: "Did you mean: \(didYouMeanError)") { [weak self] in
                        guard let self = self else { return }
                        self.mailTF.text = didYouMeanError
                    }
                }
            } else {
                guard let errorDescription = error?.localizedDescription else { return }
                Alert.showResultAlert(vc: self, massage: errorDescription)
            }
        }
    }
}


//MARK: - UICollectionViewDataSource

extension VerificationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        verificationModel.filtredMailsDomeinArrey.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell.idMailCell.rawValue,
                                                            for: indexPath) as? MailCollectionVCell
        else { return UICollectionViewCell() }
        
        let mailLabelText = verificationModel.filtredMailsDomeinArrey[indexPath.row]
        cell.cellConfigure(mailLabelText: mailLabelText)
        
        return cell
    }
}

//MARK: - SelectProposedMailProtocol

extension VerificationViewController: SelectProposedMailProtocol {
    func selectProposedMail(indexPath: IndexPath) {
        guard let text = mailTF.text else { return }
        verificationModel.getMailName(text: text)
        let domeinMail = verificationModel.filtredMailsDomeinArrey[indexPath.row]
        let mailFullName = verificationModel.mailsName + domeinMail
        mailTF.text = mailFullName
        statusLbl.isValid = mailFullName.isValid()
        verificationButton.isValid = mailFullName.isValid()
        verificationModel.filtredMailsDomeinArrey = []
        collectionView.reloadData()
    }
}

//MARK: - ActionsMailTFProtocol

extension VerificationViewController: ActionsMailTFProtocol {
    
    func typingText(text: String) {
        statusLbl.isValid = text.isValid()
        verificationButton.isValid = text.isValid()
        verificationModel.getFiltredMail(text: text)
        collectionView.reloadData()
    }
    
    func cleenOutTF() {
        statusLbl.setDefaultSettings()
        verificationButton.setDefaultSettings()
        verificationModel.filtredMailsDomeinArrey = []
        collectionView.reloadData()
    }
}

//MARK: - setConstrains

extension VerificationViewController {
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backGrndImageVeiw.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backGrndImageVeiw.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            statusLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            statusLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLbl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mailTF.heightAnchor.constraint(equalToConstant: 50),
            stackView.topAnchor.constraint(equalTo: statusLbl.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
