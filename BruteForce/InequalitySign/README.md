# 2529 부등호
- 인덱스 기반 완전탐색
- 백트래킹

## 🍎 문제 접근
- 부등호 로직이 맞는지 확인하는 로직 필요
- 백트래킹 로직 필요
- 최대 최소 비교 로직 필요
- **쉬워 보이지만 쉽지 않아서 생각을 많이하게 해준 좋은 문제**

## 🍎 문제 풀이
- 숫자 두개와 문자를 가지고 대소 비교하는 함수
```swift
func isValid(_ num1: Int, _ oper: Character, _ num2: Int) -> Bool {
    if num1 < num2 && oper == "<" { return true }
    if num1 > num2 && oper == ">" { return true }
    return false
}
```
- 메인 로직
```swift
func go(_ idx: Int, _ num: String) {
    if idx == K + 1 { // 정해진 갯수를 넘어가면 resultArr에 추가하고 함수 종료
        resultArr.append(num)
        return
    }
    for i in 0...9 {
        if visited[i] == true { continue } // 이미 방문했다면 실행안함.
        // num에 처음 들어가는 숫자거나, idx가 1이상인 상황에서 이전 부등호가 정상적이라면 실행된다.
        if idx == 0 || isValid(Int(String(num.last!))!, signArr[idx-1], i) == true { 
            visited[i] = true
            go(idx + 1, num + String(i))
            visited[i] = false
        }
    }
}
```
- 실행 로직
```swift
go(0, "")
resultArr = resultArr.sorted(by: {
    if $0.count == $1.count {
        return $0 < $1
    }
    return $0 < $1
})

print(resultArr[resultArr.count-1])
print(resultArr[0])
```
