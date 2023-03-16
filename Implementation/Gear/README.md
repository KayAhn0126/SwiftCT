# 14891 톱니바퀴
- 구현 문제

## 🍎 문제 접근

### 📖 중요 포인트
![](https://i.imgur.com/UfYJ30h.png)
![](https://i.imgur.com/ShaR2JG.png)
- **톱니바퀴 끼리 맞물리는 곳이 달라야 돌아간다!**
- 매번 어떤 톱니바퀴를 돌리기 전 맞물리는 곳의 값들을 모두 캡쳐해야한다.
- 위의 이미지에서 3번 톱니바퀴를 반시계 방향으로 회전할것이라고 하자. 4번 톱니바퀴는 3번 톱니바퀴와 맞물린곳이 다르므로 시계방향으로 돈다(아래 이미지 참고)
- 2번 톱니바퀴는 돌지 않는다. 왜?
- 3번 톱니바퀴를 돌리기 전 상태가 S 와 S 상태라서!
- **즉, 포인트는 톱니바퀴를 돌리기전 상태를 기준으로 양 옆의 톱니바퀴를 돌릴지 말지 결정한다는것!**

### 📖 처음에 문제를 접근했던 방식
- 배열을 이용해 0번째 인덱스가 top 7번째 인덱스가 마지막으로 정했다.
- 시계 방향, 반시계 방향으로 돌리는 함수를 만들어 주었다.
- 점점 복잡해져서 na982님의 강의를 보고 아이디어를 가져왔다.

## 🍎 문제 풀이
```swift
import Foundation

var gears = [[Character]](repeating: [Character](), count: 4)
var commands: [Int] = [0,0,0,0] // commands 배열을 만들어 각각의 톱니바퀴가 어디로 도는지 결정한다

for i in 0..<4 {
    gears[i].append(contentsOf: readLine()!)
}

var totalTestCase = Int(readLine()!)!

// 입력으로 주어진 톱니바퀴를 기준으로 왼쪽 톱니바퀴와 맞물리는 곳의 값이 다르면 계속 왼쪽으로 퍼져나간다
// 이때 commands배열을 "어떤 톱니바퀴를 어디로 돌릴지?" 정하는데 사용한다.
// 매개변수로 받아온 direction은 -1을 곱해줘 -1 -> 1, 1 -> -1로 만들어 이전 톱니바퀴의 역방향을 구현.
func checkLeft(_ currentGear: Int, _ direction: Int) {
    if currentGear <= 0 { return }
    if gears[currentGear][6] != gears[currentGear - 1][2] {
        commands[currentGear - 1] = direction * -1
        checkLeft(currentGear - 1, direction * -1)
    }
}

// 입력으로 주어진 톱니바퀴를 기준으로 오른쪽 톱니바퀴와 맞물리는 곳의 값이 다르면 계속 오른쪽으로 퍼져나간다
// 이때 commands배열을 "어떤 톱니바퀴를 어디로 돌릴지?" 정하는데 사용한다.
// 매개변수로 받아온 direction은 -1을 곱해줘 -1 -> 1, 1 -> -1로 만들어 이전 톱니바퀴의 역방향을 구현.
func checkRight(_ currentGear: Int, _ direction: Int) {
    if currentGear >= gears.count - 1 { return }
    if gears[currentGear][2] != gears[currentGear + 1][6] {
        commands[currentGear + 1] = direction * -1
        checkRight(currentGear + 1, direction * -1)
    }
}

// 무엇을 이쪽으로 돌리세요~ 라고 주어지면 돌리고 양쪽을 체크하는데 조건이 맞을때까지 왼쪽, 오른쪽으로 퍼져나간다.
func rotate(_ currentGear: Int, _ direction: Int) {
    commands[currentGear] = direction
    // 주어진 톱니바퀴를 어디로 돌릴지 결정 후 양쪽의 톱니바퀴를 돌려야 하는지 결정한다.
    checkLeft(currentGear, direction)
    checkRight(currentGear, direction)
}

func doBackAndForth() {
    for i in 0..<commands.count {
        if commands[i] == 1 {
            gears[i].insert(gears[i].last!, at: 0)
            gears[i].popLast()
        } else if commands[i] == -1 {
            gears[i].append(gears[i].first!)
            gears[i].removeFirst()
        }
    }
}

func calculateResult() -> Int {
    var result = 0
    var counter = 1
    for i in 0..<4 {
        result += (Int(String(gears[i][0]))! * counter)
        counter *= 2
    }
    return result
}

for i in 0..<totalTestCase {
    var gearDirection = readLine()!.split(separator: " ").map { Int(String($0))! }
    rotate(gearDirection[0] - 1, gearDirection[1])
    doBackAndForth()
    commands = [0,0,0,0]
}
print(calculateResult())
```
- commands 배열을 계속 업데이트 해주는것이 이 문제를 푸는 포인트!
- 입력으로 주어지는 톱니바퀴와 방향에 따라 


## 🍎 느낀점
- 돌아가기만 하는 코드는 지양하자
- 현재는 톱니바퀴가 4개만 있지만 톱니바퀴2에서는 몇개가 주어질지 모른다
    - 만약 4개로만 어찌저찌 구현했다면 톱니바퀴2에서는 그 방법이 통하지 않는다.
    - 넓은 시야로 문제를 보자!
