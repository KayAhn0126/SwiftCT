# 2002 추월
- 구현

## 🍎 지문 해석
- 터널을 들어간 순서와 터널을 나온 순서가 주어진다.
- 추월한 차량의 숫자를 구하면 된다.

## 🍎 문제 접근
- 먼저 들어간 순서를 저장하기 위해 inOrderDictionary를 생성하고 들어간 순서대로 0번부터 차례대로 딕셔너리에 저장한다.
- 기준을 터널을 나온 순서로 잡고 기준 이후의 요소들을 하나씩 비교하는데, 아래와 같은 2중 for문을 사용해서 모든 요소가 다른 모든 요소와의 비교를 할 수 있게 한다.
```swift
for i in 0..<N-1 {
    for j in i+1..<N {
        if inOrderDictionary[outOrderArr[i]]! > inOrderDictionary[outOrderArr[j]]! {
            count += 1
            break
        }
    }
}
```
- i가 0, j가 1일때, 추월한 차량이 없다
- i가 1, j가 2일때, g가 c를 추월했다. <- 이것을 어떻게 알 수 있을까?
    - 터널을 들어간 순서에서 현재 기준이 되는 알파벳 g를 inOrderDictionary에서 찾으면 6, 비교대상인 알파벳 c를 inOrderDictionary에서 찾으면 2이다.
    - 이때, 터널을 들어간 순서를 기반으로, 기준이 되는 알파벳이 비교 대상 알파벳보다 크다면 추월했다는 것이므로 카운트를 하나 올려주고 break를 해준다.
    - break를 해주는 이유는 g는 이미 추월한 차량으로 판정이 났기 떄문에 다른 대상 알파벳과 다시 비교하면, g가 추월한 숫자가 구해진다. 문제에서 원하는 답은 총 몇대가 추월했는지 구하는것이지, 총 몇번 추월했냐가 아니기 떄문에 break를 사용한다.
```bash
  터널을 들어간 순서             터널을 나온 순서         순서
        a                        a                0
        b                        g                1
        c                        c                2
        d                        d                3
        e                        e                4
        f                        f                5
        g                        b                6
        h                        h                7
        i                        i                8
        j                        j                9
```

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!
var inOrderDictionary = [String: Int]()
var outOrderArr = [String]()
var count = 0

for i in 0..<N {
    let plate = readLine()!
    inOrderDictionary[plate] = i
}

for _ in 0..<N {
    let plate = readLine()!
    outOrderArr.append(plate)
}

for i in 0..<N-1 {
    for j in i+1..<N {
        if inOrderDictionary[outOrderArr[i]]! > inOrderDictionary[outOrderArr[j]]! {
            count += 1
            break
        }
    }
}
print(count)
```
