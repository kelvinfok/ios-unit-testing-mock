//
//  APIClient.swift
//  food-review-unit-test-demo
//
//  Created by Kelvin Fok on 24/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

typealias dictionary = [String : Any]

class APIClient {
    
    enum APIError: Error {
        case serviceError
    }

    func login(_ userName: String, password: String, completion: @escaping (dictionary?, Error?) -> Void) {
        
        guard let url = URL.init(string: "http://localhost:8181/api/login") else {
            completion(nil, APIError.serviceError)
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(password, forHTTPHeaderField: "password")
        request.addValue(userName, forHTTPHeaderField: "userName")
        execute(request, completion: completion)
    }
    
    func execute(_ request: URLRequest, completion: @escaping (dictionary?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                completion(nil, APIError.serviceError)
                return
            }
            guard let data = data, error == nil else {
                completion(nil, APIError.serviceError)
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? dictionary else {
                    completion(nil, APIError.serviceError)
                    return }
                completion(jsonDictionary, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

}

extension APIClient: APIClientProtocol {
    
    func fetchMovies(completion: @escaping (dictionary?, Error?) -> Void) {
        
        let urlString = "https://api.myjson.com/bins/su9fu"
        
        guard let url = URL.init(string: urlString) else {
            completion(nil, APIError.serviceError)
            return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        execute(request, completion: completion)
    }
}
