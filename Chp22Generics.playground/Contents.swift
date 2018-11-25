import Cocoa

/*
 *  Key Points:
 *
 *  1.  The type placeholder (e.g., '<T>', '<Element>', etc.) immediately follows the
 *      type/func/method name. Its value, e.g., `T`, is arbitrary. For a generic can be anything.
 *      It just needs to be used consistently within the struct or class definition.
 *
 *  2.  Generics can be applied to types (e.g., Stack<T>), functions (myMap<T>(...)), and
 *      methods (Stack.map<T>(...)). Class/Struct methods are a little different. They do NOT specify
 *      a type placeholder if they're going to operate on the type associated with the containing
 *      struct/class.
 *
 *  3.  Generic types/functions/methods can be type/protocol constrained in the same way a struct
 *      or class can implement a type or conform to a protocol (e.g., Stack<TS: Equatable> or
 *      `checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>`).
 *
 *  4.  Protocols have a concept similar to Generics called  associated types. This is indicated
 *      by specifying the 'associatedtype' designation, e.g., `...associatedtype Element...`. For
 *      example, here's the definition of Swift's IteratorProtocol:
 *          protocol IteratorProtocol {
 *              associatedtype Element
 *
 *              mutating func next() -> Element?
 *          }
 *      The type placeholder, 'Element', is arbitrary. As with Generics, it can be anything as
 *      long as it's used consistently as in the example above.
 *
 *  5.  As with Generics, Protocol 'associatedtype' designation can be constrained. For example,
 *      'Sequence' below is type constrained to accept only concrete types that conform to the
 *      'IteratorProtocol'.
 *          protocol Sequence {
 *              associatedtype Iterator: IteratorProtocol
 *              func makeIterator() -> Iterator
 *          }
 *
 *  6.  Type constraints can also be used to implement Generic methods (e.g., `pushAll`)
 *      that accept collections (e.g., `Sequence`) of a specific, constrained, type. E.g.,
 *      `Sequence where Sequence.Interator.Element == TS`. This says the `Sequence`'s
 *      elements must be of type `TS`. Type-constraining an `associatedtype` protocol to be
 *      used as a method argument requires the use of the `where` clause.
 */

//
// Example of a Generic function that is type-constrained to accepting only
// concrete instances that conform to the `IteratorProtocol` protocol.
//
// Commented lines show a more verbose way of accomplishing the same thing.
// E.g., by defining `next()` as returning a `T?` type, and letting Swift infer
// the type, we can avoid the `typealias` altogether.
//
struct StackIterator<T>: IteratorProtocol {
    //    typealias Element = T
    
    var stack: Stack<T>
    
    //    mutating func next() -> Element? {
    mutating func next() -> T? {
        return stack.pop()
    }
}

// Adding the protocol `Sequence` to the `Stack` declaration illustrates the use of an associated type
// protocol (`Sequence`) which constrains its associated type to implement a specific protocol as well.
// In this case, `Sequence`'s associated type is `Iterator: IteratorProtocol`
struct Stack<TS>: Sequence {
    var items = [TS]()
    
    mutating func push(_ newItem: TS) {
        items.append(newItem)
    }
    
