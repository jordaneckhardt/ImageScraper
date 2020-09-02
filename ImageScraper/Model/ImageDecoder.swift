//
//  ImageDecoder.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import UIKit

func decodeImageFromBase64String(_ base64: String) -> UIImage? {
    if let dataDecoded = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) {
        return UIImage(data: dataDecoded)
    }
    
    return nil
}
