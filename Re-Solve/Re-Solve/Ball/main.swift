//
//  main.swift
//  Ball
//
//  Created by Kay on 2023/03/17.
//

/*
 1547
 공
 */
import Foundation

var number = Int(readLine()!)!

var arr: [Int] = [1,2,3]

for i in 0..<number {
    let userInput = readLine()!.split(separator:  " ").map { Int(String($0))! }
    let from = userInput[0]
    let to = userInput[1]
    arr.enumerated().forEach {
        if $0.element == from {
            arr[$0.offset] = to
        } else if $0.element == to {
            arr[$0.offset] = from
        }
    }
}
print(arr[0])

