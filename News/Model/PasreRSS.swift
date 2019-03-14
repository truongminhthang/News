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
    
//    private var rrsItems: [RSSItem] = []
//    private var currentElemant = ""
//    private var currentTitle: String = ""
//    private var currentDescription: String = ""
//    private var currentPudDate: String = ""
//
//    // Closure
//
//    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    static let shared = ParseRSS()
    private override init() {
        
    }
    
    var xmlParser: XMLParser! // Parser Object
    var currentElement = ""    // Giu gia tri cho XML tag
    var foundCharacters = ""    // la gia tri cua tag, Ki tu duoc dong goi boi Tag
    var currentData = [String: String]() // Cac Item / Entry chua cac preperties se duoc nhet vao (currentData)
    var parsedData = [[String: String]]()   // Dai dien cho toan bo 1 RSS feed
    var isHeader = true     // La 1 moc cho biet da parse 1 feed item hoac header.
    
    //TODO: <#spec#>
    
    func startParsingWithContentsOfURL(_ rssURL: URL, with completion: (Bool) -> ()) {
        
        let parser = XMLParser(contentsOf: rssURL)
        parser?.delegate = self
        
        if let flag = parser?.parse() {
            // Xu ly item cuoi cung trong Feed.
            parsedData.append(currentData)
            completion(flag)
        }
        
        // https://medium.com/@MedvedevTheDev/xmlparser-working-with-rss-feeds-in-swift-86224fc507dc
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        // Item moi bat dau tai <item> tag, ta khong quan tam Header
        if currentElement == "item" || currentElement == "entry" {
            
            // Tai day, ta lam viec vs n + 1 entry
            
            if isHeader == false {
                parsedData.append(currentData)
            }
            
            isHeader = false
        }
        
        if isHeader == false {
            
            // Xu ly image thu nho cua bai viet
            if currentElement == "media:thumbnail" || currentElement == "media:content" {
                foundCharacters += attributeDict["url"]!
                
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if isHeader == false {
            
            if currentElement == "title" || currentElement == "link" || currentElement == "description" || currentElement == "content" || currentElement == "pudDate" || currentElement == "author" || currentElement == "dc:creator" || currentElement == "content:encoded" {
                
                foundCharacters += string
//                foundCharacters = foundCharacters.dele
//                foundCharacters = foundCharacters.deleteHTML(tags: ["a","p","div","img"])
                
//                foundCharacters = foundCharacters.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if !foundCharacters.isEmpty {
            
            foundCharacters = foundCharacters.trimmingCharacters(in: .whitespacesAndNewlines)
            currentData[currentElement] = foundCharacters
            foundCharacters = ""
        }
    }
    
    
    
    
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
    
    //
    
}
