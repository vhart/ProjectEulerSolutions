//: [Previous](@previous)

import Foundation

//: ### Problem 6
//: Sum square difference
//:
//: The sum of the squares of the first ten natural numbers is,
//:
//: 12 + 22 + ... + 102 = 385
//: The square of the sum of the first ten natural numbers is,
//:
//: (1 + 2 + ... + 10)2 = 552 = 3025
//:
//: Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
//:
//: Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.


func sumOfSquaresTo(n:Int) ->Int {

    return (n*(n+1)*(2*n+1))/6

}

func squareOfSumTo(n: Int) -> Int{

    let sum = n*(n+1)/2

    return Int(pow(Double(sum), 2))
}

let diff = squareOfSumTo(100) - sumOfSquaresTo(100)


//: ### Problem 7
//: 10001st prime
//:
//: By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
//:
//: What is the 10 001st prime number?

func findPrimeForIndex(index: Int) -> Int{

    var memoizedPrimes: [Int] = [2, 3, 5, 7]

    var i = 2

    while memoizedPrimes.count < index{

        if isPrimesFrom6nFormula(6*i-1, primes: memoizedPrimes){

            memoizedPrimes.append(6*i-1)

            if memoizedPrimes.count == index{

                break

            }
        }

        if isPrimesFrom6nFormula(6*i+1, primes: memoizedPrimes){

            memoizedPrimes.append(6*i+1)

        }

        i++
    }

    return memoizedPrimes[index-1]
}

func isPrimesFrom6nFormula(value: Int, var primes: [Int]) -> Bool{

    let root = getSquareRootFloorValue(value)

    for var i = 0; i < primes.count ; i++ {

        if primes[i]>root{
            return true
        }

        if value%primes[i] == 0{
            return false
        }

    }

    return false
}

func getSquareRootFloorValue(number: Int) -> Int{

    if(number > 0){
        return lrint(sqrt(Double(number)))
    }
    else{
        return 0
    }
}

//findPrimeForIndex(10001)


//: ### Problem 8
//: Largest product in a series
//:
//: The four adjacent digits in the 1000-digit number that have the greatest product are 9 × 9 × 8 × 9 = 5832.
/*
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
*/
//:Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?

let oneThousandDigits: String = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"

func maximumProductFromString(numbers : String) -> Int {

    let length = numbers.characters.count

    var maximum : Int = 0

    for var i = 0; i < length-13 ; i++ {

        let val = productFromSubstring(numbers[numbers.startIndex.advancedBy(i)...numbers.startIndex.advancedBy(i+12)])
        maximum = max(maximum, val)

    }

    return maximum
}

func productFromSubstring(substring : String) -> Int{

    var product : Int = 1

    for var i = 0; i < substring.characters.count ; i++ {

        let multiplier = Int(substring.substringWithRange(substring.startIndex.advancedBy(i)...substring.startIndex.advancedBy(i)))

        if multiplier == 0{
            return 0
        }

        product *= multiplier!

    }

    return product

}

//maximumProductFromString(oneThousandDigits)

//: ### Problem 9
//: Special Pythagorean triplet
//:
//: A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
//:
//: a^2 + b^2 = c^2
//:
//: For example, 32 + 42 = 9 + 16 = 25 = 52.
//:
//: There exists exactly one Pythagorean triplet for which a + b + c = 1000.
//:
//: Find the product abc.


public struct PythagoreanTriple{

    let a, b, c : Int

    public init(_ leg: Int, _ midLeg: Int, _ hyp: Int){
        a = leg
        b = midLeg
        c = hyp
    }

    public init(){
        a = 0
        b = 0
        c = 0
    }

}

func findPythagoreanTripleWithSum(sum : Int) -> PythagoreanTriple{

    if sum <= 0{
        return PythagoreanTriple()
    }

    for var m = 2; m < getSquareRootFloorValue(sum/2); m++ {

        for var n = 1; n < m; n++ {

            let a = Int(pow(Double(m), 2) - pow(Double(n), 2))
            let b = 2*m*n
            let c = Int(pow(Double(m), 2) + pow(Double(n), 2))

            if a+b+c == sum{
                return PythagoreanTriple(a,b,c)
            }

        }

    }

    return PythagoreanTriple()
}

func getProductOfPythagoreanTriple(triple : PythagoreanTriple) -> Int {


    return triple.a * triple.b * triple.c

}

getProductOfPythagoreanTriple(findPythagoreanTripleWithSum(1000))

/*
//: ### Problem 10
//: Summation of primes
//:
//: The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
//:
//: Find the sum of all the primes below two million.
*/

func isPrime(number: Int) -> Bool{

    let root = getSquareRootFloorValue(number)

    for var factor = 2; factor <= root; factor++ {

        if number%factor == 0{

            return false

        }

    }

    return true

}


func findSumOfPrimes(var sum: Int, var currentIndex: Int) -> Int {
    
    while true{
        
        let lhs = 6*currentIndex-1
        
        if lhs >= 2000000{
            break
        }
        
        if (isPrime(lhs)){
            sum += lhs
        }
        
        let rhs = 6*currentIndex+1
        
        if rhs >= 2000000{
            break
        }
        
        if (isPrime(rhs)){
            sum += rhs
        }
        
        currentIndex++
        
    }
    
    return sum
    
}


//: [Next](@next)
