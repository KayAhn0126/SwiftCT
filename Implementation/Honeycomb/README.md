# 2292 벌집

## 🍎 키워드
- 패턴 찾기

## 🍎 문제
![](https://i.imgur.com/lvdqvDI.png)
- 위의 그림과 같이 육각형으로 이루어진 벌집이 있다. 그림에서 보는 바와 같이 중앙의 방 1부터 시작해서 이웃하는 방에 돌아가면서 1씩 증가하는 번호를 주소로 매길 수 있다. 숫자 N이 주어졌을 때, 벌집의 중앙 1에서 N번 방까지 최소 개수의 방을 지나서 갈 때 몇 개의 방을 지나가는지(시작과 끝을 포함하여)를 계산하는 프로그램을 작성하시오. 예를 들면, 13까지는 3개, 58까지는 5개를 지난다.

## 🍎 문제 풀이
- 1의 카운트는 1.
- 1에서 멀어질수록 +1.
- 1부터 사용자가 입력한 숫자에 도달하기 까지 몇칸을 이동 해야 하는지 풀어야한다.
- 무식하게 써보자
```swift
1  -> 1
2  -> 2
3  -> 2
4  -> 2
5  -> 2
6  -> 2
7  -> 2 (1 + (6 * 1))
8  -> 3
9  -> 3
10 -> 3
11 -> 3
12 -> 3
13 -> 3
14 -> 3
15 -> 3
16 -> 3
17 -> 3
18 -> 3
19 -> 3 (7 + (6 * 2))
20 -> 4
21 -> 4
.
.
.
```
- userInput과 계속 비교할 변수 makeUpNumber와 6의 배수를 만들어줄 counter변수를 만들고 (6*counter)를 계속 더해주는 동작을 반복하다 userInput보다 커지는 순간에 반복문을 빠져나오고 counter를 출력한다.

## 🍎 코드
```swift
import Foundation

var userInput = Int(readLine()!)!

var makeUpNumber = 1
var counter = 1

while userInput > makeUpNumber {
    makeUpNumber += 6 * counter
    counter += 1
}

print(counter)
```
