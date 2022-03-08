//
//  Router.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import Foundation
import Alamofire

enum APIRouter {
    case getData
}

extension APIRouter: HttpRouter {
    
    var baseURL: String {
        switch self {
        default : return "https://virtserver.swaggerhub.com/developernetwork/testingApi/1.0.0"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
        
    }
    
    var path: String {
        switch self {
        default:
            return "inventory"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        default: return URLEncoding.default
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default :
            return nil
        }
    }
    
    var body: Parameters? {
        switch self {
        default: return nil
        }
    }
    
}

protocol HttpRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Parameters? { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var parameter: Parameters? { return nil }

    func asURLRequest() throws -> URLRequest {

        var url =  try urlComponent().asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request = try URLEncoding.default.encode(request, with: body)
        
        return request
    }
    
    func urlComponent() throws -> URLComponents {
        var components = URLComponents(string: baseURL)!
        
        guard parameters != nil, let parameters = parameters else {
            return components
        }

        let items: [URLQueryItem] = parameters.map { (key, value) in
            return URLQueryItem(name: key, value: String(describing: value))
        }
        
        components.queryItems = items
        
        return components
    }
    
    func request(usingHttpService service: HttpService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}


