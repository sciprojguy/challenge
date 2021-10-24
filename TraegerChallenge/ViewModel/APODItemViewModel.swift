//
//  APODItemViewModel.swift
//  TraegerChallenge
//
//  Created by Admin on 10/24/21.
//

import Foundation

struct APODItemViewModel: Hashable {
    let formattedDate: String
    let itemTitle: String
    let itemUrl: String
    let itemImageName: String
    var itemDescription: String?
}

extension APODItemViewModel {
    
    static func viewModelForListItem(item: APODItem) -> APODItemViewModel {
        //TODO: format date as EEE, mmm dd yyyy later on
        return APODItemViewModel(formattedDate: item.date, itemTitle: item.title, itemUrl: item.url, itemImageName: URL(string: item.url)?.lastPathComponent ?? "", itemDescription: nil)
    }
    
    static func viewModelForDetailView(item: APODItem) -> APODItemViewModel {
        //TODO: format date as EEE, mmm dd yyyy
        return APODItemViewModel(formattedDate: item.date, itemTitle: item.title, itemUrl: item.url, itemImageName: URL(string: item.url)?.lastPathComponent ?? "", itemDescription: item.explanation)
    }
    
}
