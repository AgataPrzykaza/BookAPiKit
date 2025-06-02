//
//  URLSessionProtocol.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 30/05/2025.
//

import Foundation

public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
