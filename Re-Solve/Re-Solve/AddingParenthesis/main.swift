import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}


let num = Int(readLine()!)!
let regex = readLine()!

var numArr = [Int]()
var operArr = [Character]()

for i in 0..<regex.count {
    if i % 2 == 0 {
        numArr.append(Int(String(regex[i]!))!)
    } else {
        operArr.append(regex[i]!)
    }
}

/*
 가지치기해서 가장 큰수를 업데이트하면 된다.
 3 + 8 * 7 인 경우
 1. 3 + 8을 먼저 계산하고 7을 곱하는 경우
    - 처음 두개 계산 후 함수에 다시 던지기
    - 현재 매개변수로 받아온 idx로 던지기
 
 2. 8 * 7을 먼저 계산하고 3을 더하는 경우
    - 뒤에 두개 계산 후 던지기
    - 현재 매개변수로 받아온 idx+1로 던지기
 */
func calculate(_ num1: Int, _ oper: Character, _ num2: Int) -> Int {
    if oper == "*" { return num1 * num2 }
    if oper == "+" { return num1 + num2 }
    if oper == "-" { return num1 - num2 }
    return 0
}

var result = Int.min
func go(_ currentIdx: Int, _ currentResult: Int) {
    if currentIdx == numArr.count - 1 {
        result = currentResult > result ? currentResult : result
        return
    }
    go(currentIdx + 1, calculate(currentResult, operArr[currentIdx], numArr[currentIdx + 1]))
    if currentIdx + 2 <= numArr.count - 1 {
        let preWork = calculate(numArr[currentIdx + 1], operArr[currentIdx + 1], numArr[currentIdx + 2])
        go(currentIdx + 2, calculate(currentResult, operArr[currentIdx], preWork))
    }
}
go(0, numArr[0])
print(result)
