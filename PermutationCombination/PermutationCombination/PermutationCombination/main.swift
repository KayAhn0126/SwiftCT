//
//  main.swift
//  PermutationCombination
//
//  Created by Kay on 2022/12/24.
//

/*
 
 순열 또는 조합이 어떻게 이뤄지는지 알고 싶을때는
 
 바킹독 - 백트래킹 강의에서 본 상태 공간 트리를 만들어보자
 
 */
import Foundation

// MARK: - Permutation Stack
var arr1: [Int] = [1,2,3,4,5]
var finalArr1 = permutationWithStack(arr1, 3)
finalArr1.enumerated().forEach {
    print($0.element)
}
print("")



// MARK: - Permutation Recursive
var arr2: [Int] = [1,2,3,4,5]
var finalArr2 = permutationWithRecursive(arr2, 3)
finalArr2.enumerated().forEach {
    print($0.element)
}
print("")




// MARK: - Combination Stack
var arr3 = [1,2,3,4,5]

var resultArr3 = combinationWithStack(arr3, 3)
resultArr3.enumerated().forEach {
    print($0.element)
}
print("")



// MARK: - Combination Recursive
var arr4 = [1,2,3,4,5]

var resultArr4 = combinationWithRecursive(arr4, 3)
resultArr4.enumerated().forEach {
    print($0.element)
}
print("")
