# 2828 사과 담기 게임

## 🍎 키워드
- 구현
- 그리디

## 🍎 문제 풀이
### 📖 설계
- 첫번째로 어떻게 이 문제를 풀까 생각해 보았고 바구니의 범위 안에 사과가 떨어지는것과 그렇지 않은것으로 나눌수 있었다.
- 바구니의 범위는 바구니의 좌측(left)과 우측(right)를 지정했다.

### 📖 바구니의 left, right 정하기
- 이 문제에서 제일 어려웠던 부분이다.
- 바구니의 사이즈가 1이라고 가정해보자.
    - 그럼 left는1, right도 1이여야 한다.
- 만약 바구니의 사이즈가 2라면,
    - left는 1, right는 2가 된다.
![](https://i.imgur.com/BmQ9qtC.png)
- 그림의 중앙에 있는 양방향 화살표는 바구니의 크기가 2이고, 위치는 4와 5를 걸친 위치에 있다.
- 처음엔 3부터 5까지 총 3칸을 잡는 그림을 그렸었는데 그렇게 한다면 정해와 멀어지는것같아 left, right를 똑바로 잡고 가는것에 포인트를 뒀다.
- 먼저 코드를 보자
```swift
var left: Int = 1 {
    didSet {
        right = left + M - 1
    }
}
var right = left + (M - 1)
```
- 왜 left는 1일까?
    - "가장 처음에 바구니는 왼쪽 M칸을 차지하고 있다." 라고 문장이 지문에 있다.
- Ok. 그럼 사이즈가 1이면? right는 2인가?
    - 아니다. left도 1 right도 1이다.
- left와 right를 구하는 식은 어떻게 세웠나?
    - left가 1이고 사이즈가 1일때 right가 1이 되는 공식은 단 하나뿐이다.
    - 그리고 이 공식이 left와 right의 사이를 바구니의 사이즈만큼 띄워준다!
    ```swift
    var right = left + (M - 1)
    ```
    - 시작점 1, 바구니 크기 3일때 left, right를 구해보자.
    - 시작점이 1이니까 left도 1.
    - right = 1 + 3 - 1
    - **1, 2, 3까지 총 세칸을 차지하는 바구니가 탄생했다.**

### 📖 나머지 코드
```swift
var count = 0

for _ in 0..<J {
    let dropTo = Int(readLine()!)!
    if left <= dropTo && dropTo <= right { continue }
    if dropTo < left {
        count += left - dropTo
        left = dropTo
    } else { // right < dropTo 일때
        count += dropTo - right
        left = left + (dropTo - right)
    }
}
```
- 사과가 떨어지는 위치가 J만큼 주어지고 현재 바구니 위치에 따라서 몇 칸 움직였는지 세주는 count 변수와 바구니가 움직여야 할때 기준이 되는 left를 고쳐주고 있다.
- left 변수에는 프로퍼티 옵져버로 left의 값에 변화가 생기면 right도 변하게 해주었다.

## 🍎 느낀점
- 요구사항을 어떻게 현실화 시키느냐가 중요했던 문제였다.
