import Cocoa

var errorCodeString: String?
errorCodeString = "404"

if errorCodeString != nil {
    let theError = errorCodeString! // '!' indicates to 'force unwrap' the optional
    print(theError)
}

// Vs.

if let theError = errorCodeString { // 'if let...' is called 'optional binding', that is bind the optional to 'theError' if it's not nil
    print(theError)
}

// Also can put multiple optional bindings in the same 'if' clause (casting always returns an Optional since the cast may fail)
if let theError = errorCodeString, let theErrorInt = Int(theError) {
    print(theErrorInt)
}

// Add a conditional check in addition to optional binding (note the ',' which is synonymous with '&&'
if let theError = errorCodeString, let theErrorInt = Int(theError), theErrorInt == 404 {
    print(theErrorInt)
}

// Implicitly wrapped optionals - using '!' vs. '?'. Generally considered a bad idea to use as can lead to runtime errors
// Like force unwrap applied to the type definition. Don't have to explicitly access the wrapped value.
var errCodeStrImplicit: String! = "NotNil" // can also directly assign a value - e.g., '... = "404"' without unwrapping first
let anotherErrorCodeString: String = errCodeStrImplicit // Can assign directly to a non-optional variable or const (DANGER!!!)
print(anotherErrorCodeString)
let yetAnotherErrorCodeString = errCodeStrImplicit // YAECS will have an inferred type of Optional, Swift tries to do the safe thing.

// Optional chaining
var errorDescription: String?
if let theError = errorCodeString, let errorCodeInteger = Int(theError),
    errorCodeInteger == 404 {
    print("\(theError): \(errorCodeInteger)")
    errorDescription = "\(errorCodeInteger + 200): resource was not found."
}
// If errorDescription is not nil then upCaseErrorDescription will be an all upper-case version of errorDescription; nil otherwise.
var upCaseErrorDescription = errorDescription?.uppercased()

// Modifying an optional in-place
upCaseErrorDescription?.append(" PLEASE TRY AGAIN.")
upCaseErrorDescription // Add this here just to see its value show up in the sidebar without having to print it to see it

// Nil coalescing operator - use the optional value, if set. Otherwise take a default value
errorDescription = nil
let description = errorDescription ?? "No Error"
print(description)


//
// Bronze Challenge
//
// Take a look at the examples below and select which type would model them best.
//  1. The number of kids a parent has: Int or Int? - Int, they could have zero kids
//  2. The name of a person’s pet: String or String? - Optional, they might not have a pet

//
// Silver Challenge - uncomment to see associated error (hint, it's a runtime exception)
//
//var silverOptional: String?
//let nonOptional = silverOptional!
//print(nonOptional)

