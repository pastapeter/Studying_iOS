# BankManager_concurrency
야곰스타터캠프의 BankManager project에 대한 설명을 보고 공부하였습니다.
iOS의 Concurrency를 공부하던 도중, 연습이 필요할 것 같아서 Github 내에 있는 자료를 통해 공부한 내용을 기록

## 프로젝트에 대해 공부하면서 생각해봐야했던 이슈
1. 은행원이 3명이 있는데, 손님들이 들어왔을때, 줄을 어떻게 세워야하나
2. 은행원 한명한테만 가서는 안된다.
3. 은행원이 3명이 있는데, 3중에 하나가 끝난다면, 손님은 끝난 은행원에게 가서 업무를 봐야한다.
4. 은행원이 3명이 있다면, 줄도 3개가 있어야할 것!

## 동기와 비동기의 이해

## Dispatchqueue.global(), CustomQueue

## Dispatchgroup

## Semaphore에 대한 이해
