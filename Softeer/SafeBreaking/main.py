import sys
 
input = sys.stdin.readline
 
w, n = map(int, input().split())
 
jewels = [list(map(int, input().split())) for _ in range(n)]
 
jewels.sort(key=lambda x: x[1], reverse=True)

answer = 0
for weight, price in jewels:
    if w > weight:
        answer += weight * price
        w -= weight
    else:
        answer += w * price
        break
 
print(answer)
