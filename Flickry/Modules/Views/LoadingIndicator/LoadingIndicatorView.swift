//
//  LoadingIndicatorView.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit
import Reusable

class LoadingIndicatorView: UIView, NibLoadable {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // animates the view when presenting
    func show() {
        containerView.transform = .init(scaleX: 0.8, y: 0.8)
        blurBackground()
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.8,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.containerView.transform = .identity
            }, completion: nil
        )
    }
    
    // removes the view from superview with animation
    func remove() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.alpha = 0
            self.containerView.transform = .init(scaleX: 0.8, y: 0.8)
            self.backgroundColor = .clear
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            self.removeFromSuperview()
        })
    }
    
    // adds animation when adding background
    private func blurBackground() {
        backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
}
