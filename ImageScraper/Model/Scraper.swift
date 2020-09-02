//
//  Scraper.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import UIKit
import SwiftSoup

func scrape(query: String) -> [IdentifiableImage] {
    var images = [IdentifiableImage]()
    
    let urlQuery = query.replacingOccurrences(of: " ", with: "+")
    let url = "https://www.google.ca/search?q=google+images+" + urlQuery

    let webPageSource = getPageSource(link: url)
    
    if let nonNullSource = webPageSource {
        let base64Strings = getBase64StringsFromWebPageSource(source: nonNullSource)
       
        for base64 in base64Strings {
            if let uiImage = decodeImageFromBase64String(base64){
                let identifiableImage = IdentifiableImage(image: uiImage)
                images.append(identifiableImage)
            }
        }
    }
    
    return images
}


func getPageSource(link: String) -> String? {
    guard let myURL = URL(string: link) else {
        print("Error: \(link) doesn't seem to be a valid URL")
        return nil
    }
    
    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        return myHTMLString
    } catch let error {
        print("Error: \(error)")
        return nil
    }
}

func getBase64StringsFromWebPageSource(source: String) -> [String] {
    var base64Strings = [String]()
    
    do {
        let els: Elements = try SwiftSoup.parse(source).select("script")
        for e in els.array() {
            if let element = try? e.html(){
                if let base64 = getBase64ImageString(html: element) {
                    base64Strings.append(base64)
                }
                
            }
        }
    } catch Exception.Error(_, let message) {
        print(message)
    } catch {
        print("error")
    }
    
    return base64Strings
}

func getBase64ImageString(html: String) -> String? {
    let pattern = #"\(function\(\)\{var s='data:image\/jpeg;base64,(.*)';var ii=(.*?);_setImagesSrc\(ii,s\);\}\)\(\);"#
    let regex = try? NSRegularExpression(pattern: pattern)
    
    if let match = regex?.firstMatch(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count)) {
        if let captureRange = Range(match.range(at: 1), in: html) {
            var base64string = String(html[captureRange])
            if (base64string.hasSuffix("\\x3d\\x3d")) {
                base64string.removeLast(8)
                base64string.append("==")
            }
            return base64string
        }
    }
    
    return nil
}

