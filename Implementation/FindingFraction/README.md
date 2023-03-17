# 1193 분수 찾기

## 🍎 키워드
- 패턴 찾기

## 🍎 패턴 찾기

### 📖 분수 찾기 문제의 그림
![](https://i.imgur.com/hpOFYYn.png)
- 먼저 레이어가 홀수인지 짝수인지에 따라 분모, 분자를 정하는 룰이 다르다.
- 문제를 자세히 보면 레이어의 홀수 / 짝수의 시작점이 다르다.
    - 홀수는 좌측 하단에서 우측 상단으로,
        - 분모는 좌측 하단 1에서 우측 상단으로 올라가면서 + 1씩
        - 분자는 좌측 하단에서 layer에서 시작해서 우측 상단 1까지 - 1씩
    - 짝수는 우측 상단에서 좌측 하단으로 진행되면서 각각의 분모 분자를 결정한다.
        - 분모는 우측 상단에서 layer에서 시작해서 좌측 하단 1까지 -1 씩
        - 분자는 우측 상단 1에서 좌측 하단 layer까지 +1 씩
- 예를 들어 그림에서 9번째 분수를 찾는다고 하면 3/2가 나온다.
- 또 12번째 분수를 찾는다고 하면 4/2가 나온다.

### 📖 실제 패턴 찾기
- 첫번째로 찾은 패턴은
    - 각각의 레이어는 해당 레이어의 수만큼 분수를 가지고있다.
    - 예를 들면 layer 3의 분수의 갯수는 3개
    - layer 4의 분수의 갯수는 4개이다.
    - 만약 12번째 분수를 찾고 싶다면 5번째 layer에 있다는것을 알 수 있다. 어떻게??
    - 1 + 2 + 3 + 4  = 10
    - 1 + 2 + 3 + 4 + 5 = 15
    - 12는 10과 15사이에 있으므로 5번째 layer에 있다는것을 알 수 있다.
    - 그럼 layer를 알았다면 해당 layer에 몇번째에 있는지 알면 문제는 다 푼셈.
- 두번째로 찾은 패턴
    - 찾고자 하는 분수가 어느 인덱스에 있는지 확인하기
    - 12번째 분수를 찾는다고 가정해보자.
    - 모든 레이어를 다 더한 count를 구하고 현재 레이어를 빼준다.
        - 모든 레이어를 다 더한 count = 15
        - 현재 레이어 5
        - 15 - 5 = 10
    - 그리고 타겟에서 위의 값을 빼주면 해당 레이어에서 몇번째에 분수가 위치한지 알 수 있다.
    - 12 - 10 = 2
    - 분수 4/2는 5번째 레이어, 2번째에 있다
    - 좌측 하단에서 2번째? 아니면 우측 상단에서 2번째?
    - 홀수는 좌측 하단에서 우측 상단으로 진행하니까 좌측 하단에서 2번째 라는것을 구할 수 있다.
- 이제 구현만 해주면 된다. 아래는 전체 코드

## 🍎 전체 코드 분석
```swift
import Foundation

var layer = 1 // 몇번째 레이어에 있는지
var count = 1 // 인덱스 구하기 용도

let target = Int(readLine()!)!

while target > count {
    layer += 1
    count += layer
}

let index = target - (count - layer)

if layer % 2 == 0 {
    var up = 1
    var down = layer
    for _ in 1..<index {
        up += 1
        down -= 1
    }
    print("\(up)/\(down)")
} else {
    var up = layer
    var down = 1
    for _ in 1..<index {
        up -= 1
        down += 1
    }
    print("\(up)/\(down)")
}
```

## 🍎 다시 풀었을때 코드
```swift
import Foundation

var number = Int(readLine()!)!

var totalFractions = 0
var layer = 1

if number == 1 {
    print("1/1")
} else {
    while number > totalFractions {
        totalFractions += layer
        layer += 1
    }
    layer = layer - 1
    let index = number - (totalFractions - layer)
    if layer % 2 != 0 {
        print("\(layer-index+1)/\(index)")
    } else {
        print("\(index)/\(layer-index+1)")
    }
}
```
