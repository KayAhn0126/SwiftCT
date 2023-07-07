# 3649 로봇 프로젝트
- 정렬
- 투 포인터
- **여러개의 테스트 케이스**

## 🍎 문제에서 조심할 점
- 입력란에 "입력은 여러 개의 테스트 케이스로 이루어져 있다."라고 나와있다.
    - 즉, EOF가 나올때까지 계속 입력을 받아야한다. -> while let x = readLine()으로 해결
- 레고 조각의 수 n이 100만개 주어지는데 빠른 입출력 없이 단 한번 print하는 것으로 시간초과 없이 풀 수 있었다.

## 🍎 문제 접근
- 정렬 후 양쪽에 포인터를 두고 상태에 따라 left를 올리거나 right를 내리면서 조건에 맞는 첫번째 경우를 찾으면 된다.

## 🍎 전체 코드
```swift
import Foundation

var answer = ""
while let temp = readLine() {
    let X = Int(temp)! * 10000000
    let count = Int(readLine()!)!
    var arr = [Int]()
    for _ in 0..<count {
        arr.append(Int(readLine()!)!)
    }

    arr.sort()

    var leftIdx = 0
    var rightIdx = count - 1
    var tempStr = "danger\n"
    
    while leftIdx < rightIdx {
        let tempNum = arr[leftIdx] + arr[rightIdx]
        if tempNum == X {
            tempStr = "yes \(arr[leftIdx]) \(arr[rightIdx])\n"
            break
        }
        if tempNum < X {
            leftIdx += 1
        } else if tempNum > X {
            rightIdx -= 1
        }
    }
    answer += tempStr
}
print(answer)
```
