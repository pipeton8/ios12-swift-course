import UIKit

var secondLastNumber = 0
var lastNumber = 1

func fibonacci(until totalFibonacciNumbersToGet : Int) {
    print("Fibonacci number 1 is \(secondLastNumber)")
    print("Fibonacci number 2 is \(lastNumber)")
   
    for fibonacciNumberPosition in 3...totalFibonacciNumbersToGet {
        let newFibonacciNumber = lastNumber + secondLastNumber
        secondLastNumber = lastNumber
        lastNumber = newFibonacciNumber
        print("Fibonacci number \(fibonacciNumberPosition) is \(newFibonacciNumber).")
    }
}

fibonacci(until: 5)
