//
//  main.swift
//  QuadTree
//
//  Created by Kay on 2023/02/07.
//

/*
 1992
 쿼드트리
 */
import Foundation

let N = Int(readLine()!)!

var matrix = [[Character]](repeating: [Character](), count: N)

for i in 0..<N {
    matrix[i].append(contentsOf: readLine()!)
}


func calculate(_ y: Int, _ x: Int, _ size: Int) -> String {
    let current = matrix[y][x]
    if size == 1 {
        return String(current)
    }
    var result = ""
    for i in y..<y+size {
        for j in x..<x+size {
            if matrix[i][j] != current {
                result += "("
                result += calculate(y, x, size/2)
                result += calculate(y, x + size/2, size/2)
                result += calculate(y + size/2, x, size/2)
                result += calculate(y + size/2, x + size/2, size/2)
                result += ")"
                return result
            }
        }
    }
    return String(current)
}

print(calculate(0,0,N))

