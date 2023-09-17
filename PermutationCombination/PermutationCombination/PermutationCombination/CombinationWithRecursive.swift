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

    func cycle(_ now: [T], _ index: Int) {
        if now.count == n {
            result.append(now)
            return
        }

        for i in index..<array.count {
            cycle(now + [array[i]], i + 1)
        }
    }
    cycle([], 0)

    return result
}

/*

 백트래킹으로 조합 만드는 순서
 var arr4 = [1,2,3,4,5]
 
 for i in index..<array.count {
     cycle(now + [array[i]], i + 1)
 }
 
 0 in index..<array.count {
    cycle([1], 1)
 }
 
 1 in index..<array.count {
    cycle([1,2], 2)
 }
 
 2 in index..<array.count {
    cycle([1,2,3], 3) -> return
 }
 
 2 in index..<array.count {
    cycle([1,2,4], 3) -> return
 }
 
 2 in index..<array.count {
    cycle([1,2,5], 3) -> return
 }
 
 1 in index..<array.count {
    cycle([1,3], 2)
 }
 
 2 in index..<array.count {
    cycle([1,3,4], 3) -> return
 }
 
 */


/*
 
 추가!
 
 위의 코드에서 21번에서 23번 라인을 보면 아래와 같은 코드를 볼 수 있다.

 for i in index..<array.count {
     cycle(i + 1, now + [array[i]])
 }
 
 위의 코드를 더 정확히 알고자 상태 공간 트리를 만들어 보았다.
 
 그랬더니 이전에 14502 (연구소) 문제를 풀 때 사용했던 3중 for문 유형의 코드를 볼 수 있었다.
 
 i가 0일때부터 시작해 상태 공간 트리를 만들어보자!
 
 메인 로직 원형
 
 for i in index..<array.count {
    cycle(i + 1, now + array[i])
 }
 
 이것은
 
 for 0 in index..<array.count {
    cycle(1, now + array[0])
 }
 
 이 되고 저 안에서 불린 재귀 함수는 아래와 같이 표현 할 수 있다.
 
 for 1 in index..<array.count {
    cycle(2, now + array[1])
 }
 


 결국엔 이것이 내부로 파고들면 중첩 for문과 같고, 다만 다른점은 아래와 같다.
 14502 연구소 문제를 풀 때는 3개의 벽을 조합으로 세웠어야 하므로 아래와 같이 3개의 for문을 사용해 쉽게 구현 할 수 있었으나 만약 8개의 요소를 조합해야하는 상황이 생긴다면 8중 for 문을 사용할 수는 없다.
 
 // MARK: - 3 개의 벽 세우고 바이러스 뿌리기
 func buildRandomWallAndCheck() {
     let currentlyZeroCount = wallPossibleListFromGiven.count
     for i in 0..<currentlyZeroCount {
         for j in i + 1 ..< currentlyZeroCount {
             for k in j + 1 ..< currentlyZeroCount {
                 adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 1
                 adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 1
                 adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 1
                 let result = afterSpreadVirusCheckWhichIsAvailable()
                 biggestNumber = result > biggestNumber ? result : biggestNumber
                 adjMatrix[wallPossibleListFromGiven[i].0][wallPossibleListFromGiven[i].1] = 0
                 adjMatrix[wallPossibleListFromGiven[j].0][wallPossibleListFromGiven[j].1] = 0
                 adjMatrix[wallPossibleListFromGiven[k].0][wallPossibleListFromGiven[k].1] = 0
             }
         }
     }
 }
 
 하지만 CombinationWithRecursive에서 정의된 함수 + 매개변수를 적절하게 사용한다면 유연한 함수를 만들 수 있다.
 
 */
