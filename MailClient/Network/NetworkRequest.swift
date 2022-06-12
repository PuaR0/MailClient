//
//  NetworkRequest.swift
//  MailClient
//
//  Created by Алиага С on 11.6.2022.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    private init() {}
    
    func reqestData(verifaibleMail: String, completion: @escaping(Result<Data, Error>) -> Void) {
        
        let urlString = "https://api.kickbox.com/v2/verify?email=\(verifaibleMail)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }
        .resume()
    }
}
