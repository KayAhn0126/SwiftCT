# 6603 로또
- DFS

## 🍎 지문 해석
- 주어지는 수에서 6개씩 뽑아 로또 숫자를 만든다.

## 🍎 문제 접근
- 방문처리를 하면서 깊이 우선 탐색을 수행하는데, 이때 depth와 idx도 같이 넘겨준다.
- depth가 6이 된다면 출력해준다.
- 중복을 방지하기 위해서 idx부터 시작한다.

## 🍎 문제 풀이 및 전체 코드
```swift
import Foundation

var flag = false
while let x = readLine() {
    if x == "0" { break }
    if flag {
        print("")
    }
    let arr = x.split(separator: " ").map { String($0) }
    let newArr = Array(arr[1..<arr.count])
    var visited = [Bool](repeating: false, count: newArr.count)
    
    func dfs(_ depth: Int, _ current: String, _ idx: Int) {
        if depth == 6 {
            var result = current
            result.removeLast()
            print(result)
            return
        }
        for i in idx..<newArr.count {
            if visited[i] { continue }
            visited[i] = true
            dfs(depth + 1, current + newArr[i] + " ", i)
            visited[i] = false
        }
    }
    dfs(0, "", 0)
    flag = true
}
```
