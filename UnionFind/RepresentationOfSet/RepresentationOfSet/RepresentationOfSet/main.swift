//
//  main.swift
//  RepresentationOfSet
//
//  Created by Kay on 2023/04/03.
//

/*
 1717
 집합의 표현
 */

import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0]
let M = NM[1]

var parent = [Int](repeating: 0, count: N + 1)
for i in 1...N {
    parent[i] = i
}

func find_parent(_ x: Int) -> Int {
   if parent[x] != x {
       parent[x] = find_parent(parent[x])
   }
    return parent[x]
}

func union_parent(_ a: Int, _ b: Int) {
   let a = find_parent(a)
   let b = find_parent(b)

   if a < b {
       parent[b] = a
   } else {
       parent[a] = b
   }
}

for i in 0..<M {
    let operAB = readLine()!.split(separator: " ").map { Int(String($0))! }
    let oper = operAB[0]
    let a = operAB[1]
    let b = operAB[2]
    if oper == 0 {
        union_parent(a,b)
    } else {
        if find_parent(a) == find_parent(b) {
            print("YES")
        } else {
            print("NO")
        }
    }
}
