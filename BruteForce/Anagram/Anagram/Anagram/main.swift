//
//  main.swift
//  Anagram
//
//  Created by Kay on 2023/09/14.
//

/*
 6443
 애너그램
 */

import Foundation

var num = Int(readLine()!)!



while num > 0 {
    let tempStrArr = readLine()!.map { String($0) }.sorted()
    let count = tempStrArr.count
    var mySet = Set<String>()
    var visited = [Bool](repeating: false, count: count)
    
    func getAnagram(_ current: String, _ idx: Int, _ weighted: Int) {
        if weighted == count {
            if mySet.contains(current) {
                return
            }
            print(current)
            mySet.insert(current)
            return
        }
        for i in idx..<count {
            if visited[i] { continue }
            visited[i] = true
            getAnagram(current + String(tempStrArr[i]), i, weighted + 1)
            visited[i] = false
        }
    }

    getAnagram("", 0, 0)
    num -= 1
}



