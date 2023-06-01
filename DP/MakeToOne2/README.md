# 12852 1로 만들기 2
- DP
- 경로 추적

## 🍎 문제 접근
- 한번에 생각하기 어려운 문제였다.
- 이전에 숨바꼭질4 문제에서 경로 추적을 했던 기억을 되살려 풀었다.
- num이 1,2,3인 경우는 바로 출력해준다.
- 그 이외의 상황이라면 else로 가서 bottom-up 방식으로 dp 배열을 채워나간다.

## 🍎 문제 해결 및 전체 코드
```swift
import Foundation

var num = Int(readLine()!)!
var dp = [Int](repeating: 0, count: num + 1)
var prev = [Int](repeating: 0, count: num + 1)

if num == 1 {
    print(0)
    print(1)
} else if num == 2 || num == 3 {
    print(1)
    print(num, 1)
} else {
    // dp 배열은 연산의 최솟값을 계산하기 위한 배열
    // prev 배열은 경로 추적을 위한 배열
    dp[1] = 0
    prev[1] = 0

    for i in 2...num {
        // 먼저 현재 값 i에서 1을 뺐을때 최솟값과 경로를 저장한다.
        dp[i] = dp[i-1] + 1
        prev[i] = i-1
        
        // 만약 현재 값 i가 2로 나누어 떨어지고,
        // (바로 위에서 i에서 1을 뺐을때를 미리 계산한 dp[i])와 (i를 2로 나누었을때의 값 + 1)을 비교해서 i/2 + 1이 더 작다면 dp[i]의 값을 교체한다.
        // 경로 추적 배열인 prev[i] 또한 i-1i/2로 바꿔준다.
        if i % 2 == 0 && dp[i] > dp[i/2] + 1 {
            dp[i] = dp[i/2] + 1
            prev[i] = i/2
        }
        // 3으로 나누어 떨어진다면 이 부분도 체크한다
        if i % 3 == 0 && dp[i] > dp[i/3] + 1 {
            dp[i] = dp[i/3] + 1
            prev[i] = i / 3
        }
    }
    print(dp[num])
    while num != 0 {
        print(num, terminator: " ")
        num = prev[num]
    }
    print("")
}

```
