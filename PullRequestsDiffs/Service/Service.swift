//
//  Service.swift
//  PullRequestsDiffs
//
//  Created by Fahad Almehawas  on 9/23/20.
//  Copyright © 2020 Fahad Al. All rights reserved.
//

import UIKit

class Service {
    
    static let shared = Service()
    private let baseURL = "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls"

    func getPulls(completionHandler: @escaping (Result<[Pulls], PRError>) -> Void) {
        let endpoint = baseURL
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pullReq = try decoder.decode([Pulls].self, from: data)
                
                print("pull req is :\(pullReq.count)")
                completionHandler(.success(pullReq))
                return
            } catch {
                print("err")
                completionHandler(.failure(.invalidData))
                return
            }
        }
        task.resume()
    }
}

