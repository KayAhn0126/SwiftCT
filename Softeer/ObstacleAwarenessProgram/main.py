import sys
from queue import Queue

userInput = int(sys.stdin.readline())

arr = [list(map(int, sys.stdin.readline().split())) for _ in range(userInput)]
arr = []
for i in userInput:
    arr.append(list(map(int, )))

visited = [[0 for _ in range(userInput)] for _ in range(userInput)]

resultList = []

dy = [-1,0,1,0]
dx = [0,1,0,-1]

for i in arr:
    print(i)

for i in arr:
    print(i)


def bfs(y,x):
    current = 0
    queue = Queue()
    visited[y][x] = 1
    while queue.empty() == False :
        currentYX = queue.get()
        for i in range(4):
            ny = currentYX[0] + dy[i]
            nx = currentYX[1] + dx[i]
            if arr[ny][nx] == 0 or visited[ny][nx] != 0:
                continue
            visited[ny][nx] = visited[y][x] + 1
            current = visited[ny][nx]
            queue.put([ny,nx])
    resultList.append(current)

for i in range(userInput):
    for j in range(userInput):
        if arr[i][j] == 0 or visited[i][j] != 0 :
            continue
        bfs(i,j)
        
        
print(resultList.count)
resultList.sort()
for i in resultList:
    print(i)
        





