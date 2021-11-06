//
//  FlickrService.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation

class FlickrService {
    private let requestManager = RequestManager.shared
    
    // api call to search
    func fetchImages(params: FlickrSearchParams, completion: @escaping (Result<FlickrSearchResponse, FlickryError>) -> Void) {
        requestManager.request(target: FlickrAPI.search(params: params), mappedTo: FlickrSearchResponse.self, at: "photos", completion: completion)
    }
}
