import Foundation

// It's gonna work but it's not so obvious. Because in lot of cases people even can't see your source code, so they have to guess what type they have to pass. That's why we need enum
// struct Animal {
//    let type: String
//    init(type: String) {
//        if type == "Rabbit" || type == "Dog" || type == "Cat" {
//            self.type = type
//        } else {
//            preconditionFailure()
//        }
//    }
// }
// Animal(type: "Bike")

enum Animal {
    case cat
    case dog
    case rabbit
}
let cat = Animal.cat
cat

if cat == Animal.cat {
    "This is a cat"
} else if cat == Animal.dog {
    "This is a dog"
} else {
    "This is something else"
}


//if cat == Animal.cat {
//    "This is a cat"
//} else if cat == Animal.dog {
//    "This is a dog"
//} else if cat == 3 { // Referencing operator function '==' on 'BinaryInteger' requires that 'Animal' conform to 'BinaryInteger'
//    "This is something else"
//}

// This is insane, "equal to" can be a funtion HAHAHAHA...
// The solution of cat == 3, don't do this
//func == (
//    lhs: Animal,
//    rhs: Int
//) -> Bool {
//    lhs == .cat && rhs == 3
//}

if cat == Animal.cat {
    "This is a cat"
} else if cat == Animal.dog {
    "This is a dog"
} else {
    "This is something else"
}


let dog = Animal.dog
// More simpler using switch
switch dog {
    case .cat:
        "This is a cat"
        break
    case .dog:
        "This is a dog"
        break
//    case .rabbit:
//        "This is something else"
//        break
    default: // You can use default to ignore exhaustive warning
        break
}

func describelAnimal(_ animal: Animal) {
    switch animal {
        case .cat:
            "This is a cat"
            break
        case .dog:
            "This is a dog"
            break
        default:
            "This is something else"
            break
    }
}
describelAnimal(Animal.dog)


// If you add new item in Animal Enum the if-else will work perfectly, but the
// switch statement will show error everywhere it has been used. It's a good practice to use switch statement for enums
enum Animal2 {
    case cat
    case dog
    case rabbit
    case hedgehog
}

let dog2 = Animal2.dog

switch dog2 { // Switch must be exhaustive, no implementation for hedgehog
    case .cat:
        "This is a cat"
        break
    case .dog:
        "This is a dog"
        break
    case .rabbit:
        "This is a rabbit"
        break
    case .hedgehog:
        "This is a hedgehog"
        break
}

// MARK: - Enumeration with Associated Values

// Advanced Features Enum with Assosiated Values
enum Shortcut {
    case fileOrFolder(path: URL, name: String)
    case wwwUrl(path: URL)
    case song(artist: String, songName: String)
}

let wwwApple = Shortcut.wwwUrl(
    path: URL(filePath: "https://www.example.come")!
)

// Referencing operator function '==' on 'Equatable' requires that 'Shortcut' conform to 'Equatable'
// solution enum Shortcut : Equatable {}
//if wwwApple == Shortcut.wwwUrl(
//    path: URL(filePath: "https://www.example.come")!
//) {
//    
//}
// solution use switch
switch wwwApple {
    case .fileOrFolder(
        path: let path,
        name: let name
    ):
        path
        name
        break
    case .wwwUrl(
        path: let path
    ):
        path
        break
    case .song(
        artist: let artist,
        songName: let songName
    ):
        artist
        songName
        break
}
// Simpler
switch wwwApple {
    case .fileOrFolder(
        let path,
        let name
    ):
        path
        name
        break
    case .wwwUrl(
        let path
    ):
        path
        break
    case .song(
        let artist,
        let songName
    ):
        artist
        songName
        break
}
// More Simpler
switch wwwApple {
    case let .fileOrFolder(
        path,
        name
    ):
        path
        name
        break
    case let .wwwUrl(
        path
    ):
        path
        break
    case let .song(
        artist,
        songName
    ):
        artist
        songName
        break
}



// Only handle specific Enum case
if case let .wwwUrl(path) = wwwApple {
    path
}

let fileOrFolde = Shortcut.fileOrFolder(
    path: URL(filePath: "https://www.example.come")!,
    name: "Example")
if case let .fileOrFolder(path, name) = fileOrFolde {
    path
    name
}

