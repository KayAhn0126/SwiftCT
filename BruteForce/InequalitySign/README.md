# 2529 부등호
- 인덱스 기반 완전탐색
- 백트래킹

## 🍎 문제 접근
- 부등호 로직이 맞는지 확인하는 로직 필요
- 백트래킹 로직 필요
- 최대 최소 비교 로직 필요
- **쉬워 보이지만 쉽지 않아서 생각을 많이하게 해준 좋은 문제**

## 🍎 생각 해볼점
- 순열의 시간 복잡도를 구해보니 360만이라 먼저 순열을 생성하고 인덱스 기반으로 비교를 하면 될줄 알았다. 하지만..
- 시간복잡도
    - 최악의 경우 9개의 부등호가 들어와 10개의 수에 대한 순열을 구하게 된다면 O(10!), 즉 O(3628800)이 걸린다.
    - **순열만 구하는데 O(10!)이 발생하는 것이다.**
    - 여기서 for문이 하나만 추가 되더라도 시간초과가 날 수 있다.
- 순열을 구하고 푸는것이 아닌 숫자를 선택하고 조건에 맞으면 진행시키고 아니면 가지를 잘라내는 방법으로 문제를 풀어가야한다.
    - 이 방법으로 구현하면 최대 O(10!)이라서 무조건 통과할 수 있다.
- 최소 360만 VS 최대 360만은 차이가 크다.

## 🍎 로직은 맞지만 시간초과 발생하는 코드 (실패코드)
```swift
import Foundation

func permutation<T>(_ arr: [T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if arr.count < num { return result }
    
    var visited = [Bool](repeating: false, count: arr.count)
    func cycle(_ now: [T]) {
        if now.count == num {
            result.append(now)
            return
        }
        for i in 0..<arr.count {
            if visited[i] == true {
                continue
            }
            visited[i] = true
            cycle(now + [arr[i]])
            visited[i] = false
        }
    }
    cycle([])
    return result
}

func checkIfSignIsValid(_ num1: Int, _ sign: Character, _ num2: Int) -> Bool {
    if sign == "<" && num1 < num2 { return true }
    if sign == ">" && num1 > num2 { return true }
    return false
}

let N = Int(readLine()!)!
let sign = readLine()!.split(separator: " ").map { Character(String($0)) }

//MARK: Main Logic -> 여기서 permutation은 각각의 순열
let permu = permutation([0,1,2,3,4,5,6,7,8,9], N + 1)
var totalResult = [[Int]]() // 마지막 결과를 집어 넣을 2차원 배열

for permutation in 0..<permu.count { // [0,1,2]
    var flag = true
    for i in 0..<sign.count { // [<,>]
        if checkIfSignIsValid(permu[permutation][i], sign[i], permu[permutation][i+1]) == true { continue }
        flag = false
        break
    }
    if flag == true {
        totalResult.append(permu[permutation])
    }
}

print(totalResult[totalResult.count-1].map { String($0) }.joined())
print(totalResult[0].map { String($0) }.joined())
```

## 🍎 통과 코드 + 문제 풀이
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
        // num에 처음 들어가는 숫자거나, idx가 1이상인 상황에서 현재 i를 넣었을때 식이 성립되면 더 깊이 가지치기를 한다.
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
- 정렬은 딱히 필요하지 않다.
    - 왜? 어차피 처음 들어간 문자열이 가장 작은 숫자로 된 문자열이고, 가장 나중에 들어간 문자열이 가장 큰 숫자로 된 문자열이다.
