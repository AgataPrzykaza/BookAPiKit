//
//  BookAPIService.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 28/05/2025.
//

import Foundation



public protocol BookAPIServiceProtocol {
    func searchBooks(query: String,type: BookSearchType,maxResult: Int) async throws -> [Book]
}


public struct BookAPIService: BookAPIServiceProtocol {
    private let session: URLSessionProtocol

    
        public init() {
            self.session = URLSession.shared as! any URLSessionProtocol
        }
        
        
        init(session: URLSessionProtocol) {
            self.session = session
        }
  

    public func searchBooks(query: String,type: BookSearchType = .all,maxResult: Int = 20) async throws -> [Book] {
        let queryValue = type.buildQuery(from: query)
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(queryValue)&maxResults=\(maxResult)"
        guard let url = URL(string: urlString) else {
            throw BookAPIError.invalidURL
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw BookAPIError.invalidResponse
        }

        do {
            let decoded = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
            let books = decoded.items?.compactMap { volume -> Book? in
                let info = volume.volumeInfo
                return Book(
                    id: volume.id,
                    title: info.title,
                    authors: info.authors ?? ["Nieznany autor"],
                    publishedDate: info.publishedDate,
                    description: info.description,
                    thumbnailURL: info.imageLinks.flatMap { URL(string: $0.thumbnail ?? "") },
                    categories: info.categories
                )
            } ?? []
            
            return books
        }
        catch{
            throw BookAPIError.decodingFailed
        }
    }
    

}
