//
//  GoogleBooksResponse.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 28/05/2025.
//

struct GoogleBooksResponse: Decodable {
    struct Volume: Decodable {
        let id: String
        let volumeInfo: VolumeInfo
    }

    struct VolumeInfo: Decodable {
        let title: String
        let authors: [String]?
        let publishedDate: String?
        let description: String?
        let imageLinks: ImageLinks?
        let categories: [String]?
    }

    struct ImageLinks: Decodable {
        let thumbnail: String?
    }

    let items: [Volume]?
}
