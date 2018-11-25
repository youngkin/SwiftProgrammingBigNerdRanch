import Cocoa

import Cocoa

func printGreeting() {
    print("Hello, playground.")
}
printGreeting()

func printPersonalGreeting(name: String) {
    print("PG1 - Hello \(name), welcome to your playground.")
}

//
// Functions are called with "named" parameters (e.g., 'name' below). This is intended to make them
// more readable at the caller. In this case it's not particularly readable.
//
printPersonalGreeting(name: "Matt")

//
// External ('to') vs internal ('name') parameters. This form reads better than above when used by callers.
//
func printPersonalGreeting2(to name: String) {
    print("PG2 - Hello \(name), welcome to your playground.")
}
printPersonalGreeting2(to: "Matt")

//
// Multiple parameters with a return type
// Note use of default parameter 'withPunctuation'. Default parameters
// must be the last parameter in the function definition
//
func divisionDescriptionFor(numerator: Double, denominator: Double, withPunctuation: String = ".") -> String {
    return "\(numerator) divided by \(denominator) equals \(numerator / denominator)" + withPunctuation
}

print("\n" + divisionDescriptionFor(numerator: 25, denominator: 5) + "\n")
print("\n" + divisionDescriptionFor(numerator: 25, denominator: 5, withPunctuation: "!") + "\n")

//
// Variadic functions
//
func printPersonalGreetings(to names: String...) {
    for name in names {
        print("PG3 - Hello \(name), welcome to your playground")
    }
}
printPersonalGreetings(to: "Jeff", "Rich", "Clay")
// Passing an array as a Variadic parameter doesn't work
//var variadicParms = ["Jeff", "Rich", "Clay"]
//printPersonalGreetings(to: variadicParms...)

//
// In/out parameters
//
var error = "The request failed"
func appendErrorCode(_ code: Int, toErrorString errorString: inout String) {
    if code == 400 {
        errorString += ", bad request."
    }
}
appendErrorCode(400, toErrorString: &error)
error

//
// Nested functions
//
func areaOfATriangle(base: Double, height: Double) -> Double {
    var numerator = base*height
    func divide() -> Double {
        return numerator/2
    }
    return divide()
}
areaOfATriangle(base: 3, height: 5)


//
// Multiple Returns
//
func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    var evens = [Int]()
    var odds = [Int]()
    for number in numbers {
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    return (evens, odds)
}

let aBunchOfNumbers = [10,1,4,3,57,43,84,27,156,111]
let theSortedNumbers = sortedEvenOddNumbers(aBunchOfNumbers)
print("The even numbers are: \(theSortedNumbers.evens); the odd numbers are: \(theSortedNumbers.odds)")


//
// Optional Returns
//

func grabMiddleName(fromFullName name: (String, String?, String)) -> String? {
    return name.1
}

// This will not print anything if 'nil' is passed in for the "middle" name
let middleName = grabMiddleName(fromFullName: ("Porgy", nil, "Tirebiter"))
if let theName = middleName {
    print(theName)
}

//
// Early returns + Bronze Challenge
//
func greetByMiddleName(fromFullName name: (first: String,
                                            middle: String?,
                                            last: String)) {
    guard let middleName = name.middle, middleName.count < 5 else {
        print("Howdy!")
        return
    }
    print("Howdy \(middleName)!")
}
greetByMiddleName(fromFullName: ("Porgy", "Tire", "Biter"))
greetByMiddleName(fromFullName: ("Porgy", "The Tire", "Biter"))

//
// Silver Challenge - Take a list of groceries and return a named tuple separating the beans
// from the rest of the groceries
//
func siftBeans(fromGroceryList items: [String]) -> (beans: [String], otherGroceries: [String]) {
    var beans: [String] = []
    var otherGroceries: [String] = []
    
    for item in items {
        if item.hasSuffix("beans") {
            beans.append(item)
        } else {
            otherGroceries.append(item)
        }
    }
    return (beans, otherGroceries)
}
let result = siftBeans(fromGroceryList: ["green beans",
                                         "milk",
                                         "black beans",
                                         "pinto beans",
                                         "apples"])
result.beans == ["green beans", "black beans", "pinto beans"] // true
result.otherGroceries == ["milk", "apples"] // true
