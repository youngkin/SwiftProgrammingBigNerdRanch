//
//  Utilities.swift
//  Chp19TabularDataSource
//
//  Created by Youngkin, Richard on 10/17/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

func printTable(_ dataSource: TabularDataSource & CustomStringConvertible) {
    print("Table: \(dataSource.description)")
    // Create first row containing column headers
    var firstRow = "|"
    
    // Also keep track of the width of each column
    var columnWidths = [Int]()
    
    for i in 0 ..< dataSource.numberOfColumns { // Note, this statement uses a half-open range operator (see basic operators in the language guide)
        let columnLabel = dataSource.label(forColumn: i)
        let columnHeader = " \(columnLabel) |"
        firstRow += columnHeader
        columnWidths.append(columnLabel.count)
    }
    for _ in 0...firstRow.count - 1 {
        print("-", terminator: "")
    }
    print("")

    print(firstRow)
    
    for _ in 0...firstRow.count - 1 {
        print("-", terminator: "")
    }
    print("")
    
    for i in 0 ..< dataSource.numberOfRows {
        // Start the output string
        var out = "|"
        
        // Append each item in this row to the string
        for j in 0 ..< dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: i, column: j)
            let paddingNeeded = columnWidths[j] - item.count
            var padding = ""
            if paddingNeeded >= 0 {
                padding = repeatElement(" ", count:
                    paddingNeeded).joined(separator: "")
            } 
            out += " \(padding)\(item) |"
        }
        
        // Done - print it!
        print(out)
    }
    
    for _ in 0...firstRow.count - 1 {
        print("-", terminator: "")
    }
    print("")
}
