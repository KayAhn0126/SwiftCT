//
//  main.swift
//  CompleteBinaryTree
//
//  Created by Kay on 2023/03/31.
//

/*
 9934
 완전 이진 트리
 */

import Foundation

let N = Int(readLine()!)!
var arr = readLine()!.split(separator: " ").map { Int(String($0))! }

let mid = arr.count / 2
//depth를 들어가서 mid를 출력하면된다.

var result = [[Int]](repeating: [Int](), count: N + 1)

func go(_ from: Int, _ to: Int, _ depth: Int) {
    if depth == N + 1 {
        return
    }
    let mid = (from + to) / 2
    result[depth].append(arr[mid])
    go(from, mid-1, depth + 1)
    go(mid+1, to, depth + 1)
}
go(0, arr.count-1, 1)

for i in 1...N {
    for j in 0..<result[i].count {
        print(result[i][j], terminator: " ")
    }
    print("")
}
