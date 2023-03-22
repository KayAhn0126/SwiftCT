//
//  main.swift
//  ATM
//
//  Created by Kay on 2023/03/22.
//

/*
 11399
 ATM
 */

import Foundation

let N = Int(readLine()!)!

var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
var result = 0
var adder = 0
arr.enumerated().sorted(by: {
    return $0.element < $1.element
}).forEach {
    adder += $0.element
    result += adder
}
print(result)


