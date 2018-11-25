import Cocoa

/*
 * Key points:
 *
 *  1.  Extending protocols vs. Types (in Chapter 21)
 *
 *  2.  Protocol extensions are a way to add behavior to a protocol so that each
 *      implementing class/struct doesn't have to. Kind of like an abstract base class,
 *      but without the issues of inheritance.
 */

protocol Exercise: CustomStringConvertible {
    var name: String { get }
    var caloriesBurned: Double { get }
    var minutes: Double { get }
    var title: String { get }
}

// Adds a behavior and associated implementation.
extension Exercise {
    var caloriesBurnedPerMinute: Double {
        return caloriesBurned / minutes
    }
}

// Adds conformance to the CustomStringConvertible protocol. This can't be done in the
// protocol declaration itself since it's an implementation of a behavior, but it is a
// little awkward to separate out the declaration of inheriting from CustomStringConvertible
// with the implementation of it in a protocol extension.
extension Exercise {
    var description: String {
            return "Exercise(\(name), burned \(caloriesBurned) calories in \(minutes) minutes)"
    }
}

// An example of a protocol extension (of `Sequence`) that is type constrained to only
// `Sequence`'s of `Exercise`.
extension Sequence where Iterator.Element == Exercise {
    func totalCaloriesBurned() -> Double {
        var total: Double = 0
        for exercise in self {
            total += exercise.caloriesBurned
        }
        return total
    }
}

struct EllipticalWorkout: Exercise {
    let name = "Elliptical Workout"
    // An example of one of the issues you can encounter using protocol extensions with members
    // whose names conflict with a name in one of the defined protocol extensions. If un-commented,
    // the following line will work differently in the `for exercise in mondayWorkout` vs.
    // `print(ellipcticalWorkout.title`.
    //
    // This can be uncommented if the Bronze challenge code is implemented.
    let title = "Title: Workout using the Go Fast Elliptical Trainer 3000"
    let caloriesBurned: Double
    let minutes: Double
}

struct TreadmillWorkout: Exercise {
    let name = "Treadmill Workout"
    let title = "Title: Treadmill Workout"
    let caloriesBurned: Double
    let minutes: Double
    let laps: Double
}

// Example of overriding the default behavior of the `Exercise` extension that implements the
// `CustomStringConvertible` protocol.
extension TreadmillWorkout {
    var description: String {
        return "TreadmillWorkout(\(caloriesBurned) calories and \(laps) laps in \(minutes) minutes)"
    }
}

//
// Examples of the use of the above protocol, extension, and struct definitions from above
//
let ellipticalWorkout = EllipticalWorkout(caloriesBurned: 335, minutes: 30)
let runningWorkout = TreadmillWorkout(caloriesBurned: 350, minutes: 25, laps: 10.5)

print(ellipticalWorkout.caloriesBurnedPerMinute)
print(runningWorkout.caloriesBurnedPerMinute)

let mondayWorkout: [Exercise] = [ellipticalWorkout, runningWorkout]
print(mondayWorkout.totalCaloriesBurned())

print(ellipticalWorkout)
print(runningWorkout)

// The extension definition of `title` that conflicts with the inclusion of `title` in the
// `EllipticalWorkout` definition above. Can resolve this by moving the definition of `title`
// into the declaration of the `Exercise` protocol (Bronze challenge).
//extension Exercise {
//    var title: String {
//        return "\(name) - \(minutes) minutes"
//    }
//}

// Example that demonstrates the different behaviors of `EllipticalWorkout` vs. `TreadmillWorkout`
// with respect to conflicts in the definition of `title`.
for exercise in mondayWorkout {
    print(exercise.title)
}

print(ellipticalWorkout.title)
