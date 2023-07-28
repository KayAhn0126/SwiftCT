//
//  main.swift
//  CuttingPaper
//
//  Created by Kay on 2023/07/27.
//

/*
 2628
 종이자르기
 */
import Foundation

let colRow = readLine()!.split(separator: " ").map { Int(String($0))! }
let userInput = Int(readLine()!)!
var r = [0,colRow[1]]
var c = [0,colRow[0]]
for i in 0..<userInput {
    let tempRCWhere = readLine()!.split(separator: " ").map { Int(String($0))! }
    let tempRC = tempRCWhere[0]
    let tempWhere = tempRCWhere[1]
    if tempRC == 0 { // 가로로 자르는 경우
        r.append(tempWhere)
    } else {         // 세로로 자르는 경우
        c.append(tempWhere)
    }
}
r.sort()
c.sort()
var rowMax = Int.min
var colMax = Int.min

for i in 1..<r.count {
    let gap = r[i] - r[i-1]
    rowMax = rowMax < gap ? gap : rowMax
}
for i in 1..<c.count {
    let gap = c[i] - c[i-1]
    colMax = colMax < gap ? gap : colMax
}
print(rowMax * colMax)
