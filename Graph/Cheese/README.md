# 2636 치즈

## 🍎 키워드
- 시뮬레이션
- dfs
- 정확히 외곽만 구하기

## 🍎 문제 요구 사항
- 시간이 지남에 따라 치즈가 녹는다
    - '치즈가 하나도 남지 않는 상황까지 걸리는 시간'과 '모두 녹기 한 시간 전에 치즈 조각이 놓여있는 칸의 갯수'를 구하면 된다.

## 🍎 문제 접근
### 📖 치즈 녹이기
- 이 문제는 치즈를 예제처럼 잘 녹이면 된다. (중요)
- 잘 녹인다는 의미는 정확히 치즈의 외곽(c라고 되어있는 부분)만 녹여야한다는 뜻이다.
    - 예제에서는 치즈의 내부에도 공기와 접촉하는 부분이 있지만 문제의 요구 사항은 외부 공기로만 녹여야 한다.
- 문제에서 주어진 치즈 예시를 보자
![](https://i.imgur.com/Jf9Ioph.png)
- c라고 적혀있는 부분만 녹여야한다.
- 처음엔 예제 그림을 보지 않고 "공기와 닿아 있는 부분을 다 녹이면 되겠구나" 하고 구현을 했더니 아래와 같이 정말 공기와 다 닿아있는 부분을 녹였다.
![](https://i.imgur.com/CD6Fs3l.png)
- 문제에서는 치즈의 내부의 공기는 신경쓰지 않고 외부만 녹여야 하고, 정상적으로 '외부만' 녹았을 때는 아래와 같이 나온다.
- 한시간이 지난 후 치즈 모양
![](https://i.imgur.com/j7iqQEJ.png)
- 두시간이 지난 후 치즈 모양
![](https://i.imgur.com/FtecZpy.png)

### 📖 그래서 어떻게 외곽만 찾을수 있을까? 
- **외곽에 있는 모든 1을 찾을수 있도록 dfs를 할 때, 이전에 방문한곳만 넘어가도록 구현했다.**
    - 이전 방문한곳이면 pass, 1이면 meltingSpot 배열에 추가.
- 가장 바깥에 있는 치즈를 찾고 나중에 녹일때 베이스가 되는 meltingSpot 배열에 넣어주는 작업까지 하는 함수
```swift
// MARK: - 가장 바깥에 있는 1(치즈)를 찾고 meltingSpot 배열에 넣기
func meltingDFS(_ y: Int, _ x: Int) {
    meltingVisited[y][x] = true
    if adjMatrix[y][x] == 1 {
        meltingSpot.append((y,x))
        return
    }
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || meltingVisited[ny][nx] == true { continue }
        meltingDFS(ny, nx)
    }
}
```

### 📖 진짜로 치즈 녹이기
- 위의 meltingDFS 함수에서 '녹일'치즈의 위치를 구했고 이제는 치즈를 녹이면 된다.
- 또 녹여진 치즈 지도를 바탕으로 현재 치즈가 존재하는 칸수를 구하면 된다.
- 아래의 코드는 다음과 같은 내용을 포함하고 있다.
    - 녹일 치즈 선별(meltingSpot)
    - meltingSpot을 이용해 치즈 녹이기
        - 녹일때 녹인 치즈의 칸수 더해주기
        - meltingSpot의 요소를 이용해 치즈 녹이기
    - meltingSpot 초기화
```swift
// MARK: - 녹일 치즈 위치를 이용해 치즈 판 업데이트
func melting() {
    cheesePiecesAnHourAgo = 0
    meltingVisited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
    meltingDFS(0,0)
    meltingSpot.enumerated().forEach {
        cheesePiecesAnHourAgo += 1
        adjMatrix[$0.element.0][$0.element.1] = 0
    }
    meltingSpot.removeAll()
}
```
- 문제에서 원하는 답 2개 중 하나인 '모두 녹기 한 시간 전에 치즈 조각이 놓여있는 칸의 갯수'를 구하기 위해 
```swift
cheesePiecesAnHourAgo += 1
```
- 위와 같이 코드를 썼다. 왜 여기서 값을 올려주고 있을까?
- 바로 치즈가 다 녹았을때 그 전의 값을 출력 해주기 위해서이다.
```swift
while isAdjMatrixHasSomething() {
    melting()
    totalMeltingTime += 1
}
```


## 🍎 전체 코드
```swift
/*
 2636
 치즈
 */
// 2nd week fast campus

import Foundation

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var adjMatrix = [[Int]](repeating: [Int](), count: N)

var meltingSpot = [(Int, Int)]()
var meltingVisited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)

var totalMeltingTime = 0
var cheesePiecesAnHourAgo = 0


for i in 0..<N {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}


// MARK: - 가장 바깥에 있는 1(치즈)를 찾고 meltingSpot 배열에 넣기
func meltingDFS(_ y: Int, _ x: Int) {
    meltingVisited[y][x] = true
    if adjMatrix[y][x] == 1 {
        meltingSpot.append((y,x))
        return
    }
    
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if ny < 0 || nx < 0 || ny >= N || nx >= M || meltingVisited[ny][nx] == true { continue }
        meltingDFS(ny, nx)
    }
}

// MARK: - 녹일 치즈 위치를 이용해 치즈 판 업데이트
func melting() {
    cheesePiecesAnHourAgo = 0
    meltingVisited = [[Bool]](repeating: [Bool](repeating: false, count: M), count: N)
    meltingDFS(0,0)
    meltingSpot.enumerated().forEach {
        cheesePiecesAnHourAgo += 1
        adjMatrix[$0.element.0][$0.element.1] = 0
    }
    meltingSpot.removeAll()
}

// MARK: - 남아있는 치즈가 있는지 확인하는 함수
func isAdjMatrixHasSomething() -> Bool {
    var flag = false
    for i in 0..<N {
        for j in 0..<M {
            if adjMatrix[i][j] == 1 {
                flag = true
            }
        }
    }
    return flag
}

while isAdjMatrixHasSomething() {
    melting()
    totalMeltingTime += 1
}

print(totalMeltingTime)
print(cheesePiecesAnHourAgo)
```
