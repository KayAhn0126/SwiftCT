import Foundation

let NC = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NC[0]
let C = NC[1]

var arr = [Int](readLine()!.split(separator: " ").map { Int(String($0))! })

var dictionary: [Int: (Int, Int)] = [:]

arr.enumerated().forEach {
    if dictionary[$0.element] == nil {
        dictionary[$0.element] = ($0.offset, 1)
    } else {
        let index = dictionary[$0.element]!.0
        let count = dictionary[$0.element]!.1
        dictionary[$0.element]! = (index, count + 1)
    }
}
var result = [Int]()
dictionary.sorted(by: {
    if $0.value.1 == $1.value.1 {
        return $0.value.0 < $1.value.0
    }
    return $0.value.1 > $1.value.1
}).forEach {
    for _ in 0..<$0.value.1 {
        result.append($0.key)
    }
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
