//
//  ViewController.swift
//  food-review-unit-test-demo
//
//  Created by Kelvin Fok on 24/2/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Tutorial video - https://www.youtube.com/watch?v=zB61-7E7eoo
    
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIClient().fetchMovies { (json, error) in
            if let error = error {
                print(error)
            } else if let json = json {
                do {
                    let data = try JSONSerialization.data(withJSONObject: json, options: [])
                    let movies = try JSONDecoder().decode(Movies.self, from: data)
                    DispatchQueue.main.async {
                        self.textView.text = "\(movies)"
                    }
                } catch {
                    print(String(describing: error))
                }
            } else {
                fatalError()
            }
        }
    }
}

struct Movies: Codable {
    let movies: [Movie]
}

struct Movie: Codable {
    let title: String
    let actors: [String]
    let genre: String
}
