//
//  UIViewController+Error.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit

extension UIViewController {
    
    // Shows error alert
    func showErrorAlert(with error: FlickryError) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
