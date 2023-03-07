# 17142 연구소 3

## 🍎 문제 접근
- 주어진 조건
    - 바이러스가 비활성화 된 곳을 가면 활성화가 된다.
    - 활성화 시킬 수 있는 바이러스의 갯수가 주어진다.

## 🍎 연구소 2번과 다른점
- 연구소2 문제에서는 조합으로 선택하지 않은 바이러스는 0으로 바꿔서 바이러스를 퍼뜨리면 되었다.
- 하지만 연구소3 문제는 바이러스가 활성화, 비 활성화 상태로 나뉘고, **활성화 바이러스가 비 활성화 바이러스에게 가면 비 활성화 바이러스는 활성화 바이러스로 바뀌는데, 이때!, 비 활성화 바이러스가 활성화 바이러스로 바뀌는것은 시간계산에 포함시키지 않는다.**
- 연구소3 문제 예제 7번을 보면 위의 설명을 쉽게 알 수 있다.
```bash
예제입력
5 1
2 2 2 1 1
2 1 1 1 1
2 1 1 1 1
2 1 1 1 1
2 2 2 1 1

예제 출력
0
```
- 5x5칸에 1개를 활성화 하고 바이러스를 퍼뜨릴것이다.
- 한개를 제외한 나머지 2는 모두 비활성화 바이러스
- 카운트를 하지 않아서 답은 0초
- 즉, 0초만에 다 퍼뜨린다는 뜻이다.

## 🍎 문제 풀이
- 고려해야하는 상황
    - 맵에 0이 있는 경우
        - 바이러스를 다 퍼뜨리지 못하는 경우
    - result가 한번이라도 바뀐 경우
        - 윗단에서 최소값 비교 후 분기 처리
    - 맵에 0도 없고 result도 바뀌지 않아 0인경우
        - 이미 다 퍼진 경우라 0 출력

## 🍎 함수 설명
- makeNegativeTwo()
    - 바이러스 전체를 -2로 처리해 비활성화 시켜준다.
- bfs() -> Int
```swift
func bfs() -> Int {
    var result = 0
    while !queue.isEmpty {
        let currentYX = queue.dequeue()!
        let currentY = currentYX.0
        let currentX = currentYX.1
        for i in 0..<4 {
            let ny = currentY + dy[i]
            let nx = currentX + dx[i]
            if ny < 0 || nx < 0 || ny >= N || nx >= N { continue }
            if adjMatrix[ny][nx] == 1 || visited[ny][nx] > 0 { continue }
            // 비 활성화된 바이러스도 방문처리는 해주지만 카운트는 하지 않는다.
            visited[ny][nx] = visited[currentY][currentX] + 1
            queue.enqueue((ny,nx))
            // 오직 오리지널 0만 카운트 해주는 코드
            if adjMatrix[ny][nx] == 0 {
                // 최대값을 찾는 이유는 가장 큰 값이 결국 해당 맵을 채우기 위한 최단거리이기 때문이다.
                result = visited[ny][nx] > result ? visited[ny][nx] : result
            }
        }
    }
    let hasZero = checkZeroes()
    if hasZero == true { // 0이 있는 경우
        return 987654321
    } else if result != 0 { // 0은 없고 result가 바뀐경우
        return result
    } else {            // 0은 없고, result가 0인 경우
        return 0
    }
}
```
