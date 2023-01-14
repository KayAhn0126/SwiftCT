//
//  CombinationWithStack.swift
//  PermutationCombination
//
//  Created by Kay on 2023/01/14.
//

import Foundation

// MARK: - combination using stack
func combinationWithStack<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
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
