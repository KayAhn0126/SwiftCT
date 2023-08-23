# 14888 연산자 끼워넣기
- 백트래킹
- 브루트포스

## 🍎 지문 해석
- 수의 순서를 바꾸지 말고 주어진 연산자의 순서만 바꿔가면서 연산했을때 가장 큰 수와 가장 작은 수를 찾는 문제.
- N(수)의 개수 최대 11개
- 연산자의 수 최대 N-1개

## 🍎 문제 접근
- 처음에는 연산자에 대한 모든 순열을 구하고, 구해진 순열들을 하나씩 순회하면서 피 연산자와 계산해나아가는 로직을 구현했는데 메모리 초과를 받았다.
    - 아마 순열을 저장하는 2차원배열의 크기가 10! = 360만정도라 메모리초과를 받는것이 아닌가 싶다.

## 🍎 문제 해결 및 전체 코드
### 📖 로직은 문제 없지만 메모리 초과 판정을 받은 코드
```swift
import Foundation

let N = Int(readLine()!)!
let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
let tempOperators = readLine()!.split(separator: " ").map { Int(String($0))! }

var charArr = [Character]()
for i in 0..<4 {
   let currentCount = tempOperators[i]
   if currentCount > 0 {
       var currentChar: Character = " "
       if i == 0 {
           currentChar = "+"
       } else if i == 1 {
           currentChar = "-"
       } else if i == 2 {
           currentChar = "*"
       } else if i == 3 {
           currentChar = "/"
       }
       for _ in 0..<currentCount{
           charArr.append(currentChar)
       }
   }
}

func permutation<T>(_ arr: [T], _ r: Int) -> [[T]] {
   var result: [[T]] = []
   if arr.count < r { return result }

   var visited = [Bool](repeating: false, count: arr.count)

   func cycle(_ now: [T]) {
       if now.count == r {
           result.append(now)
           return
       }
       for i in 0..<arr.count {
           if visited[i] { continue }
           visited[i] = true
           cycle(now + [arr[i]])
           visited[i] = false
       }
   }
   cycle([])
   return result
}

var operatorsPermutation = permutation(charArr, charArr.count)

func calculate(_ lhs: Int, _ oper: Character, _ rhs: Int) -> Int {
   if oper == "+" { return lhs + rhs }
   if oper == "-" { return lhs - rhs }
   if oper == "*" { return lhs * rhs }
   if oper == "/" { return lhs / rhs }
   return 0
}

var max = Int.min
var min = Int.max

for permu in operatorsPermutation {
   var result = calculate(arr[0], permu[0], arr[1])
   for i in 1..<charArr.count {
       result = calculate(result, permu[i], arr[i+1])
   }
   max = result > max ? result : max
   min = result < min ? result : min
}
print(max)
print(min)
```
### 📖 백트래킹을 이용해 통과한 코드
- 다른 사람들의 코드를 보고 아이디어를 얻어왔다!
- 아래 코드의 장점은 바로바로 계산을 하고 일정 depth까지 간다면 거기서 max, min 값을 갱신한다.
    - 즉, 연산자의 순열을 구한 후 계산하는 것보다 더 빠르다.
```swift
let N = Int(readLine()!)!

let numArr = readLine()!.split(separator: " ").map { Int(String($0))! }
var charArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var min = Int.max
var max = Int.min

func dfs(_ depth: Int, _ result: Int) {
    if depth == N {
        min = result < min ? result : min
        max = result > max ? result : max
        return
    }
    
    // 1 0 1 0 <- charArr가 왼쪽과 같은 형태로 주어지는데, 순서대로 + , - , * , / 다.
    // 즉, 왼쪽의 1 0 1 0 은 +가 1개 *가 1개 있다는 뜻.
    for i in 0..<4 {
        var localResult = result
        if charArr[i] > 0 {
            charArr[i] -= 1
            if i == 0 {        // +
                localResult += numArr[depth]
            } else if i == 1 { // -
                localResult -= numArr[depth]
            } else if i == 2 { // *
                localResult *= numArr[depth]
            } else if i == 3 { // /
                localResult /= numArr[depth]
            }
            dfs(depth + 1, localResult)
            charArr[i] += 1
        }
    }
}

dfs(1, numArr[0])
print(max)
print(min)
```
