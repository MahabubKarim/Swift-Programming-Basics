import Foundation



// cannot to be assigned to again
let myName = "Mahabub"
// can be assigned to again
var yourName = "Foo"
var names = [
    myName,
    yourName
]
names.append("Bar")
names.append("Car")




// This is a struct, and structure is a "value type", internal immutability is only works in struct
// and variable
let moreNames = [
    "Foo",
    "Bar"
]
var copy = moreNames
copy.append("Baz")
moreNames
copy




// This is a class and class is a "reference type", internal immutability is not works here, class
// might change internally
let oldArray = NSMutableArray(
    array: [
        "Foo",
        "Bar"
    ]
)
// because it's reference type so you can add value even if it's let
oldArray.add("Baz")
var newArray = oldArray
newArray.add("Qux")
oldArray
newArray



let someNames = NSMutableArray(
    array: [
        "Foo",
        "Bar"
    ]
)

func changeTheArray(_ array: NSArray) {
    let copy = array as! NSMutableArray
    copy.add("Baz")
}
changeTheArray(someNames)
someNames
