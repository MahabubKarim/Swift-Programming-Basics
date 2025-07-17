import Foundation

func noArgNoReturnVal() {
    "I don't know what I'm doing"
}
noArgNoReturnVal()



func plusTwo(value: Int) {
    value + 2
}
plusTwo(value: 40)



func newPlusTwo(value: Int) -> Int {
   return value + 2
}
newPlusTwo(value: 50)



func customAdd(
    value1: Int,
    value2: Int
) -> Int {
    value1 + value2
}
let customAdded = customAdd(
    value1: 20,
    value2: 30
)

func customAddExternal(
    external value1: Int,
    value2: Int
) -> Int {
    value1 + value2
}
let customAddedExternal = customAddExternal(
    external: 20,
    value2: 30
)



func customMinus(
    _ lhs: Int,
    _ rhs: Int
) -> Int {
    lhs - rhs
}
let customSubstracted = customMinus(
    50,
    30
)


//@discardableResult
func myCustomAdd(
    _ lhs: Int,
    _ rhs: Int
) -> Int {
    lhs + rhs
}
myCustomAdd(20, 30)



func getFullName(
    firstName: String = "Foo",
    lastName: String = "Bar"
) -> String {
    "\(firstName) \(lastName)"
}
getFullName()
getFullName(firstName: "Max")
getFullName(lastName: "Mk")
getFullName(firstName: "Max", lastName: "Mk")


func doSomethingComplicated(
    with value: Int
) -> Int {
    func mainLogic(value: Int) -> Int {
        value + 2
    }
    return mainLogic(value: value)
}
doSomethingComplicated(with: 50)


