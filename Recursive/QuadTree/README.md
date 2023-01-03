# 1992 쿼드트리

## 🍎 키워드
- 재귀함수
- 구현

## 🍎 문제 풀이
- 좌상,우상,좌하,우하 기준으로 영상을 압축한 결과를 나타내면 되는 문제.
- 재귀함수를 이용해 풀어야하는 문제.
    - 기저사례
    - 메인로직
![](https://i.imgur.com/gwjD2GK.png)
- 처음 주어지는 값은 어디에서 시작할지 정해주는 좌표와 해당 맵의 사이즈이다.
```swift
print(quad(0, 0, size)) // 이렇게 주어진다.
```
- 처음 주어진 0,0을 이용해서 currentLetter라는 변수에 arrMatrix[0][0]을 저장한다. 이유는 나중에 나옴.
- 그리고 2차원 배열 전체를 돌면서 currentLetter와 다른 글자가 있는지 찾는다. 
- 예를들어 만약 currentLetter와 다른글자가 하나라도 없다면,
```swift
//예시 코드
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1
```
- 그럼 이 문제의 답은 currentLetter인 1이 된다.
- 하지만 만약 아래 이미지 처럼 다른 글자를 만나게 된다면,
![](https://i.imgur.com/Ylf77ut.png)
- 찾는것을 더 이상 진행하지 않고 재귀함수에 인자들을 적절히 넣어 4등분으로 나눈 후 각각의 자리에서 다시 탐색한다.
![](https://i.imgur.com/Dw7Zt4M.png)
- 4등분으로 나눴고 이제 다시 각자의 사각형 내 시작지점과 다른 숫자가 있는지 탐색한다.
![](https://i.imgur.com/eaNuMl9.png)
- 좌측 상단 사각형은 전부 0으로 이뤄져있으므로 0이다. 우측 상단 사각형은 우측 상단 사각형의[0][0]위치는 0인데 중간에 1이 발견되었으므로 탐색을 중지하고 다시 4등분한다.
![](https://i.imgur.com/4xkkf0V.png)
- 우측 상단의 사각형 안에 다시 작은 사각형 4개가 생겼으므로 다시 작은 사각형 안에 0,0부터 자신과 같은지 체크를 한다.
![](https://i.imgur.com/vaxIlQE.png)
- 이런식으로 반복하면 된다.

## 🍎 예제 출력을 보고 패턴을 찾자
- 예제 출력을 보면 아래와 같은 형식으로 되어있다.
- (0(0011)(0(0111)01)1)
- 즉, 4등분으로 나눠질때마다 양측에 괄호가 생긴다는 것을 파악해야한다.

## 🍎 전체 코드
```swift
import Foundation

let N = Int(readLine()!)!
var arrMatrix = [[String]]()

for _ in 0..<N {
    arrMatrix.append(readLine()!.map { String($0) })
}

func quad(_ y: Int, _ x: Int, _ size: Int) -> String {
    let currentLetter = arrMatrix[y][x]
    if size == 1 { return currentLetter }
    var result = ""
    for i in y..<y+size {
        for j in x..<x+size {
            if currentLetter != arrMatrix[i][j] {
                result += "("
                result += quad(y, x, size/2)
                result += quad(y, x+size/2, size/2)
                result += quad(y+size/2, x, size/2)
                result += quad(y+size/2, x+size/2, size/2)
                result += ")"
                return result
            }
        }
    }
    return currentLetter
}

print(quad(0,0,N))
```

## 🍎 느낀점
- 이런 재귀함수 문제를 많이 풀어보지 못해서 큰 그림을 작은그림으로 나눠서 해결하는 연습을 해야겠다.
- 처음 설계가 매우 중요하다는것을 느낀 문제.
