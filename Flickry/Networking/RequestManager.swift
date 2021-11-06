//
//  RequestManager.swift
//  Flickry
//
//  Created by Denrick on 11/6/21.
//

import Foundation
import Moya
import Alamofire

class RequestManager: NSObject {
    static let shared = RequestManager()
    
    /// T: Target Type
    /// U: Model
    func request<T: TargetType, U: Decodable>(
        target: T,
        provider: MoyaProvider<T> = T.provider(),
        mappedTo decodableModelType: U.Type,
        at keyPath: String? = nil,
        isOnSecondAttemptAfterAuth: Bool = false,
        completion: @escaping (Result<U, FlickryError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let moyaResponse = try response.filterSuccessfulStatusCodes()
                    do {
                        let mappedResponse = try moyaResponse.map(decodableModelType, atKeyPath: keyPath, failsOnEmptyData: false)
                        completion(.success(mappedResponse))
                    } catch {
                        if !response.data.isEmpty {
                            print("[Mappable: \(decodableModelType)] \(error.localizedDescription)")
                        }
                        completion(.failure(.jsonParse))
                    }
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(.general))
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(.network))
            }
        }
    }
}
