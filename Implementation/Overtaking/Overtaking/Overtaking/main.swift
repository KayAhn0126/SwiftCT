//
//  main.swift
//  Overtaking
//
//  Created by Kay on 2023/10/24.
//

/*
 2002
 추월
 */

import Foundation

let N = Int(readLine()!)!
var inOrderDictionary = [String: Int]()
var outOrderArr = [String]()
var count = 0

for i in 0..<N {
    let plate = readLine()!
    inOrderDictionary[plate] = i
}

for _ in 0..<N {
    let plate = readLine()!
    outOrderArr.append(plate)
}

for i in 0..<N-1 {
    for j in i+1..<N {
        if inOrderDictionary[outOrderArr[i]]! > inOrderDictionary[outOrderArr[j]]! {
            count += 1
            break
        }
    }
}
print(count)
