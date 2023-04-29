# 1107 리모컨
- 브루트 포스
- 2023/4/29일 업데이트

## 🍎 문제 접근
- 처음 채널이 100으로 설정 되어있다.

### 📖 메인 로직 구현
- 먼저 가장 무식하게 현재 채널인 100에서 타겟넘버까지 + 버튼 또는 - 버튼으로 얼마만에 갈 수 있는지 구하고 result 변수에 넣는다.
```swift
var result = abs(number - 100)
```
- 고장난 버튼이 없을때
    - 현재 위치인 100에서 + 버튼 또는 - 버튼으로 타겟 넘버에 가는 것이 가까운지, 아니면 키패드를 눌러서 가는것이 더 가까운지 비교 후 출력하면 된다!
- 고장난 버튼이 있을때
    - 어떤 랜덤 숫자를 선택하고 그 숫자가 고장난 키를 포함하고 있는지 체크한다!
    - A) 고장난 키를 포함하지 않는 숫자라면 그 랜덤 숫자를 누르기 위해서 키패드를 몇번 눌렀는지 확인한다. -> 예) 100은 3번, 1000은 4번...
    - B) 이제 랜덤 숫자에서 타겟넘버까지 + 버튼 또는 - 버튼으로 몇번만에 갈 수 있는지 확인한다.
    - A와 B를 더 해주고 이 값을 result와 비교하면서 가장 작은 값으로 갱신한다.
- 결국!
    - (처음 채널 100에서 +,- 버튼을 눌러서 타겟넘버에 도달하기까지 필요한 값) vs (고장난 키를 포함하지 않는 숫자를 누르고 그 숫자에서 +,- 버튼을 눌러서 타겟 넘버에 도달하기까지 필요한 값)
    ```text
    예를 들어 타겟 넘버가 150이고 고장난 숫자 1개 -> 9라고 해보자
    이미 맨 위에서 result에 100에서 target 숫자까지 +,- 버튼만으로 가는 횟수를 구했다.
    즉 현재 result는 50이다 -> 100에서 50번만 +를 누르면 되기 때문에.
    이제 result보다 작은 값이 있는지 확인해보자!
    i = 0, (0을 입력해야 하므로 1) + (0에서 타겟넘버인 150까지 + 버튼을 150번 눌러야 하므로 150) = 151
    151은 50보다 크니까 최소값이 될 수 없다.
    i = 1, (1을 입력해야 하므로 1) + (1에서 타겟넘버인 150까지 + 버튼을 149번 눌러야 하므로 149) = 150
    ...
    i = 10, (10을 입력해야 하므로 2) + (10에서 타겟넘버인 150까지 + 버튼을 140번 눌러야 하므로 140) = 142
    i = 100, (100을 입력해야 하므로 3) + (100에서 타겟넘버인 150까지 + 버튼을 50번 눌러야 하므로 50) = 53
    i = 150, (150을 입력해야 하므로 3) + (150에서 타겟넘버인 150까지 아무것도 안눌러도 되므로 0) = 3
    이 경우 답은 가장 작은 숫자인 3이 된다.
    ```

## 🍎 생각 포인트
- 0. 지문에는 없지만 생각 해볼 포인트.
    - 고장난 버튼이 없을 수 있다. -> 입력도 받지 않아야 한다.
- 1. 0부터 1000000(백만)까지 돌면서 해당 숫자 중 키패드에서 고장났던 숫자가 있는지 확인한다.
    - 왜? 1,000,000일까?
    - 1000000(백만)인 이유는, 극단적으로 0과 9를 제외한 모든 키패드(1~8)가 다 고장났고 목표하는 숫자는 50만이라고 가정해보자.
    - 그럼 100에서 50만까지 오려면 + 버튼을 49만9990번을 눌러야 한다. 하지만 만약 90만에서 -를 40만번 누른다면 50만에 도착하므로 100보다는 90만에 더 가깝다.
