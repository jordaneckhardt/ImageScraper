//
//  ImageDetail.swift
//  ImageScraper
//
//  Created by Jordan Eckhardt on 2020-09-02.
//  Copyright © 2020 Jordan Eckhardt. All rights reserved.
//

import SwiftUI

struct ImageDetail: View {
    var image: IdentifiableImage
    
    var body: some View {
        Image(uiImage: image.image)
            .cornerRadius(ViewConstants.cornerRadius)
    }
}

//struct ImageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetail(image: image)
//    }
//}
