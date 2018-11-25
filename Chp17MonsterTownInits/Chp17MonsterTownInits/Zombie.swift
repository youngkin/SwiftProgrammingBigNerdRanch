//
//  Zombie.swift
//  MonsterTown
//
//  Created by Youngkin, Richard on 10/16/18.
//  Copyright © 2018 BigNerdRanch. All rights reserved.
//

/* Key points:
 *  1. Automatic initializer inheritance, initializers inherited from a superclass.
 *      Occurs when a class specified default values for subclass specific properties but
 *      Doesn't have any designated initializers of its own. Can apply to convenience
 *      initializers as well.
 *
 *      Interestingly enough the subclass, Zombie in this case, doesn't have to actually
 *      define the initializer. It gets it for free from the superclass.
 *  2. Designated initializers - ensure that all of a class's properties are intialized
 *  3. Convenience initializers - take only arguments that can't be defaulted and then
 *      they delegate all intialization responsibility to a designated initializer.
 *  4. Required initializers - specified as required in the superclass, requires that all
 *      subclasses implement these initializers.
 *  5. Deinitialization - same as a C/C++ destructor, similar to a Java finalizer
 */

import Foundation

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
    
    private(set) var isFallingApart: Bool
    var walksWithLimp: Bool
    
    // Demonstrates use of a designated initializer (Zombie) and it's use of
    // its superclass's designated initializer to complete the initialization.
    init?(limp: Bool, fallingApart: Bool, town: Town?, monsterName: String) {
        walksWithLimp = limp
        isFallingApart = fallingApart
        super.init(town: town, monsterName: monsterName)
    }
    
    // Demonstrates use of a convenience initializer to take only "interesting"
    // parameters and use defaults for the remaining (e.g., town and monsterName)
    convenience init?(limp: Bool, fallingApart: Bool) {
        self.init(limp: limp, fallingApart: fallingApart, town: nil, monsterName: "Fred")
        // walksWithLimp can only be referenced after initialization has completed. In
        // this case it must appear after delegating the initialization above.
        if walksWithLimp {
            print("This zombie has a bad knee")
        }
    }
    
    required convenience init?(town: Town?, monsterName: String) {
//        walksWithLimp = false
//        isFallingApart = false
//        super.init(town: town, monsterName: monsterName)
        // Silver challenge - Convert to a convenience initializer
        self.init(limp: false, fallingApart: false, town: town, monsterName: monsterName)
    }
    
    // Destructs the instance. Note: This will set the value of the variable pointing to this
    // instance to nil. So any variables defined for Zombies must be 'Optional'.
    deinit {
        print("Zombie named \(name) is no longer with us")
    }
    
    // Demonstrates

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
