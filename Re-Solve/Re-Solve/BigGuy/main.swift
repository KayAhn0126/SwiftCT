import Foundation

let num = Int(readLine()!)!

var people: [(Int,Int)] = []
var result = [Int](repeating: 1, count: num)

for i in 0..<num {
    let info = readLine()!.split(separator: " ").map { Int(String($0))! }
    people.append((info[0], info[1]))
}

// i는 기준, j는 비교 대상
for i in 0..<num {
    for j in 0..<num {
        if i == j {
            continue
        }
        if people[i].0 < people[j].0 && people[i].1 < people[j].1 {
            result[i] += 1
        }
    }
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
