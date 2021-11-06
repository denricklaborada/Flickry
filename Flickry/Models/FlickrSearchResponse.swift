//
//  FlickrSearchResponse.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation

// Response model for the search API
struct FlickrSearchResponse: Codable {
    var page: Int
    var pages: Int
    var photos: [FlickrSearchPhoto]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case photos = "photo"
    }
}

// Model for photos list
struct FlickrSearchPhoto: Codable {
    var id: String
    var farm: Int
    var server: String
    var secret: String
    
    var imageURL: String {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
