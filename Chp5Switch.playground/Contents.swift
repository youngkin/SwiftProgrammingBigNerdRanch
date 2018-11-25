import Cocoa

var statusCode = 417
var errString: String?

switch statusCode {
case 400:
    errString = "Bad request"
case 401:
    errString = "Unauthorized"
default:
    break
}

// Segue on optionals
// The below will use 'statusCode' if 'errString' is nil
print("Optionals:")
print("\t\(errString ?? String(statusCode))")

// Demonstrates switch with ranges (e.g., 300...307 means "300 through 307 inclusive"
print("\n\nSwitch with ranges:")
var errorString: String = "\tThe request failed with the error:"
switch statusCode {
case 100, 101:
    errorString += " Informational, 1xx."
    
case 204:
    errorString += " Successful but no content, 204."
    
case 300...307:
    errorString += " Redirection, 3xx."
    
case 400...417:
    errorString += " Client error, 4xx."
    
case 500...505:
    errorString += " Server error, 5xx."
    
default:
    errorString += "Unknown. Please review the request and try again."
}
print(errorString)

// Alternative implementation using 'value binding' to eliminate need for 'default' clause
print("\n\nSwitch with value binding:")
errorString = "\tThe request failed with the error:"
statusCode = 600
switch statusCode {
case 100, 101:
    errorString += " Informational, 1xx."
case 204:
    errorString += " Successful but no content, 204."
case 300...307:
    errorString += " Redirection, 3xx."
case 400...417:
    errorString += " Client error, 4xx."
case 500...505:
    errorString += " Server error, 5xx."
case let unknownCode:
    errorString += " \(unknownCode) Unknown. Please review the request and try again."
}
print(errorString)

// Another alternative using 'where' clause to filter out statusCodes. Still need the 'default'
// clause since the introduction of 'where' implies the case is not exhaustive anymore.
// 'switch' clauses are evaluated in order, short-circuiting when there's a match.
print("\n\nSwitch with where clause:")
errorString = "\tThe request failed with the error:"
switch statusCode {
case 100, 101:
    errorString += "\(statusCode) Informational, 1xx."
case 204:
    errorString += "\(statusCode) Successful but no content, 204."
case let unknownCode where (unknownCode > 101):
    errorString += "\(unknownCode) Unknown. Please review the request and try again."
default:
    errorString += "\(statusCode) How did I get here?"
}
print(errorString)

// Tuples and pattern matching
print("\n\nTuples & Pattern Matching")
let error = (statusCode, errorString)
print("\terror.0: \(error.0); error.1: \(error.1)")

let error2 = (code: statusCode, error: errorString)
print ("\terror2.code: \(error2.code); error2.error: \(error2.error)")

// first & second error codes relate to searching for items on 2 different
// web sites. The requested resource wasn't found in the first site, but it was
// at the second site.
let firstErrorCode = 404
let secondErrorCode = 200
let errorCodes = (firstErrorCode, secondErrorCode)

switch errorCodes {
case (404, 404):
    print("\tAll codes found")
case (404, _):
    print("\tFirst code found")
case (_, 404):
    print("\tSecond code found")
default:
    print("\tNo codes found")
}

// Pattern matching in 'if' statements
print("\n\nPattern matching in 'if' statements")
let age = 25

if case 18...35 = age, age > 21 {
    print("\tCool demographic and of drinking age")
}

print("\n\nSilver Challenge")
if case 18...25 = age, age > 21, age < 30 {
    print("\tCool demographic, of drinking age and younger than 30")
}


// Bronze Challenge
print("\n\nBronze Challenge, what will print out???")
let point = (x: 1, y: 4)

switch point {
case let q1 where (point.x > 0) && (point.y > 0):
    print("\t\(q1) is in quadrant 1")
    
case let q2 where (point.x < 0) && point.y > 0:
    print("\t\(q2) is in quadrant 2")
    
case let q3 where (point.x < 0) && point.y < 0:
    print("\t\(q3) is in quadrant 3")
    
case let q4 where (point.x > 0) && point.y < 0:
    print("\t\(q4) is in quadrant 4")
    
case (_, 0):
    print("\t\(point) sits on the x-axis")
    
case (0, _):
    print("\t\(point) sits on the y-axis")
    
default:
    print("\tCase not covered.")
}
