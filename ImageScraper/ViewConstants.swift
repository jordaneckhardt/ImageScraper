//
//  ViewConstants.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-02.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ViewConstants {
    static let cornerRadius: CGFloat = 8
    static let imageWidthAndHeight: CGFloat = 100
    static let numColumns: Int = Int(UIScreen.main.bounds.width / imageWidthAndHeight)
}
