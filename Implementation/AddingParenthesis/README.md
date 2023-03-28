# 16637 괄호 추가하기
- 구현
- 브루트포스

## 🍎 문제 접근
- 모든 방법을 탐색해 답을 찾는것은 브루트 포스 같은데, 그것보단 재귀에 더 가까운것 같다.
- 처음에 문제를 파악하고 정리하는것이 중요.
- 괄호가 하나도 없어도 되고, 제한도 없다. 다만 겹치지만 않으면 된다.
### 📖 숫자와 연산자 분리하기
- readLine()!으로 전체 입력을 받는데 0을 포함한 짝수 인덱스는 모두 숫자이고, 홀수 인덱스에 있는 문자들은 모두 연산자이다.
- 일반 계산처럼 왼쪽부터 계산해야한다.
- 3 + 8 * 7 와 같은 식이 주어진다면
    - 1. (3 + 8) * 7 -> 77
    - 2. 3 + (8 * 7) -> 59
- 첫째 숫자와 둘째 숫자를 먼저 계산하고, 마지막 숫자와 계산하는 경우.
- 둘째 숫자와 셋째 숫자를 먼저 계산하고, 처음 숫자와 계산하는 경우.
- 제일 중요한 포인트는 이런 계산을 하고 어느 위치에 이 값을 던져줘서 다음 작업을 이어가도록 코드를 작성하는것이다.
- 문제 풀이를 보자!
## 🍎 문제 풀이
- 먼저 숫자 2개와 연산자가 주어지면 연산을 해서 값을 내놓는 함수를 하나 만든다.
```swift
func calculate(_ num1: Int, _ oper: Character, _ num2: Int) -> Int {
    if oper == "+" { return num1 + num2 }
    if oper == "-" { return num1 - num2 }
    if oper == "*" { return num1 * num2 }
    return 0
}
```
- 메인로직
- 숫자 2개와 연산자 1개를 계산 후 필요한 위치에 놓는 로직
```swift
// 정답은 2^31보다 작고, -2^31보다 크다.
// 즉 음수도 들어올 수 있으므로 Int의 가장 작은 값을 넣어준다.
var result = Int.min

func go(_ currentIdx: Int, _ number: Int) {
    // 위치가 끝까지 왔다면, 현재까지 계산한 값과 result와 비교해서 더 큰 수를 result에 넣어준다.
    if currentIdx == numberArr.count - 1 { 
        result = number > result ? number : result
        return
    }
    // 현재 인덱스와 다음 인덱스를 현재 연산자를 통해서 계산한 값을 매개변수로 받아온 currentIdx + 1에 넘겨준다.
    go(currentIdx + 1, calculate(number, operatorArr[currentIdx], numberArr[currentIdx + 1]))
    
    // 만약 현재 인덱스 + 2가 숫자 배열의 끝과 같거나 작다면 뒤쪽부터 계산이 가능하다는 이야기므로, 뒤쪽을 먼저 계산하고 앞애 있는 수를 계산한다.
    if currentIdx + 2 <= numberArr.count - 1 {
        // 뒤에 있는 수 계산하기 3 + 8 * 5라면 8 * 5를 먼저 계산하는 로직
        let backSideCalculation = calculate(numberArr[currentIdx + 1], operatorArr[currentIdx + 1], numberArr[currentIdx + 2])
        // 이후 3 + 바로 윗코드에서 넘어온 값 40을 더하는 로직
        go(currentIdx + 2, calculate(number, operatorArr[currentIdx], backSideCalculation))
    }
}

// 0번째 인덱스 부터 시작하고 첫번째 숫자를 넣는다.
go(0, numberArr[0])
print(result)
```
