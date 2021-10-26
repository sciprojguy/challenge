//
//  APODItem.swift
//  TraegerChallenge
//
//  Created by Admin on 10/23/21.
//

import SwiftUI
import Combine

struct APODItem:Decodable, Hashable {
    let date: String
    let explanation: String
    let hdurl: String?
    let media_type: String
    let service_version: String
    let title: String
    let url: String
    let copyright: String?
}

class APODItems: ObservableObject {
    
    @Published var items:[APODItem] = []
    @Published var httpError:HTTPError? = nil
    @Published var fetchProgress:FetchProgress = .idle

    var sub: AnyCancellable? = nil
    var pub: AnyPublisher<[APODItem], Error>? = nil

    func fetchAPODs(starting:Date, ending:Date) {
        let fmtr = DateFormatter()
        fmtr.dateFormat = "yyyy-MM-dd"
        
        self.fetchProgress = .inProgress
        
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&start_date=\(fmtr.string(from: starting))&end_date=\(fmtr.string(from: ending))")!

        pub = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse
                    else {
                        throw HTTPError.noResponse
                }
                guard response.statusCode == 200
                else {
                    self.fetchProgress = .succeeded
                    throw HTTPError.statusCode(response.statusCode)
                }
                return output.data
            }
            .decode(type: [APODItem].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        sub = pub?.receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.httpError = error as? HTTPError
                self.fetchProgress = .failed(error)
            }
        }, receiveValue: { receivedItems in
            //sort so that we start with today and go backwards
            self.items = receivedItems.sorted { $0.date > $1.date }
        })

    }
    
    func fetchMostRecentAPODs(nDays:Int) {
        let today = Date()
        guard let nDaysAgo = Calendar.current.date(byAdding: .day, value: -nDays, to: today)
        else {
            return //throw error
        }
        
        fetchAPODs(starting: nDaysAgo, ending: today)
    }
    
    func fetch7MostRecentAPODs() {
        fetchMostRecentAPODs(nDays: 6)
    }
    
    //func fetchAPODImage(url: URL)
}
