//
//  Endpoint.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public typealias ModelProtocol = Codable

public protocol Requestable {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: ModelProtocol? { get }
    var parameters: ModelProtocol? { get }
    
    func toURLQueryItems() -> [URLQueryItem]?
}

extension Requestable {
    public var scheme: String {
        return "https"
    }
    
    public var host: String {
        return "datausa.io"
    }
    
    public var parameters: String? {
        return nil
    }
    
    public func toURLQueryItems() -> [URLQueryItem]? {
        guard let parameters = parameters else { return nil }
        
        guard let data = try? JSONEncoder().encode(parameters),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return nil
        }
        
        return dictionary.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
    }
}

public enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case none
}

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case serverError(String)
    case unknown
    
    public var customMessage: String {
        switch self {
        case .decode:
            return "There was an issue decoding the response. Please try again."
        case .invalidURL:
            return "The requested URL is invalid. Please check the URL."
        case .noResponse:
            return "No response received from the server. Please check your connection."
        case .unauthorized:
            return "Session expired. Please log in again."
        case .unexpectedStatusCode:
            return "An unexpected status code was received. Please try again later."
        case .serverError(let message):
            return "Server error: \(message)"
        case .unknown:
            return "An unknown error occurred. Please try again later."
        }
    }
}
