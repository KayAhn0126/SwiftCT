# Dictionary

## 🍎 Dictionary
### 📖 생성
```swift
// 1. 타입 추론으로 생성하기
var dict1 = ["height": 165, "age" : 100]
var dict2 = [:]                                         // error! 타입 추론으론 빈 딕셔너리 생성 불가
 
 
// 2. 타입 Annotation으로 생성하기
var dict3: [String: Int] = [:]                          // 빈 딕셔너리 생성
var dict4: [String: Int] = ["height": 165, "age" : 100]
 
 
// 3. 생성자로 생성하기
var dict5 = Dictionary<String, Int>()                   // :이 아닌 ,로 명시
var dict6 = [String: Int]()

// 4. 여러 타입을 저장하는 딕셔너리 생성하기
var dict7: [String: Any] = ["name": "Sodeul", "age": 100]
var dict8: NSDictionary = ["name": "Sodeul", "age": 100]
// Hashable 프로토콜을 준수하는 자료형만 Key값으로 올 수 있다.
```

### 📖 갯수 확인
```swift
var dict1 = ["height": 165, "age" : 100]
 
let count: Int = dict1.count            // 딕셔너리 갯수 확인 : 3
let isEmpty: Bool = dict1.isEmpty       // 딕셔너리 비었는지 확인 : false
```

### 📖 요소 접근
```swift
var dict1 = ["height": 165, "age" : 100]
 
// 1. 반환 값 - Optional Type
let height = dict1["height"]                     // Optional(165)
let weight = dict1["weight"]                     // nil
 
// 2. 반환 값 - Non Optional Type
let height = dict1["height", default: 150]       // 165
let weight = dict1["weight", default: 200]       // 200
```
- 딕셔너리의 경우, Subscript로 요소에 접근하면 기본 반환값이 Optional Type이기 때문에 (해당 Key 값이 없을 때를 대비)
- 따라서, 만약 Optional Type이 싫다하면 default 값을 직접 명시하면 된다
- 그럼 반환 값이 Non-Optional Type이다


### 📖 요소 추가하기
```swift
var dict1 = ["height": 165, "age" : 100]
 
// 1. Subscript로 추가하기
dict1["weight"] = 100                                // 해당 Key가 없다면, 추가 (insert)
dict1["height"] = 200                                // 해당 Key가 있다면, Value 덮어쓰기 (update)
 
// 2. updateValue(:forKey)
dict1.updateValue(100, forKey: "weight")             // 해당 Key가 없다면, 추가하고 nil 리턴 (insert)
dict1.updateValue(200, forKey: "height")             // 해당 Key가 있다면, Value 덮어쓰고 덮어쓰기 전 값 리턴 (update)
```

### 📖 요소 삭제하기
```swift
var dict1 = ["height": 165, "age" : 100]
 
// 1. Subscript로 삭제하기 (nil 대입하기)
dict1["weight"] = nil                              // 해당 Key가 없어도 에러 안남
dict1["height"] = nil                              // 해당 Key가 있다면, 해당 Key-Value 삭제
 
// 2. removeValue(forKey:)
dict1.removeValue(forKey: "weight")                // 해당 Key가 없다면, nil 반환
dict1.removeValue(forKey: "age")                   // 해당 Key가 있다면, 해당 Key-Value 삭제 후 삭제된 Value 반환 : Optional(100)
 
// 3. removeAll() : 전체 삭제하기
dict1.removeAll()
```

### 📖 Key, Value 나열하기
```swift
var dict1 = ["height": 165, "age" : 100]
 
// 1. Key 모두 나열하기
dict1.keys                         // "height, "age"
dict1.keys.sorted()                // "age", "height
 
// 2. Value 모두 나열하기
dict1.values                       // 165, 100
dict1.values.sorted()              // 100, 165
```
- 정렬은 가능하지만 찍을때마다 달라진다.
- 순간적인 정렬만 가능

### 📖 딕셔너리 비교하기
```swift
var dict1 = ["height": 165, "age" : 100]
var dict2 = ["height": 165, "age" : 100]
var dict3 = ["Height": 165, "Age" : 100]
var dict4 = ["name": "sodeul", "address" : "Suwon"]
 
dict1 == dict2              // true
dict1 == dict3              // false (대소문자 다름)
dict1 == dict4              // false (모든 Key-Vlaue 다름)
```
- 비교 연산자로 비교 가능
- 모든 키와 벨류가 정확히 일치해야만 true

### 📖 요소 검색하기
```swift
var dict1 = ["height": 165, "age" : 100]
 
let condition: ((String, Int)) -> Bool = {
    $0.0.contains("h")
}
 
// 1. contains(where:)  : 해당 클로저를 만족하는 요소가 하나라도 있을 경우 true
dict1.contains(where: condition)                   // true
 
// 2. first(where:)     : 해당 클로저를 만족하는 첫 번쨰 요소 튜플로 리턴 (딕셔너리는 순서가 없기 때문에, 호출할 때마다 값이 바뀔 수 있음)
dict1.first(where: condition)                      // Optional((key: "height", value: 165))
 
// 3. filter            : 해당 클로저를 만족하는 요소만 모아서 새 딕셔너리로 리턴
dict1.filter(condition)                            // ["height": 165]
```
- 딕셔너리 요소 검색은 클로져를 이용해서 검색
- 클로저의 파라미터 타입은 딕셔너리의 타입과 같아야하고 반환 타입은 무조건 Bool 타입이여야 한다.
- 만약 [String : String] 딕셔너리에서 요소를 검색한다면 ((String : String)) -> Bool 이렇게 작성해야한다.
