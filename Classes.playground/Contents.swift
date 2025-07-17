import Foundation


// It's a third storage of three Variables, Structures and Classes to hold value into
// the memory, and classes are reference types and allow mutability without prefix thing
// like mutating like structures

// Class 'Person' has no initializers so we need init constructor
class Person {
    var name: String
    var age: Int
    
    init(
        name: String,
        age: Int
    ) {
        self.name = name
        self.age = age
    }
    
    // mutating func increaseAge() { // 'mutating' is not valid on instance methods in classes
    func increaseAge() {
        self.age += 1
    }
}

let person1 = Person(name: "Foo", age: 20)
person1.name
person1.age
person1.increaseAge()
person1.age


// MARK: - Checking equality by reference

// They are sharing the reference of the memory not value, if we change one it will affect the other one.
let person2 = person1
person2.increaseAge()
person1.age
person2.age

if person1 === person2 {
    "Person1 and Person2 point to the same memory"
} else {
    "They don't point to the same memory"
}


// MARK: - Class Inheritence
class Vehicle {
    func goVroom() {
        "Vroom Vroom"
    }
}
class Car: Vehicle {
    override func goVroom() {
       "Go Pip Pip"
    }
}
let car = Car()
car.goVroom()


// MARK: - Private set variable
class PersonPrivate {
    private(set) var age: Int = 0
    
    init(age: Int) {
        self.age = age
    }
    
    func increaseAge() {
        self.age += 1
    }
}
let personPrivate = PersonPrivate(age: 30)
personPrivate.age
// Left side of mutating operator isn't mutable: 'age' setter is inaccessible
// personPrivate.age += 1
personPrivate.increaseAge()
personPrivate.age


// MARK: - Designated and Convenience Initializer
// You can have
// convenience initializers - Add some logic to the constructor or the initializer of that class and delegate the initialization to the designated initilizer.
// designated initializer - ensure construct an instance of class by ensuring that all property values are set, internal structure and validaty of that class hold us
class Tesla {
    let manufacturer = "Tesla"
    let model: String
    let year: Int
    
    // Designated Initializer
    init() {
        // Designated initializer for 'Tesla' cannot delegate (with 'self.init')
        // self.init(model: "Y", year: 2024)
        self.model = "X"
        self.year = 2023
    }
    
    // Designated Initializer
    init(
        model: String,
        year: Int
    ) {
        self.model = model
        self.year = year
    }
    
    // Convenience Initializer
    convenience init(
        model: String
    ) {
        self.init(
            model: model,
            year: 2023
        )
    }
}

class TeslaModelY: Tesla {
    override init() {
        super.init(model: "Y", year: 2023)
        // super.init(model: "Y") // Must call a designated initializer of the superclass 'Tesla'
    }
}

let modelY = TeslaModelY()
modelY.model
modelY.year
modelY.manufacturer



// MARK: - Classe are reference type e.g.

let fooBar = PersonPrivate(age: 20)
fooBar.age
func doSomething(with person: PersonPrivate) {
    person.increaseAge()
}
doSomething(with: fooBar)
fooBar.age


// MARK: - Deinitilizers
// If you are working with notification or reactive programming (Rx) etc.
// Deinit are invoke automatically by swift whenever your class instance going out of memory, like getting clean from the memory.
class MyClass {
    init() {
       "Initialized"
    }
    
    func doSomething() {
        "Do Something"
    }
    
    deinit {
        "Deinitialized"
    }
}

let myClass = MyClass()
myClass.doSomething()

// To calls deinit, put the whole thing into a closure and when closure is called, the scope inside the closure is finishes and MyClass deinit is called.
let myClosure = {
    let myClass = MyClass()
    myClass.doSomething()
}
myClosure()


