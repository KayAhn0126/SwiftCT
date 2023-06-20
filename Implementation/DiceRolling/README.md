# 14499 주사위 굴리기
- 시뮬레이션
- 입력으로 주어지는 X,Y 값을 알맞는 위치에 넣기

## 🍎 문제 접근
- 주사위를 유효한 위치로 옮길때마다 주사위의 상단을 출력하면 되는 문제다.
- 고려해야할 사항이 많다. 순서대로 알아보자.
- 먼저 처음에 주사위는 아래와 같이 모든 면이 0인 형태다.
```bash
  0
0 0 0
  0
  0
  0
```
- 이동하려는 칸이 Board(맵)을 벗어나면 아무 동작도 하지 않는다.
- 이동한 칸이 0이면 주사위 바닥에 있는 수가 칸으로 복사된다.
- 이동한 칸이 0이 아니면, 칸에 쓰여있는 수가 주사위 바닥면에 복사되고, 칸은 0이 된다.

## 🍎 문제 풀이
### 📖 십자(+) 주사위를 아래와 같이 배열 두개로 관리했다.
```swift
var rowArr = [0,0,0]
var colArr = [0,0,0,0]
```
- 정 중앙에서 겹치는 부분은 각 배열의 1번째 인덱스다.

### 📖 현재 위치를 튜플 형태의 변수로 관리한다.
```swift
var currentDiceLocation: (Int,Int) = (X,Y)
```
### 📖 현재 위치를 옮기는 함수 구현
- 만약 갈 수 없는 위치라면 위치도 옮기지 않고, 추후 아무 로직도 실행 되지 않게 flag 변수를 사용해서 관리하고 있다.
```swift
func changeCurrentLocation(_ direction: Int, _ flag: inout Bool) {
    var nextLocation = (currentDiceLocation.0, currentDiceLocation.1)
    if direction == 1 {
        nextLocation = (nextLocation.0, nextLocation.1 + 1)
    } else if direction == 2 {
        nextLocation = (nextLocation.0, nextLocation.1 - 1)
    } else if direction == 3 {
        nextLocation = (nextLocation.0-1, nextLocation.1)
    } else {
        nextLocation = (nextLocation.0+1, nextLocation.1)
    }
    if nextLocation.0 < 0 || nextLocation.0 >= N || nextLocation.1 < 0 || nextLocation.1 >= M {
        flag = false
        return
    }
    currentDiceLocation = nextLocation
}
```

### 📖 주사위를 굴려주는 함수 구현
- 단, flag가 true일때 실행되는 함수다. 즉, 주사위가 갈 곳이 Board 맵을 벗어나지 않는 유효한 곳이라는 것이다.
```swift
func rollDice(_ direction: Int) {
    // 동 = 1, 서 = 2, 북 = 3, 남 = 4
    if direction == 1 {
        rowArr.insert(colArr.popLast()!, at: 0)
        colArr.append(rowArr.popLast()!)
        colArr[1] = rowArr[1]
    } else if direction == 2 {
        rowArr.append(colArr.popLast()!)
        colArr.append(rowArr.removeFirst())
        colArr[1] = rowArr[1]
    } else if direction == 3 {
        colArr.append(colArr.removeFirst())
        rowArr[1] = colArr[1]
    } else {
        colArr.insert(colArr.popLast()!, at: 0)
        rowArr[1] = colArr[1]
    }
}
```
- 실제로 주사위가 굴러가는것처럼 로직을 만들어 준다.

### 📖 이동한 칸이 0이거나 0이 아닐 때 실행되는 로직 함수 구현
- 이동한 칸이 0이면 주사위 바닥에 있는 수가 칸으로 복사된다.
- 이동한 칸이 0이 아니면, 칸에 쓰여있는 수가 주사위 바닥면에 복사되고, 칸은 0이 된다.
```swift
func swapBottom() {
    let y = currentDiceLocation.0
    let x = currentDiceLocation.1
    if board[y][x] == 0 {
        board[y][x] = colArr[3]
    } else {
        colArr[3] = board[y][x]
        board[y][x] = 0
    }
}
```

### 📖 메인 로직
```swift
for order in moveArr {
    var flag = true
    if (currentDiceLocation.0 == 0 && order == 3) || (currentDiceLocation.1 == 0 && order == 2) || (currentDiceLocation.0 == N-1 && order == 4) || (currentDiceLocation.1 == M-1 && order == 1) { continue }
    changeCurrentLocation(order, &flag)
    if flag == true {
        rollDice(order)
        swapBottom()
        print(rowArr[1])
    }
}
```

## 🍎 전체 코드
```swift
import Foundation

let userInput = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = userInput[0]
let M = userInput[1]
let X = userInput[2]
let Y = userInput[3]
let K = userInput[4]

var board = [[Int]](repeating: [Int](), count: N)
for i in 0..<N {
    let tempArr = readLine()!.split(separator: " ").map { Int(String($0))! }
    board[i].append(contentsOf: tempArr)
}
let moveArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var rowArr = [0,0,0]
var colArr = [0,0,0,0]

var currentDiceLocation: (Int,Int) = (X,Y)

func rollDice(_ direction: Int) {
    // 동 = 1, 서 = 2, 북 = 3, 남 = 4
    if direction == 1 {
        rowArr.insert(colArr.popLast()!, at: 0)
        colArr.append(rowArr.popLast()!)
        colArr[1] = rowArr[1]
    } else if direction == 2 {
        rowArr.append(colArr.popLast()!)
        colArr.append(rowArr.removeFirst())
        colArr[1] = rowArr[1]
    } else if direction == 3 {
        colArr.append(colArr.removeFirst())
        rowArr[1] = colArr[1]
    } else {
        colArr.insert(colArr.popLast()!, at: 0)
        rowArr[1] = colArr[1]
    }
}

func changeCurrentLocation(_ direction: Int, _ flag: inout Bool) {
    var nextLocation = (currentDiceLocation.0, currentDiceLocation.1)
    if direction == 1 {
        nextLocation = (nextLocation.0, nextLocation.1 + 1)
    } else if direction == 2 {
        nextLocation = (nextLocation.0, nextLocation.1 - 1)
    } else if direction == 3 {
        nextLocation = (nextLocation.0-1, nextLocation.1)
    } else {
        nextLocation = (nextLocation.0+1, nextLocation.1)
    }
    if nextLocation.0 < 0 || nextLocation.0 >= N || nextLocation.1 < 0 || nextLocation.1 >= M {
        flag = false
        return
    }
    currentDiceLocation = nextLocation
}

func swapBottom() {
    let y = currentDiceLocation.0
    let x = currentDiceLocation.1
    if board[y][x] == 0 {
        board[y][x] = colArr[3]
    } else {
        colArr[3] = board[y][x]
        board[y][x] = 0
    }
}

for order in moveArr {
    var flag = true
    if (currentDiceLocation.0 == 0 && order == 3) || (currentDiceLocation.1 == 0 && order == 2) || (currentDiceLocation.0 == N-1 && order == 4) || (currentDiceLocation.1 == M-1 && order == 1) { continue }
    changeCurrentLocation(order, &flag)
    if flag == true {
        rollDice(order)
        swapBottom()
        print(rowArr[1])
    }
}
```
