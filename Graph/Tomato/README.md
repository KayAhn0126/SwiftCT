# 7576 토마토

## 🍎 키워드
- bfs
- 최단거리
- 시작지점이 다수인 경우

## 🍎 문제 풀이
- 시작 지점이 하나 일수도 있고 여러개일수도 있다.
- 2차원 배열이니 이중 for문을 돌면서 요소가 만약 1이라면 bfsQueue에 넣는다.
- bfsQueue에 넣어진 위치에서 한번에 시작해 토마토가 익는데 걸리는 시간(최단거리)를 구한다.
- 마지막엔 요소 하나하나를 돌면서 익지 않은 토마토가 있는지 확인한다
    - 벽이 아니면서 visited가 0인 경우!
    - 이런 경우는 -1 출력!
- 아니라면 visited에서 최대값을 출력하면 토마토가 모두 익는데 걸리는 최소의 시간을 찾을 수 있다.
