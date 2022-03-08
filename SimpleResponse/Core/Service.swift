//
//  Service.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import Foundation
import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}

final class Service: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<600)
    }
    
}