- 2. 랜덤한 숫자가 고장난 키를 포함하고 있는지 확인하는 함수
```swift
func checkValidNumber(_ number: Int) -> Bool {
    var result = true
    var testNumber = number
    
    if testNumber > 9 {
        while testNumber > 0 {
            if validArr[testNumber % 10] == false {
                result = false
                break
            }
            testNumber /= 10
        }
    } else {
        if validArr[testNumber] == false {
            result = false
        }
    }
    return result
}
```
- 왜 if문으로 분기를 나눠 줬을까? 그냥 아래와 같이 구현하면 안되는가?
```swift
func checkValidNumber(_ number: Int) -> Bool {
    var result = true
    var testNumber = number
    while testNumber > 0 {
        if validArr[testNumber % 10] == false {
            result = false
            break
        }
        testNumber /= 10
    }
}
```
- 위와 같이 구현 할 경우 0이 들어왔을때 처리하지 못한다!

## 🍎 전체 코드
```swift
import Foundation

let targetNumberInString = readLine()!
let targetNumber = Int(targetNumberInString)!

let brokenCount = Int(readLine()!)!
var result = abs(targetNumber - 100) // 100에서 타겟 넘버까지 +,- 버튼을 누른 횟수

var brokenArr = [Bool](repeating: false, count: 10) // 고장난 버튼이 어떤 버튼인지 알 수 있도록 담아두는 배열

//MARK: 랜덤한 브루트포스의 숫자가 고장난 키를 가지고 있는지 확인하는 함수
func checkNumber(_ num: Int) -> Bool {
    var flag = true
    var testNum = num
    // 원래는 while testNum > 0으로 고장난 키패드를 포함하는지 확인했다.
    // 하지만 분기 처리한 이유는 0이 들어왔을때 while testNum > 0 으로 한다면 0을 처리하지 못한다.
    if testNum > 9 {
        while testNum > 0 {
            if brokenArr[testNum % 10] == true {
                flag = false
            }
            testNum /= 10
        }
    } else {
        if brokenArr[testNum] == true {
            flag = false
        }
    }
    
    return flag
}

if brokenCount == 0 {
    //고장난 버튼이 하나도 없다면, 타겟 넘버를 직접 누르는 것과 100에서 +,- 버튼을 눌러 타겟넘버에 도달하는 것 중 작은것을 출력하면 된다.
    result = result > targetNumberInString.count ? targetNumberInString.count : result
} else {
    // 고장난 버튼이 있다면,
    let tempArr = readLine()!.split(separator: " ").map { Int(String($0))! }
    for i in tempArr {
        brokenArr[i] = true
    }
    for i in 0...1000000 {
        if checkNumber(i) == true { // 현재 숫자 i가 고장난 키를 포함하고 있지 않다면
            // i를 누르기 위해서 버튼을 클릭한 횟수와 + 이제 i에서 target 숫자까지 도달하기 위한 +,- 버튼을 누른 숫자를 더한다.
            let tempResult = String(i).count + abs(targetNumber - i)
            
            // 이미 맨 위에서 result에 100에서 target 숫자까지 +,- 버튼만으로 가는 횟수를 구했다.
            // tempResult가 (100에서 타켓까지 +,-로만 이동할 때의 숫자)보다 작으면 갱신을 시켜준다.
            
            result = result > tempResult ? tempResult : result
            
            // 예를 들어 타겟 넘버가 150이고 고장난 숫자 1개 -> 9라고 해보자
            // 이미 맨 위에서 result에 100에서 target 숫자까지 +,- 버튼만으로 가는 횟수를 구했다.
            // 즉 현재 result는 50이다 -> 100에서 50번만 +를 누르면 되기 때문에.
            // 이제 result보다 작은 값이 있는지 확인해보자!
            // i = 0, (0을 입력해야 하므로 1) + (0에서 타겟넘버인 150까지 + 버튼을 150번 눌러야 하므로 150) = 151
            // 151은 50보다 크니까 최소값이 될 수 없다.
            // i = 1, (1을 입력해야 하므로 1) + (1에서 타겟넘버인 150까지 + 버튼을 149번 눌러야 하므로 149) = 150
            // ...
            // i = 10, (10을 입력해야 하므로 2) + (10에서 타겟넘버인 150까지 + 버튼을 140번 눌러야 하므로 140) = 142
            // i = 100, (100을 입력해야 하므로 3) + (100에서 타겟넘버인 150까지 + 버튼을 50번 눌러야 하므로 50) = 53
            // i = 150, (150을 입력해야 하므로 3) + (150에서 타겟넘버인 150까지 아무것도 안눌러도 되므로 0) = 3
            // 이 경우 답은 가장 작은 숫자인 3이 된다.
        }
    }
}
print(result)
```
