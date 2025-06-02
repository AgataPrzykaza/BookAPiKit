import Testing
@testable import BookAPiKit

@Test func testBuildQueryAll() {
    
    let type = BookSearchType.all
    let term = "Harry Potter"
    let result = type.buildQuery(from: term)
    let encoded = "Harry%20Potter"
    
    #expect(result == encoded)
}


@Test func testBuildQueryTitle() {
    
    let type = BookSearchType.title
    let term = "Harry Potter"
    let result = type.buildQuery(from: term)
    let encoded = "Harry%20Potter"
    
    #expect(result == "intitle:\(encoded)")
}

@Test func testBuildQueryAuthor() {
    
    let type = BookSearchType.author
    let term = "Penn Cole"
    let result = type.buildQuery(from: term)
    let encoded = "Penn%20Cole"
    
    #expect(result == "inauthor:\(encoded)")
}
