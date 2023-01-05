//
//  main.swift
//  ExamViewer
//
//  Created by Kay on 2023/01/05.
//

/*
 13458
 시험감독
 */

import Foundation

let N = Int(readLine()!)!

let testTaker = readLine()!.split(separator: " ").map { Int(String($0))! }
let BC = readLine()!.split(separator: " ").map { Int(String($0))! }

let B = BC[0]
let C = BC[1]

var counter = 0

for i in 0..<testTaker.count {
    doCal(testTaker[i])
}

func doCal(_ testTaker: Int) {
    if B >= testTaker {
        counter += 1
    } else {
        counter += 1
        let remainder = (testTaker - B) % C == 0 ? (testTaker-B)/C :(testTaker-B)/C + 1
        counter += remainder
    }
}
print(counter)

