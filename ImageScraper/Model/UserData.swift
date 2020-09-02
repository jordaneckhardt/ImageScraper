//
//  UserData.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI
import Combine

final class UserData : ObservableObject {
    @Published var images = [[IdentifiableImage]]()
}
