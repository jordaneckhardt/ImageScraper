//
//  ImageListViewModel.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-02.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import UIKit

class ImageListViewModel : ObservableObject, Identifiable {
    @Published var images = [[IdentifiableImage]]()

    func userDidSearch(query: String) {
        DispatchQueue.global(qos: .background).async {
            let newImagesList = scrape(query: query)
            let numRows: Int = Int(ceil(Double(newImagesList.count) / Double(ViewConstants.numColumns)))
            
            var newImagesGrid = [[IdentifiableImage]]()
            for row in 0..<numRows {
                newImagesGrid.append([IdentifiableImage]())
                for column in 0..<ViewConstants.numColumns {
                    let imageIndexInList = row * ViewConstants.numColumns + column
                    if imageIndexInList >= newImagesList.count {
                        break
                    }
                    
                    let newImage = newImagesList[imageIndexInList]
                    newImagesGrid[row].append(newImage)
                }
            }
            
            DispatchQueue.main.async {
                self.images.removeAll()
                self.images.append(contentsOf: newImagesGrid)
            }
        }
    }
}
