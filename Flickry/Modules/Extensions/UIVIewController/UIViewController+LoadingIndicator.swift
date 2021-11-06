//
//  UIViewController+LoadingIndicator.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit
import SnapKit

extension UIViewController {
    
    // Shows loading animation
    func startLoading() {
        guard let topView = view.window,
              !topView.subviews.contains(where: { $0 is LoadingIndicatorView }) else {
            return
        }
        
        let loadingView = LoadingIndicatorView.loadFromNib()
        
        topView.addSubview(loadingView)
        topView.bringSubviewToFront(loadingView)
        loadingView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        loadingView.show()
    }
    
    // Removes loading animation
    func stopLoading() {
        guard let topView = view.window,
              let loadingView = topView.subviews.first(where: { $0 is LoadingIndicatorView }) as? LoadingIndicatorView else {
            return
        }
        
        loadingView.remove()
    }
}
