import Cocoa


//Multiple Trailing Closure

func multi(first: () -> (), second: () -> (), third: () -> ()) {
    
}

// ~ Swift 5.2
multi(first: { }, second: { }) {
    
}

// Swift 5.3 ~
multi {
    <#code#>
} second: {
    <#code#>
} third: {
    <#code#>
}


