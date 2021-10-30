//
//  ItemDetail.swift
//  TraegerChallenge
//
//  Created by Admin on 10/24/21.
//

import SwiftUI

struct ItemDetail: View {
    
    @EnvironmentObject var apodImgFetcher:APODImageFetcher
    var item:APODItemViewModel
    var imgName: String?
    var body: some View {
        ScrollView {
            VStack(spacing: 4) {
                Text(item.itemTitle).font(.headline)
                if let img = APODImageFetcher().capturedImage(imgName: item.itemImageName) {
                    Image(uiImage: img).resizable().frame(width: 256, height: 256, alignment: .center)
                }
                else {
                    Text("Image not cached")
                }
                Text(item.itemDescription ?? "no description available")
                    .lineLimit(nil).font(.subheadline)
            }.background(Color.white).frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail(item: APODItemViewModel(formattedDate: "2021-10-30", itemTitle: "Dummy", itemUrl: "", itemImageName: "goo", itemDescription: "Dummy item"))
    }
}
