//
//  IdentifiableImage.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import UIKit

class IdentifiableImage : NSObject, Identifiable {
    public var image: UIImage
    var id: UUID

    init(image: UIImage) {
        self.image = image
        self.id = UUID()
    }
}
