//
//  Network Tests.swift
//  Recipes
//
//  Created by Mason Peralta on 10/9/24.
//

//import Foundation
//
//class MockURLProtocol: URLProtocol {
//    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
//    
//    override class func canInit(with request: URLRequest) -> Bool {
//        return true // Intercept all requests
//    }
//
//    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//        return request
//    }
//
//    override func startLoading() {
//        guard let handler = MockURLProtocol.requestHandler else {
//            fatalError("Handler is unavailable.")
//        }
//        
//        do {
//            let (response, data) = try handler(request)
//            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
//            client?.urlProtocol(self, didLoad: data)
//            client?.urlProtocolDidFinishLoading(self)
//        } catch {
//            client?.urlProtocol(self, didFailWithError: error)
//        }
//    }
//
//    override func stopLoading() {
//        // No need to handle this for now
//    }
//}
//