let withoutYou = Shortcut.song(
    artist: "Symphony X",
    songName: "Without You"
)
if case let .song(artist, songName) = withoutYou {
    artist
    songName
}
if case let .song(_, songName) = withoutYou {
    songName
}



// Get diffrent type using method
enum Vehicle {
    case Car(manufacturer: String, model: String)
    case Bike(manufacturer: String, yearMade: Int)
    
    // As Method
//    func getManufacturer() -> String {
//        switch self {
//            case let .Car(manufacturer, _):
//                return manufacturer
//            case let  .Bike(manufacturer, _):
//                return manufacturer
//        }
//    }
    
    // As Property
    var manufacturer: String {
//        switch self {
//            case let .Car(manufacturer, _):
//                return manufacturer
//            case let  .Bike(manufacturer, _):
//                return manufacturer
//        }
        // more simpler, returning same variable
        switch self {
//            case let .Car(manufacturer, _),
//            let .Bike(manufacturer, _):
//                return manufacturer
            
            // Pattern mathing for different parameter
            case let .Car(_, foo),
            let .Bike(foo, _):
                return foo
        }
    }
}
let car = Vehicle.Car(manufacturer: "Tesla", model: "X")
let bike = Vehicle.Bike(manufacturer: "HD", yearMade: 1987)

// Call Enum Method
// car.getManufacturer()
// bike.getManufacturer()

// Call Enum Property
car.manufacturer
bike.manufacturer

// As Function Outside Class
func getManufacturer(from vehicle: Vehicle) -> String {
    switch vehicle {
        case let .Car(manufacturer, _):
            return manufacturer
        case let  .Bike(manufacturer, _):
            return manufacturer
    }
}
getManufacturer(from: bike)
getManufacturer(from: car)



//MARK: - Enumeration with raw values

//enum FamilyMember {
//    case father = "Papa" // Enum case cannot have a raw value if the enum does not have a raw type
//    case mother = "Mama"
//    case brother = "Bro"
//    case sister = "Sis"
//}

enum FamilyMember : String {
    case father = "Papa"
    case mother = "Mama"
    case brother = "Bro"
    case sister = "Sis"
}
FamilyMember.father.rawValue
FamilyMember.mother.rawValue
FamilyMember.brother.rawValue
FamilyMember.sister.rawValue


// MARK: - Iterable Enum
enum FavouriteEmoji: String, CaseIterable {
    case blush = "☺️" // Shortcut to Emoji Cmd+Ctrl+Space
    case rocket = "🚀"
    case fire = "🔥"
    case love = "💕"
    case snow = "❄️"
}
FavouriteEmoji.allCases
FavouriteEmoji.allCases.map(\.rawValue)

FavouriteEmoji.blush.rawValue
FavouriteEmoji.love.rawValue

// reverse the value emoji itself
// if let blush = FavouriteEmoji(rawValue: "😍") {
if let blush = FavouriteEmoji(rawValue: "☺️") {
    "Found the blush emoji"
    blush
} else {
    "This emoji doesn't exist"
}

if let snow = FavouriteEmoji(rawValue: "❄️") {
    "Snow Exists?! really?"
    snow
} else {
    "As expected, snow doesn't exist in our enum"
}


// MARK: - Make Enum Mutating

enum Height {
    case short, medium, long
    mutating func makeLong() {
        self = Height.long
    }
}
// Cannot use mutating member on immutable value: 'myHeight' is a 'let' constant
// let myHeight = Height.medium
var myHeight = Height.medium
myHeight.makeLong()
myHeight


// MARK: - Recursive Enumeration (Enumeration that refers to itself)
/// In Swift, the indirect keyword is used to create data structures that reference themselves, like linked lists or trees. These structures can grow dynamically and handle complex relationships.
indirect enum IntOperation {
    case add(Int, Int)
    case subtract(Int, Int)
    case freehand(IntOperation)
    
    func calculateResult(
        of operation: IntOperation? = nil
    ) -> Int {
        switch operation ?? self {
            case let .add(lhs, rhs):
                    return lhs + rhs
            case let .subtract(lhs, rhs):
                return lhs - rhs
            case let .freehand(operation):
                return calculateResult(of: operation)
        }
    }
}
let freeHand = IntOperation.freehand(.freehand(.add(20, 30)))
freeHand.calculateResult()
// freeHand.calculateResult(of: .freehand(.add(20, 30)))


