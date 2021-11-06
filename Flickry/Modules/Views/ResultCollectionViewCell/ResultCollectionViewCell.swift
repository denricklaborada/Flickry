//
//  ResultCollectionViewCell.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import UIKit
import Reusable
import Kingfisher

class ResultCollectionViewCell: UICollectionViewCell, NibReusable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Setup
    
    func setup(imageUrl: String) {
        imageView.kf.indicatorType = .activity // add animation when fetching image from url
        imageView.kf.setImage(with: URL(string: imageUrl)) // sets image
    }
}
