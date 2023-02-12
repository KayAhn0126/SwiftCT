//
//  main.swift
//  Tree
//
//  Created by Kay on 2023/02/12.
//

/*
 1068
 트리
 */

/*
 
 */
import Foundation
let number = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let deleteNum = Int(readLine()!)!

var dArr = [[Int]](repeating: [Int](), count: 51)
var visited = [Int](repeating: 0, count: number)

var root = -1
var result = 0

func dfs(_ number: Int) {
    visited[number] = 1
    if dArr[number].count == 0 {
        result += 1
    } else {
        for number in dArr[number] {
            if visited[number] == 1 {
                continue
            }
            dfs(number)
        }
    }
}

for i in 0..<arr.count {
    if arr[i] == -1 {
        root = i
    } else {
        if i == deleteNum {
            continue
        }
        dArr[arr[i]].append(i)
    }
}

if root == deleteNum {
    print(0)
} else {
    dfs(root)
    print(result)
}

// 40분
