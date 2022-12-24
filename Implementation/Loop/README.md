# Loop

## 🍎 loop 사용법
### 📖 for loop
```swift
// 기본 for loop 
for i in 0...10 // 0 ~ 10
for i in 0..<10 // 0 ~ 9
for i in 0...10 where i % 2 == 0 // 0 2 4 6 8 10
for i in stride(from: 0, to 5, by 1)
for i in stride(from: 5, to 0, by -1)

// Array와 자주 사용하는 forEach loop
arr.enumerated().forEach {
    print($0.offset) // 인덱스
    print($0.element) // 값
}
```

### 📖 while loop
```swift
var i = 0
while i < 5 {
    print(i)
    i += 1
}
```

### 📖 repeat while
```swift
var j = 10

repeat {

    print(j)
    j += 1
    
} while j < 10
```

