//
//  URLSession+Mock.swift
//  WeatherForecastTests
//
//  Created by Hoang Ta on 10/8/24.
//

import Foundation

extension URLSession {
    static var mock: URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: config)
    }
}

final class URLProtocolMock: URLProtocol {
    static var requestData: ((URL) -> Data)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url, let data = URLProtocolMock.requestData?(url) {
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
            client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
