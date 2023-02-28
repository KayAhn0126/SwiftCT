# 14501 퇴사
- DP로 풀었지만 DFS로도 풀 수 있다고 한다.
- na982님의 강의를 보고 문제 해결 (top - down)

## 🍎 문제 접근
- 처음에는 그리디하게 현재 위치에서 가장 가까운 일을 골라서 수행했다.
- 문제의 예제 입력 4를 보자
```bash
10
5 50 - 1일
4 40
3 30
2 20
1 10
1 10 - 6일
2 20 - 7일
3 30 - 8일
4 40
5 50 - 10일
```
- 1에서 부터 10일까지 매 일마다 걸리는 시간과 보수가 나와있다.
- 만약 이것을 그리디하게 푼다면 1일,6일,7일이 되어서 80원을 벌 수 있다.
- 하지만 6일이 되었을 때, 7일을 쉬고 8일에 다시 일을 하게된다면 10일동안 총 90원을 벌 수 있다.

## 🍎 문제 풀이
![](https://i.imgur.com/ya8vI5p.png)
### 📖 생각해야 하는것
- 내가 백준이가 되었다고 생각해보자.
- 나는 오늘부터 일을해서 N일 전까지 매일 일하건 띄엄띄엄 일을 하건, 무조건 돈을 최대한 많이 벌기만 하면된다.
    - 최대값을 구하기만 하면 되기 때문에 꼭 꽉차게(그리디하게) 일을 할 필요는 없다.
- 오늘 일을 했을때와 오늘을 스킵 했을 때, 둘 중 큰 값을 출력하면 된다.

### 📖 점화식
- 간잽이 백준이가 사용할 점화식은 아래와 같다
```swift
solve(i) = max(solve(i + 1), solve(T[i]) + P[i])
```
- 점화식을 풀어서 이해해보자.
- 오늘의 스케쥴을 하는 경우
    - solve[i + T[i]] + P[i]
    - 오늘 스케쥴을 소화했기 때문에 (현재 날 + 걸리는 날)의 날짜로 가서 다시 점화식 수행
    - 스케쥴을 소화했으므로 보수 P[i] 추가
- 오늘의 스케쥴을 소화하지 않는 경우 
    - solve(i + 1)
    - 오늘의 스케쥴을 소화하지 않으면 간단하게 다음날로 넘기면 된다.
- 큰 카테고리에서 보면,
    - 오늘 일을 했을때 수익
    - vs
    - **오늘 일을 건너 뛰었을 때 수익**
    - 중 큰 값을 출력하면 된다.
