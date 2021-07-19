# BankManager_concurrency
야곰스타터캠프의 BankManager project에 대한 설명을 보고 공부하였습니다.
iOS의 Concurrency를 공부하던 도중, 연습이 필요할 것 같아서 Github 내에 있는 자료를 통해 공부한 내용을 기록

## 프로젝트에 대해 공부하면서 생각해봐야했던 문제점
1. 은행원이 3명이 있는데, 손님들이 들어왔을때, 줄을 어떻게 세워야하나
2. 은행원 한명한테만 가서는 안된다.
3. 은행원이 3명이 있는데, 3중에 하나가 끝난다면, 손님은 끝난 은행원에게 가서 업무를 봐야한다.
4. 은행원이 3명이 있다면, 줄도 3개가 있어야할 것!

## 동기와 비동기의 이해
위의 문제들을 해결하기 위해서는 동기와 비동기를 이해했어야했다. 동기는 말그대로 동시에 일어난다는 뜻이다. 
요청 -> 결과로 나타나는데, 이 결과가 얼마나 오래걸리던지 요청한 자리에서 결과가 주어져야한다. 

" 내 작업이 끝나기전까지는 작업을 수행 못한다. "

반대로 비동기는 요청을 보냈을때 응답상태와 상관없이 다음 동작을 수행할 수 있어야한다.

이 프로젝트에서 꼭 필요한 것이 있었는데, 그것이 바로 이 그림에 있다.
<img width="405" alt="스크린샷 2020-07-09 16 21 39" src="https://user-images.githubusercontent.com/69891604/126137148-b59143cf-5902-43e2-96a9-69a30cc2d352.png">

결국 은행원 3명에 대해서 클라이언트들이 끝나는대로 들어가야한다. 결국 비동기가 필요하다는 의미이다.

## What queue? serial vs concurrent? async vs sync?

그렇다면 은행원 3명에 대해서 줄을 세운다고 한다면 각 은행원을 init할때 줄도 같이 만들어주면된다. 하지만 생각해보면 은행원 각각한명씩에게 줄이 있다면, 은행원은 그 일을 어떻게 처리해야할까? 
만약에 커피숍에 갔는데, 우리가 줄을 섰는데, 한줄로 서지말라고 하고 가로로 선다면? 어이가 없을 것이다. 

그래서 우리는 1명의 teller에게 1개의 줄을 주는데, 순차적으로 일을 할당해주는 줄을 만들어줘야할 것이다. 결국은 Serial Queue를 줘야한다. concurrent 큐를 만들어주면 client 들이 화날것이다^^
~~~
class Teller {
    private var windowInBank: Int
    private var isWorking = false
    var isNotworking = true
    let workingQueue : DispatchQueue
    
