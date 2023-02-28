# 1018 체스판 다시 칠하기

## 🍎 문제 접근
- 최소 8x8 크기의 체스판이 주어지는데, 만약 이보다 더 큰 크기의 체스판이 주어진다면, 8x8로 잘랐을때 가장 적게 체스판을 칠하는 경우를 출력하면 된다.
- 8x8 크기는 아무데서나 골라도 된다.
- 다시 칠해야 하는 정사각형의 최소 갯수를 구하는 프로그램을 작성.

## 🍎 문제 풀이
### 📖 현재 위치가 주어졌을때, 현재 위치를 기준으로 8x8내에 다시 칠해야 하는 정사각형의 갯수 구하는 함수
```swift
func checkChangeCount(_ y: Int, _ x: Int, _ first: Character) -> Int {
    var changeCount = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if i % 2 == 0 { // 짝수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                }
            } else { // 홀수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                }
            }
        }
    }
    return changeCount
}
```

### 📖 주어진 배열에서 8x8로 자르는 코드
```swift
var smallest = 987654321
for i in 0...N-8 {
    for j in 0...M-8 {
        let W = Character("W")
        let B = Character("B")
        let tempResultW = checkChangeCount(i, j, W)
        let tempResultB = checkChangeCount(i, j, B)
        let tempResult = tempResultW > tempResultB ? tempResultB : tempResultW
        smallest = smallest > tempResult ? tempResult : smallest
    }
}
print(smallest)
```

## 🍎 전체 코드
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var chessBoard = [[Character]](repeating: [Character](), count: N)

for row in 0..<N {
    chessBoard[row].append(contentsOf: readLine()!)
}

// 짝수행의 짝수열은 firstLetter
// 짝수행의 홀수열은 secondLetter
// 홀수행의 짝수열은 secondLetter
// 홀수행의 짝수열은 firstLetter

func checkChangeCount(_ y: Int, _ x: Int, _ first: Character) -> Int {
    var changeCount = 0
    for i in y..<y+8 {
        for j in x..<x+8 {
            if i % 2 == 0 { // 짝수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                }
            } else { // 홀수 행
                if j % 2 == 0 { // 짝수 열
                    if chessBoard[i][j] == first {
                        changeCount += 1
                    }
                } else { // 홀수 열
                    if chessBoard[i][j] != first {
                        changeCount += 1
                    }
                }
            }
        }
    }
    return changeCount
}

var smallest = 987654321
for i in 0...N-8 {
    for j in 0...M-8 {
        let W = Character("W")
        let B = Character("B")
        let tempResultW = checkChangeCount(i, j, W)
        let tempResultB = checkChangeCount(i, j, B)
        let tempResult = tempResultW > tempResultB ? tempResultB : tempResultW
        smallest = smallest > tempResult ? tempResult : smallest
    }
}
print(smallest)
```
