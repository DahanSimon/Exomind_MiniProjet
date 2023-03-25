//
//  UIImageView+Exomin_MiniProjet.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 24/03/2023.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                    self?.image = UIImage(systemName: "questionmark.square.dashed")
                }
            } else {
                DispatchQueue.main.async {
                    self?.image = UIImage(systemName: "questionmark.square.dashed")
                }
            }
        }
    }
}
