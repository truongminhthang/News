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

protocol GetDataFromAPI: class {
    func getArrayLinks()
}

struct key {
    var key: String?
    
    init(json: [String: Any]) {
        self.key = "\(json.keys.description)"
    }
}


class JSON {
    
    
//    private init() {
//        
//    }
    weak var delegate: GetDataFromAPI?

    var categories : [String: [String]] = [:]
    

    var arrayCategory1: [String] = []
    var arrayCategory2: [String] = []
    var arrayCategory3: [String] = []
    
    var stringg : String = "Toan Le"
    
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
//                let keyJson = key(json: json)
//                //FIXME: Lay key de goi thanh category
//                json.keys.forEach({ (data) in
////                    categories["\(json.keys)", default: [].append(stringg)])
//                    self.categories["\(json.keys)", default: []].append("\(json.values)")
//                    print(self.stringg)
//                })
//                categories.keys = json.keys
        }
//        guard let urlString = URL(string: url) else { return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else {return}
//            do {
//
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {return}
//                let categoryKey = key[json: json]
//
//            } catch let err {
//                print("\(err)")
//            }
//        }
        
    }
//    func transData() {
//        
//        getJsonFeedTemplate(url: completJson) { (json) in
//            guard let dataFeedLink = FeedTemplateModel(JSON: json) else { return }
//            
//            json.keys.forEach({ (data) in
//                self.categories["\(json.keys.description)", default: []].append(dataFeedLink.category1![2].feed!)
//            })
//            print(self.categories)
//        }
//    }
    
    
//     get data from json
    func getData() {
        getJsonFeedTemplate(url: completJson) { json in
            guard let dataFeedLink = FeedTemplateModel(JSON: json) else { return }
//            let dataFeedCategory = dataFeedLink.category1
            for i in 0..<json.keys.count {
                self.arrayCategory1.append(dataFeedLink.category1![i].feed!)
                self.arrayCategory2.append(dataFeedLink.category2![i].feed!)
                self.arrayCategory3.append(dataFeedLink.category3![i].feed!)
            }
        }
    }
    
    
    
}
