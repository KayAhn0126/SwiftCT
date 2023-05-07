# Set

## 🍎 Set 정리
### 📖 생성
```swift 
var mySet1 = Set<Int>()
var mySet2: Set<Int> = []
// Set은 타입 추론으로 생성 불가!
var mySet3 = [1,2,3,4,5] // X!
```

### 📖 중요 메서드 시간 복잡도
```swift
var mySet: Set<Int> = [1,2,3,4,5]
print(mySet.count) // O(1)
print(mySet.contains(5)) // O(1)
```

### 📖 값 추가하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]
 
// 1. insert : 값을 추가하고, 추가된 결과를 튜플로 리턴 (중복이면 false, 추가된 값)
set1.insert(1)                // (false, 1)
set1.insert(10)               // (true, 10)
 
// 2. update : 값이 존재하지 않으면 추가 후 nil 리턴, 존재할 경우 덮어쓰기 후 덮어쓰기 전 값 리턴
set1.update(with: 1)          // Optioanl(1)
set1.update(with: 120)        // nil
```

### 📖 요소 삭제하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]
 
// 1. remove() : 한 가지 요소 삭제할 때 사용, 삭제 후 삭제한 값 return (없는 요소 삭제 시 nil 리턴)
set1.remove(1)              // Optional(1)
set1.remove(10)             // nil
 
// 2. removeAll() : 전체 요소 삭제
set1.removeAll()  
```

### 📖 Set끼리 비교하기
```swift
var set1: Set<Int> = [1, 2, 5, 0]
var set2: Set<Int> = [0, 2, 1, 5]
var set3: Set<Int> = [1, 3, 11, 20]
 
set1 == set2            // true
set1 == set3           // false
```
- set은 정렬되지 않은 collection, 모든 요소만 같다면 true 반환

### 📖 부분 집합
```swift
var set1: Set<Int> = [1, 2, 5, 0]
var set2: Set<Int> = [1, 2]
 
set1.isSubset(of: set2)               // false
set2.isSubset(of: set1)               // true
```

### 📖 상위 집합
```swift
var set1: Set<Int> = [1, 2, 5, 0]
var set2: Set<Int> = [1, 2]
 
set1.isSuperset(of: set2)               // true
set2.isSuperset(of: set1)               // false
```

### 📖 같은 집합
```swift
var set13: Set<Int> = [1, 2, 5, 0]
var set14: Set<Int> = [6, 7, 8, 0]
var set15: Set<Int> = [3, 7, 9, 10]
 
print(set13.isDisjoint(with: set14))               // false -> 같은 집합이라는 뜻, 하나만 같아도 false.
print(set15.isDisjoint(with: set13))               // true -> 요소가 하나라도 같은게 없으면 true.
```

### 📖 연산
![](https://hackmd.io/_uploads/rk2jpQBN3.png)
```swift
var a: Set = [1,2,3,4,5,6,7,8,9]
var b: Set = [1,3,5,7,9]
var c: Set = [2,4,6,8,10]
 
// 1. intersection : 교집합을 새로운 Set으로 리턴
a.intersection(b)                     // [1, 3, 5, 9, 7]
b.intersection(c)                     // [] : 겹치는 요소 없음
 
// 2. union : 합집합을 새로운 Set으로 리턴
a.union(b)                            // [2, 7, 9, 4, 8, 5, 6, 1, 3]
b.union(c)                            // [9, 3, 10, 4, 1, 8, 7, 2, 6, 5]
 
// 3. sysmetricDifference : 교집합의 여집합을 새로운 Set으로 리턴
a.symmetricDifference(b)              // [4, 8, 6, 2]
b.symmetricDifference(c)              // [10, 9, 8, 6, 7, 1, 2, 4, 3, 5]
 
// 4. subtracting : 차집합을 새로운 Set으로 리턴
a.subtracting(b)                      // [4, 8, 6, 2]
b.subtracting(c)                      // [9, 1, 3, 5, 7]
```
