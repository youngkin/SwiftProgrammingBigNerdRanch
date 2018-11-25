//
//  Department.swift
//  Chp19TabularDataSource
//
//  Created by Youngkin, Richard on 10/17/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

/*
 * Key points:
 *  1.  Implements a protocol (TabularDataSource)
 *  2.  Alternate Array initialization syntax using an implied type and default
 *      initializer ([Person]())
 */

struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()
    
    var numberOfRows: Int {
        return people.count
    }
    
    var numberOfColumns: Int {
        return 3
    }
    
    var description: String {
        return "Department (\(name))"
    }
    
    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0: return "Employee Name"
        case 1: return "Age"
        case 2: return "Years of Experience"
        default: fatalError("Invalid column!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearsOfExperience)
        default: fatalError("Invalid column!")
        }
    }
}
