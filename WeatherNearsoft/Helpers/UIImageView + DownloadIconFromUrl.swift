//
//  UIImage + DownloadIconFromUrl.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 23/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadIcon(withUrlIconString link: String, contentMode mode: UIViewContentMode = .scaleAspectFit, completionHandler: @escaping(_ succes: Bool) -> Void) {
        guard let url = URL(string: link) else { return }
        downloadedFromUrl(url: url, contentMode: mode) { _ in
            completionHandler(true)
        }
    }
    
    private func downloadedFromUrl(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit, completionHandler: @escaping(_ succes: Bool) -> Void) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
                completionHandler(true)
            }         
        }.resume()
    }
}
