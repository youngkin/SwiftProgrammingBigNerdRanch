//
//  Zombie.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/* Key points:
 *  1. Subclassing
 *  2. Nice real world use of Optionals
 *  3. Type variable overriding ('spookyNoise')
 *  4. Method overriding
 *  5. Access control (open, public, internal(default), fileprivate, private)
 */

import Foundation

/*
 * Key points:
 *  1.  Overridding class level functions
 *  2.  Access control in decreasing visibility - open, public, internal fileprivate, private
 *  3.  Preventing overriding via 'final'
 *  4.  Alternate syntax for specifying visibility on getter/setter (set in this case)
 */

class Zombie: Monster {
    // class level function (i.e., call be called on the type, no instance necessary
//    class func makeSpookyNoise() -> String {
//        return "Brains..."
//    }
    // Here's the computed property version of it. The Monster super-class also
    // defines this type property. It can be overridden here...
    override class var spookyNoise: String {
        return "Brains.."
    }
    
    // Access control, only visible within Zombie
//    private var isFallingApart = false
    // Modify it to make it visible throughout the project (module) and demonstrate an new
    // sytax for defining getters/setters. In this case the getter defaults to internal
    // and the setter is explicitly defined as private.
    internal private(set) var isFallingApart = false

    var walksWithLimp = true
    
    // 'final' prevents subclasses from overriding like Zombie did with
    // 'Monster.terrorizeTown()'
    final override func terrorizeTown() {
        let killNPeople = -10
        if let pop = town?.population {
            if pop >= killNPeople && isFallingApart {
                town?.changePopulation(by: killNPeople)
            }
        }
        super.terrorizeTown()
    }
}
