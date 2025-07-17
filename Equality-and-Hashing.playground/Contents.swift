import Foundation

// Equality in swift is provided using a protocol called equatable. Any object that conforms to the equtable protocol has to have a static equality function (==) and has two arguments left-hand-side and right-hand-side both of the exact same type as the current structure class implementing it.

// Use Structure
struct Person: Equatable {
    let id: String
    let name: String
}

let foo1 = Person(
    id: "1",
    name: "Foo"
)
let foo2 = Person(
    id: "1",
    name: "Foo"
)

if foo1 == foo2 {
    "They are equal"
} else {
    "They are not equal"
}

// If person is equatable then no need to implement equality function
//extension Person {
//    static func == (
//        lhs: Self,
//        rhs: Self
//    ) -> Bool {
//        lhs.id == rhs.id
//    }
//}


// Use Enumeration
enum AnimalType: Equatable {
    case dog(breed: String)
    case cat(breed: String)
}

let dog1 = AnimalType.dog(breed: "Sherif Labrador")
let dog2 = AnimalType.dog(breed: "Sherif Labrador")

if dog1 == dog2 {
    "They are equal"
} else {
    "They are not equal"
}

// Custom Implementation
// We can remove this extensions because swift provide this if we make our enum equatable
// If you have some custom funtionality then you can add custom extension
//extension AnimalType: Equatable {
//    static func == (
//        lhs: Self,
//        rhs: Self
//    ) -> Bool {
//        switch(lhs, rhs) {
//        case let (.dog(lhsBreed), .dog(rhsBreed)),
//            let (.cat(lhsBreed), .cat(rhsBreed)):
//            return lhsBreed == rhsBreed
//        default:
//            return false
//        }
//    }
//}

struct Animal: Equatable {
    let name: String
    let type: AnimalType
    
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.type == rhs.type
    }
}
let cat1 = Animal(
    name: "Muezza",
    type: .cat(
        breed: "Persian"
    )
)
let cat2 = Animal(
    name: "Whiskers",
    type: .cat(
        breed: "Persian"
    )
)
if cat1 == cat2 {
    "They are equal because of their type"
} else {
    "They are not equal"
}


// MARK: - Hashable

// Hashable looks at all properties of a struct or class to make them hashable
struct House: Hashable {
    let number: Int
    let numberOfBedrooms: Int
}

let house1 = House(
    number: 123,
    numberOfBedrooms: 4
)
house1.hashValue

let house2 = House(
    number: 123,
    numberOfBedrooms: 4
)
house2.hashValue

let houses = Set([house1, house2])
houses.count


// Custom Hashable
struct NumberedHouse: Hashable {
    let number: Int
    let numberOfBedrooms: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(number)
    }
    
    static func == (
        lhs: Self,
        rhs: Self
    ) -> Bool {
        lhs.number == rhs.number
    }
}

let house3 = NumberedHouse(
    number: 124,
    numberOfBedrooms: 2
)
let house4 = NumberedHouse(
    number: 123,
    numberOfBedrooms: 3
)
let houses2 = Set([house3, house4])
houses2.count
houses2.first!.numberOfBedrooms
house3.hashValue
house4.hashValue
house3.number.hashValue
house4.number.hashValue


// Enum by default Hashable if it doesn't has associated values
enum CarPart {
    case roof
    case tire
    case trunk
}

let uniqueParts: Set<CarPart> = [
    .roof,
    .tire,
    .roof,
    .trunk
]


enum HouseType: Hashable {
    case bigHouse(NumberedHouse)
    case smallHouse(NumberedHouse)
}
let houseTypes: Set<HouseType> = [
    .bigHouse(NumberedHouse(
        number: 1, numberOfBedrooms: 1
    )),
    .smallHouse(NumberedHouse(
        number: 2, numberOfBedrooms: 2
    ))
]
let bigHouse1 = HouseType
    .bigHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )
let bigHouse2 = HouseType
    .bigHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )
let smallHouse1 = HouseType
    .smallHouse(
        NumberedHouse(
            number: 1,
            numberOfBedrooms: 1
        )
    )
let allHouses: Set<HouseType> = [
    bigHouse1,
    bigHouse2,
    smallHouse1
]
allHouses.count
for value in allHouses {
    print(value)
}

// When it comes to equality and hashing, one is the hash value which determines whether two objects should consume the same space inside a set but also you have to implement equality which determines wheter two objects are actualy equal to each other.

//In programming, Equatable and Hashable protocols are crucial for defining how objects are compared for equality and used in data structures like sets and dictionaries. Equatable allows objects to be checked for equality using the == operator, while Hashable provides a mechanism to generate a hash value for an object, enabling its use as a key in hash-based collections.

//Explanation:
//Equatable:
//This protocol is implemented by types that can be compared for equality. It defines the == operator, which determines if two instances of the type are considered the same. For example, in Swift, String conforms to Equatable, so you can check if two strings have the same characters. If two objects are equal according to ==, their hash values must also be the same (though the reverse is not necessarily true).

//Hashable:
//This protocol builds upon Equatable and allows objects to be hashed. Hashing is the process of converting an object into a numerical representation (hash value), which can be used to quickly locate or compare objects. When an object is hashable, it can be used as a key in dictionaries or stored in sets. This is because the hash value acts as an index into a hash table, allowing for efficient lookups. For example, if you have a dictionary that maps student names to their grades, you would use the Hashable protocol to ensure that you can quickly retrieve a student's grade based on their name.

//Relationship between == and hashValue:
//If two objects are equal according to the == operator, their hashValue must be the same. However, the reverse is not always true. Two objects can have the same hashValue (a hash collision) but not be equal according to ==. This is because the hash function maps potentially many different inputs to a smaller range of outputs.

//Importance of Hashable for data structures:
//Sets: Sets store unique elements. The Hashable protocol allows sets to efficiently determine if an element already exists.
//Dictionaries: Dictionaries store key-value pairs. The Hashable protocol allows dictionaries to quickly find the value associated with a given key.

//Example:
//Imagine a class Point with x and y coordinates. To make Point hashable, you would first make it Equatable by defining the == operator (e.g., two points are equal if their x and y coordinates are the same). Then, you would implement Hashable and define how the hashValue is calculated (e.g., based on the x and y coordinates).
//Now, you can create a set of Point objects, and if you add two points with the same coordinates, the set will recognize that they are the same point and only store one instance. Similarly, you can use Point objects as keys in a dictionary.
