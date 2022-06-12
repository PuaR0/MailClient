//
//  Alerts.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation
import UIKit

struct Alert {
    private static func showSimpleAlert(vc: UIViewController,
                                        title: String,
                                        massage: String) {
        let alertController = UIAlertController(title: title,
                                                message: massage,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(ok)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    private static func showChangeAlert(vc: UIViewController,
                                       title: String,
                                       massage: String,
                                       copletion:
                                       @escaping() -> Void) {
        let alertController = UIAlertController(title: title,
                                                message: massage,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {_ in
            copletion()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    static func showResultAlert(vc: UIViewController, massage: String) {
        showSimpleAlert(vc: vc, title: "Result", massage: massage)
    }
    
    static func showErrorAlert(vc: UIViewController, massage: String, completion: @escaping() -> Void) {
        showChangeAlert(vc: vc, title: "Error", massage: massage, copletion: completion)
    }
}
