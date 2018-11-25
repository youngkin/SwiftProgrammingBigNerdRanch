//
//  Monster.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/*
 * Key points:
 *  1.  Defining default, superclass, behavior
 *  2.  Demonstrating Getters & Setters ('victimPool')
 *  3.  Demonstrating the use of type level properties
 *      a. 'class' property, spookyNoise, defines a default value that can be overridden
 *      b. 'static' property, isTerrifying, that can't be overridden
 *  4. Use of an Optional variable, 'Town'
 */

import Foundation

class Monster {
    // Can't be overridden by subclasses
    static let isTerrifying = true
    
    // Can be overridden by subclasses
    class var spookyNoise: String {
        return "Grrr"
    }

    var town: Town?
    var name = "Monster"
    var victimPool: Int {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize, yet...")
        }
    }
}
