//
//  MockURLSession.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 30/05/2025.
//

@testable import BookAPiKit
import Foundation

class MockURLSession: URLSessionProtocol {
    var mockData: Data
    var mockResponse: URLResponse
    init(mockData: Data, mockResponse: URLResponse) {
        self.mockData = mockData
        self.mockResponse = mockResponse
    }
  
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
    
        return (mockData, mockResponse)
    }
}
