//
//  FlickryError.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation

// Custom Error for API Calls
enum FlickryError: Error {
    case general
    case network
    case jsonParse
}

// MARK: - Properties

extension FlickryError {
    var title: String {
        return "Error Occurred"
    }
    
    var message: String {
        switch self {
        case .general:
            return "Oops, something went wrong. Please try again later."
        case .network:
            return "Request timed out."
        case .jsonParse:
            return "There was a problem parsing the response."
        }
    }
}
