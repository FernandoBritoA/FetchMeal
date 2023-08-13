//
//  Extensions.swift
//  FetchMeal
//
//  Created by Fernando Brito on 13/08/23.
//

import Foundation
import UIKit

extension UIImageView {
    func load(with url: URL) async {
        let cache = URLCache.shared
        let request = URLRequest(url: url)

        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image

        } else {
            self.image = nil

            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let image = UIImage(data: data) else { return }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)

                self.image = image
            } catch {
                print(error)
            }
        }
    }
}
