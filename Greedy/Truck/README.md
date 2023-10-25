# 13335 트럭
- 그리디

## 🍎 지문 해석
- 트럭은 다리의 길이만큼 올라갈 수 있다.
- 트럭은 다리가 버틸 수 있는 하중까지 올라갈 수 있다.
- 위 두개의 조건을 만족해야 한다.

## 🍎 문제 접근
- 처음 다리의 길이만큼 배열(queue)을 0으로 생성한다.
- 다리를 지날 트럭이 있다면,
    - 현재 다리위에 올라와 있는 트럭의 무게 + 다음 트럭의 무게가 다리의 최대 하중보다 작거나 같고, 현재 다리 위에 올라와 있는 트럭의 수가 다리의 길이보다 작거나 같다면,
        - 트럭을 다리에 올려준다
    - 아니라면,
        - queue뒤에 0을 넣어줘 다리에 있던 기존 요소들을 앞으로 밀어준다.
- 만약 다리가 비어있지 않고 다리의 첫번째가 0이 아닌 실제 트럭이라면,
    - 현재 다리위의 총 무게를 가지고 있는 변수에서 해당 무게를 빼준다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let NWL = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NWL[0]
let W = NWL[1]
let L = NWL[2]

var truckArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var queue = [Int](repeating: 0, count: W)

var time = 0
var currentWeight = 0

while !queue.isEmpty {
    queue.removeFirst()
    if !truckArr.isEmpty {
        if L >= (currentWeight + truckArr[0]) && W >= queue.count {
            queue.append(truckArr[0])
            currentWeight += truckArr[0]
            truckArr.removeFirst()
        } else {
            queue.append(0)
        }
    }
    if !queue.isEmpty && queue[0] != 0 {
        currentWeight -= queue[0]
    }
    time += 1
}

print(time)
```
