import Foundation

let peopleParty = readLine()!.split(separator: " ").map { Int(String($0))! }
let peopleCount = peopleParty[0] // 총 인원 수
let partyCount = peopleParty[1] // 총 파티 수

// 추후 누가누가 알고 있는지 체크하기 위한 visited 배열
var visited = [Bool](repeating: false, count: peopleCount + 1)
var queue = [Int](), idx = 0

// 누가누가 알고있나?
let knows = readLine()!.split(separator: " ").map { Int(String($0))! }
// 총 몇명이 지민이의 거짓말을 알고 있나?
let howMany = knows[0]
// 알고있는 사람 체크 해주기
for i in 1..<knows.count {
    visited[knows[i]] = true
    queue.append(knows[i])
}

// 전체 파티 리스트
var partyList = [[Int]](repeating: [Int](), count: partyCount)
// 모든 파티 정보 넣기
for i in 0..<partyCount {
    partyList[i].append(contentsOf: readLine()!.split(separator: " ").map { Int(String($0))! })
}

//MARK: 인접리스트 만들고 한번이라도 만난 친구들 넣어주기
var adjList = [[Int]](repeating: [Int](), count: peopleCount + 1)
for partyInfo in partyList {
    for i in 1..<partyInfo.count {
        for j in 1..<partyInfo.count {
            if i == j { continue }
            if adjList[partyInfo[i]].contains(partyInfo[j]) ==  true { continue }
            adjList[partyInfo[i]].append(partyInfo[j])
        }
    }
}



func bfs() {
    while idx < queue.count {
        let current = queue[idx]; idx += 1
        for i in adjList[current] {
            if visited[i] == true { continue }
            visited[i] = true
            queue.append(i)
        }
    }
}

bfs()

var result = 0
if howMany == 0 {
    print(partyCount)
} else {
    for party in partyList {
        var flag = false
        for person in 1..<party.count {
            if visited[party[person]] == true { flag = true }
        }
        if flag == false {
            result += 1
        }
    }
    print(result)
}
