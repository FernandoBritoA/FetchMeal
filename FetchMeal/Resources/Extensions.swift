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
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }

        } else {
            DispatchQueue.main.async { [weak self] in
                self?.image = nil
            }

            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let image = UIImage(data: data) else { return }
                let cachedData = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cachedData, for: request)

                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error)
            }
        }
    }
}

enum ToastType {
    case success
    case error
}

extension UIViewController {
    func showToast(message: String, type: ToastType) {
        let padding = 5.0
        let verticalOffset = 100.0
        let horizontalOffset = 20.0
        let bgColor = type == .success ? UIColor.black : UIColor.systemRed

        let containerView = UIView(frame: CGRect(
            x: horizontalOffset,
            y: self.view.frame.size.height - verticalOffset,
            width: self.view.frame.width - horizontalOffset * 2,
            height: 40 + padding * 2))

        let toastLabel = UILabel(frame: CGRect(
            x: padding,
            y: padding,
            width: containerView.frame.width - padding * 2,
            height: containerView.frame.height - padding * 2))

        containerView.alpha = 1.0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = bgColor.withAlphaComponent(0.9)

        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.textAlignment = .center
        toastLabel.textColor = UIColor.white
        toastLabel.font = .systemFont(ofSize: 12)

        containerView.addSubview(toastLabel)
        self.view.addSubview(containerView)

        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            containerView.alpha = 0.0
        }, completion: { _ in
            containerView.removeFromSuperview()
        })
    }
}
