# 1107 리모컨
- 브루트 포스

## 🍎 문제 접근
- 리모컨을 누르기 전에는 채널이 100으로 설정 되어있다.
- 즉, 특정 채널이 주어지면, 키패드를 누르는것과 100에서 +,-로 갔을때, 무엇이 더 가까운지도 체크해야한다.
- 지문에는 없지만 생각 해볼 포인트.
    - 고장난 버튼이 없을 수 있다.

## 🍎 문제 풀이
- 먼저 특정 채널 숫자로 가야한다고 주어지면 +,-버튼을 얼만큼 눌러야 하는지 구한다.
```swift
var result = abs(number - 100)
```
- 0부터 1000000(백만)까지 돌면서 해당 숫자 중 키패드에서 고장났던 숫자가 있는지 확인한다.
    - 1000000(백만)인 이유는, 극단적으로 0과 9를 제외한 모든 키패드(1~8)가 다 고장났고 목표하는 숫자는 50만이라고 가정해보자.
    - 그럼 100에서 50만까지 오려면 + 버튼을 49만9990번을 눌러야 한다. 하지만 만약 90만에서 -를 40만번 누른다면 50만에 도착하므로 100보다는 90만에 더 가깝다.
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
- 만약 없다면 해당 숫자가 고장난 키를 가지고 있지 않으면, 해당 숫자를 치기위해 키패드를 몇번 눌렀는지 확인한다.
```swift
let digitCount = String(i).count
```
- 그리고 target 숫자에서 해당 숫자를 빼준다.
    - 이 작업은 그 숫자를 누르고 키패드를 몇번 더 눌러야 하는지 찾는 작업이다.
```swift
let currentMin = abs(number - i) + digitCount
```
- 로직 자체는 어렵지 않지만 자세히 설명하기는 어려움. 만약 다시 본다면 checkValidNumber 함수가 "어떤 숫자에 고장난 키패드 번호가 있는지 확인한다" 정도만 알고 코드를 보면 된다!

