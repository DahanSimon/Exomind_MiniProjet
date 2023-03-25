//
//  UIViewController+Exomind_MiniProjet.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 24/03/2023.
//

import Foundation
import UIKit

extension UIViewController {
    func presentAlert(message: String, title: String, handler: ((UIAlertAction) -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}
