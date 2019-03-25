//
//  Test.swift
//  News
//
//  Created by Toan on 3/19/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit

//let categories: [String] = ["Category 1","Category 2","Category 3"]


class Test {
    struct Categories: Decodable{
        let feed: String
        
    }
    

    func fetchJSON() {
        guard let urlString = URL(string: completJson) else { return }
        URLSession.shared.dataTask(with: urlString) { (data, response, err) in
            DispatchQueue.main.async {
                if let err = err {
                    print("Failed to get data from URL :", err)
                    return
                }
                guard let data = data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    self.
                }
            }
        }.resume()
        
    }
}

