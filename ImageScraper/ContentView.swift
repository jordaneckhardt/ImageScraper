//
//  ContentView.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $query)
                    .padding()
                
                List (images) { image in
                    Image(uiImage: image.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(25)
                    
                    
                    
                }
                .listStyle(PlainListStyle())
                
            }
            .navigationBarTitle("Images")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
