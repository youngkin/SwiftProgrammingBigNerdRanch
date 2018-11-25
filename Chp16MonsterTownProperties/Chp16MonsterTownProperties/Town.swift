//
//  Town.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/*
 * Key points:
 *  1.  Use of enums, including as a property with a Getter ('Size' & 'townSize')
 *  2.  Lazy properties & computed properties ('townSize')
 *  3.  Property observers ('population')
 *  4.  Type variables (use of 'static' keyword for the const 'region')
 */

import Foundation

struct Town {
    // 'static' keyword identifies this as a 'type' property, i.e., applicable
    // to all instances of the type. For classes, 'static' will prevent a subclass
    // from overriding with its own implementation of the property. To allow
    // overriding use the 'class' keyword.
    static let region = "South"
    var population = 5_422 {
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
    var numberOfStoplights = 4
    
    let mayor = Mayor()
    
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
        print("Population: \(population), number of stoplights: \(numberOfStoplights)")
    }
    
    mutating func changePopulation(by delta: Int) {
        if delta < 0 && delta * -1 > population {
            population = 0
            return
        } else {
            population += delta
        }
    }
}
