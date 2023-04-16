# 2869 달팽이는 올라가고 싶다.
- 구현

## 🍎 문제 접근
- V는 아주 크고, A,B가 작다면 시간초과가 날 수 있다는 것을 망각하고 문제에 접근했다.
    - 예) 
        - V = 1,000,000,000
        - A = 2
        - B = 1
        - 약 5억번의 연산을 해야됨 -> 5초
- 먼저, 작성했던 틀린 코드를 보자.
- 범위가 작았다면 1000만 정도였다면 괜찮았을(?) 코드
```swift
import Foundation

let ABV = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABV[0]
let B = ABV[1]
let V = ABV[2]

var current = 0
var count = 0

while current <= V {
    current += A
    count += 1
    if current >= V {
        break
    }
    current -= B
}
print(count)
```
- 이제 정답 코드를 어떻게 접근했는지 보자.
- **정상에 올라간 후에는 미끄러지지 않는다는 점과**
- **결국 정상에 오르는 시간은 낮이라는 점이다.**
- **"어차피 정상 오르는 시간인 낮시간을 빼주면 계산하기 좀 더 수월해지지 않을까?"**라는 생각이 들었다.
- 코드를 보자

## 🍎 문제 풀이
```swift
import Foundation

let ABV = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABV[0]
let B = ABV[1]
let V = ABV[2]

var current = 0
var count = 0

// 만약 낮에 한번에 갈 수 있는 거리가 V보다 크면 하루걸림!
if A >= V { 
    print(1)
} else {
    if (V-A) % (A-B) == 0 {
        // 어차피 낮에 도착하니 아예 낮을 도착지점에서 빼줬다. 
        // 이제 하루 전체(낮-밤)으로 나눴을때 딱 떨어진다면, 몫을 구하고 아까 빼주었던 낮을 더한다.
        print(((V-A) / (A-B)) + 1)
    } else { 
        // 딱 안떨어진다는 의미는 현재 몫이 없는 상태이고, A-B만큼(1) 가고, 아까 빼주었던 낮을 더하면 
        // + 2와 같다.
        print(((V-A) / (A-B)) + 2)
        // 예 5 1 6
        // ((6-5) / (5-1)) + 2 = (1 / 4) + 2 = 0 + 2 
    }
}

```
