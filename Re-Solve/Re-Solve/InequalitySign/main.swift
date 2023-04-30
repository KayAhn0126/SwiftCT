import Foundation

func checkIfSignIsValid(_ num1: Int, _ sign: Character, _ num2: Int) -> Bool {
    if sign == "<" && num1 < num2 { return true }
    if sign == ">" && num1 > num2 { return true }
    return false
}

let signCount = Int(readLine()!)!
let signArr = readLine()!.split(separator: " ").map { Character(String($0)) }

var visited = [Bool](repeating: false, count: 10)

var totalResult = [String]()

func backTracking(_ idx: Int, _ currentString: String) {
    if idx == signCount + 1 { // 여기까지 왔다는것은 유효하다는 증거
        totalResult.append(currentString)
        return
    }
    for i in 0...9 {
        if visited[i] { continue }
        if idx == 0 || checkIfSignIsValid(Int(String(currentString.last!))!, signArr[idx - 1], i) {
            visited[i] = true
            backTracking(idx + 1, currentString + String(i))
            visited[i] = false
        }
    }
}

backTracking(0, "")

print(totalResult[totalResult.count-1])
print(totalResult[0])
