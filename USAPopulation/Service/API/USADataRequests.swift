//
//  USADataEndpoint.swift
//  USAPopulation
//
//  Created by michael on 04/11/2024.
//

import Foundation

public class USADataRequests: Requestable {
    public private(set) var header: [String : String]?
    public private(set) var body: ModelProtocol?
    public private(set) var path: String
    public private(set) var method: RequestMethod
    public private(set) var parameters: ModelProtocol?
    
    public init(header: [String : String]? = nil,
                body: ModelProtocol? = nil,
                parameters: ModelProtocol? = nil) {
        self.header = header
        self.body = body
        self.path = Constants.api
        self.path.append(path: Constants.data)
        self.method = .none
        self.parameters = parameters
    }
    
    public class PopulationData: USADataRequests {
        public init(headers: [String: String]?, parameters: ModelProtocol?) {
            super.init(header: headers, parameters: parameters)
            method = .get
        }
    }
    
    private enum Constants {
        static let api = "api"
        static let data = "data"
    }
}
