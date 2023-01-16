# 2852 NBA 농구

## 🍎 키워드
- 시간 계산
- 구현 (previous 변수의 활용)

## 🍎 문제 접근
### 📖 대부분의 시간을 더하고 빼는 문제는 시간의 최소단위를 가지고 해결해야 한다.
- 1번팀이 이기고 있다가 2번팀이 득점을 해서 동점이 된다면, 2번팀이 득점한 시각에서 1번팀이 득점했던 시각을 빼면 되는데. 이 문제에서는 각각의 분, 초를 계산 해야하니 각각의 시각을 가장 작은 단위인 초로 변환 후 계산하면 된다.

## 🍎 코드 해석
### 📖 시간 계산을 어떻게 할까?
- 이전 시간을 활용 해야한다.
```swift
for _  in 0..<N {
    let teamAndTime = readLine()!.split(separator: " ").map { String($0) }
    let team = teamAndTime[0]
    let time = teamAndTime[1]
    
    if aCount > bCount {
        aSum += calculateTime(time, "sub", previousTime)
    } else if bCount > aCount {
        bSum += calculateTime(time, "sub", previousTime)
    }
    
    if team == "1" {
        aCount += 1
    } else {
        bCount += 1
    }
    
    previousTime = time
}
```
- 사용자로 부터 입력이 주어질 때마다 현재 시간은 이전 시간에 대입해서 다음에 계산을 할 수 있도록 한다.

### 📖 현재는 마지막에 들어온 값을 처리해주는 로직이 없다.
- 농구경기는 정확히 48분동안 진행된다고 하니, 마지막에 들어온 값까지 분기처리 해줘야 한다.
```swift
if aCount > bCount {
    aSum += calculateTime("48:00", "sub", previousTime)
} else if bCount > aCount {
    bSum += calculateTime("48:00", "sub", previousTime)
}
```
