import Foundation

// readLine() -> String?
// readLine()! -> String
// readLine()!.map { $0 } -> [String.element] -> [Character]
// typealias Element = Character
// String 배열로 만들고 싶다면 ..
// readLine()!.map { String($0) } -> [String]

let myString = readLine()!.map { Character(String($0)) }
let myStringCount = myString.count


let number = Int(readLine()!)!

// split은 String의 내장 함수
// split 함수의 반환 타입은 [String.Subsequence]
// typealias SubSequence = Substring
// Substring은 구조체 -> String으로 감싸 줘야한다.

// 주어진 문자열에서 나오는 문자를 해당 행/열에 가서 카운트 해준다.
var countingArr = [[Int]](repeating: [Int](repeating: 0, count: myStringCount + 1), count: 26)

for i in 0..<myStringCount {
    let row = Int(myString[i].asciiValue!) - 97
    countingArr[row][i+1] += 1
}

var prefixSum = [[Int]](repeating: [Int](repeating: 0, count: myStringCount + 1), count: 26)

for i in 0..<26 {
    for j in 1...myStringCount {
        prefixSum[i][j] = prefixSum[i][j-1] + countingArr[i][j]
    }
}

func getResult(_ char: Character, _ num1: Int, _ num2: Int) -> Int {
    let n = Int(char.asciiValue!) - 97
    return prefixSum[n][num2+1] - prefixSum[n][num1]
}

for i in 0..<number {
    let charFromTo = readLine()!.split(separator: " ")
    let char = Character(String(charFromTo[0]))
    let from = Int(String(charFromTo[1]))!
    let to = Int(String(charFromTo[2]))!
    print(getResult(char,from,to))
}
