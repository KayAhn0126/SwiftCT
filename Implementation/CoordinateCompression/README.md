# 18870 좌표 압축
- 구현
- 정렬
- 다양한 컬렉션 사용

## 🍎 문제 접근
- 예제 입력, 출력을 보고 "작은 수에서 큰 수로 오름차순으로 정렬"하고 순서대로 인덱스를 매기면 된다고 생각했다.
- 이때 중복되는 수 제거를 위해 set 컬렉션 사용
- 딕셔너리를 사용해서 해당 숫자가 정렬된 배열의 어느 인덱스에 있는지 확인하기

### 🍎 예제를 통해 이해하기
- 예제 입력
    - 5
    - 2 4 -10 4 -9
- 예제 출력
    - 2 3 0 3 1
- 예제 출력은 어떻게 만들어졌나?
- 예제 입력으로 주어진 숫자들을 정렬하면 -10 -9 2 4 4.
- 이들의 인덱스를 각 자리에 맞게 넣어주면된다.

## 🍎 문제 해결 및 전체 코드
```swift
import Foundation

var result = [Int]()

let n = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let tempSet = Array(Set(arr).sorted())
var myDictionary: [Int: Int] = [:]
for i in 0..<tempSet.count {
    myDictionary[tempSet[i]] = i
}

for i in arr {
    result.append(myDictionary[i]!)
}
result.enumerated().forEach {
    print($0.element, terminator: " ")
}
print("")
```
