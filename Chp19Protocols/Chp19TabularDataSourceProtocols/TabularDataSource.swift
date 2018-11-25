//
//  TabularDataSource.swift
//  Chp19TabularDataSource
//
//  Created by Youngkin, Richard on 10/17/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

/*
 * Key points:
 *  1.  Definition of a protocol via the 'protocol' keyword
 *  2.  Designating getter/setter on protocol definition (e.g., numberOfRows)
 */
protocol TabularDataSource {
    var numberOfRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    
    func itemFor(row: Int, column: Int) -> String
}
