pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [i, ..] -> i
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [i, ..tail] -> [i + 1, ..tail]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [0, ..] -> True
    [_, ..tail] -> has_day_without_birds(tail)
  }
}

pub fn total(days: List(Int)) -> Int {
  sum_rec(days, 0)
}

pub fn busy_days(days: List(Int)) -> Int {
  busy_day_rec(days, 0)
}

pub fn sum_rec(days: List(Int), acc: Int) -> Int {
  case days {
    [] -> acc
    [head, ..tail] -> sum_rec(tail, acc + head)
  }
}

pub fn busy_day_rec(days: List(Int), acc: Int) -> Int {
  case days {
    [] -> acc
    [head, ..tail] if head > 4 -> busy_day_rec(tail, acc + 1)
    [_, ..tail] -> busy_day_rec(tail, acc)
  }
}
