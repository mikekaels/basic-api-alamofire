//
//  APIManager.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import Foundation
import CoreData

enum CustomError: Error {
    case noInternetConnection
    case unexpected
}

class APIManager {
    static let shared = APIManager()
    private let httpService = Service()
    
    func fetchAllPost(completion: @escaping(Result<Inventory, CustomError>) -> Void) {
        
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .getData
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        do {
                            let result = try JSONDecoder().decode(Inventory.self, from: data)
                            completion(.success(result))
                        } catch {
                            print(error)
                            completion(.failure(.unexpected))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
}
