//
//  BookSearchType.swift
//  BookAPiKit
//
//  Created by Agata Przykaza on 30/05/2025.
//

public enum BookSearchType {
    
    case all
    case author
    case title
    
    public func buildQuery(from term: String) -> String{
        let encoded = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? term
                switch self {
                case .all:
                    return encoded
                case .author:
                    return "inauthor:\(encoded)"
                case .title:
                    return "intitle:\(encoded)"
                }
    }
    
}
