//
//  main.swift
//  OperatorInsertion
//
//  Created by Kay on 2023/08/21.
//

import Foundation

// 메모리초과 코드.. 짐작되는건 순열의 총 갯수가 10! -> 360만개여서 그런것이 아닌가 생각이 든다.
//let N = Int(readLine()!)!
//let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
//let tempOperators = readLine()!.split(separator: " ").map { Int(String($0))! }
//
//var charArr = [Character]()
//for i in 0..<4 {
//    let currentCount = tempOperators[i]
//    if currentCount > 0 {
//        var currentChar: Character = " "
//        if i == 0 {
//            currentChar = "+"
//        } else if i == 1 {
//            currentChar = "-"
//        } else if i == 2 {
//            currentChar = "*"
//        } else if i == 3 {
//            currentChar = "/"
//        }
//        for _ in 0..<currentCount{
//            charArr.append(currentChar)
//        }
//    }
//}
//
//func permutation<T>(_ arr: [T], _ r: Int) -> [[T]] {
//    var result: [[T]] = []
//    if arr.count < r { return result }
//
//    var visited = [Bool](repeating: false, count: arr.count)
//
//    func cycle(_ now: [T]) {
//        if now.count == r {
//            result.append(now)
//            return
//        }
//        for i in 0..<arr.count {
//            if visited[i] { continue }
//            visited[i] = true
//            cycle(now + [arr[i]])
//            visited[i] = false
//        }
//    }
//    cycle([])
//    return result
//}
//
//var operatorsPermutation = permutation(charArr, charArr.count)
//
//func calculate(_ lhs: Int, _ oper: Character, _ rhs: Int) -> Int {
//    if oper == "+" { return lhs + rhs }
//    if oper == "-" { return lhs - rhs }
//    if oper == "*" { return lhs * rhs }
//    if oper == "/" { return lhs / rhs }
//    return 0
//}
//
//var max = Int.min
//var min = Int.max
//
//for permu in operatorsPermutation {
//    var result = calculate(arr[0], permu[0], arr[1])
//    for i in 1..<charArr.count {
//        result = calculate(result, permu[i], arr[i+1])
//    }
//    max = result > max ? result : max
//    min = result < min ? result : min
//}
//print(max)
//print(min)

let N = Int(readLine()!)!

let numArr = readLine()!.split(separator: " ").map { Int(String($0))! }
var charArr = readLine()!.split(separator: " ").map { Int(String($0))! }

var min = Int.max
var max = Int.min

func dfs(_ depth: Int, _ result: Int) {
    if depth == N {
        min = result < min ? result : min
        max = result > max ? result : max
        return
    }
    
    for i in 0..<4 {
        var localResult = result
        if charArr[i] > 0 {
            charArr[i] -= 1
            if i == 0 {        // +
                localResult += numArr[depth]
            } else if i == 1 { // -
                localResult -= numArr[depth]
            } else if i == 2 { // *
                localResult *= numArr[depth]
            } else if i == 3 { // /
                localResult /= numArr[depth]
            }
            dfs(depth + 1, localResult)
            charArr[i] += 1
        }
    }
}

dfs(1, numArr[0])
print(max)
print(min)

