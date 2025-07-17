import Foundation

/// Special types of functions that are created inline. You can pass theme to another funtion and they
/// can hold a function.


func add(
    _ lhs: Int,
    _ rhs: Int
) -> Int {
    lhs + rhs
}

let add: (Int, Int) -> Int
= { (lhs: Int, rhs: Int) -> Int in
    lhs + rhs
}

add(20, 30)



func customAdd(
    _ lhs: Int,
    _ rhs: Int,
    using function: (Int, Int) -> Int // trailling closure syntax
) -> Int {
    function(lhs, rhs)
}
customAdd(
    20,
    30,
    using: { (lhs: Int, rhs: Int) -> Int in
        lhs + rhs
    }
)
// because it has trailling closure
// best approach
customAdd(
    20,
    30
) { (lhs: Int, rhs: Int) -> Int in
    lhs + rhs
}
// Cleaning up the code
// the less you give information to the compiler the more it will take to comple the code
customAdd(
    20,
    30
) { (lhs, rhs) in
    lhs + rhs
}
// More cleaning
customAdd(
    20, // $0
    30  // $1
) {
    $0 + $1
}
customAdd(20, 30) { $0 + $1 }



let ages = [30, 20, 19, 40,7, 21, 90, 13, 100]
ages.sorted(by: { (lhs: Int, rhs: Int) -> Bool in
        lhs > rhs
    }
)
ages.sorted(by: >) // More like code above
ages.sorted(by: <)



func customAddNew(
    using function: (Int, Int) -> Int,
    _ lhs: Int,
    _ rhs: Int
) -> Int {
    function(lhs, rhs)
}
// Looks Verbose
customAddNew(using: { (lhs, rhs) in
    lhs + rhs
}, 20, 80)
customAddNew(using: { $0 + $1}, 20, 80)



func add10To(_ value: Int) -> Int {
    value + 10
}
func add20To(value: Int) -> Int {
    value + 20
}
func doAddition(
    on value: Int,
    using function: (Int) -> Int
) {
    function(value)
}
doAddition(
    on: 100,
    using: { (lhs: Int) -> Int in
        lhs + 40
    }
)
doAddition(
    on: 100
) { (lhs) in
     lhs + 40
}
doAddition(
    on: 100,
    using: add10To(_:)
)
doAddition(
    on: 100,
    using: add20To(value:)
)
