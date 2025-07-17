import Foundation

// Optionals indicates a value that might or might not be present.

// Way 1
func multiplyByTwo(_ value: Int?) -> Int {
    if let value {
        return value * 2
    } else {
        return 0
    }
}
multiplyByTwo(10)
multiplyByTwo(nil)
multiplyByTwo(7)
multiplyByTwo(190)

// Way 2
func multiplyByTwo2(_ value: Int? = nil) -> Int {
    (value ?? 0) * 2
}
multiplyByTwo2(10)

// Way 3
func multiplyByTwo3(_ value: Int = 0) -> Int {
    value * 2
}
multiplyByTwo3(10)


// Use if let to check nil
var age : Int? = nil
if age != nil {
    "Age is there! How odd!"
} else  {
    "Age is nil. Correct."
}
if let age {
    "Age is there. How odd! Its value is \(age)"
} else {
    "No age is present. As expected"
}


// Use guard let to check nil
// Guard does a negation of age. If your function depends on some optional value and it can't continue without those optional values being present then you need to use guard keyword. Suppose you want to check form field before submission.
let age2 : Int? = 50
func checkAge() {
    //    if age == nil {
    //        "Age is nil as expected"
    //        return
    //    }
    
    // We did not unwrap the value of age
    guard age2 != nil else {
        "Age is nil as expected"
        return
    }
    "Age is not nil here. Strange!"
    "Age is not nil here. Strange! -> \(age2)"
    
    // To unwrap the value of age we need to use guard let
    guard let age2 else {
        return
    }
    "Age is not nil here. Strange! -> \(age2)"
}
checkAge()



// Optionals are actually instance of Enumeration
switch age2 {
case .none:
    "Age has null value as expected"
    break
    // case .some(_): // not unwrapped
case let .some(value):
    "Age has the value of \(value)"
    break
}

// Simple comparison with optional value and int value, can be possible
// if age2 == 50 {
if age2 == .some(50) { // this is more descriptive
    "Age has the value of \(age2!)"
} else {
    "Age has null value as expected"
}



// You can also to do optional chaining
struct Person {
    let name: String
    let address: Address?
    struct Address {
        let firstLine: String?
    }
}

let foo: Person = Person(
    name: "Foo",
    address: Person.Address(firstLine: "Address Line 1")
)

if let fooFirstAddressLine = foo.address?.firstLine {
    fooFirstAddressLine
} else {
    "Foo doesn't have an address with first line as expected"
}

if let fooAdress = foo.address,
   let firstLine = fooAdress.firstLine {
    fooAdress
    firstLine
}

let bar: Person? = Person(
    name: "Bar",
    address: Person.Address(
        firstLine: nil
    )
)

if bar?.name == "Bar",
   bar?.address?.firstLine == nil {
    "Bar's name is bar and has no first line of address."
} else {
    "Seems like something isn't working right!"
}


// You can also switch on optional chaining using where clauses
let baz : Person? = Person(
    name: "Baz",
    address: Person.Address(
        firstLine: "Baz First Line"
    )
)
switch baz?.address?.firstLine {
    case let .some(firstLine) where firstLine.starts(with: "Baz"):
        "Baz first address line = \(firstLine)"
        break
    case let .some(firstLine):
        "Baz first address line that didn't match the previous case."
        firstLine
        break
    case .none:
        "Baz first address line is nil? weird!"
        break
}


// guard let and if let
func getFullName(
    firstName: String,
    lastName: String?
) -> String? {
    if let lastName {
        return "\(firstName) \(lastName)"
    } else {
        return nil
    }
}
getFullName(firstName: "Foo", lastName: "Bar")
getFullName(firstName: "Foo", lastName: nil)

// If your function depends on some optional value and it can't continue without those optional values being present then you need to use guard keyword. Suppose you want to check form field before submission.
func getFullName2(
    firstName: String,
    lastName: String?
) -> String? {
    guard let lastName else {
        return nil
    }
    return "\(firstName) \(lastName)"
}
getFullName2(firstName: "Foo", lastName: "Bar")
getFullName2(firstName: "Foo", lastName: nil)
