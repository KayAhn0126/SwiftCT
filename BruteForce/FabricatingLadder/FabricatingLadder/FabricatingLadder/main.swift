//
//  main.swift
//  FabricatingLadder
//
//  Created by Kay on 2023/03/31.
//

/*
 15684
 사다리 조작
 */

/*
 처음에 생각했던 방식.
 
 시간 복잡도
 300 C 3 = 4500000
 (300 * 299 * 298) / (3 * 2)

 - 최소값을 구하는 문제. result = 99999999으로 놓는다.

 3차원 배열을 사용한 간선 저장하기
    - adjMatrix[level][from][to]
    - 만약 1레벨에서 1과 2가 연결되어 있으면 아래와 같이 양방향 간선 연결
    - adjMatrix[1][1][2] = true
    - adjMatrix[1][2][1] = true
 
 1에서 시작하면 1로 끝나는지 확인하는 함수.
 N만큼 반복한다. 큰 그림에서 체크 function이다.
 시작점에서 부터 1 level ~ N레벨까지.
    - 만약 현재 레벨에 나와 연결된 노드가 있다? -> 연결된 노드로 이동
    - 연결된 노드에서 이제 다음 레벨 체크,
    - 있다면 해당 노드로 이동, 없다면 다음 레벨로 이동 ~ 어디까지? M 까지
 
 놓을수 있는 모든 조합을 구한다. 3개까지. 그리고 놓을수 없는 곳들의 위치 찾기 벽이거나
 가로선 1개부터 추가한다.
 
 여기서 멈추었다.. 너무 복잡해서.. 큰돌님의 코드를 보았다.
 */



/*
 큰돌님 방식.
 (C++을 스위프트로 그대로 변환. 코드가 로직만 딱 가지고 있어 너무 깔끔해 로직을 그대로 옮겨왔다.)
 큰돌님은 내가 3차원 배열로 구현하려던 것을 2차원 배열로 구현했다.
 이렇게 구현하는것이 엄청나게 어려운건 아닌데 문제를 풀 때, 계속 염두하고 풀어야해서 쉬운방법으로 가려고 3차원으로 구현하려 했는지도 모른다.. 3차원 배열은 웬만하면 쓰지말자.
 나는 adjMatrix[level][from][to] = 1 이런식으로 구현해서 특정 레벨에 어디서 부터 어디까지 연결 되어있다 라고 구현하려했다.
 큰돌님은 adjMatrix[level][from] = 1로 구현해 "해당 레벨의 from에서 오른쪽으로 한칸 연결되어있다"를 구현했다.
 
 go 함수를 보면
 
 문제를 풀고 느낀점 -> 백트래킹을 많이 연습 하자!
 */

import Foundation

func checkStartResultSame() -> Bool {
    for i in 1...N { // 세로줄
        var start = i
        for j in 1...Level { // 가로줄
            if visited[j][start] == 1 {
                start += 1
            } else if visited[j][start-1] == 1 {
                start -= 1
            }
        }
        if start != i {
            return false
        }
    }
    return true
}

let NMLevel = readLine()!.split(separator: " ").map { Int(String($0))! }

let N = NMLevel[0] // 세로
let M = NMLevel[1] // 간선의 갯수
let Level = NMLevel[2] // 가로줄

var result = Int.max
var visited = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)

for i in 0..<M {
    let levelAndFrom = readLine()!.split(separator: " ").map { Int(String($0))! }
    let level = levelAndFrom[0]
    let from = levelAndFrom[1]
    visited[level][from] = 1
}

func go(_ here: Int, _ count: Int) {
    if count > 3 || count >= result { return }
    if checkStartResultSame() == true {
        result = min(result, count)
        return
    }
    for i in here...Level {
        for j in 1...N {
            if visited[i][j] == 1 || visited[i][j-1] == 1 || visited[i][j+1] == 1 { continue }
            visited[i][j] = 1
            go(i, count + 1)
            visited[i][j] = 0
        }
    }
}

go(1,0)
if result == Int.max {
    result = -1
}
print(result)

/*
visited.enumerated().forEach {
    if $0.offset != 0 {
        print($0.element)
    }
}
*/
