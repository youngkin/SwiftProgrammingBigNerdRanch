//
//  Monster.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/*
 * Key points:
 *  1.  Designated initializers, any initializer for a class
 *  2.  Required initializers
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
    var name: String
    var victimPool: Int64 {
        get {
            return town?.population ?? 0
        }
        set(newVictimPool) {
            town?.population = newVictimPool
        }
    }
    
    // prefixing an initializer with 'required' specifies that all subclasses
    // must implement this initializer. Not sure what this is good for...
    //
    // Gold Challenge - require that 'name' have at least 1 character.
    // So turn init into a failable initializer.
    required init?(town: Town?, monsterName: String) {
        if monsterName.count < 1 {
            return nil
        }
        self.town = town
        name = monsterName
    }

    func terrorizeTown() {
        if town != nil {
            print("\(name) is terrorizing a town!")
        } else {
            print("\(name) hasn't found a town to terrorize, yet...")
        }
    }
}
