import Foundation

let ABC = readLine()!.split(separator: " ").map { Int(String($0))! }
let A = ABC[0]
let B = ABC[1]
let C = ABC[2]

// (a * b) % c = ((a % c) * (b % c)) % c

func go(_ b: Int) -> Int {
    if b == 1 {
        return A % C
    }
    var result = go(b/2)
    result = (result * result) % C
    if b % 2 != 0 {
        result = (result * A) % C
    }
    return result
}

print(go(B))
