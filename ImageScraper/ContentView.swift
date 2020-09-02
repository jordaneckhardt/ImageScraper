//
//  ContentView.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State public var userQuery = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $userQuery, onCommit: {
                    DispatchQueue.global(qos: .background).async {
                        print("Scraping for new images")
                        
                        let newImages = scrape(query: self.userQuery)
                        
                        DispatchQueue.main.async {
                            print("Updating UI after updating images")
                            self.userData.images.removeAll()
                            self.userData.images.append(contentsOf: newImages)
                            
                        }
                    }
                    
                    
                })
                    .padding()
                
                List (userData.images) { image in
                    Image(uiImage: image.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                }
            }
            .navigationBarTitle("Images")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}
