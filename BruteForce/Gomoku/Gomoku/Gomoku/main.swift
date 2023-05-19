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

var adjMatrix = [[Int]](repeating: [Int](), count: 19)
for i in 0..<19 {
    adjMatrix[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

func checkStraightBottom(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    var result = true
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y+1][x] == currentNumber &&
        adjMatrix[y+2][x] == currentNumber &&
        adjMatrix[y+3][x] == currentNumber &&
        adjMatrix[y+4][x] == currentNumber {
        if y == 0 {
            if adjMatrix[y+5][x] == currentNumber {
                result = false
            }
        } else if y <= 13 {
            if adjMatrix[y-1][x] == currentNumber || adjMatrix[y+5][x] == currentNumber {
                result = false
            }
        }
    } else {
        result = false
    }
    return result
}

func checkStraightDiagonal(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    var result = true
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y+1][x+1] == currentNumber &&
        adjMatrix[y+2][x+2] == currentNumber &&
        adjMatrix[y+3][x+3] == currentNumber &&
        adjMatrix[y+4][x+4] == currentNumber {
        if y > 0 && x > 0 {
            if adjMatrix[y-1][x-1] == currentNumber { result = false }
        }
        if y <= 13 && x <= 13 {
            if adjMatrix[y+5][x+5] == currentNumber { result = false }
        }
        if y == 14 && x <= 14 {
            if adjMatrix[y-1][x-1] == currentNumber  { result = false }
        }
    } else {
        result = false
    }
    return result
}

func checkOtherSideDiagonal(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    var result = true
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y-1][x+1] == currentNumber &&
        adjMatrix[y-2][x+2] == currentNumber &&
        adjMatrix[y-3][x+3] == currentNumber &&
        adjMatrix[y-4][x+4] == currentNumber {
        
        if y > 4 && x <= 13 {
            if adjMatrix[y-5][x+5] == currentNumber { result = false }
        }
        if y >= 4 && y < 18 && x > 0 && x <= 14 {
            if adjMatrix[y+1][x-1] == currentNumber { result = false }
        }
    } else {
        result = false
    }
    return result
}

func checkStraightRight(_ y: Int, _ x: Int, _ currentNumber: Int) -> Bool {
    var result = true
    if adjMatrix[y][x] == currentNumber &&
        adjMatrix[y][x+1] == currentNumber &&
        adjMatrix[y][x+2] == currentNumber &&
        adjMatrix[y][x+3] == currentNumber &&
        adjMatrix[y][x+4] == currentNumber {
        if x <= 13 {
            if adjMatrix[y][x+5] == currentNumber {
                result = false
            }
        }
        if x > 0 && x <= 14 {
            if adjMatrix[y][x-1] == currentNumber {
                result = false
            }
        }
    } else {
        result = false
    }
    return result
}

var location: [(Int, Int)] = []
for i in 0..<19 {
    for j in 0..<19 {
        if adjMatrix[i][j] == 0 { continue }
        if j <= 14 {
            if checkStraightRight(i, j, 1) { location.append((i,j)) }
            if checkStraightRight(i, j, 2) { location.append((i,j)) }
        }
        if i <= 14 {
            if checkStraightBottom(i, j, 1) { location.append((i,j)) }
            if checkStraightBottom(i, j, 2) { location.append((i,j)) }
        }
        if i <= 14 && j <= 14 {
            if checkStraightDiagonal(i, j, 1) { location.append((i,j)) }
            if checkStraightDiagonal(i, j, 2) { location.append((i,j)) }
        }
        if i >= 4 && j <= 14 {
            if checkOtherSideDiagonal(i,j,1) { location.append((i,j)) }
            if checkOtherSideDiagonal(i,j,2) { location.append((i,j)) }
        }
    }
}
if location.isEmpty {
    print(0)
} else {
    if adjMatrix[location[0].0][location[0].1] == 1 {
        print(1)
    } else {
        print(2)
    }
    print(location[0].0 + 1, location[0].1 + 1)
}

