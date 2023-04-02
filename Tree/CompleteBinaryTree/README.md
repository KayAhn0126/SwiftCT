# 9934 완전 이진 트리
- 트리
- 패턴 찾기 (재귀)

## 🍎 문제 접근
### 📖 문제 이해
- 문제의 예제 입력들을 보면 특정한 패턴이 있다.
- 예제 입력1
- 2 1 3
- 즉, 입력 2 1 3은 아래와 같은 형태의 트리가 된다.
```bash
  2
 / \
1   3
```
- 이 트리를 통해 알 수 있는것은,가운데에 있는것이 양쪽 노드의 부모노드가 된다.
- 다른 예제도 한번 보자
- 1 6 4 3 5 2 7
```bash
     3
    / \
   6   2
  / \ / \
 1  4 5  7
```
- 이러한 트리가 완성된다.
- 출력해야하는 답은 depth 1부터 K까지 depth별로 한줄 한줄 출력하면 된다.
- 위의 예제에 대한 출력을 보자
```bash
3 -> depth 1
6 2 -> depth 2
1 4 5 7 -> depth 3 or depth K
```
## 🍎 문제 풀이
### 📖 답을 저장할 2차원 배열
- 답을 저장할 2차원 배열을 만든다.
- depth 1에 들어갈 노드는 depth[1]에 append해준다.
- depth 2에 들어갈 노드는 depth[2]에 append해준다.
```swift
var result = [[Int]](repeating: [Int](), count: N + 1)
```
- 해당 배열의 가운데를 mid로 잡고 depth에 넣어준다.
- mid를 기준으로 양쪽으로 구역을 나눠 함수를 호출한다.
- 재귀함수니까 기저사례가 필요하다.
- 함수 내에서 depth가 N보다 큰경우는 답이 될 수 없으므로 return 해준다.
```swift
if depth == N + 1 {
    return
}
```

### 📖 전체코드
```swift
import Foundation

let N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let mid = arr.count / 2
//depth를 들어가서 mid를 출력하면된다.

var result = [[Int]](repeating: [Int](), count: N + 1)

func go(_ from: Int, _ to: Int, _ depth: Int) {
    if depth == N + 1 {
        return
    }
    let mid = (from + to) / 2
    result[depth].append(arr[mid])
    go(from, mid-1, depth + 1)
    go(mid+1, to, depth + 1)
}
go(0, arr.count-1, 1)

for i in 1...N {
    for j in 0..<result[i].count {
        print(result[i][j], terminator: " ")
    }
    print("")
}
```

### 📖 메인 로직
```swift
func go(_ from: Int, _ to: Int, _ depth: Int) {
    if depth == N + 1 {
        return
    }
    let mid = (from + to) / 2
    result[depth].append(arr[mid])
    go(from, mid-1, depth + 1)
    go(mid+1, to, depth + 1)
}
```
- 함수의 매개변수에 depth도 같이 넣어주어 result의 depth번째에 답이 append될 수 있도록 한다.
- 호출 코드
```swift
go(0, arr.count-1, 1)
```

### 📖 답 출력
- 2차원 배열을 순회하면서 정답 출력
```swift
for i in 1...N {
    for j in 0..<result[i].count {
        print(result[i][j], terminator: " ")
    }
    print("")
}
```
