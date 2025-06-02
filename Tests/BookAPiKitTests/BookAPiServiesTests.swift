//
//  BookAPiServiesTests.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 30/05/2025.
//

import Testing
@testable import BookAPiKit
import Foundation

@Test func testSearchBooksReturnsBooks() async throws {
    
    let jsonString = """
    {
      "items": [
        {
          "id": "1",
          "volumeInfo": {
            "title": "Test Book",
            "authors": ["Test Author"],
            "publishedDate": "2020",
            "description": "Test description",
            "imageLinks": { "thumbnail": "http://example.com/thumb.jpg" }
          }
        }
      ]
    }
    """
    let data = jsonString.data(using: .utf8)!
    let response = HTTPURLResponse(
        url: URL(string: "https://www.googleapis.com/books/v1/volumes?q=test")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!

    let mockSession = MockURLSession(mockData: data, mockResponse: response)
    let service = BookAPIService(session: mockSession)

    let books = try await service.searchBooks(query: "test")

    #expect(books.count == 1)
    #expect(books.first?.title == "Test Book")
    #expect(books.first?.authors == ["Test Author"])
    #expect(books.first?.thumbnailURL?.absoluteString == "http://example.com/thumb.jpg")
}

@Test func testSearchBooksReturnsEmptyArrayWhenNoItems() async throws {
    let jsonString = """
    {
      "items": []
    }
    """
    let data = jsonString.data(using: .utf8)!
    let response = HTTPURLResponse(
        url: URL(string: "https://www.googleapis.com/books/v1/volumes?q=test")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!

    let mockSession = MockURLSession(mockData: data, mockResponse: response)
    let service = BookAPIService(session: mockSession)

    let books = try await service.searchBooks(query: "test")

    #expect(books.isEmpty)
}

@Test func testSearchBooksThrowsInvalidResponseFor404() async {
    let data = "Not Found".data(using: .utf8)!
    let response = HTTPURLResponse(
        url: URL(string: "https://www.googleapis.com/books/v1/volumes?q=test")!,
        statusCode: 404,
        httpVersion: nil,
        headerFields: nil
    )!

    let mockSession = MockURLSession(mockData: data, mockResponse: response)
    let service = BookAPIService(session: mockSession)

    await #expect(throws: BookAPIError.invalidResponse) {
        try await service.searchBooks(query: "test")
    }
}

@Test func testSearchBooksThrowsDecodingErrorForInvalidJSON() async {
    let invalidJSON = "{ invalid json }"
    let data = invalidJSON.data(using: .utf8)!
    let response = HTTPURLResponse(
        url: URL(string: "https://www.googleapis.com/books/v1/volumes?q=test")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil
    )!

    let mockSession = MockURLSession(mockData: data, mockResponse: response)
    let service = BookAPIService(session: mockSession)

    await #expect(throws: BookAPIError.decodingFailed) {
        try await service.searchBooks(query: "test")
    }
}
