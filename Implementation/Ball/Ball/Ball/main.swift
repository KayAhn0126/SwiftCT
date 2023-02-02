//
//  main.swift
//  Ball
//
//  Created by Kay on 2023/02/02.
//

/*
 1547
 공
 */

import Foundation

var arr = [1,2,3]

let userInput = Int(readLine()!)!

for i in 0..<userInput {
    let fromTo = readLine()!.split(separator: " ").map { Int(String($0))! }
    let from = fromTo[0]
    let to = fromTo[1]
    arr.enumerated().forEach {
        if $0.element == from {
            arr[$0.offset] = to
        } else if $0.element == to {
            arr[$0.offset] = from
        }
    }
}
print(arr[0])


