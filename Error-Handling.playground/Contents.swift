import Foundation

// Error Handling is one of the most important concepts in any programming language to support erros and exceptions. It's either the faliure of the code that we've written such as an error or is the failure of the person calling any funtion such as an exception. In swift we will only talk about errors.
// The code found out the something hasn't gone according to the plans, it throws an error. (keyword throw)

struct Person {
    let firstName: String?
    let lastName: String?
    
    enum PersonErrors: Error {
        case firstNameIsNil
        case lastNameIsNil
        case bothNamesAreNil
    }
    
    func getFullName() throws -> String {
        if let firstName, let lastName {
            "\(firstName) \(lastName)"
        } else if firstName == nil, let lastName {
            throw PersonErrors.firstNameIsNil
        } else if lastName == nil, let firstName {
            throw PersonErrors.lastNameIsNil
        } else {
            throw PersonErrors.bothNamesAreNil
        }
    }
    
    func getFullNameSwitch() throws -> String {
        switch (firstName, lastName) {
            
        case (.none, .none):
            throw PersonErrors.bothNamesAreNil
        case (.none, .some):
            throw PersonErrors.firstNameIsNil
        case (.some, .none):
            throw PersonErrors.lastNameIsNil
        case let (.some(firstName), .some(lastName)):
            "\(firstName) \(lastName)"
        }
    }
}

let person = Person(
    firstName: nil,
    lastName: "Bar"
)
// let fullName = person.getFullNameSwitch()        // Call can throw but is not marked with 'try'
// let fullName = try person.getFullNameSwitch()    // An error was thrown and was not caught
// try person.getFullName()                         // An error was thrown and was not caught
// try person.getFullNameSwitch()                   // An error was thrown and was not caught

do {
    let fullName = try person.getFullName()
    fullName
} catch {
    "Got an error = \(error)" // hidden variable error
}
//catch is Person.PersonErrors {
//    "Got an error"
//}

// How do I know which one of this error it is?
let bar = Person(
    firstName: nil,
    lastName: nil
)

do {
    let fullName = try bar.getFullNameSwitch()
    fullName
} catch Person.PersonErrors.firstNameIsNil {
    "First Name is Nil"
} catch Person.PersonErrors.lastNameIsNil {
    "Last Name is Nil"
} catch Person.PersonErrors.bothNamesAreNil {
    "Both First Name and Last Name is Nil"
} catch {
    "Some other error was thrown = \(error)"
}


// MARK: - You can also throw errors inside constructors of Structure and Classes. You try to construct an object but the parameters that you're passing to the object are somehow not valid.
struct Car {
    let manufacturer: String
    
    enum Erros: Error {
        case inavalidManufacturer
    }
    
    init(
        manufacturer: String
    ) throws {
        if manufacturer.isEmpty {
            throw Erros.inavalidManufacturer
        }
        self.manufacturer = manufacturer
    }
}
do {
    let myCar = try Car(manufacturer: "")
    myCar
    myCar.manufacturer
} catch Car.Erros.inavalidManufacturer {
    "Invalid Manufacturer"
} catch {
    "Some other error was thrown = \(error)"
}

// MARK: - try with ?
// You sometimes may not care about the errors
// if let yourCar = try Car( // Initializer for conditional binding must have Optional type, not 'Car'
if let yourCar = try? Car( // try? means you do not have to have the do and catch statement
    manufacturer: "Tesla"
) {
    "Success, your car = \(yourCar)"
    yourCar.manufacturer
} else {
    "Failed to construct and error is not accessible now"
}


// MARK: - try with ! should avoid
// You can also in some very rare cases very angrily try to unwrap the value of a function that can throw. That means it will indeed crash
// Fatal error: 'try!' expression unexpectedly raised an error: __lldb_expr_931.Car.Erros.inavalidManufacturer
let theirCar = try! Car(
    manufacturer: "Ford"
)
theirCar.manufacturer



// MARK: - Any funtions that has throws can throw any errors
struct Dog {
    let isInjured: Bool
    let isSleeping: Bool
    
    enum BarkingErrors: Error {
        case cannotBarkIsSleeping
    }
    
    enum RunnigErrors: Error {
        case cannotRunIsInjured
    }
    
    func bark() throws {
        if isSleeping {
            throw BarkingErrors.cannotBarkIsSleeping
        }
        "Barking..."
    }
    
    func run() throws {
        if isInjured {
            throw RunnigErrors.cannotRunIsInjured
        }
        "Running..."
    }
    
    // If you mark your mark you funtion as throws, just try things you dont need to wrap them into do and catch.
    // If any of this functions that we have inside throws then this funtion itself will throw
    // func barkAndRun() rethrows { // 'rethrows' function must take a throwing function argument (like closure)
    func barkAndRun() throws {
        try bark()
        try run()
        
        // if backend developer say to call an API when catch error then use do and catch
//        do {
//            try bark()
//        } catch {
//            // do your API call
//        }
    }
}

let dog = Dog(
    isInjured: true,
    isSleeping: false
)
do {
    try dog.barkAndRun()
    dog
} catch Dog.BarkingErrors.cannotBarkIsSleeping {
    "Cannot bark is sleeping"
} catch Dog.RunnigErrors.cannotRunIsInjured {
    "Cannot run is injured"
} catch {
    "Some other error"
}


// MARK: - Lets talk about rethrows
// A function that internally calls another function which can also throw
func fullName(
    firstName: String?,
    lastName: String?,
    calculator: (String?, String?) throws -> String?
) rethrows -> String? {
    try calculator(
        firstName,
        lastName
    )
}

enum NameErros: Error {
    case firstNameIsInvalid
    case lastNameIsInvalid
}
func + (
    firstName: String?,
    lastName: String?
) throws -> String? {
    guard let firstName, !firstName.isEmpty else {
        throw NameErros.firstNameIsInvalid
    }
    guard let lastName, !lastName.isEmpty else {
        throw NameErros.firstNameIsInvalid
    }
    return "\(firstName) \(lastName)"
}

do {
    let fooBar = try fullName(
        firstName: "Foo",
        lastName: nil,
        calculator: +
    )
} catch NameErros.firstNameIsInvalid {
    "First name is invalid"
} catch NameErros.lastNameIsInvalid {
    "Last name is invalid"
} catch let err {
    "Some other error = \(err)"
}
// return type String? as closure but main method using String is promotio but reversing will not work because of demotion
// func + (
// firstName: String?,
// lastName: String?
// ) throws -> String {}

// func fullName(
//    firstName: String?,
//    lastName: String?,
//    calculator: (String?, String?) throws -> String?
// ) rethrows -> String? {}



// MARK: - Lets also talk about Result (usually we use to write API calls)
enum IntegerErrors: Error {
    case noPositiveIntegerBefore(thisValue: Int)
}

func getPreviousPositiveInteger(
    from value: Int
) -> Result<Int, IntegerErrors> {
    guard value > 0 else {
        return Result.failure(
            IntegerErrors.noPositiveIntegerBefore(thisValue: value)
        )
    }
    return Result.success(value - 1)
}
func perforGet(fromValue value: Int) {
    switch getPreviousPositiveInteger(from: value) {
    case let .success(previousValue):
        "Previous vale is \(previousValue)"
    case let .failure(error):
        switch error {
        case let .noPositiveIntegerBefore(thisValue):
            "No positive integer before \(thisValue)"
        }
    }
}
perforGet(fromValue: -5)
perforGet(fromValue: 10)
getPreviousPositiveInteger(from: 10)
