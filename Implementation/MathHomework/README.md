# 2870 수학 숙제

## 🍎 키워드
- 구현
- 조건에 따른 정렬

## 🍎 문제 접근
- "073", "045", "001", "000" 이런식으로 숫자 앞에 0이 있을때 처리
    - removeZero 함수 사용
- 문자열에 수들만 모으기
    - checkString 함수 사용
- 오름차순으로 출력하기
    - 고차 함수 정렬 사용

## 🍎 코드 해석
### 📖 먼저 숫자 앞에 0이 있을떄 어떻게 처리하는지 보자.
```swift
func removeZero(_ temp: String) -> String {
    var newString = temp
    while newString.hasPrefix("0") {
        if newString.count == 1 {
            break
        }
        newString.removeFirst()
    }
    return newString
}
```
- String의 내장함수 hasPrefix()를 사용해 현재 문자열의 첫글자가 "0"인지 확인하고 있다면 removeFirst()함수를 이용해서 삭제한다. 
    - 만약 문자열의 첫글자가 "0"이면서 문자열의 카운트가 1이면 말그대로 숫자 0이므로 break
### 📖 문자열안에 숫자가 있는지 확인하는 함수
```swift
func checkString(_ temp: String) {
    var gatherString = ""
    for i in 0..<temp.count {
        let currentNumber = temp[i]!.asciiValue! - 48
        if 0 <= currentNumber && currentNumber <= 9 {
            gatherString += String(currentNumber)
        } else {
            if !gatherString.isEmpty {
                numberArr.append(removeZero(gatherString))
                gatherString = ""
            }
        }
    }
    if !gatherString.isEmpty {
        numberArr.append(removeZero(gatherString))
    }
}
```
- 아스키코드를 통해 판별하고, 숫자가 아닌 문자가 나오면, 지금까지 만들어 놓았던 문자열을 numberArr 배열에 추가해준다.
- 위에서 마지막 코드를 보자
```swift
if !gatherString.isEmpty {
        numberArr.append(removeZero(gatherString))
    }
```
- 이 코드는 for문이 종료 되었을때, 숫자를 담은 문자열에 무언가가 들어있다면 그 숫자도 넣어줘야하기 때문에 구현했다.

### 📖 오름차순으로 출력하기
```swift
numberArr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0.count < $1.count
}).forEach {
    print($0)
}
```
- 카운트로 숫자의 크고 작음을 판단하고 만약 두 수의 길이가 같다면 작은 순으로 출력하게끔 정렬
