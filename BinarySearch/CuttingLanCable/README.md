# 1654 랜선 자르기
- 기본 이분탐색 변형
- 나무 자르기 문제와 비슷하다.

## 🍎 문제 접근
- 영식이가 원래 가지고 있던 랜선의 갯수 K를 이용해서 N개를 만들어야 한다. 이때 각각의 랜선의 길이를 가장 크게 만들어야한다.
- 예제 입력을 보자
```bash
4 11
802
743
457
539
```
- 영식이가 원래 가지고 있던 랜선의 갯수 4개
- 4개의 랜선의 길이는 각각 802, 743, 457, 539.
- 이 4개를 11개로 만들어야 하는데 이때 각각의 랜선의 길이를 최대한 크게 만들어야 한다.
- 100센티미터로 자르면..
    - 802/100 + 743/100 + 457/100 + 539/100 = 8 + 7 + 4 + 5 = 24개의 랜선이 된다.
- 200센티미터로 자르면..
    - 802/200 + 743/200 + 457/200 + 539/200 = 4 + 3 + 2 + 2 = 11개의 랜선이 된다.(답!)

## 🍎 전체 코드
```swift
import Foundation

let KN = readLine()!.split(separator: " ").map { Int(String($0))! }
let K = KN[0] // 오영식이 이미 가지고 있는 랜선의 개수
let N = KN[1] // 필요한 랜선의 개수 N

var currentLanCables = [Int](repeating: 0, count: N)

for i in 0..<K {
    currentLanCables[i] = Int(readLine()!)!
}

func checkIsEnough(_ cuttingLength: Int) -> Bool {
    var tempCount = 0
    for cable in currentLanCables {
        tempCount += cable / cuttingLength
        if tempCount >= N {
            return true
        }
    }
    return false
}

// 이분탐색으로 가장 알맞은 수를 찾아보자!
func binarySearchForBestNumber() -> Int {
    var result = 0
    var start = 0, end = 10987654321, mid = 0
    while start <= end {
        mid = (start + end) / 2
        if checkIsEnough(mid) == true {
            result = mid
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    return result
}

print(binarySearchForBestNumber())
```

## 🍎 다시 풀었을때 틀렸다면..
- **지문을 꼼꼼히 읽고 end를 잘 설정하자.**
- 첫째 줄에는 오영식이 이미 가지고 있는 랜선의 개수 K, 그리고 필요한 랜선의 개수 N이 입력된다. K는 1이상 10,000이하의 정수이고, N은 1이상 1,000,000이하의 정수이다. 그리고 항상 K ≦ N 이다. 그 후 K줄에 걸쳐 이미 가지고 있는 각 랜선의 길이가 센티미터 단위의 정수로 입력된다. **랜선의 길이는 2^31-1보다 작거나 같은 자연수이다.**