    init(windowInBank: Int) {
        self.windowInBank = windowInBank
        self.workingQueue = DispatchQueue(label: "\(windowInBank)")
    }

~~~

이번에는 sync 와 async 중에 어떤 것을 사용해야할까? sync는 위에서 말했던 동기이고, async는 비동기이다. 
sync를 사용한다면 1번 고객이 1번창구로 간다. 그리고 오래해야하는 일을 하고 있다면? 2번 3번 창구가 비었는데도, 다른 고객들이 들어가지 못한다. 왜냐면, sync는 요청과 즉시 응답을 받아야한다. 그렇기 때문에 일처리하는 함수는 무조건 async로 구현해야한다.

~~~
func handleBusiness(client: Client, with group: DispatchGroup){
        isWorking = true
        isNotworking = false
        workingQueue.async(group: group) {
            switch client.businessType {
                case .deposit:
                    self.handleDeposit(client: client)
                case .loan:
                    self.handleLoan(client: client)
            }
            self.isWorking = false
            self.isNotworking = true
        }
    }
~~~
위의 함수는 class Teller 에 있는 함수로, Teller 가 일을 하고 있다는 것을 나타내는 함수이다. 여기서 workingQueue는 serial큐이고, async로 작동하고 있다.

## Dispatchgroup
Dispatchgroup은 여러 Dispatchqueue들을 그룹화시킬 수 있다. 이를 통해서 그룹 내의 dispatchqueue 내에 있는 task들이 일이 다 마친 것을 확인할 수 있다. 

구현하면서 햇갈렸던 것은 .wait()과 .notify의 차이점이었다. 
wait()은 synchronous 하게 동작한다.
notify()은 asynchronous 하게 동작한다.

이것에 대한 의미가 잘 이해가 안갔지만, notify()와 wait()으로 했을때, 결과가 달랐다.
~~~
private func assignBusinessToTeller(){
    let windows = DispatchGroup()
    var clientIndex = clients.count-1
    var isContinuous = true
    while isContinuous {
        for teller in tellers {
            if clientIndex == -1 {
                isContinuous = false
                break
            }
            if teller.isNotworking {
                teller.handleBusiness(client: clients[clientIndex], with: windows)
                clientIndex -= 1
            }
        }
    }
//        windows.notify(queue: DispatchQueue.main){
//            print("모든손님의 일처리를 모두 마무리했다!!!")
//        }
    windows.wait()
    print("모든손님의 일처리를 모두 마무리했다!!!")
}
~~~
### notify()를 쓴경우
<img width="300" alt="스크린샷 2021-07-19 오후 6 59 54" src="https://user-images.githubusercontent.com/69891604/126143150-b311086f-dcae-4523-82a2-39dbcc2969d0.png">

### wait()을 쓴경우
<img width="300" alt="스크린샷 2021-07-19 오후 6 59 08" src="https://user-images.githubusercontent.com/69891604/126143159-0c6ead80-f382-46eb-a67e-c2a0714fbe7e.png">

notify를 쓴 경우에는 결과가 다 출력되지 않은 경우에 그냥 프로그램이 종료된다. 하지만, wait()을 쓴 경우에는 dispatchgroup의 모든 일이 마무리되어야지 끝이 난다. 비동기로 돌아가서 이 함수가 끝나기전에 완료 함수가 돌아서 종료되는 것이다.
반면에 wait()을 쓰면 dispatchgroup 내의 일이 다 끝나야지 다음 것으로 넘어가게 만들었기 때문에, 다 출력된 다음 프로그램이 종료된다.

## DispatchSemaphore에 대한 이해
Semaphore은 간단하게 말하자면, 멀티 스레드 프로그래밍에서 공유하는 자원에 대한 이해이다. 공유를 할 수 있게 만들거나, 누군가 공유자원을 쓰고 있다면 잠시 막아두는 그런일을 할 때 쓴다.

~~~
private func sendDocumentToHeadOffice(client: Client){
      let semaphore = DispatchSemaphore(value: 0) // 실행순서 1
      
      HeadOffice.shared.LoanQueue.async { //실행순서 2지만 다른 스레드이므로 바로 실행순서 3으로 넘어간다.
          HeadOffice.shared.judgeLoan(client: client)
          semaphore.signal()
      }
      semaphore.wait() //실행순서 3 다른 스레드에서 signal이 불릴때까지 넘어가지 못한다.
  }
~~~
  
semaphore의 value는 공유자원의 수이다. 1이면 1개이고, 2이면 2개, 0이면 없다는 것이다.
wait()은 사용해서 기다리라는 의미로 value -1을 해준다.
signal()은 다 썻으니 한명 들어와! 라는 의미로 value+1을 해준다.


### DispatchSemaphore은 2가지 용도가 있지만, 여기서는 두 스레드의 특정 이벤트 완료 상태 동기화에 대해서만 이야기한다.
### [DispatchSemaphore의 용도] 

위의 경우는 Headoffice가 일을 완료했는지 확인할 때 쓰인다. 현재 지금 sendDocumentToHeadOffice 함수는 비동기적으로 돌아가고 있다. 다른 어떤 특정 스레드에서 돌아가고 있다. 이 함수가 불릴때, headoffice의 또다른 dispatchqueue에서 일이 비동기적으로 돌아가게 된다. 

클라이언트가 은행원에게 대출서류 제출 -> 은행원은 대출서류를 본부에 제출 -> 본부는 서류 확인 -> 확인 완료되면 은행원은 대출 처리 완료

우리가 알아야하는 것은 headOffice에서 돌아가는 스레드(서류 확인)가 완료되면, Teller 객체의 다른 함수(대출 처리)가 돌아가게 만들어야한다는 것이다.

### 이 상황에서 대출 처리 스레드는 돌아가다가 이 상황에서 잠깐 멈춘다 wait(), 그리고 서류 확인 스레드가 돌아가면서 완료되면 signal()을 줘서 다시 대출 처리 스레드가 일을 시작하게 만든다. 

세마포어의 value가 0이라서 다음에 오는 스레드에서 완료되었다는 알림(signal)이 있기 전까지는 계속 블럭을 시켜둔다. 실행순서는 위의 주석에 있다.


