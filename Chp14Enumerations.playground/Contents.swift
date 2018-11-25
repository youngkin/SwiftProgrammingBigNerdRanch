import Cocoa

// -----------------------------------------------------------------------------------//
//
// ------------------------------------ [Basic enum] ---------------------------------//
//
// -----------------------------------------------------------------------------------//
//
enum TextAlignment {
    case left
    case right
    case center
}

// Using switch to evaluate. Notice that there is no required default case. Swift knows
// all the possible values so it can be left out. Also, like other types, enum types
// can be inferred. The use of 'default' is discouraged as it isn't future proof,
// i.e., if a new enum value is added the code may not work as expected.
//
//
var alignment = TextAlignment.left
alignment = .right
switch alignment {
case .left:
    print("left aligned")
    
case .right:
    print("right aligned")
    
case .center:
    print("center aligned")
}


// -----------------------------------------------------------------------------------//
//
// ------------------------------- [Raw value enums] ---------------------------------//
//
// -----------------------------------------------------------------------------------//
//
//enum TextAlignmentInt: Int {
//    case left     // raw value: 0
//    case right    // raw value: 1
//    case center   // raw value: 2
//    case justify  // raw value: 3
//}

// Or can specify the raw value...
enum TextAlignmentInt: Int {
    case left    = 20
    case right   = 30
    case center  = 40
    case justify = 50
}

// Can also assign raw values to an enum. Note, 'TextAlignmentInt()' returns an optional,
// hence the need for the optional binding ('if let...')
// Create a raw value
let myRawValue = 20

// Try to convert the raw value into a TextAlignment
if let myAlignment = TextAlignmentInt(rawValue: myRawValue) {
    print("successfully converted \(myRawValue) into a TextAlignment: \(myAlignment)")
} else {

    print("\(myRawValue) has no corresponding TextAlignmentInt case")
}

// enums with Strings. Enum value will default to case value if omitted. E.g.,
enum ProgrammingLanguage: String {
    case swift
    case objectiveC = "objective-c"
    case c
    case cpp        = "c++"
    case java
}
let myFavoriteLanguage = ProgrammingLanguage.swift
print("My favorite programming language is \(myFavoriteLanguage.rawValue)")


// -----------------------------------------------------------------------------------//
//
// ------------------------------- [enum methods] ---------------------------------//
//
// -----------------------------------------------------------------------------------//
//
enum Lightbulb {
    case on
    case off
    
    func surfaceTemperature(forAmbientTemperature ambient: Double) -> Double {
        switch self {
        case .on:
            return ambient + 150.0
            
        case .off:
            return ambient
        }
    }
    
    // Note the use of 'mutating' qualifier on the function definition.
    // Enums are value types and value types can only be modified by functions
    // that are explicitly defined as such.
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
var bulb = Lightbulb.on
let ambientTemperature = 77.0

var bulbTemperature = bulb.surfaceTemperature(forAmbientTemperature:
    ambientTemperature)
print("the bulb's temperature is \(bulbTemperature)")

bulb.toggle()
bulbTemperature = bulb.surfaceTemperature(forAmbientTemperature: ambientTemperature)
print("The bulb's temperature is now \(bulbTemperature)")


// -----------------------------------------------------------------------------------//
//
// ------------------------------- [Associated Values] -------------------------------//
//
// -----------------------------------------------------------------------------------//
//
enum ShapeDimensions {
    // point has no associated value - it is dimensionless
    case point
    // square's associated value is the length of one side
    case square(side: Double)
    // rectangle's associated value defines its width and height
    case rectangle(width: Double, height: Double)
    
    func area() -> Double {
        switch self {
        case .point:
            return 0
        case let .square(side: side):
            return side * side
            
        case let .rectangle(width: w, height: h):
            return w * h
        }
    }
    
    func perimeter() -> Double {
        switch self {
        case .point:
            return 0
        case let .square(side: side):
            return 4*side
        case let .rectangle(width: w, height: h):
            return 2*w + 2*h
        }
    }
}

var pointShape = ShapeDimensions.point
var squareShape = ShapeDimensions.square(side: 10.0)
var rectShape = ShapeDimensions.rectangle(width: 5.0, height: 10.0)

print("point's area = \(pointShape.area())")
print("square's area = \(squareShape.area())")
print("rectangle's area = \(rectShape.area())")
print("point's perimeter = \(pointShape.perimeter())")
print("square's perimeter = \(squareShape.perimeter())")
print("rectangle's perimeter = \(rectShape.perimeter())")



// -----------------------------------------------------------------------------------//
//
// -------------------------------- [Recursive enums] --------------------------------//
//
// -----------------------------------------------------------------------------------//
//
// Doesn't work because Swift can't figure out it's size at compile time. If it's marked
// as indirect then Swift will make the 'FamilyTree`'s associated value a pointer so it
// can defer this decision until runtime. The size of a pointer is known and hence can be
// reserved.
//
// Indirect can be used at the enum level, or only on the individual cases where the
// recursion takes place (e.g., 'oneKnownParent', 'twoKnownParents')
//enum FamilyTree {
//    case noKnownParents
//    case oneKnownParent(name: String, ancestors: FamilyTree)
//    case twoKnownParents(fatherName: String, fatherAncestors: FamilyTree,
//        motherName: String, motherAncestors: FamilyTree)
//}
indirect enum FamilyTree {
    case noKnownParents
    /*indirect*/ case oneKnownParent(name: String, ancestors: FamilyTree)
    /*indirect*/ case twoKnownParents(fatherName: String, fatherAncestors: FamilyTree,
        motherName: String, motherAncestors: FamilyTree)
}
let fredAncestors = FamilyTree.twoKnownParents(
    fatherName: "Fred Sr.",
    fatherAncestors: .oneKnownParent(name: "Beth", ancestors: .noKnownParents),
    motherName: "Marsha",
    motherAncestors: .noKnownParents)

