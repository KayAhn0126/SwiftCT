//
//  main.swift
//  PutDownCard
//
//  Created by Kay on 2023/04/06.
//

/*
 5568
 카드 놓기
 */

import Foundation

func combination<T>(_ arr: [T], _ num: Int) -> [[T]] {
    var result: [[T]] = []
    if num > arr.count { return result }
    
    func cycle(_ now: [T], _ index: Int) {
        if now.count == num {
            result.append(now)
            return
        }
        for i in index..<arr.count {
            cycle(now + [arr[i]], i + 1)
        }
    }
    cycle([],0)
    return result
}

func permutationWithRecursive<T: Comparable>(_ array: [T], _ n: Int) -> Set<String> {
    var result = Set<String>()
    if array.count < n { return result }

    var visited = Array(repeating: false, count: array.count)
    
    func cycle(_ now: String, _ depth: Int) {
        if depth == n {
            result.insert(now)
            return
        }
        
        for i in 0..<array.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + String("\(array[i])"), depth + 1)
                visited[i] = false
            }
        }
    }
    cycle("", 0)
    return result
}

var from = Int(readLine()!)!
var pick = Int(readLine()!)!

var arr = [Int]()
for i in 0..<from {
    arr.append(Int(readLine()!)!)
}

var result = permutationWithRecursive(arr, pick)
print(result.count)
