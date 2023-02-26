# 16139 인간-컴퓨터 상호작용

## 🍎 문제 접근
- 알파벳 26자
- 각 알파벳 마다 주어지는 문자열에서의 누적합을 구해놓는다.
```bash
2차원 배열
    [a][a의 psum]
    [b][b의 psum]
    [c][c의 psum]
    [d][d의 psum]
    ...
    ...
    [z][z의 psum]
    
이런 아이디어이고 실제로 구현 할 때는
아래와 같이 알파벳 대신 0 ~ 25를 사용해 구현한다.
    [0][a의 psum]
    [1][b의 psum]
    [2][c의 psum]
    [3][d의 psum]
    ...
    ...
    [25][[z의 psum]
```
- 누적합 배열은 만들었으니 이제 누적합을 구하는 로직을 만들어 주면 된다.
- 주어진 문자열을 배열로 만들어서 접근을 편하게 해준 후 문제를 푼다.
- a부터 z까지 반복문을 돌면서 문자열 배열에서 각 알파벳이 어느 인덱스에 나오는지 확인하고 givenStringToIntArr에 알맞는 인덱스를 1로 바꿔준다.
- givenStringToIntArr과 twoDimensionalPsumArr으로 각 알파벳에 대한 psum을 구하고, 문제를 풀어주면 된다.

## 🍎 전체 코드
```swift
import Foundation

let givenString = readLine()! // 주어진 문자열
let count = Int(readLine()!)! // 테스트 할 갯수
let lengthOfString = givenString.count // 주어진 문자열의 길이

var givenStringToArr = Array(givenString) // 문자열을 사용하기 편하게 배열화
var twoDimensionalPsumArr = [[Int]](repeating: [Int](repeating: 0, count: lengthOfString + 1), count: 26)

//MARK: 누적합 구하는 로직
for i in 0...25 { // i는 행렬의 첫번째 dimension
    let currentLetter = String(UnicodeScalar(97 + i)!) // a ~ z
    var givenStringCountArr = [Int](repeating: 0, count: lengthOfString)
    
    for j in 0..<givenStringToArr.count {
        if currentLetter == String(givenStringToArr[j]) {
            givenStringCountArr[j] = 1
        }
    }
    givenStringCountArr.insert(0, at: 0)
    
    for k in 1...givenStringToArr.count {
        twoDimensionalPsumArr[i][k] = twoDimensionalPsumArr[i][k-1] + givenStringCountArr[k]
    }
}

//MARK: 값 구하는 함수
func getPsum(_ alphabet: Character, _ from: Int, _ to: Int) -> Int {
    let currentLetterToInt = Int(alphabet.asciiValue!) - 97
    return twoDimensionalPsumArr[currentLetterToInt][to + 1] - twoDimensionalPsumArr[currentLetterToInt][from]
}

//MARK: 입력받고 함수 호출로 해 구하기
for _ in 0..<count {
    let test = readLine()!.split(separator: " ").map { String($0) }
    let alphabet = Character(test[0])
    let from = Int(test[1])!
    let to = Int(test[2])!
    print(getPsum(alphabet, from, to))
}
```

