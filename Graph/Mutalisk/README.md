# 12869 뮤탈리스크

## 🍎 키워드
- 순열
- bfs
- 범위 주의

## 🍎 문제 이해하기
### 📖 지문
- 뮤탈은 1마리
- SCV 1 ~ 3마리
- 어떤 SCV가 첫 공격을 맞을지 모른다. 9,3,1로 **순열 만들기**
- 1마리가 주어진다면 num 0 0
- 2마리가 주어진다면 num num 0
- 3마리가 주어진다면 num num num

### 📖 시작부터 고민한 점
- scv의 마릿수가 정해지는데 마리 수에 따른 로직을 각각 구현해야하나? 생각했는데 만약 1마리만 주어진다면 2,3번의 체력은 0이라고 가정하고 문제를 풀자 생각했다.

## 🍎 문제 풀이
### 📖 필요한 변수 및 배열
- 방문 여부를 담을 3차원 배열 생성
- 3개의 정수를 담을 구조체 생성
- 순열이 들어있는 배열 생성

### 📖 로직
```swift
while !bfsQueue.isEmpty {
    let HP = bfsQueue.dequeue()
    let first = HP!.first
    let second = HP!.second
    let third = HP!.third
    if first == 0 && second == 0 && third == 0 {
        break
    }
    for i in 0..<givenAfterPermutation.count {
        let nFirst = max(0, first - givenAfterPermutation[i][0])
        let nSecond = max(0, second - givenAfterPermutation[i][1])
        let nThird = max(0, third - givenAfterPermutation[i][2])
        if visited[nFirst][nSecond][nThird] != 0 { continue }
        visited[nFirst][nSecond][nThird] = visited[first][second][third] + 1
        bfsQueue.enqueue(scvHp(first: nFirst, second: nSecond, third: nThird))
    }
}
```
- 체력이 음수로 갈수 없으니 계산한 값이 음수라면 0으로 만든다.
- 그리고 dequeue했을때 셋 다 0이라면 visited 배열에서 해당 최단거리 - 1 을 출력하면 끝.
