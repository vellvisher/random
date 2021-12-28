// From Morning Brew newsletter 24th December 2021.
// Your task is to make 100 by placing pluses and minuses in the string of digits 9 8 7 6 5 4 3 2 1 in
// that order. But that’s not actually your only task. To get full credit on this puzzle, you must find the
// least number of pluses and minuses needed to get to 100.

let array = [9, 8, 7, 6, 5, 4, 3, 2, 1]
let target = 100

// let array = [-1, 1, 1]
// let target = 100

var currentBest = Int.max
var currentSeq: [Int] = []
var PLUS = -1 + Int.max
var MINUS = -2 + Int.max
var totalIter = 0

func main() {
  guard let first = array.first else {
    print("Need at least one element")
    return
  }

  findsTarget(remaining: Array(array.dropFirst()), currentSum: [first], currentSymbols: 0)
  findsTarget(remaining: Array(array.dropFirst()), currentSum: [-first], currentSymbols: 1)
  if currentBest == Int.max {
    print("No solution!")
  }
  print("Total iterations \(totalIter)")
}

func findsTarget(remaining: [Int], currentSum: [Int], currentSymbols: Int) {
  totalIter = totalIter + 1
  if remaining.isEmpty {
    if currentSum.total() == target && currentSum.symbols < currentBest {
      print("\(currentSum.pretty()) with \(currentSum.symbols) symbols")
      currentSeq = currentSum
      currentBest = currentSum.symbols
    }
    return
  }

  findsTarget(
    remaining: Array(remaining.dropFirst()),
    currentSum: currentSum + [PLUS, remaining.first!],
    currentSymbols: currentSymbols + 1)
  findsTarget(
    remaining: Array(remaining.dropFirst()),
    currentSum: currentSum + [MINUS, remaining.first!],
    currentSymbols: currentSymbols + 1)
  findsTarget(
    remaining: Array(remaining.dropFirst()),
    currentSum: Array(currentSum.dropLast()) + [
      currentSum.last! * 10 + (remaining.first! * (currentSum.last! < 0 ? -1 : 1))
    ],
    currentSymbols: currentSymbols)
}

extension Array where Element == Int {
  func total() -> Int {
    var totalSum = self.first!
    for i in 0..<self.count {
      if self[i] == PLUS {
        totalSum = totalSum + self[i + 1]
      } else if self[i] == MINUS {
        totalSum = totalSum - self[i + 1]
      }
    }
    return totalSum
  }

  var symbols: Int {
    return self.filter { $0 == PLUS || $0 == MINUS }.count
  }

  func pretty() -> String {
    return self.map {
      switch $0 {
      case PLUS:
        return "+"
      case MINUS:
        return "-"
      default:
        return String($0)
      }
    }.joined()
  }
}

main()
