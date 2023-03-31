//
//  main.swift
//  FabricatingLadder
//
//  Created by Kay on 2023/03/31.
//

/*
 15684
 사다리 조작
 */

/*
 3차원 배열 사용
 
 1.간선 저장하기
 adjMatrix[level][from][to]
 만약 1레벨에서 1과 2가 연결되어 있으면 아래와 같이 양방향 간선 연결
 adjMatrix[1][1][2] = true
 adjMatrix[1][2][1] = true
 
 2.
 N만큼 반복한다. 큰 그림에서 체크 function이다.
 시작점에서 부터 1 level ~ N레벨까지.
    - 만약 현재 레벨에 나와 연결된 노드가 있다? -> 연결된 노드로 이동
    - 연결된 노드에서 이제 다음 레벨 체크,
    - 있다면 해당 노드로 이동, 없다면 다음 레벨로 이동 ~ 어디까지? M 까지
 
 3.
 가로선 1개부터 추가한다.
    - 추가 할 때,
 30C 3 =
 5 * 29 * 28/
 
 */
import Foundation



