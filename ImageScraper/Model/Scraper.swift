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
    guard let url = URL(string: link) else {
        print("Error: \(link) doesn't seem to be a valid URL")
        return nil
    }
    
    do {
        return try String(contentsOf: url, encoding: .ascii)
    } catch let error {
        print("Error: \(error)")
        return nil
    }
}

// First, this function uses SwiftSoup to isolate the script elements in the web page's source
// Then, it calls getBase64ImageString() to extract the base64-encoded image data from the script
func getBase64StringsFromWebPageSource(source: String) -> [String] {
    var base64Strings = [String]()
    
    do {
        let scriptElements: Elements = try SwiftSoup.parse(source).select("script")
        for se in scriptElements.array() {
            if let scriptElement = try? se.html(){
                if let base64 = getBase64ImageString(html: scriptElement) {
                    base64Strings.append(base64)
                }
                
            }
        }
    } catch Exception.Error(_, let message) {
        print(message)
    } catch {
        print("Error parsing images from web page's source code")
    }
    
    return base64Strings
}

// This function uses a regex to extract the base64-image data from a script element
// In the source for google.com, image data is passed as a parameter to the _setImagesSrc Javascript function
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

