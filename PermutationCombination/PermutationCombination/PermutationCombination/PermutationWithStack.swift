//
//  PermutationWithStack.swift
//  PermutationCombination
//
//  Created by Kay on 2023/01/14.
//

import Foundation

// MARK: - Permutation Stack
func permutationWithStack<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
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
