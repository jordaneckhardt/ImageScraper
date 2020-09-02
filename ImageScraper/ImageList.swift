//
//  ContentView.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-01.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ImageList: View {
    @ObservedObject var viewModel: ImageListViewModel
    @State public var userQuery = ""
    
    init(viewModel: ImageListViewModel) {
        self.viewModel = viewModel
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $userQuery, onCommit: {
                            self.viewModel.userDidSearch(query: self.userQuery)
                        })
                            .foregroundColor(.primary)
                        
                        if !userQuery.isEmpty {
                            Button(action: {
                                self.userQuery = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                }
                .padding(.horizontal)

                
                List (viewModel.images, id: \.self){ imageRow in
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
        ImageList(viewModel: ImageListViewModel())
    }
}
