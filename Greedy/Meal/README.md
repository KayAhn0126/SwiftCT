# 23559 밥
- 그리디
- 정렬

## 🍎 지문 해석
- A 메뉴를 먹을시 5000원, B 메뉴를 먹을시 1000원이다.
- 남은 학기 N일 동안 두 메뉴 중 하나를 꼭 먹어야 한다.
    - 즉, 매일매일 먹어야한다.
- 각 메뉴가 얼마나 맛있을지 수치를 매겨 두었다.
- N일간 학식에 총 X원 이하를 써야 한다.
- 고른 메뉴의 맛의 합을 최대화 하면 된다.

## 🍎 문제 접근
- 일단 N이 10만이다. -> 2중 for문 안됨
- 돈이 있다고 해서 맛있는것만 먹다가 나중에 밥을 못 먹을수도 있기 때문에 남은 일수도 신경써야 한다.
- 나는 먼저 메뉴의 맛의 합을 최대화 하기 위해 두 메뉴의 절대값이 가장 큰것을 앞으로 두도록 배열을 정렬했다.
    - arr는 [(A, B, abs(A-B))] 형태
- 정렬된 배열을 순회하면서 5000원 이상이고, 현재 돈에서 5천원을 차감했을때 남은 일수들을 B 메뉴로 먹을 수 있는지 확인했다.
    - 이것이 가능하다면 A와 B를 비교해서 분기처리 해주었다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let NandMoney = readLine()!.split(separator: " ").map { Int(String($0))! }
var N = NandMoney[0]
var Money = NandMoney[1]

// (A,B A와 B의 차이) 튜플을 요소로 가지는 배열
var arr = [(Int, Int, Int)]()
for _ in 0..<N {
    let temp = readLine()!.split(separator: " ").map { Int(String($0))! }
    arr.append((temp[0], temp[1], abs(temp[0] - temp[1])))
}
arr.sort(by: {
    return $0.2 > $1.2
})

var result = 0
// 현재 arr는 gap(|a-b|)이 가장 큰 튜플이 맨 앞으로 와있음. 즉, 두 수의 차가 가장 큰것이 앞에 있음.
for info in arr {
    let A = info.0
    let B = info.1
    if Money >= 5000 && Money - 5000 >= (N - 1) * 1000 { // 5천원 이상이라면,
        if A > B { // A를 선택하려 했을때, 나머지 남은 날들에 밥을 B로만 때울수 있는지 체크하기 위해 현재 금액에서 5천원을 차감한것이 나머지 날들 * 1000원 이상이라면, A학식을 먹을수 있다.
            result += A
            Money -= 5000
        } else if B >= A { // 위의 if문이 아니라면 B를 먹어야 한다. 같은 맛 만족도라면 싼게 좋다!
            result += B
            Money -= 1000
        }
    } else if Money >= 1000 { // 5천원은 없고, 1000원 이상이라면
        result += B
        Money -= 1000
    }
    N -= 1 // 날짜 차감
}
print(result)
```

## 🍎 주의 할 점
- A와 B가 같을 수 있다.
- 지문에 주어져있지 않지만, 매일 밥을 먹어야한다!
