//
//  JSON.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
import Alamofire
// MARK: - Lay data tu JSON


let completJson : String = "https://raw.githubusercontent.com/gadote/smartnewstest/master/feeds_template.json"

class JSON {
    
    var arrayCategory1: [String] = []
    var arrayCategory2: [String] = []
    var arrayCategory3: [String] = []
    
    // request API -> json
    func getJsonFeedTemplate(url: String, completJson:  @escaping ([String: Any]) -> Void) {
        guard let urlString = URL(string: url) else { return }
        let urlRequest = URLRequest(url: urlString)
        Alamofire.request(urlRequest)
            .responseJSON { response in
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                completJson(json)
        }

    }
    
    // get data from json
    func getData() {
    
        
        getJsonFeedTemplate(url: completJson) { [weak self] json in
            guard let dataFeedLink = FeedTemplateModel(JSON: json) else { return }
            for i in 0...2 {
                self?.arrayCategory1.append(dataFeedLink.category1![i].feed!)
                self?.arrayCategory2.append(dataFeedLink.category1![i].feed!)
                self?.arrayCategory3.append(dataFeedLink.category1![i].feed!)
            }
        }
    }
    
}
