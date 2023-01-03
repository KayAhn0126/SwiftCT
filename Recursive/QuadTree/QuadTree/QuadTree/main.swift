//
//  main.swift
//  QuadTree
//
//  Created by Kay on 2023/01/03.
//

/*
 1992
 쿼드트리
 */
// 2nd week fast-campus

import Foundation

let N = Int(readLine()!)!
var arrMatrix = [[String]]()

for _ in 0..<N {
    arrMatrix.append(readLine()!.map { String($0) })
}

func quad(_ y: Int, _ x: Int, _ size: Int) -> String {
    let currentLetter = arrMatrix[y][x]
    if size == 1 { return currentLetter }
    var result = ""
    for i in y..<y+size {
        for j in x..<x+size {
            if currentLetter != arrMatrix[i][j] {
                result += "("
                result += quad(y, x, size/2)
                result += quad(y, x+size/2, size/2)
                result += quad(y+size/2, x, size/2)
                result += quad(y+size/2, x+size/2, size/2)
                result += ")"
                return result
            }
        }
    }
    return currentLetter
}

print(quad(0,0,N))
