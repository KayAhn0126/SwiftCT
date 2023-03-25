# 20413 MVP 다이아몬드(Easy)
- 구현
- 이전 값 prev 변수 사용

## 🍎 문제 접근
- **메인 포인트**
    - 2개월 단위로 과금액을 산정해 등급을 매긴다.
        - **상민이가 한번 달성한 MVP 등급은 줄어들지 않는다.**
    - MVP 등급을 달성하기 위한 최대 누적 과금액을 만원 단위로 출력한다.
- 예제로 "**BSG**"가 주어졌다고 가정하자
- 즉 처음에 B(Bronze)등급 이라면 첫째달에 최대 29만원을 사용했다라는 말이다.
- 다음달에는 상민이는 S(Silver)등급이 되는데 실버등급이 되려면 2개월간의 과금액이 최대 59만원이 된다.
- 바로 지난달에 29만원을 썼기때문에 현재달에 최대 30만원을 쓴것이다.
- 또, 바로 다음달에 G(Gold)등급이 되는데 저번달에 30만원을 썼고 현재달에 Gold라면 최대 59만원을 사용한 셈이다.
    - 첫째달 -> 29만원
    - 둘째달 -> 30만원
    - 셋째달 -> 59만원
- 다 더한 값 118이 답이다.

## 🍎 전체 코드
- 중요한 부분은 주석처리
```swift
import Foundation

extension String {
    subscript(idx: Int) -> Character? {
        guard(0..<count).contains(idx) else { return nil }
        let target = index(startIndex, offsetBy: idx)
        return self[target]
    }
}

let N = Int(readLine()!)!

var SGPD = readLine()!.split(separator: " ").map { Int(String($0))! }

var testString = readLine()!

var prevArr = [Int](repeating: 0, count: N)
var prev: Int = 0

// prevArr의 처음 값을 넣기위한 작업
if testString[0] == "B" {
    prev = SGPD[0] - 1
} else if testString[0] == "S" {
    prev = SGPD[1] - 1
} else if testString[0] == "G" {
    prev = SGPD[2] - 1
} else if testString[0] == "P" {
    prev = SGPD[3] - 1
} else {
    prev = SGPD[3]
}
prevArr[0] = prev

// 이전 값을 이용해서 현재달에 얼마를 썼는지 체크하는 로직
for i in 1..<testString.count {
    if testString[i] == "B" {
        prevArr[i] = SGPD[0] - 1 - prev
    } else if testString[i] == "S" {
        prevArr[i] = SGPD[1] - 1 - prev
    } else  if testString[i] == "G" {
        prevArr[i] = SGPD[2] - 1 - prev
    } else if testString[i] == "P" {
        prevArr[i] = SGPD[3] - 1 - prev
    } else {
        prevArr[i] = SGPD[3]
    }
    prev = prevArr[i]
}

// prevArr를 반복하면서 최대 누적금액 계산
var result = 0
prevArr.enumerated().forEach {
    result += $0.element
}
print(result)
```
