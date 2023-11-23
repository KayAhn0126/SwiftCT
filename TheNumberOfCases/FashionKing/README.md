# 9375 패션왕 신해빈

## 🍎 키워드
- 경우의 수

## 🍎 문제에서 사용한 경우의 수 개념
- 먼저 문제를 보자
- 문제: 해빈이는 패션에 매우 민감해서 한번 입었던 옷들의 조합을 절대 다시 입지 않는다. 예를 들어 오늘 해빈이가 안경, 코트, 상의, 신발을 입었다면, 다음날은 바지를 추가로 입거나 안경대신 렌즈를 착용하거나 해야한다. 해빈이가 가진 의상들이 주어졌을때 과연 해빈이는 알몸이 아닌 상태로 며칠동안 밖에 돌아다닐 수 있을까?
- 입력: 
    - hat headgear
    - sunglasses eyewear
    - turban headgear

## 🍎 문제 풀이
- 위의 입력을 기준으로 설명하면 해빈이가 만들 수 있는 패션의 숫자는 총 5개이다.
    - hat
    - sunglasses
    - turban
    - hat, sunglasses
    - turban sunglasses
- **이 문제에서 제일 중요한 포인트는 하나를 선택했을때 다른 하나를 선택 안하는것도 하나의 선택이라는 점이다.**
    - hat, (nothing)
    - sunglasses, (nothing)
    - turban, (nothing)
- 좀 더 이해하기 쉽게 카테고리를 나열 해보자!
- headgear
    - hat, turban, nothing
- eyewear
    - sunglasses, nothing
- 이것을 바탕으로 총 경우의 수를 계산해보자
    - hat, nothing
    - sunglasses, nothing
    - turban, nothing
    - hat, sunglasses
    - turban, sunglasses
    - nothing, nothing 
- 여기서 경우의 수는 headgear의 총 갯수 * eyewear의 총 갯수 = 6이고 아무것도 안입는 경우 즉, nothing, nothing을 빼주면 정답인 5가 된다.

## 🍎 순열? 조합?
- 처음엔 순열 또는 조합을 써야하나 생각했지만 아래와 같은 이유로 사용하지 않았다.
- **이 문제를 순열로 풀면 안되는 이유.**
    - 모든 요소를 사용
        - 반례: hat, sunglasses, turban와 같이 하나만 사용하는 경우의 수 가 있으므로 안됨.
    - 카테고리에 중복이 있으면 안된다.
        - 반례: hat, turban 또는 turban, hat
    - order sensitive
        - 이 문제에서는 순서는 상관없다.
- **이 문제를 조합으로 풀면 안되는 이유**
    - 모든 요소를 사용
        - 반례: hat, sunglasses, turban와 같이 하나만 사용하는 경우의 수가 있으므로 안됨.
    - 카테고리에 중복이 있으면 안된다.
        - 반례: hat, turban
