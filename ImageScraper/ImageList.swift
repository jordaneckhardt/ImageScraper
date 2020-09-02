//
//  ContentView.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ImageList: View {
    @State public var userQuery = ""
    @EnvironmentObject var userData: UserData
    let numColumns: Int = Int(UIScreen.main.bounds.width / 120)
    
    
    init() {
         UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $userQuery, onCommit: {
                    DispatchQueue.global(qos: .background).async {
                        let newImagesList = scrape(query: self.userQuery)
                        let numRows: Int = Int(ceil(Double(newImagesList.count) / Double(self.numColumns)))
                        
                        var newImagesGrid = [[IdentifiableImage]]()
                        for row in 0..<numRows {
                            newImagesGrid.append([IdentifiableImage]())
                            for column in 0..<self.numColumns {
                                let imageIndexInList = row * self.numColumns + column
                                if imageIndexInList >= newImagesList.count {
                                    break
                                }
                                
                                let newImage = newImagesList[imageIndexInList]
                                newImagesGrid[row].append(newImage)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.userData.images.removeAll()
                            self.userData.images.append(contentsOf: newImagesGrid)
                        }
                    }
                })
                    .padding()
                
                List (self.userData.images, id: \.self){ imageRow in
                    HStack {
                        Spacer()
                        ForEach(imageRow) { image in
                            Image(uiImage: image.image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                            
                        }
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Images")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ImageList()
            .environmentObject(UserData())
    }
}
