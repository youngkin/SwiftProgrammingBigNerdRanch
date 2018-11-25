//
//  BookCollection.swift
//  Chp19TabularDataSource
//
//  Created by Youngkin, Richard on 10/17/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

struct BookCollection: TabularDataSource {
    var books = [Book]()
    
    var numberOfRows: Int {
        return books.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    mutating func add(_ book: Book) {
        books.append(book)
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Title"
        case 1: return "Author"
        case 2: return "Average Review"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let book = books[row]
        switch column {
        case 0: return book.title
//        case 1: return book.authors.reduce("", {partRes, nextPartRes in
//            partRes + ", " + nextPartRes
//        })
        case 1:
            var authors = book.authors[0]
            switch book.authors.count {
            case 0: return ""
            case 1: return book.authors[0]
            case 2: return book.authors[0] + ", " + book.authors[1]
            case 3: return book.authors[0] + ", " + book.authors[1] + ", " + book.authors[2]
            default:
                for i in 1...book.authors.count - 2 {
                    authors = authors + ", " + book.authors[i]
                }
            authors = authors + book.authors[book.authors.count - 1]
            return authors
            }
        
        case 2: return String(book.avgReview)
        default: fatalError("Invalid column!")
        }
    }
}
