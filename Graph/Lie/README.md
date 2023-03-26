# 1043 거짓말
- 구현
- 인접리스트

## 🍎 문제 접근
- 진실을 아는 사람들을 "떠벌이"큐에 넣는다.
    - 나중에 이 큐에 있는 사람들이 만나는 사람들을 visited 배열에서 방문처리 해줄것이다.
    - 방문처리 되었다는 뜻은 진실을 아는 사람 또는 진실을 들은 사람이다.
- 모든 전처리가 끝나면 처음에 파티에 오는 사람의 숫자와 누가 오는지 입력받은 2차원 배열을 돌면서 방문처리가 되어있는 사람이 있는 파티는 제외하면서 카운팅하면 된다.

## 🍎 문제 풀이
```swift
import Foundation

let NM = readLine()!.split(separator: " ").map { Int(String($0))! }
let N = NM[0] // 사람의 수
let M = NM[1] // party 수

// 진실을 아는 사람들을 "떠벌이" 큐에 넣는다."
// "떠벌이" 큐에 들어가면 이 리스트에 있는 사람들과 접촉하는 모든 사람들을 true로 만든다
// 모든 파티를 돌면서 true인 사람이 하나라도 있다면 그 파티는 카운트하지 않는다.

//MARK: 진실을 알고 있는 사람의 숫자와 누구누구가 알고 있는지 주어진다.
let truthAndCount = readLine()!.split(separator: " ").map { Int(String($0))! }
var queue = [Int](), idx = 0
var truth = truthAndCount[0]

//MARK: 진실을 알고 있는 사람이 아무도 없다면 지민이는 모든 파티에 갈 수 있다.
if truth == 0 {
    print(M)
} else {
    //MARK: finalCheckArr는 각 파티 정보를 저장해 두었다가 나중에 지민이가 진실을 아는 사람들을 걸러내는 용도!
    var finalCheckArr = [[Int]](repeating: [Int](), count: M)
    var visited = [Bool](repeating: false, count: N + 1)
    var adjList = [[Int]](repeating: [Int](), count: N + 1)

    //진실을 알고 있는 사람들을 큐에 넣어준다.
    for i in 1..<truthAndCount.count {
        queue.append(truthAndCount[i])
        visited[truthAndCount[i]] = true
    }

    // 파티에 누가 오는지 입력받고 인접리스트를 활용해 접촉자 연관 짓기
    // 처음에 연관이 없더라도 나중에 다른 파티에서 연관이 된다.
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

    //MARK: 진실을 알고 있는 사람이 자신과 만난 사람에게 진실 퍼뜨리기
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in 0..<adjList[current].count {
            if visited[adjList[current][i]] == false {
                visited[adjList[current][i]] = true
                queue.append(adjList[current][i])
            }
        }
    }

    //MARK: 지민이가 파티 정보를 보고 진실이 있는 사람이 한명이라도 있으면 해당 파티를 가지 않는 로직.
    // 반대로 한명도 없다면 그 파티는 카운트한다.
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
```
