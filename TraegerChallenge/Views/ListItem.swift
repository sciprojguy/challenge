//
//  APODListItemView.swift
//  TraegerChallenge
//
//  Created by Admin on 10/23/21.
//

import SwiftUI

struct ListItem: View {
    let item:APODItemViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(item.formattedDate)")
                .foregroundColor(.green)
                .font(.system(size: 12))
            Text("\(item.itemTitle)")
                .foregroundColor(.black)
                .font(.system(size:17))
        }
    }
}

struct APODListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItem(item: APODItemViewModel(formattedDate: "yyyy-mm-dd", itemTitle: "Joe's Bar", itemUrl: "url", itemImageName: "goo", itemDescription: "Joe's end of the galaxy bar"))
    }
}
