//
//  main.swift
//  Lie
//
//  Created by Kay on 2023/03/24.
//

/*
 1043
 거짓말
 */

/*
 접근 방법
 큐에 넣는 방식
 
 [1][5]
 [2][6]
 [3][10]
 [4]
 [7][8]
 [8][7]
 [9]
 [10]
 
 
 */


import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 사람의 수
let M = NM[1] // party 수




// 기본적으로 주어진 "진실을 아는 사람들을 큐에 넣어서 (입 단속 리스트)에 넣는다."
// 방지 리스트에 들어가면 이 리스트에 있는 사람들과 접촉하는 모든 사람들을 true로 만든다
// 모든 파티를 돌면서 true인 사람이 하나라도 있다면 그 파티는 카운트하지 않는다.

let truthAndCount = readLine()!.split(separator: " ").map { Int(String($0))! }
var queue = [Int](), idx = 0
var truth = truthAndCount[0]

// 진실을 알고 있는 사람이 아무도 없다면 지민이는 모든 파티에 갈 수 있다.
if truth == 0 {
    print(M)
} else {
    var finalCheckArr = [[Int]](repeating: [Int](), count: M)
    var visited = [Bool](repeating: false, count: N + 1)
    var adjList = [[Int]](repeating: [Int](), count: N + 1)

    //진실을 알고 있는 사람들을 큐에 넣어준다. 이 큐는
    for i in 1..<truthAndCount.count {
        queue.append(truthAndCount[i])
        visited[truthAndCount[i]] = true
    }

    // 파티에 누가 오는지 입력받고 인접리스트를 활용해 접촉자 연관 짓기
    // 처음에 연관이 없더라도 나중 파티에서 연관이 된다.
    for i in 0..<M {
        let howManyPeopleAndWho = readLine()!.split(separator: " ").map { Int(String($0))! }
        let howManyPeople = howManyPeopleAndWho[0] // 몇명 오는지
        finalCheckArr[i].append(contentsOf: howManyPeopleAndWho[1..<howManyPeopleAndWho.count])
        for j in 1..<howManyPeopleAndWho.count {
            for k in 1..<howManyPeopleAndWho.count {
                if adjList[howManyPeopleAndWho[j]].contains(howManyPeopleAndWho[k]) { continue }
                if howManyPeopleAndWho[j] == howManyPeopleAndWho[k] { continue }
                adjList[howManyPeopleAndWho[j]].append(howManyPeopleAndWho[k])
            }
        }
    }

    // 진실을 알고 있는 사람이 자신과 만난 사람에게 진실 퍼뜨리기
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in 0..<adjList[current].count {
            if visited[adjList[current][i]] == false {
                visited[adjList[current][i]] = true
                queue.append(adjList[current][i])
            }
        }
    }

    var result = 0
    for i in 0..<finalCheckArr.count {
        var flag = true
        for j in 0..<finalCheckArr[i].count {
            if visited[finalCheckArr[i][j]] == true {
                flag = false
            }
        }
        if flag == true {
            result += 1
        }
    }
    print(result)
}











