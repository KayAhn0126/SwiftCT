# 13458 시험 감독

## 🍎 키워드
- 구현

## 🍎 문제 풀이
- 먼저 'B가 감시 가능한 인원이 시험 인원보다 많으면 B 혼자서도 가능하다. 그게 아니라면 보조 감독이 필요하다'라고 정하고 문제를 풀었다.
```swift
func doCal(_ testTaker: Int) {
    if B >= testTaker {
        counter += 1
    } else {
        counter += 1
        let remainder = (testTaker - B) % C == 0 ? (testTaker-B)/C :(testTaker-B)/C + 1
        counter += remainder
    }
}
```
- B가 감시 가능한 인원 >= 시험 인원
    - 카운터에 + 1
- B가 감시 가능한 인원보다 시험 인원이 많다면
    - 일단 B는 투입해야하니 카운터에 + 1
    - 나머지를 구하고 C만큼 나눠주고 나머지가 없으면 몫으로, 나머지가 있다면 1명 더 추가해야하니까 + 1.
    - 추가인원도 카운터에 추가.

## 🍎 느낀점
- 이 문제에 20분을 썼다. 문제 정의 속도 올리기.
