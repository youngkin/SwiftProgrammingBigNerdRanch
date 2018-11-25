//
//  Town.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/*
 * Key points:
 *  1.  Use of custom initializers
 */

import Foundation

struct Town {
    let region: String
    var population: Int64 {
        // 'didSet' is a property observer. It is fired after a property has changed.
        // There is a corresponding `willSet` that will fire just before a property
        // is changed.
        didSet(oldPopulation) {
            // Bronze challenge - only log population changes if the population decreases
            if population < oldPopulation {
                //print("The population has changed to \(population) from \(oldPopulation).")
                mayor.makeStatement()
            }
        }
    }
    var numberOfStoplights: Int
    
    let mayor = Mayor()
 
    // Note the use of 'self' in the first 2 assignments but not in the 3rd.
    // That's because it needs to disambiguate the parameter names from the
    // property names.
    // Also note the use of the "Optional" indication on the init function. This is used
    // to indicate that the initializer may fail and hence returns an 'Optional'.
    init?(region: String, population: Int64, stoplights: Int) {
        guard population > 0 else {
            return nil
        }
        self.region = region
        self.population = population
        numberOfStoplights = stoplights
    }
    
    // initializer delegation. Note that the 'region' is missing but is filled in
    // by delegating to another 'init' function.
    init?(population: Int64, stoplights: Int) {
        self.init(region: "N/A", population: population, stoplights: stoplights)
    }

    
    // Computed property
    enum Size {
        case small
        case medium
        case large
    }
    
    // 'lazy' means the value won't be set until it's first needed/accessed.
    // The closing set of '()' indicate that the closure will be called the first
    // time the property ('townSize') is referenced and the result stored as the
    // property's value. Otherwise, 'townSize' would just be a variable referencing
    // a function.
    //
    // Lazy properties like 'Town.townSize' are only evaluated once, so any changes to
    // other properties used to determine the value will not have an affect on a lazy
    // property's value. For this reason they're bad for properties that are based on
    // the values of other properties that may change.
//    lazy var townSize: Size = {
//        switch self.population {
//        case 0...10_000:
//            return Size.small
//
//        case 10_001...100_000:
//            return Size.medium
//
//        default:
//            return Size.large
//        }
//    }()
    // A better way to do this is to use a 'computed property'.
    var townSize: Size {
        get {
            switch self.population {
            case 0...10_000:
                return Size.small
                
            case 10_001...100_000:
                return Size.medium
                
            default:
                return Size.large
            }
        }
    }
    

    func printDescription() {
        print("Population: \(population), number of stoplights: \(numberOfStoplights), region: \(region)")
    }
    
    // qualifier 'mutating' is required on struct methods that will modify struct
    // properties. This is because for structs instance methods are actually implemented
    // as type methods that return a function that take the instance of the struct as a
    // parameter. By default the parameter is passed by value. Adding the 'mutating' qualifier
    // modifies the generation of the type method to specify that the parameter is an 'inout'
    // parameter which allows modification of the parameter. It's interesting that when calling
    // a 'mutating' method on a struct instance that you don't have to qualify it with a '&' as
    // you do with other 'inout' arguments.
    mutating func changePopulation(by delta: Int) {
        if delta < 0 && delta * -1 > population {
            population = 0
            return
        } else {
            population += Int64(delta)
        }
    }
}
