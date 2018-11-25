import Cocoa

// Value semantics - structs are only values
var str = "Hello, playground"
var playgroundGreeting = str
playgroundGreeting += "! How are you today?"
str

// Reference semantics - classes use reference semantics
class GreekGod {
    var name: String
    init(name: String) {
        self.name = name
    }
}
let hecate = GreekGod(name: "Hecate")
let anotherHecate = hecate

anotherHecate.name = "AnotherHecate"
anotherHecate.name
hecate.name

// Warning - be careful of putting a reference type in a value type as a 'var'
struct Pantheon {
    var chiefGod: GreekGod
}

// Constant Value & Reference semantics
let pantheon = Pantheon(chiefGod: hecate)
let zeus = GreekGod(name: "Zeus")
// Error - cannot assign to property: 'pantheon' is a 'let' constant
//pantheon.chiefGod = zeus
zeus.name = "Zeus Jr."
// With a const class its properties can be changed because you're not changing
// the value of the actual instance variable. The property 'name' is mutable
// so it can be changed even if the value of 'zeus' cannot be.
zeus.name

// Demonstrates the folly of making a reference type a property of a value type.
// The property can be changed at will, perhaps unexpectedly, even though the
// container is a struct/value-type. In this case you're not changing the value
// of greekPantheon, nor even the value of 'chiefGod'. You're changing a property
// of a reference type. If this kind of thing is really necessary, consider making
// the reference property a constant ('let')
pantheon.chiefGod.name
// greekPantheon is a copy of pantheon
let greekPantheon = pantheon
hecate.name = "Trivia"
greekPantheon.chiefGod.name


// Deep vs. shallow copying. Swift only supports (directly) shallow copying
// In this example the name of zeus in both arrays is actually "Jupiter" since
// the reference property, chiefGod, is only shallow copied (i.e., on the reference
// is copied, not the entire instance).
let athena = GreekGod(name: "Athena")

let gods = [athena, hecate, zeus]
let godsCopy = gods
gods.last?.name = "Jupiter"
gods
godsCopy

