//
//  main.swift
//  Gear2
//
//  Created by Kay on 2023/03/14.
//

/*
 15662
 톱니바퀴 2
 */

/*
 
 톱니바퀴1과 다른점.
 톱니바퀴1 문제는 톱니바퀴가 4개였다. + 마지막에 각 톱니바퀴의 문자가 s라면 1,2,4,8을 더해줘서 값을 계산했다.
 하지만 톱니바퀴2는 톱니바퀴가 T개. + 마지막에 각 톱니바퀴의 0번째 문자가 s인 총 갯수를 반환하면 된다.
 
 */

import Foundation

var numberOfGears = Int(readLine()!)!

var gears = [[Character]](repeating: [Character](), count: numberOfGears)
var commands = [Int](repeating: 0, count: numberOfGears)


for i in 0..<numberOfGears {
    gears[i].append(contentsOf: readLine()!)
}

var totalTestCase = Int(readLine()!)!

func resetCommands() {
    for i in 0..<numberOfGears {
        commands[i] = 0
    }
}

func checkLeft(_ currentGear: Int, _ direction: Int) {
    if currentGear <= 0 { return }
    if gears[currentGear][6] != gears[currentGear-1][2] {
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

func rotate(_ currentGear: Int, _ direction: Int) {
    commands[currentGear] = direction
    checkLeft(currentGear, direction)
    checkRight(currentGear, direction)
}

func calculateResult() -> Int {
    var result = 0
    for i in 0..<gears.count {
        if gears[i][0] == "1" {
            result += 1
        }
    }
    return result
}

for i in 0..<totalTestCase {
    let gearDirection = readLine()!.split(separator: " ").map { Int(String($0))! }
    let gear = gearDirection[0]
    let direction = gearDirection[1]
    rotate(gear - 1, direction)
    doBackAndForth()
    resetCommands()
}
print(calculateResult())
