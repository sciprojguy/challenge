//
//  ContentView.swift
//  TraegerChallenge
//
//  Created by Admin on 10/23/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var apodItems:APODItems
    @EnvironmentObject var apodImgFetcher:APODImageFetcher
    @State private var detailItem:APODItemViewModel? = nil
    
    var body: some View {

        VStack {
            Text("Astronomical Pic of the Day").font(.largeTitle)
            if apodItems.items.count < 1 {
                Text("No APODs available")
            }
            else {
                //map items we get back from API to view model items
                List(apodItems.items.map {
                    APODItemViewModel(
                        formattedDate: $0.date,
                        itemTitle: $0.title,
                        itemUrl: $0.url,
                        itemImageName: URL(string: $0.url)?.lastPathComponent ?? "",
                        itemDescription: $0.explanation
                    )}, id:\.self) { item in
                    ListItem(item: item).onTapGesture {
                        if let imgName = URL(string: item.itemUrl)?.lastPathComponent {
                            //start image download if it's not already downloaded
                            if nil == apodImgFetcher.capturedImage(imgName: imgName) {
                                apodImgFetcher.fetchAPODImage(urlStr: item.itemUrl)
                            }
                            else {
                                apodImgFetcher.imageName = imgName
                            }
                            self.detailItem = item
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.sheet(item: $detailItem) { item in
            ItemDetail(item: item)
        }
        .onAppear(perform:  {apodItems.fetch7MostRecentAPODs()})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
