//
//  Protocol.swift
//  food-review-unit-test-demo
//
//  Created by Kelvin Fok on 24/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    
    func fetchMovies(completion: @escaping (dictionary?, Error?) -> Void)
    
    
}
