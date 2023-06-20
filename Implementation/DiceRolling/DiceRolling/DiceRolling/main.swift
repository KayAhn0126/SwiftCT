//
//  main.swift
//  DiceRolling
//
//  Created by Kay on 2023/06/20.
//

/*
 14499
 주사위 굴리기
 */

/*
 문제 접근
 주사위를 굴렸을 때,
    이동한 칸이 0이면 주사위 바닥에 있는 수가 칸에 복사된다.
    이동한 칸이 0이 아니면, 칸에 쓰여있는 수가 주사위 바닥면에 복사되고, 칸은 0이 된다.
 좌표와 이동 명령이 주어지면, 이동할 때 마다 상단에 쓰여있는 값을 구하라.
 지도 밖으로는 이동 불가.
 
 세로크기 N 가로크기 M, 좌표 x,y, 명령의 개수 K
 상하좌우에 따라 배열 바꾸기
 */

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
        print("현재 방향은 \(order)")
        print(rowArr[1])
    }
}
