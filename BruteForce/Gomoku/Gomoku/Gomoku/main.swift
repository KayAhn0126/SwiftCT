//
//  main.swift
//  Gomoku
//
//  Created by Kay on 2023/05/10.
//

/*
 2615
 오목
 */

import Foundation

var adjMatrix = [[Int]](repeating: [Int](), count: 20)
for i in 0..<19 {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}
adjMatrix[19].append(contentsOf: [Int](repeating: 0, count: 19))

adjMatrix.enumerated().forEach {
    print($0.element)
}

func checkStraightBottom(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y+1][x] == currentNumber &&
        adjMatrix[y+2][x] == currentNumber &&
        adjMatrix[y+3][x] == currentNumber &&
        adjMatrix[y+4][x] == currentNumber &&
        adjMatrix[y+5][x] != currentNumber {
        return true
    }
    return false
}

func checkStraightDiagonal(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y+1][x+1] == currentNumber &&
        adjMatrix[y+2][x+2] == currentNumber &&
        adjMatrix[y+3][x+3] == currentNumber &&
        adjMatrix[y+4][x+4] == currentNumber &&
        adjMatrix[y+5][x+5] != currentNumber {
        return true
    }
    return false
}

func checkStraightRight(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y][x+1] == currentNumber &&
        adjMatrix[y][x+2] == currentNumber &&
        adjMatrix[y][x+3] == currentNumber &&
        adjMatrix[y][x+4] == currentNumber {
        if x != 0 {
            if adjMatrix[y][x-1] != currentNumber {
                return true
            }
        }
        return true
    }
    return false
}

var location: [(Int, Int)] = []
for i in 0...14 {
    for j in 0...14 {
        if adjMatrix[i][j] == 0 { continue }
        if checkStraightBottom(i, j, 1) { location.append((i,j)) }
        if checkStraightDiagonal(i, j, 1) { location.append((i,j)) }
        if checkStraightRight(i, j, 1) { location.append((i,j)) }
        
        if checkStraightBottom(i, j, 2) { location.append((i,j)) }
        if checkStraightDiagonal(i, j, 2) { location.append((i,j)) }
        if checkStraightRight(i, j, 2) { location.append((i,j)) }
    }
}
if adjMatrix[location[0].0][location[0].1] == 1 {
    print(1)
} else {
    print(2)
}
print(location[0].0 + 1, location[0].1 + 1)
