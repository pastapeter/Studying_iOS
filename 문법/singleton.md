# Singleton in Swift, 싱글톤 어떻게 활용?

공부하던 도중 singleton에 대해 궁금한 점이 생겨서 작성하게되었다. 특히 내가 만드는 Singleton은 어떻게 작성해야할까? 

아무래도 Singleton in Swift이니 가장 먼저 봤던 것은 apple document였다.

apple document가 말하는 singleton은 다음과 같다.

[##_Image|kage@dfttlu/btq9NQhisyi/2SnCW8DddtcxNIbJ3iaHek/img.png|alignCenter|data-origin-width="1534" data-origin-height="372" data-filename="스크린샷 2021-07-17 오후 5.27.36.png" data-ke-mobilestyle="widthOrigin"|||_##]

클래스의 글로벌하게 액세스가 가능하고, shared 하고 있는 instance를 제공한다는 것이다. 우리는 우리가 만든 싱글톤을 가지고, 어떤 리소스(property)나, 서비스(method)에 통일된 접근 포인트를 만들수 있다. 근데 결국 이 싱글톤은 모든 앱에 다 쉐어되고있는 것이다. 예를 들어서 우리가 음악플레이어를 만드는데 있어서, 볼륨을 줄이고 올리고 하는것은 뮤직플레이어 앱에서 전체가 다 공유하고 있어야하는 속성이다. 그렇기 때문에 우리는 Userdefault라는 싱글톤을 사용하는 것이다.

일반적으로 UIKit이나 Foundation에서 제공하는 싱글톤(Userdefault, NotificationCenter ...)을 제외하고 내가 만드는 싱글톤의 활용방법이 어떻게 진행될까??

## 내가 만드는 싱글톤

싱글톤을 만드는 방법은 여러가지가 있지만, 하지만 보면 다 똑같다.

```
class Singleton {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}
```

```
class LocationManager{
    
    static let shared = LocationManager()
    
    var locationGranted: Bool?
    //Initializer access level change now
    private init(){}
    
    func requestForLocation(){
        //Code Process  
        locationGranted = true     
        print("Location granted")
    }
    
}
//Access class function in a single line
LocationManager.shared.requestForLocation()
```

위의 코드로 쓴다면, 우리는 LocationManager라는 싱글톤 클래스를 가지고 우리는 어디서든 LocationManager.shared.reaquestForLocation() locationGranted인지 확인할 수 있다. 

기존의 경우에서는 우리는 항상 인스턴스를 만들어줘야한다. 하지만 싱글톤을 사용하면 바로 공유하고 있는 변수에 접근가능하다는 것!! 꼭알아봐야한다.  그렇다면 간단한 예제로 살펴볼수도 있다.

## 간단 활용법

```
class Car {
    var color = "Red"
    static let shared = Car()
    private init(){}
    
    func printColor(){
        print(color)
    }
}

Car.shared.printColor()
Car.shared.color = "Brown"
Car.shared.printColor()
```

여기서 우리는 Car의 색상을 마음대로 바꿀수 있다. 그렇다면 조금 더 확실하게 닿기 위해서 다른 예제를 해본다면??? 완전 코드로 간단한 뮤직플레이어를 만들어보자면

```
class Volume {
    var volume = 50
    static let shared = Volume()
    
    private init(){}
    
    func lowVolume(){
        volume -= 5
    }
    
    func highVolume(){
        volume += 5
    }
}

class music{
    var musicName: String
    var artist: String
    var volume = Volume.shared
    
    init(musicName: String, artist: String) {
        self.musicName = musicName
        self.artist = artist
    }
}

let musicA = music(musicName: "하루하루", artist: "빅뱅")
let musicB = music(musicName: "쏘리쏘리", artist: "슈퍼주니어")

print("\(musicA.musicName)의 음량은 \(musicA.volume.volume)")
musicA.volume.highVolume()
musicA.volume.highVolume()
print("\(musicB.musicName)의 음량은 \(musicB.volume.volume)")
```

위에서 보면 volume(음악볼륨)을 singleton 클래스로 만들어봤습니다. 그리고 music 클래스는 노래이름과, 작가, 그리고 음악볼륨을 프로퍼티로 가지고 있어요! 하지만 여기서 음악볼륨의 타입은 volume 클래스이고, 싱글톤이기 때문에 모든 음악객체는 이 볼륨을 공유하고 있죠!!!

그래서 우리는 musicA가 빅뱅의 하루하루이고, musicB가 슈주의 쏘리쏘리입니다. 근데 우리가 하루하루를 듣다가 너무 작아서 볼륨을 2번 올린거죠. 그렇다면 다음노래 쏘리쏘리 들을때도 그 볼륨은 그대로여야 할것입니다. 쏘리쏘리로 넘어갔다고 다시 볼륨이 default로 가면 안되겠죠!!

그래서 저기서 볼륨에서 2번 높였을때, MusicB의 볼륨음량의 값을 확인해보면 60이 나옵니다!!! 기본 50에서 5를 2번 올려서 그렇게 되는 것이에요

출력

[##_Image|kage@enz1ft/btq9Knf5rnN/skFnhEkmqVC2edUlGKhiV1/img.png|alignCenter|data-origin-width="320" data-origin-height="92" data-filename="스크린샷 2021-07-17 오후 6.01.41.png" data-ke-mobilestyle="widthOrigin"|||_##]