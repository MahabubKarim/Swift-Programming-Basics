import Foundation
// We need this because asynchronous code requires that our playground is active all the time so that it doesn't start from the beginning.
import PlaygroundSupport
import _Concurrency

PlaygroundPage
    .current
    .needsIndefiniteExecution = true

// If you have an asynchronous function, it will not immediately return its result. It can take any number of seconds to complete its work and sometimes return some value.
func calculateFullName(
    firstName: String,
    lastName: String
) async -> String {
    try? await Task.sleep(for: .seconds(5))
    return "\(firstName) \(lastName)"
}

// To call a asynchronous function
Task {
    let result1 = await calculateFullName(
        firstName: "Foo",
        lastName: "Bar"
    )
    
    // "async let" creates a child task as part of parent Task
    async let result2 = calculateFullName(
        firstName: "Foo",
        lastName: "Bar"
    )
    await result2
}


// async, async let and task together
enum Clothe {
    case socks, shirt, trouser
}

func buySocks() async throws -> Clothe {
    try await Task.sleep(for: .seconds(2))
    return Clothe.socks
}
func buyShirt() async throws -> Clothe {
    try await Task.sleep(for: .seconds(2))
    return Clothe.shirt
}
func buyTrousers() async throws -> Clothe {
    try await Task.sleep(for: .seconds(2))
    return Clothe.trouser
}

struct Ensemble: CustomDebugStringConvertible {
    let clothes: [Clothe]
    let totalPrice: Double
    
    var debugDescription: String {
        "Clothes = \(clothes), price = \(totalPrice)"
    }
}
func buyWholeEnsemble() async throws -> Ensemble {
    async let socks = buySocks()
    async let shirt = buyShirt()
    async let trousers = buyTrousers()
    
    let ensemble = Ensemble(
        clothes: await [
            try socks,
            try shirt,
            try trousers
        ],
        totalPrice: 2000
    )
    return ensemble
}

Task {
    let result1 = try await buySocks()
    
    if let ensemble = try? await buyWholeEnsemble() {
        print(ensemble)
    } else {
        "Something went wrong"
    }
}

//async let result2 = calculateFullName(
//    firstName: "Foo",
//    lastName: "Bar"
//)
//await result2

func getFullName(
    delay: Duration,
    calculator: () async -> String
) async -> String {
    try? await Task.sleep(for: delay)
    return await calculator()
}

func fullName() async -> String { return "Foo bar" }

Task {
    await getFullName(
        delay: .seconds(1)
    ) {
        async let name = fullName()
        return await name
    }
}
