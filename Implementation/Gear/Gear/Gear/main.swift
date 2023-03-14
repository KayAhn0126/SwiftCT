//
//  main.swift
//  Gear
//
//  Created by Kay on 2023/03/13.
//

/*
 14891
 톱니바퀴
 */

/*
 돌릴 당시의 상태를 기억하고 극이 다르다면 반대방향으로 회전.
 func rotate(무엇을, 어느방향으로)
 내 옆이 회전하고 극이 다르면 나도 회전한다.
 
 N = 0
 S = 1
 
 clockWise = 1
 counterClockWise = -1
 */

// 이 문제에서는 톱니바퀴가 4개 있지만, 만약 톱니바퀴가 10개 있다면..? -> 빡구현이 통하지 않는다.
// 무엇을 이쪽으로 돌리세요~ 라고 주어지면 돌리고 양쪽을 체크하는데 조건이 맞을때까지 왼쪽, 오른쪽으로 퍼져나간다.

// commands 배열을 만들어 각각의 톱니바퀴가 어디로 도는지 결정한다
// 주어진 톱니바퀴를 어디로 돌릴지 결정 후 양쪽의 톱니바퀴를 돌려야 하는지 결정한다.

import Foundation

var gears = [[Character]](repeating: [Character](), count: 4)
var commands: [Int] = [0,0,0,0]

for i in 0..<4 {
    gears[i].append(contentsOf: readLine()!)
}

var totalTestCase = Int(readLine()!)!

func checkLeft(_ currentGear: Int, _ direction: Int) {
    if currentGear <= 0 { return }
    if gears[currentGear][6] != gears[currentGear - 1][2] {
        commands[currentGear - 1] = direction * -1
        checkLeft(currentGear - 1, direction * -1)
    }
}

func checkRight(_ currentGear: Int, _ direction: Int) {
    if currentGear >= gears.count - 1 { return }
    if gears[currentGear][2] != gears[currentGear + 1][6] {
        commands[currentGear + 1] = direction * -1
        checkRight(currentGear + 1, direction * -1)
    }
}

func rotate(_ currentGear: Int, _ direction: Int) {
    commands[currentGear] = direction
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
