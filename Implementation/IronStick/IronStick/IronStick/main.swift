//
//  main.swift
//  IronStick
//
//  Created by Kay on 2023/08/11.
//

/*
 10799
 쇠막대기
 */

//import Foundation
//
//struct Stack<T> {
//    var elements: [T] = []
//    var count: Int {
//        return elements.count
//    }
//
//    var isEmpty: Bool {
//        return elements.isEmpty
//    }
//
//    var top: T? {
//        return elements.last
//    }
//
//    mutating func push(_ element: T) {
//        elements.append(element)
//    }
//    mutating func pop() -> T? {
//        return elements.popLast()
//    }
//}
//
//var str = readLine()!
//var myStack = Stack<Character>()
//
//var result = 0
//var laserFlag = false
//var arr = [Int]()
//for i in str {
//    if i == "(" {
//        arr.append(0)
//        myStack.push("(")
//        laserFlag = true
//    } else if laserFlag && !myStack.isEmpty && myStack.top! == "(" && i == ")" {
//        arr.popLast()!
//        for j in 0..<arr.count {
//            arr[j] += 1
//        }
//        myStack.pop()!
//        laserFlag = false
//    } else if !laserFlag && !myStack.isEmpty && myStack.top! == "(" && i == ")" {
//        result += arr.popLast()! + 1
//        myStack.pop()!
//    }
//}
//print(result)

// 위의 코드는 잘 작동하지만 66%에서 시간초과를 맞았다.
// 실패 요인 -> 로직을 처음에 제대로 못 세웠다. 즉, 흘러가는대로 로직을 생각하다보니 arr.count만큼 반복하는 로직(최대 10만 * 10만까지 연산하는..)이 만들어짐. -> 시간초과.

// 이에 대한 해결 방법을 찾아봤다. 레이저는 괄호가 연속적으로 열고 닫힌 -> () 것이라는 점을 활용.
// 1. ()을 치환 해주기.
// 2. 치환하지 않고 풀어주기

// 1. ()을 치환 해주기.
//import Foundation
//var str = readLine()!
//str = str.replacingOccurrences(of: "()", with: "*")
//var stackCount = 0
//var result = 0
//for i in str {
//    if i == "(" {
//        stackCount += 1
//    } else {
//        if i == ")" {
//            stackCount -= 1
//            result += 1
//        } else { // *이라면
//            result += stackCount
//        }
//    }
//}
//print(result)

// 2. () <- 레이저를 다른 모양으로 치환하지 않고 풀기
import Foundation
let str = readLine()!
var stackCount = 0 // 현재 몇개의 막대기가 있는지
var result = 0
var strArr = Array(str)
for i in 0..<str.count {
    if strArr[i] == "(" {
        stackCount += 1
    } else {
        stackCount -= 1
        if strArr[i-1] == "(" { // 직전이 ( 였고 현재 )라면 레이저다.
            result += stackCount
        } else { // 막대기를 하나 뺀다.
            result += 1
        }
    }
}
print(result)

