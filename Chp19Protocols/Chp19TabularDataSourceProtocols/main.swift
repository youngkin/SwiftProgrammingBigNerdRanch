//
//  main.swift
//  Chp19TabularDataSource
//
//  Created by Youngkin, Richard on 10/17/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

import Foundation

/*
 * Key points:
 *
 *  1.  Use of protocols to extend structs & classes
 */

var department = Department(name: "Engineering")
department.add(Person(name: "Joe", age: 1_000, yearsOfExperience: 6))
department.add(Person(name: "Karen", age: 40, yearsOfExperience: 18))
department.add(Person(name: "Fred", age: 50, yearsOfExperience: 20))

printTable(department)

var books = BookCollection()
books.add(Book(title: "HP 1", authors: ["JKR"], avgReview: 5))
books.add(Book(title: "HP 2", authors: ["JKR"], avgReview: 5))
books.add(Book(title: "HP 7", authors: ["JKR"], avgReview: 5))

//printTable(books)
