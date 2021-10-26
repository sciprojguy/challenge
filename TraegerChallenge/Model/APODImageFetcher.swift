//
//  ImageFetcher.swift
//  TraegerChallenge
//
//  Created by Admin on 10/23/21.
//

import UIKit
import Combine

class APODImageFetcher: ObservableObject {
    
    @Published var httpError:HTTPError? = nil
    @Published var fetchProgress:FetchProgress = .idle
    @Published var imageName:String? = nil
    
    //method adapted from https://theswiftdev.com/how-to-download-files-with-urlsession-using-combine-publishers-and-subscribers/
    func fetchAPODImage(urlStr: String) {
        
        guard let remoteUrl = URL(string: urlStr)
        else {
            return
        }
        
        // download task
        URLSession.shared.downloadTask(with: remoteUrl) { [weak self] url, response, error in
            guard
                let urlResponse = response as? HTTPURLResponse,
                let cache = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first,
                let url = url
            else {
                return
            }

            //grab the stem of urlStr and use that as the filename
            //duh.  modify pc
            let contentType = urlResponse.value(forHTTPHeaderField: "Content-Type")
            if !["image/png", "image/jpg", "image/jpeg"].contains(contentType) {
                DispatchQueue.main.async {
                    self?.imageName = "nil"
                }
                return
            }
            
            let pc = remoteUrl.lastPathComponent
            do {
                let file = cache.appendingPathComponent(pc)
                if FileManager.default.fileExists(atPath: file.path) {
                    try? FileManager.default.removeItem(atPath: file.path)
                }
                try FileManager.default.moveItem(atPath: url.path,
                                                 toPath: file.path)
                DispatchQueue.main.async {
                    self?.imageName = pc
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func capturedImage(imgName: String) -> UIImage? {
        if let cache = FileManager.default.urls(for: .cachesDirectory,
                        in: .userDomainMask).first {
            let file = cache.appendingPathComponent(imgName)
            if FileManager.default.fileExists(atPath: file.path) {
                return UIImage(contentsOfFile: file.path)
            }
        }
        return nil
    }
}
