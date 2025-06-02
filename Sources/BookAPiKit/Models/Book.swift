//
//  Book.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 28/05/2025.
//

import Foundation

public struct Book: Identifiable, Decodable, Sendable {
    
    public let id: String
    public let title: String
    public let authors: [String]
    public let publishedDate: String?
    public let description: String?
    public let thumbnailURL: URL?
    
    public init(id: String, title: String, authors: [String],publishedDate: String? = nil, description: String? = nil, thumbnailURL: URL? = nil) {
        self.id = id
        self.title = title
        self.authors = authors
        self.publishedDate = publishedDate
        self.description = description
        self.thumbnailURL = thumbnailURL
    }
    
    
}
