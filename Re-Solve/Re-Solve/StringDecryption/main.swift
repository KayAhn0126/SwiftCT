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

let find = readLine()!
let given = readLine()!

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

func countingAndAdd(_ num: Int, _ char: Character) {
    if char == "+" {
        if 65 <= num && num <= 90 {
            givenVisited[num - 65] += 1
        } else if 97 <= num && num <= 122 {
            givenVisited[num - 97 + 26] += 1
        }
    } else {
        if 65 <= num && num <= 90 {
            givenVisited[num - 65] -= 1
        } else if 97 <= num && num <= 122 {
            givenVisited[num - 97 + 26] -= 1
        }
    }
    
}

given.enumerated().forEach {
    let number = Int($0.element.asciiValue!)
    countingAndAdd(number, "+")
    count += 1
    if count == N {
        if findVisited == givenVisited {
            result += 1
        }
        let lastNumber = Int(given[$0.offset - (N - 1)]!.asciiValue!)
        countingAndAdd(lastNumber, "-")
        count -= 1
    }
}
print(result)