    mutating func pop() -> TS? {
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    // The use of type `T` (e.g., (TS) -> T) was done to resolve the
    // `'(TS) -> TS' is not convertible to '(TS) -> TS'` compilation error.
    //
    // QUESTION: Why did the above compilation error occur?
    // ANSWER: `map` may return a different type that it was provided with, i.e.,
    // it is free to `map` from one type to another. E.g., from a String to an Int.
    // Or more generically, it maps from a <TS> -> <T>. In practice, that doesn't mean that
    // <TS> and <T> can't be the same concrete types, only that they can.
    func map<T>(_ f: (TS) -> T) -> Stack<T> {
        var mappedItems = [T]()
        for item in items {
            mappedItems.append((f(item)))
        }
        // Note the use of a `memberwise`, i.e., implied, initializer to construct
        // the new Stack<T>.
        return Stack<T>(items: mappedItems)
    }
    
    // Bronze challenge #1
    // `filter`, even though it might look similar to `map` in terms of taking a closure
    // and returning a Stack<>, is different in a critical way from `map`. It is not itself
    // generic in the sense that it can operate on any type of Element in the Stack. It will
    // work on `<TS>` elements, and return a `Stack<TS>`.
    func filter(_ f: ((TS) -> Bool)) -> Stack<TS> {
        var mappedItems = [TS]()
        for item in items {
            if f(item) {
                mappedItems.append(item)
            }
        }
        return Stack<TS>(items: mappedItems)
    }
    
    // `pushAll()` is defined as a function scoped to type `Stack<TS>`, which itself is constrained
    // to `Sequence`, i.e., `Stack<TS>: Sequence`. `pushAll()`, if it is also going to be
    // generic with respect to the types that may be contained in that `Sequence`, must be
    // further constrained to accept only parameters of type `Sequence` where the `Sequence`
    // is a `Sequence` containing only `<TS>` typed elements. Otherwise it would have to be
    // defined to accept a concrete type, such as an `[]<TS>` (e.g., an `Array` of `TS`'s), which
    // would be limiting.
    //
    // The ability to accept a type-constrained protocol (e.g., other than `[]<TS>`) is supported by
    // the use of the `where` constraint (i.e., `where S.Iterator.Element == TS`). That is how the
    // function declaration would look if it wasn't made Generic WRT the type of argument it accepts:
    // (and it would be missing the `where S.Iterator.Element == TS` constraint.)
    
    /* mutating func pushAll(_ array: [Element]) { */
    mutating func pushAll<S: Sequence>(_ sequence: S)
        where S.Iterator.Element == TS {
            for item in sequence {
                self.push(item)
            }
    }

    // See below for definition of `StackIterator`
    func makeIterator() -> StackIterator<TS> {
        return StackIterator(stack: self)
    }
}


//
// Simple `Stack` use cases
//
var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)
intStack = intStack.map {$0*5}
// `as Any` suffix is used to suppress `Expression implicitly coerced from 'Int?' to 'Any'`
// compiler warnings.
print(intStack.pop() as Any)
print(intStack.pop() as Any)
print(intStack.pop() as Any)

var stringStack = Stack<String>()
stringStack.push("Item1")
stringStack.push("Item2")

print(stringStack.pop() as Any)
print(stringStack.pop() as Any)
// Use of a nil coalescing operator.
print(stringStack.pop() ?? "Not sure what this is" )

//
// Example of a Generic function that takes a closure of type
// (_:<T>, _:<T> -> <U>) and returns a <U>.
//
func myMap<T,U>(_ items: [T], _ f: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        result.append((f(item)))
    }
    return result
}

let strings = ["one", "two", "three"]
let stringLengths = myMap(strings) {$0.count}
print(stringLengths)

//
// Example of a Generic function that accepts/operates-on 2 different types
//
func checkIfDescriptionsMatch<T: CustomStringConvertible, U: CustomStringConvertible>(_ first: T, _ second: U) -> Bool {
    return first.description == second.description
}

print(checkIfDescriptionsMatch(Int(1), UInt(1)))
print(checkIfDescriptionsMatch(1, 1.0))
print(checkIfDescriptionsMatch(Float(1.0), Double(1.0)))


//
// Example of the use of a type-constrained `associatedtype` protocol
//
var myStack = Stack<Int>()
myStack.push(10)
myStack.push(20)
myStack.push(30)

var myStackIterator = StackIterator(stack: myStack)
while let value = myStackIterator.next() {
    print("got \(value)")
}

// NOTE: myStackIterator received a copy of myStack (structs are passed by value)
// packaged in the StackIterator. So the copy got mutated, not `myStack` directly.
// So `myStack` still hasn't been popped.
for value in myStack {
    print("for-in loop: got \(value)")
}

// NOTE: Sequence operations (`for-in`) aren't destructive even though the underlying
// operation is implemented via a pop(). But why, is this construct operating on a copy?
//
// QUESTION: WHY????
for value in myStack {
    print("for-in loop: got \(value)")
}

var myOtherStack = Stack<Int>()
myOtherStack.pushAll([1, 2, 3])
myStack.pushAll(myOtherStack)
for value in myStack {
    print("after pushing items onto stack, got \(value)")
}

var myOtherStack2 = Stack<String>()
myOtherStack2.pushAll(["A", "B", "C"])

// This will fail compilation since the code is attempting to push a `Stack<String>` on to a
// `Stack<Int>`.
//myStack.pushAll(myOtherStack2)
//for value in myStack {
//    print("after pushing items onto stack, got \(value)")
//}

print("\n\nBronze challenge #1")
myStack = Stack<Int>()
var contents: Array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
myStack.pushAll(contents)
myStack = myStack.filter { return $0 < 5 }

for item in myStack {
    print("After applying filter: \(item)")
}
