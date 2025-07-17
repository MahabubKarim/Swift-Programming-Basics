import Foundation

// SwiftUI is based entirely on generic types, so you cannot ignore them
// Generics is used to writing same function or same code multiple times

// Scary Looking Function
func performInt(
    _ op: (Int, Int) -> Int,
    on lhs: Int,
    and rhs: Int
) -> Int {
    op(lhs, rhs)
}

performInt(+, on: 100, and: 200)
performInt(-, on: 200, and: 100)
performInt(*, on: 100, and: 200)
performInt(/, on: 200, and: 20)

func performDouble(
    _ op: (Double, Double) -> Double,
    on lhs: Double,
    and rhs: Double
) -> Double {
    op(lhs, rhs)
}

performDouble(+, on: 100.50, and: 200)
performDouble(-, on: 200, and: 100)
performDouble(*, on: 100, and: 200.30)
performDouble(/, on: 200, and: 20)



// We can solve the above problem using generics
func perform<N: Numeric>(
    _ op: (N, N) -> N,
    on lhs: N,
    and rhs: N
) -> N {
    op(lhs, rhs)
}

perform(+, on: 100, and: 2000)
perform(+, on: 10.70, and: 20.30)

// For funtion signatures of generic parameters, we can move the type to return type like "-> A where A: Somthing" to avoid "foo<A: Something, B: Something, C: Something, D: Something>" etc.
func perform2<N>(
    _ op: (N, N) -> N,
    on lhs: N,
    and rhs: N
) -> N where N: Numeric {
    op(lhs, rhs)
}
perform2(+, on: 100, and: 2000)
perform2(-, on: 10.70, and: 20.30)




// Structures and Classes supports multiple protocols
protocol CanJump {
    func jump()
}

protocol CanRun {
    func run()
}

struct Person: CanRun, CanJump {
    func jump() {
        "Jumping..."
    }
    
    func run() {
       "Running..."
    }
}

func jumpAnRun(value: Person) {
    value.jump()
    value.run()
}
func jumpAnRun<T: CanJump & CanRun>(_ value: T) {
    value.jump()
    value.run()
}
let person = Person()
jumpAnRun(person)

let names : [String] = ["Foo", "Bar"]
let names2 : Array<String> = ["Foo", "Bar"]

// Old System
extension Array where Element == String {}

// New System
extension [String] {
    func longestString() -> String? {
        self.sorted { (lhs: String, rhs: String) -> Bool in
            lhs.count > rhs.count
        }.first
    }
}
["Foo", "Bar", "Mahabub", "Helping Hand"].longestString()

extension [Int] {
    func largestNumber() -> Int? {
        self.sorted { (lhs: Int, rhs: Int) -> Bool in
            lhs > rhs
        }.first
    }
}
[100, 69, 78, 4, 59, 300, 700, 340, 557].largestNumber()

extension [Int] {
    func average() -> Double {
        Double(add()) / Double(self.count)
    }
    func add() -> Int {
        self.reduce(0, +)
    }
}
[100, 69, 78, 4, 59, 300, 700, 340, 557].average()
[100, 69, 78, 4, 59, 300, 700, 340, 557].add()




// Now work with Generic Protocols
// We want to represent every object in our system that can be turned into a view
protocol View {
    func addSubView(_ view: View)
}
extension View {
    func addSubView(_ view: View) {
        // empty
    }
}

struct Button: View {
    // empty
}




// If you want to turn a protocol into generic protocol you have to use associated type keyword
protocol PresentableAsView {
    associatedtype ViewType : View // Can be a button, table etc.
    func produceView() -> ViewType // If your view type is button it will produce button, if it's table then table
    func configure(
        superView: View,
        thisView: ViewType
    ) // anytime we want to present an object as a view, we allowed it to configure itself
    func present(
        view: ViewType,
        superView: View
    )
}

extension PresentableAsView {
    func configure(
        superView: View,
        thisView: ViewType
    ) {
        // empty
    }
    
    func present(
        view: ViewType,
        superView: View
    ) {
        superView.addSubView(view)
    }
}

// For Example I want to make Person Presenrtable on the UI, combine and swiftui somehow work like this
struct PersonUI: PresentableAsView {
    // According to our protocol implementation the produceView has to produce a ViewType that conforms to the View protocol and Button does that
    func produceView() -> Button {
        Button()
    }
    
    func configure(
        superView: any View,
        thisView: Button
    ) {
        superView.addSubView(thisView)
    }
    
    // That's how generics works, below the present method add the first parameter as Button automatically
    func present(view: Button, superView: any View) {
        // empty
    }
    
    let name: String
}

struct Table: View {
    // empty
}
struct MyTable: PresentableAsView {
    func produceView() -> Table {
        Table()
    }
    func configure(superView: any View, thisView: Table) {
        superView.addSubView(thisView)
    }
}

extension PresentableAsView {
    func deleteTheView() {
        // delete the button here
    }
    func doSomethingWithTheView() -> String {
        "This is a \(ViewType.self)"
    }
}

let personUI = PersonUI(name: "Foo")
personUI.deleteTheView()
personUI.doSomethingWithTheView()

let myTable = MyTable()
myTable.deleteTheView()
myTable.doSomethingWithTheView()

