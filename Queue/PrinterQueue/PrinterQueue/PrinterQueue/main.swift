//
//  main.swift
//  PrinterQueue
//
//  Created by Kay on 2023/03/05.
//

/*
 1966
 프린터 큐
 */

// 무엇이 가장 큰 값인지 알기 위해서는 기준이 필요하다.
// 받은 배열을 내림차순 정렬
// 정렬 후 현재 값이 기존 배열의 값과 맞으면 같이 popFront()
// popFront() 횟수를 구하면 답

import Foundation

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let docsCountFind = readLine()!.split(separator: " ").map { Int(String($0))! }
    
    var arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var sortedArr = arr.sorted(by: >)
    
    let number = arr[docsCountFind[1]]
    var index = docsCountFind[1] // 궁금한 숫자의 인덱스 (변화한다!)
    
    
    var counter = 1
    while true {
        if (index == 0) && sortedArr[0] == number {
            print(counter)
            break
        }
        // 앞 숫자와 앞 숫자가 맞으면 pop한다
        // counter도 늘려준다.
        if arr[0] == sortedArr[0] {
            arr.removeFirst()
            sortedArr.removeFirst()
            counter += 1
            index -= 1
        } else {
            arr.append(arr[0])
            arr.removeFirst()
            if index == 0 {
                index = arr.count - 1
            } else {
                index -= 1
            }
        }
    }
}



