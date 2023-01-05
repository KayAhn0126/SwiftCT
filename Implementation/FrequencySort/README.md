# 2910 빈도 정렬

## 🍎 키워드
- 딕셔너리 활용 및 2단계 정렬

## 🍎 요구 사항
- 여러 숫자들이 있을때 많이 등장하는 순서대로 출력해야하고, 만약 등장하는 횟수가 같다면 입력으로 주어졌을때 먼저 나온 것이 앞에 있어야 한다.

## 🍎 문제 풀이
- 딕셔너리를 [String : (Int, Int)] 형태로 만들었다.
- ["숫자" : (빈도, 입력에서 처음 나온 순서)]
```swift
var data: [String : (Int,Int)] = [:]
```
- 이제 N 만큼 입력을 받는다.
    - 입력을 받을때 딕셔너리에 등록이 되어있지 않다면 새로 만들어준다.
- 이미 나왔던 숫자라면 딕셔너리에 등록되어 있을테니 이전 빈도에 1을 더한 값으로 빈도를 업데이트 한다.
```swift
for i in 0..<N {
    if data[input[i]] == nil { // 처음 등록할 때
        data[input[i]] = (1,i)
    } else { // 이미 있을때
        let previousFrequency = data[input[i]]!.0
        let currentFrequency = previousFrequency + 1
        let firstAppearance = data[input[i]]!.1
        data.updateValue((currentFrequency, firstAppearance), forKey: input[i])
    }
}
```
- 딕셔너리를 정렬 할 것인데, sorted된 상태에서 작업을 해야한다.
- 정렬한 상태로 새로운 변수에 할당해도 딕셔너리 특성상 세팅이 날아간다.
- 정렬의 기준은 첫번째로, 빈도수가 같을때, 먼저 나온 순서대로 정렬하고, 그게 아니라면 빈도수가 높은쪽이 앞으로 오도록 정렬했다.
```swift
data.sorted(by: {
    if $0.value.0 == $1.value.0 {
        return $0.value.1 < $1.value.1
    }
    return $0.value.0 > $1.value.0
}
```
- 마지막 줄 코드인 return $0.value.0 > $1.value.0을 if 문 보다 먼저 써주게 되면 바로 리턴을 하기 때문에 조건을 체크할 수 없다.
- 이제 forEach문으로 값을 만들고 출력하면 끝난다.

## 🍎 전체 코드
```swift
//
//  main.swift
//  FrequencySort
//
//  Created by Kay on 2023/01/05.
//

/*
 2910
 빈도 정렬
 */
// 2nd week fast-campus

import Foundation

let NC = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NC[0]
let C = NC[1]

let input = readLine()!.split(separator: " ").map { String($0) }

var data: [String : (Int,Int)] = [:]

var result = ""

for i in 0..<N {
    if data[input[i]] == nil {
        data[input[i]] = (1,i)
    } else {
        let previousFrequency = data[input[i]]!.0
        let currentFrequency = previousFrequency + 1
        let firstAppearance = data[input[i]]!.1
        data.updateValue((currentFrequency, firstAppearance), forKey: input[i])
    }
}

data.sorted(by: {
    if $0.value.0 == $1.value.0 {
        return $0.value.1 < $1.value.1
    }
    return $0.value.0 > $1.value.0
}).forEach {
    for i in 0..<$0.value.0 {
        result += $0.key + " "
    }
}
print(result)

```
