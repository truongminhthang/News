//
//  PasreRSS.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
// MARK: - Parse link Feeds thanh Title, Image, DateTime
import ReadabilityKit
import Alamofire
import AlamofireRSSParser

public enum NetworkResponseStatus {
    case success
    case err(string: String?)
}


struct RSSItem {
    var title : String
    var description : String
    var pudDate : String
    
    init(title: String,description: String, pudDate: String) {
        self.title = title
        self.description = description
        self.pudDate = pudDate
    }
}

class ParseRSS: NSObject, XMLParserDelegate {
//    let demoLinkRSS = "https://www.bisnis.com/rss"
    let url = URL(string: "https://www.bisnis.com/rss")
    
    private var rrsItems: [RSSItem] = []
    private var currentElemant = ""
    private var currentTitle: String = ""
    private var currentDescription: String = ""
    private var currentPudDate: String = ""
    
    // Closure
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    
    
}

public class RSSParser {
    public static func getRSSFeedResponse(path: String, completionHandler: @escaping (_ response: RSSFeed?,_ status: NetworkResponseStatus) -> Void) {
        Alamofire.request(path).responseRSS() { response in
            if let rssFeedXML = response.result.value {
                // Successful response - process the feed in your completion handler
                completionHandler(rssFeedXML, .success)
            } else {
                // There was an error, so feel free to handle it in your completion handler
                completionHandler(nil, .err(string: response.result.error?.localizedDescription))
            }
        }
    }
}
