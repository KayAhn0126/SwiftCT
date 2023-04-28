import Foundation

//extension String {
//    subscript(idx: Int) -> Character? {
//        guard(0..<count).contains(idx) else { return nil }
//        let target = index(startIndex, offsetBy: idx)
//        return self[target]
//    }
//}

let wlsl = readLine()!.split(separator: " ").map { Int(String($0))! }
let wl = wlsl[0] // W의 길이
let sl = wlsl[1] // S의 길이

// 대문자 먼저(0~25), 소문자 나중(26~51)
var wArr = [Int](repeating: 0, count: 52)

let W = readLine()!.map { Character(String($0))} // 문자열 W
let S = readLine()!.map { Character(String($0))} // 문자열 S

for letter in W {
    let currentLetterNum = Int(letter.asciiValue!)
    if 65 <= currentLetterNum && currentLetterNum <= 90 {
        wArr[currentLetterNum - 65] += 1
    } else {
        wArr[currentLetterNum - 97 + 26] += 1
    }
}

var sArr = [Int](repeating: 0, count: 52)
var result = 0
var currentCount = 0

// currentCount가 wl이 될때까지 계속 넣어준다.
// 배열이 같은지 비교한다.
// 4번전의 character 지워주고 다음올 character 올려주고 배열이 같은지 비교
for i in 0..<S.count {
    let currentLetterNum = Int(S[i].asciiValue!)
    if 65 <= currentLetterNum && currentLetterNum <= 90 {
        sArr[currentLetterNum - 65] += 1
    } else {
        sArr[currentLetterNum - 97 + 26] += 1
    }
    currentCount += 1
    if currentCount == wl {
        if wArr == sArr {
            result += 1
        }
        let currentLetterNum = Int(S[i - (wl - 1)].asciiValue!)
        if 65 <= currentLetterNum && currentLetterNum <= 90 {
            sArr[currentLetterNum - 65] -= 1
        } else {
            sArr[currentLetterNum - 97 + 26] -= 1
        }
        currentCount -= 1
    }
}
print(result)
