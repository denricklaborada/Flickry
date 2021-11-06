//
//  FlickrAPI.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation
import Moya

enum FlickrAPI {
    case search(params: FlickrSearchParams)
}

extension FlickrAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.flickr.com/services/rest")!
    }

    var path: String {
        switch self {
        case .search:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .search(let params):
            let method = "flickr.photos.search"
            let apiKey = "96358825614a5d3b1a1c3fd87fca2b47"
            let format = "json"
            let noJsonCallback = 1
            let perPage = 25
            let parameters: [String: Any] = ["method": method,
                                             "api_key": apiKey,
                                             "format": format,
                                             "nojsoncallback": noJsonCallback,
                                             "per_page": perPage,
                                             "text": params.text,
                                             "page": params.page]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        let headers = ["Content-type": "application/json"]
        return headers
    }
}
