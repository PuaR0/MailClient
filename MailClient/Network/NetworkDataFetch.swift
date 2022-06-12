//
//  NetworkDataFetch.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    private init() {}
    
    func fatchMail(verifaibleMale: String, responce: @escaping (MailResponseModel?, Error?) -> Void) {
        NetworkRequest.shared.reqestData(verifaibleMail: verifaibleMale) { result in
            switch result{
            case .success(let data):
                do {
                    let mail = try JSONDecoder().decode(MailResponseModel.self, from: data)
                    responce(mail, nil)
                } catch let jsonError {
                    print("Faild to decode JSON", jsonError)
                }
            case .failure(let error):
                print("Error recieved requesting dsta: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
