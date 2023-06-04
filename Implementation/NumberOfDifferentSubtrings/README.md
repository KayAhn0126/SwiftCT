# 11478 서로 다른 부분 문자열의 개수
- 구현
- Set을 활용한 중복 제거

## 🍎 접근 방법
- 서로 다른 부분 문자열의 개수를 모두 구해주면 된다.
- abcde라면
    - a,ab,abc,abcd,abcde를 set에 추가
    - b,bc,bcd,bcde를 set에 추가
    - c,cd,cde를 set에 추가
    - d,de를 set에 추가
    - e를 set에 추가
- 어? 위의 케이스는 하나도 겹치는게 없는데 그냥 배열에 넣어주면 되는거 아니야? 라고 생각할 수 있지만 아래의 케이스를 배열에 넣고 배열의 count를 계산한다고 생각해보자.
- ababc라면
    - a,ab,aba,abab,ababc
    - b,ba,bab,babc
    - a,ab,abc
    - b,bc
    - c
- a,ab,b가 겹치는 상황이 생긴다. 이 상황을 방지하기 위해 set을 사용해야한다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let userInput = readLine()!.map { String($0) }

let count = userInput.count
var resultSet = Set<String>()

for i in 0..<count {
    var tempString = ""
    for j in i..<count {
        tempString += userInput[j]
        resultSet.insert(tempString)
    }
}
print(resultSet.count)
```
