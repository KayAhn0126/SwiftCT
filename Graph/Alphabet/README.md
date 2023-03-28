# 1987 알파벳
- 백트래킹
- 비트마스킹

## 🍎 문제 접근
- 컴백홈 문제처럼 방문 배열과 계수 정렬 배열을 동시에 백트래킹을 하면 될줄 알았다.
- 로직엔 문제 없는것 같은데 **시간초과**.
- 질문게시판에서 wapas님이 "이미 지나간 알파벳을 계수 정렬 배열에서 방문 처리 해줬기 때문에 또 다른 방문배열은 필요없다"라고 했다.
- 또 시간을 줄이기 위해서 Bool 타입의 배열을 방문 배열로 사용하기 보다 비트마스킹을 사용하는게 메모리, 시간적으로 더 효율적이다.

## 🍎 문제 풀이
- 메인 로직
```swift
let dy = [-1,0,1,0]
let dx = [0,1,0,-1]

// 먼저 방문 배열을 대신할 숫자를 만들어준다.
var visitedNumber: Int = (1 << 26)

// 만들어준 배열에 adjMatrix[0][0]의 요소를 넣어준다. 만약 adjMatrix[0][0]에 'B'가 들어있다면 
// vistedNumber를 2진수로 표현했을때 아래와 같이 표현된다.
// 00 0000 0000 0000 0000 0000 0010
visitedNumber |= (1 << adjMatrix[0][0])

var result = 0
func search(_ y: Int, _ x: Int, _ depth: Int) {
    result = depth > result ? depth : result
    for i in 0..<4 {
        let ny = y + dy[i]
        let nx = x + dx[i]
        // 범위 체크
        if ny < 0 || nx < 0 || ny >= R || nx >= C { continue }
        
        let idx = 1 << adjMatrix[ny][nx]
        
        // 맵에서 다음 갈 곳의 숫자가 이미 방문된 숫자인지 비트마스킹으로 체크
        // 알파벳이 단 한번씩만 나와야 하므로 만약 A를 만났던 상태에서 다시 A를 만나면 continue가 된다.
        if visitedNumber & (1 << idx) != 0 { continue }
        
        // 그것이 아니라면 비트를 켜 방문처리 해준다.
        visitedNumber |= (1 << idx)
        
        // 방문처리를 해주고 search 함수를 실행한다.
        search(ny, nx, depth + 1)
        
        // 방문이 끝났다면 백트래킹을 위해 다시 미방문 처리 해준다.
        visitedNumber &= ~(1 << idx)
        
    }
}
search(0,0,1)
print(result)
```

## 🍎 배운점
- 현재 주어지는 2차원 배열은 문자이다.
    - 이것을 연산 할 때 마다 숫자로 바꿔줘야 하는데, 아예 처음부터 숫자로 바꾸고 시작하는것이 시간을 줄일 수 있다.
- 2차원 배열에 많이 접근하면 그만큼 속도도 느려진다.
