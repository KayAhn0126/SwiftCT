//
//  main.swift
//  GlobalWarming
//
//  Created by Kay on 2023/10/08.
//

/*
 5215
 지구 온난화
 */

// MARK: - 이런 문제는 주어지는 맵을 마지막까지 건들지 않는것이 좋다.

import Foundation

let rowcol = readLine()!.split(separator: " ").map { Int(String($0))! }
let row = rowcol[0]
let col = rowcol[1]

var currentMap = [[Character]](repeating: [Character](), count: row)
for i in 0..<row {
    currentMap[i].append(contentsOf: readLine()!)
}

let topAndBottomSea = [Character](repeating: ".", count: col + 2) // 위, 아래 바다 만들기

// MARK: - 주어진 맵 주변으로 바다 생성.
currentMap.insert(topAndBottomSea, at: 0)
for i in 1...row {
    currentMap[i].insert(".", at: 0)
    currentMap[i].insert(".", at: col + 1)
}
currentMap.insert(topAndBottomSea, at: row + 1)


var mapAfter50Years = currentMap

let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

func checkAround(_ y: Int, _ x: Int) -> Bool {
    var count = 0
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        if currentMap[ny][nx] == "." { count += 1 }
    }
    if count >= 3 { return true }
    return false
}

// MARK: - map을 만들고 X의 위치를 true로 변경
var checkChangesMap = [[Bool]](repeating: [Bool](repeating: false, count: col + 2), count: row + 2)
for i in 0..<row+2 {
    for j in 0..<col+2 {
        if currentMap[i][j] == "X" { checkChangesMap[i][j] = true }
    }
}

// MARK: - 현재 시점이 X이면서 3면 또는 4면이 바다인 경우 "X를 .으로 바꾸기 위한 플래그 올리기 작업"
// 실제로 여기서 수정하지 않음.
for i in 1...row {
    for j in 1...col {
        if currentMap[i][j] == "X" && checkAround(i,j) {
            checkChangesMap[i][j] = false
        }
    }
}

// MARK: - 전처리 과정을 마치고 여기서 수정
for i in 1...row {
    for j in 1...col {
        if currentMap[i][j] == "X" && checkChangesMap[i][j] == false {
            mapAfter50Years[i][j] = "."
        }
    }
}

// MARK: - 위에서 부터 몇개 자를지 구하기
var removedFromTopRowCount = 0
for i in 0..<row+2 {
    var rowDotCount = 0
    for j in 0..<col+2 {
        if mapAfter50Years[i][j] == "." { rowDotCount += 1 }
    }
    if rowDotCount == col + 2 { removedFromTopRowCount += 1 }
    else { break }
}

// MARK: - 아래서 부터 몇개 자를지 구하기
var removedFromBottomRowCount = 0
for i in stride(from: row + 1, through: 0, by: -1) {
    var rowDotCount = 0
    for j in 0..<col+2 {
        if mapAfter50Years[i][j] == "." { rowDotCount += 1 }
    }
    if rowDotCount == col + 2 { removedFromBottomRowCount += 1 }
    else { break }
}

// MARK: - 앞에서 부터 몇개 자를지 구하기
var removedFromStartColCount = 0
for i in 0..<col + 2 {
    var colDotCount = 0
    for j in 0..<row + 2 {
        if mapAfter50Years[j][i] == "." { colDotCount += 1 }
    }
    if colDotCount == row + 2 { removedFromStartColCount += 1 }
    else { break }
}

// MARK: - 뒤에서 부터 몇개 자를지 구하기
var removedFromEndColCount = 0
for i in stride(from: col+1, through: 0, by: -1) {
    var colDotCount = 0
    for j in 0..<row + 2 {
        if mapAfter50Years[j][i] == "." { colDotCount += 1 }
    }
    if colDotCount == row + 2 { removedFromEndColCount += 1 }
    else { break }
}


// MARK: - 마지막으로 부분 자르기
var finalMap = [[Character]]()

for i in removedFromTopRowCount..<row + 2 - removedFromBottomRowCount {
    let valid = Array(mapAfter50Years[i][removedFromStartColCount..<col+2-removedFromEndColCount])
    finalMap.append(valid)
}

// MARK: - 로직이 잘 적용되었는지 확인하기
finalMap.enumerated().forEach {
    print(String($0.element))
}

