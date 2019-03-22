//
//  PasreRSS.swift
//  News
//
//  Created by Toan on 3/13/19.
//  Copyright © 2019 Toan.IOS. All rights reserved.
//

import UIKit
// MARK: - Parse link Feeds thanh Title, Image, DateTime

public enum NetworkResponseStatus {
    case success
    case err(string: String?)
}

struct RSSItem {
    var title : String
    var description : String
    var pubDate : String
    var img : UIImage?
    
    init(title: String,description: String, pubDate: String, imgString: String) {
        self.title = title
        self.description = description
        self.pubDate = pubDate
        /// Convert to Image.
        let imgUrl = NSURL(string: imgString)
        guard let _imgUrl = imgUrl else {return}
        guard let data = NSData(contentsOf: _imgUrl as URL) else {return}
        let image = UIImage(data: data as Data)
        self.img = image
    }
}

// MARK: - Get feed links

class RSSParser: NSObject, XMLParserDelegate {

    private var rssItems: [RSSItem] = []
    private var currentElement = ""
    //TODO: Remove whitespace around strings in swift

    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentImage: String = ""
    var currentImage1: [AnyObject] = []
    
    private var parserCompletionHandler: (([RSSItem]) -> Void)?
    
    func parseFeed(url: String, completionHandler: (([RSSItem]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        let request = URLRequest(url: URL(string: url)!) 
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else {
                if let err = err {
                    print(err.localizedDescription)
                }
                return
            }
            ///Parse xml data
            let parser = XMLParser(data: data)
            parser.delegate = self
            // Boolen parse()
            parser.parse()
        }.resume()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        // Item moi bat dau tai <item> tag, ta khong quan tam Header
        if currentElement == "item" {
            //}|| currentElement == "entry" {
            // Tai day, ta lam viec vs n + 1 entry
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentImage = ""
        }
        else if currentElement == "enclosure" {
            if let urlString = attributeDict["url"] {
                currentImage1.append(urlString as AnyObject)
                guard let _urlString = urlString as? String else {return}
                currentImage.append(_urlString) // dang nil
            }
        }
    
    }
    
    func parser(_ parser: XMLParser,foundCharacters string: String) {
        switch currentElement {
        case "title" : currentTitle += string
        case "description" :
//            let removed = "/>"
//            var a = string.components(separatedBy: "/>")[1]
            
            currentDescription += string
            
        case "pubDate" : var a = string.components(separatedBy: "+").first
                        currentPubDate += a!
        default: break
//            "/>
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, description: currentDescription, pubDate: currentPubDate, imgString: currentImage.description)
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error)
    {
        print(parseError.localizedDescription)
    }
    
}
