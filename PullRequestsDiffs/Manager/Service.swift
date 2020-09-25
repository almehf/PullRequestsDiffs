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
//     "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls"
    private let baseURL = "https://api.github.com/repos/magicalpanda/MagicalRecord/pulls?state=all"
    
    
    
    func getPulls(completionHandler: @escaping (Result<[Pull], PRError>) -> Void) {
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
                let pullReq = try decoder.decode([Pull].self, from: data)
                
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
    
        func getFiles(PRNumber: Int, completionHandler: @escaping (Result<[File], PRError>) -> Void) {
            let endpoint = baseURL + "/\(PRNumber)/files"
            
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
                    let files = try decoder.decode([File].self, from: data)
                    
                    print("Files Count is :\(files.count)")
                    completionHandler(.success(files))
                    return
                } catch let errJsonParse {
                    print("error while decoding json:  \(errJsonParse)")
                    completionHandler(.failure(.invalidData))
                    return
                }
            }
            task.resume()
        }
}


