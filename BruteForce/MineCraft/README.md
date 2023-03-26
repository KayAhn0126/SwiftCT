# 18111 마인크래프트
- 브루트포스

## 🍎 문제 접근
### 📖 처음에 접근한 방법
- 입력으로 주어지는 2차원 배열의 요소들을 전부 더한 후 N * M 으로 나누면 평균이 나오는데 그 평균으로 부터 플러스 마이너스 2씩 해주고 
- 예
    - [avg - 2, avg - 1, avg, avg + 1, avg + 2]
- 위 값들을 돌면서 가장 작은 비용이 드는 값을 찾는 방식으로 했다.
- 이 방법은 배열 각각의 요소들 끼리 차이가 얼마 나지 않으면 괜찮은 방법이지만 요소끼리의 차이가 많이 나면 정확하지 않을 수 있다.
- 중간에 시간초과도 났었다.
- 시간초과 코드
```swift
for k in 0...256 {
    var tempResult = 0
    if k >= 0 {
        var tempB = B
        var count = 0
        for i in 0..<N {
            for j in 0..<M {
                count = 0
                let currentNumber = arr[i][j]
                if k > arr[i][j] {
                    while k != currentNumber + count {
                        tempB -= 1
                        count += 1
                        tempResult += 1
                    }
                } else if k == currentNumber {
                    continue
                } else {
                    while k != currentNumber - count {
                        tempB += 1
                        count += 1
                        tempResult += 2
                    }
                }
            }
        }
        if tempB >= 0 {
            if totalCost > tempResult {
                totalCost = tempResult
                result = k
            }
        }
    }
}
print("\(totalCost) \(result)")
```
- 256 * 500 * 500 = 6400만.
- 여기서 while k != currentNumber + count 까지 돌렸으니 시간초과가 날 수 밖에..

### 📖 while문 필요없이 그냥 빼주면 되잖아?
```swift
let currentNumber = arr[i][j]
if k > arr[i][j] {
    tempB = tempB - (k - currentNumber)
    tempResult += (k - currentNumber)
} else if k == currentNumber {
    continue
} else {
    tempB = tempB + (currentNumber - k)
    tempResult += (currentNumber - k) * 2
}
```

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let NMB = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NMB[0]
let M = NMB[1]
let B = NMB[2]

var arr = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    arr[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var totalCost = 9999999999999
var result = 0

for k in 0...256 {
    var tempResult = 0
    if k >= 0 {
        var tempB = B
        for i in 0..<N {
            for j in 0..<M {
                let currentNumber = arr[i][j]
                if k > arr[i][j] {
                    tempB = tempB - (k - currentNumber)
                    tempResult += (k - currentNumber)
                } else if k == currentNumber {
                    continue
                } else {
                    tempB = tempB + (currentNumber - k)
                    tempResult += (currentNumber - k) * 2
                }
            }
        }
        if tempB >= 0 {
            if totalCost >= tempResult {
                totalCost = tempResult
                result = k
            }
        }
    }
}
print("\(totalCost) \(result)")
```

## 🍎 명심할 점
- 문제 풀기 전 시간복잡도 계산 하자.
