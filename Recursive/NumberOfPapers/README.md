# 1780 종이의 개수
- 재귀
- 분할 정복

## 🍎 문제 접근
- 쿼드트리 문제와 비슷한 유형
- 9개씩 묶음 중 첫번째 숫자가 다음 숫자와 다르면 9등분한다.
- 이것이 계속 반복되다 보면 최소단위인 1이 될때 기저사례를 통해 반환해준다.

## 🍎 문제 풀이
```swift
import Foundation

let N = Int(readLine()!)!

var adjMatrix = [[Int]](repeating: [Int](), count: N)

for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var currentSize = N
var currentNumber = adjMatrix[0][0]

var negOneCount = 0
var zeroCount = 0
var oneCount = 0
// 사이즈가 3일때 하나라도 틀리면 각각 세주어야 한다.

func plusCount(_ number: Int) {
    if number == -1 {
        negOneCount += 1
    } else if number == 0 {
        zeroCount += 1
    } else {
        oneCount += 1
    }
}

func checkSizeBySize(_ y: Int, _ x: Int, _ size: Int) {
    if size == 1 {
        plusCount(adjMatrix[y][x])
    }
    currentNumber = adjMatrix[y][x]
    var flag = true
    for i in y..<y + size {
        for j in x..<x + size {
            if currentNumber != adjMatrix[i][j] {
                flag = false
                let newSize = size/3
                checkSizeBySize(y, x, newSize)
                checkSizeBySize(y, x + newSize, newSize)
                checkSizeBySize(y, x + newSize + newSize, newSize)
                
                checkSizeBySize(y + newSize, x, newSize)
                checkSizeBySize(y + newSize, x + newSize, newSize)
                checkSizeBySize(y + newSize, x + newSize + newSize, newSize)
                
                checkSizeBySize(y + newSize + newSize, x, newSize)
                checkSizeBySize(y + newSize + newSize, x + newSize, newSize)
                checkSizeBySize(y + newSize + newSize, x + newSize + newSize, newSize)
                break
            }
        }
        if flag == false {
            break
        }
    }
    if size >= 3 && flag == true {
        plusCount(currentNumber)
    }
}

checkSizeBySize(0,0,N)
print(negOneCount)
print(zeroCount)
print(oneCount)
```
