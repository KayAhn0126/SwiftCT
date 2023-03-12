# 14503 로봇 청소기
- 그래프 탐색(1%) + 시뮬레이션(99%)

## 🍎 문제 접근
- 지금까지는 현재 위치에서 시계방향으로만 탐색을 해왔었는데 이번 문제에서는 반시계방향 및 현 위치의 반대 방향 탐색을 요구했다.
- 현재 칸의 주변 4칸 중 청소되지 않은 빈 칸이 없는 경우 처리.
- 나머지는 문제의 요구에 맞게 구현하면 된다.

## 🍎 실패 코드
```swift
import Foundation


 let dy = [-1,0,1,0]
 let dx = [0,1,0,-1]

 let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
 let N = NM[0]
 let M = NM[1]

 let currentLocationAndDirection = readLine()!.split(separator: " ").map { Int(String($0))! }
 var currentLocY = currentLocationAndDirection[0]
 var currentLocX = currentLocationAndDirection[1]
 var currentDir = currentLocationAndDirection[2]

 var adjMatrix = [[Int]](repeating: [Int](), count: N)
 for i in 0..<N {
     adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
 }

 var result = 0
 var leftCount = 0
 while true {
     if adjMatrix[currentLocY][currentLocX] == 0 {
         adjMatrix[currentLocY][currentLocX] = 2
         result += 1
     }
     
     // 방향을 왼쪽으로 돌기
     let totheLeftDir = (currentDir + 3) % 4
     let ny = currentLocY + dy[totheLeftDir]
     let nx = currentLocX + dx[totheLeftDir]
     
     if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
     
     if adjMatrix[ny][nx] == 0 { // 왼쪽으로 돌았을때 앞의 칸이 청소가 안되어 있으면, 위치를 옮긴다.
         currentDir = totheLeftDir
         currentLocY = ny
         currentLocX = nx
         leftCount = 0
     } else if adjMatrix[ny][nx] == 2 {
         leftCount += 1
         if leftCount == 4 { // 4방향 모두 2로 차있다면 후진, 후진한 곳이 벽이라면 청소 종료
             let backY = currentLocY + dy[(currentDir + 2) % 4]
             let backX = currentLocX + dx[(currentDir + 2) % 4]
             currentLocY = backY
             currentLocX = backX
             currentDir = totheLeftDir
             if adjMatrix[backY][backX] == 1 {
                 print(result)
                 break
             }
             
         } else {
             currentLocY = ny
             currentLocX = nx
             currentDir = totheLeftDir
         }
     } else {
         leftCount += 1
         currentLocY = ny
         currentLocX = nx
         currentDir = totheLeftDir
     }
 }
```
- 이 코드는 보기에 로직은 문제 없어 보이지만 아래의 코드로 인해 무한 루프에 걸린다.
```swift
            ...

let totheLeftDir = (currentDir + 3) % 4
let ny = currentLocY + dy[totheLeftDir]
let nx = currentLocX + dx[totheLeftDir]
     
if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }

            ...
```

## 🍎 통과 코드
```swift
/*
 0  1 2  3
 북 동 남 서
 
 0 -> 청소 안됨
 1은 벽
 */

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

let currentLocationAndDirection = readLine()!.split(separator: " ").map { Int(String($0))! }
var currentLocY = currentLocationAndDirection[0]
var currentLocX = currentLocationAndDirection[1]
var currentDir = currentLocationAndDirection[2]

var adjMatrix = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

var result = 0 // 로봇 청소기가 청소한 바닥 수
var leftCount = 0 // 현재 칸의 주변 4칸 중 이동해서 탐색을 하지 않았는지 확인하는 변수

while true {
    //MARK: 현재 바닥이 청소 되어있지 않다면 청소한다.
    if adjMatrix[currentLocY][currentLocX] == 0 {
        adjMatrix[currentLocY][currentLocX] = 2
        result += 1
    }
    
    leftCount = 4
    // 실패한 코드와 다른점은 continue를 만나도 반시계방향으로 돌면서 청소 가능 공간을 찾는다.
    for i in 0..<4 {
        let totheLeftDir = (currentDir + 3 - i) % 4
        let ny = currentLocY + dy[totheLeftDir]
        let nx = currentLocX + dx[totheLeftDir]
        
        if ny < 0 || nx < 0 || ny >= N || nx >= M { continue }
        if adjMatrix[ny][nx] != 0 { continue }
        // 이곳에 들어왔다는것은 청소 할 수 있다는 뜻!
        leftCount -= 1
        currentLocY = ny
        currentLocX = nx
        currentDir = totheLeftDir
        break
    }
    
    //MARK: 현재 칸의 주변 4칸 중 청소되지 않은 빈 칸이 없는 경우 처리
    if leftCount == 4 { // 위의 for 문에서 한번도 청소를 하지 않았다면 leftCount가 4이다.
        let backY = currentLocY + dy[(currentDir + 2) % 4]
        let backX = currentLocX + dx[(currentDir + 2) % 4]
        // 뒤로 이동했을때 맵을 빠져나갔거나 벽이라면 프로그램 종료!
        if backY < 0 || backX < 0 || backY >= N || backX >= M || adjMatrix[backY][backX] == 1 {
            print(result)
            break
        }
        currentLocY = backY
        currentLocX = backX
    }
}
```
