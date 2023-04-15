import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let NL = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NL[0]
let L = NL[1]

let find = readLine()!.map { Character(String($0)) }
let given = readLine()!.map { Character(String($0)) }

var findVisited = [Int](repeating: 0, count: 53)
var givenVisited = [Int](repeating: 0, count: 53)

for i in find {
    let number = Int(i.asciiValue!)
    if 65 <= number && number <= 90 {
        findVisited[number - 65] += 1
    } else if 97 <= number && number <= 122 {
        findVisited[number - 97 + 26] += 1
    }
}

var count = 0
var result = 0
var flag = false

for i in 0..<L {
    let number = Int(given[i].asciiValue!)
    if 65 <= number && number <= 90 {
        givenVisited[number - 65] += 1
    } else if 97 <= number && number <= 122 {
        givenVisited[number - 97 + 26] += 1
    }
    count += 1
    if count == N {
        if findVisited == givenVisited {
            result += 1
        }
        let lastNumber = Int(given[i - (N - 1)].asciiValue!)
        if 65 <= lastNumber && lastNumber <= 90 {
            givenVisited[lastNumber - 65] -= 1
        } else if 97 <= lastNumber && lastNumber <= 122 {
            givenVisited[lastNumber - 97 + 26] -= 1
        }
        count -= 1
    }
}
print(result)
