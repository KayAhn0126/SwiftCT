import Foundation

let number = Int(readLine()!)!

var data: [Int: (String, Int)] = [:]

for i in 0..<number {
    let temp = readLine()!.split(separator: " ").map { String($0) }
    data[i] = (temp[1], Int(temp[0])!)
}

data.sorted(by: {
    if $0.value.1 == $1.value.1 {
        return $0.key < $1.key
    }
    return $0.value.1 < $1.value.1
}).forEach {
    print("\($0.value.1) \($0.value.0)")
}
