//
//  TargetType+Provider.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation
import Moya

extension TargetType {
    
    // adds logging of api calls
    public static func provider() -> MoyaProvider<Self> {
        return MoyaProvider<Self>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    }
}
