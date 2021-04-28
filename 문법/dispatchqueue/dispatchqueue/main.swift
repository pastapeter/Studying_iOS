//
//  main.swift
//  dispatchqueue
//
//  Created by abc on 2021/04/28.
//

import Foundation
let queue = DispatchQueue(label: "dohyun")
queue.async {
    for _ in 50...55 {
        print("first async")
    }
}
queue.async {
    for _ in 1...5 {
        print("second async")
    }
}
print("================")
for i in 100...105 {
    print(i)
}

