//
//  main.swift
//  PermutationCombination
//
//  Created by Kay on 2022/12/24.
//

import Foundation

// MARK: - Permutation 분석 (Stack)
func permutation<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result } // 같을때는 가능

    var stack: [([T], [Bool])] = array.enumerated().map {
        var visited = Array(repeating: false, count: array.count)
        visited[$0.offset] = true
        return ([$0.element], visited) // [([1], [true, false, false]), ([2], [false, true, false]), ([3], [false, false, true])]
    }
    print(stack)
    while stack.count > 0 {
        let now = stack.removeLast()

        let elements = now.0
        var visited = now.1

        if elements.count == n {
            result.append(elements)
            continue
        }

        for i in 0...array.count-1 {
            if visited[i] { continue }
            visited[i] = true
            stack.append((elements + [array[i]], visited))
            visited[i] = false
        }
    }

    return result
}


//// MARK: - permutation test
//var arr: [Int] = [1,2,3]
//var finalArr = permutation(arr, 3)
//finalArr.enumerated().forEach {
//    print($0.element)
//}

// MARK: - Permutation 재귀
func permutationWithRecursive<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    var visited = Array(repeating: false, count: array.count)
    
    func cycle(_ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }
        
        for i in 0..<array.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + [array[i]])
                visited[i] = false
            }
        }
    }
    
    cycle([])
    
    return result
}
var test: [Int] = [1,2,3]
var resultArr = permutationWithRecursive(test, 3)
resultArr.enumerated().forEach {
    print($0.element)
}
// 1
// 1, 2
// 1, 2, 3 (O)
// 1, 3
// 1, 3, 2 (O)
// 2
// 2, 1
// 2, 1, 3 (O)
// 2, 3
// 2, 3, 1 (O)
// 3
// 3, 1
// 3, 1, 2 (O)
// 3, 2
// 3, 2, 1 (O)
print("")

// MARK: - combination using stack
func combination<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    var stack = array.enumerated().map { ([$0.element], $0.offset) }

    while stack.count > 0 {
        let now = stack.removeLast()

        let elements = now.0
        let index = now.1

        if elements.count == n {
            result.append(elements.sorted())
            continue
        }

        guard index+1 <= array.count-1 else { continue }

        for i in index+1...array.count-1 {
            stack.append((elements + [array[i]], i))
        }
    }
    return result
}

// MARK: - combination 재귀
func combinationWithRecursive<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    if array.count < n { return result }

    func cycle(_ index: Int, _ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }

        for i in index..<array.count {
            cycle(i + 1, now + [array[i]])
        }
    }

    cycle(0,[])

    return result
}

var combinationArr = [1,2,3,4,5]

var combiResultArr = combinationWithRecursive(combinationArr, 3)
combiResultArr.enumerated().forEach {
    print($0.element)
}
