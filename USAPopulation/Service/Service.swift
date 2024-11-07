//
//  Service.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public protocol ServiceProtocol {
    func sendRequest<T: Decodable>(request: Requestable, responseModel: T.Type) async -> Result<T, RequestError>
}

extension ServiceProtocol {
    public func sendRequest<T: Decodable>(request: Requestable, responseModel: T.Type) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = request.scheme
        urlComponents.host = request.host
        urlComponents.path = "/" + request.path
        urlComponents.queryItems = request.toURLQueryItems()
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.header
        
        if let body = request.body {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        return .failure(.serverError(errorResponse.error))
                    }
                    
                    return .success(decodedResponse)
                } catch {
                    debugPrint(error)
                    return .failure(.decode)
                }
            case 401:
                debugPrint(response)
                return .failure(.unauthorized)
            default:
                debugPrint(response)
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            debugPrint(error)
            return .failure(.unknown)
        }
    }
}
