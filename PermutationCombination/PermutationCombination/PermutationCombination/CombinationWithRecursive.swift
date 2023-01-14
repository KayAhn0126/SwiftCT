//
//  CombinationWithRecursive.swift
//  PermutationCombination
//
//  Created by Kay on 2023/01/14.
//

import Foundation

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
