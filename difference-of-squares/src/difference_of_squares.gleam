import gleam/list

/// Compute the sum of a list
fn sum(list: List(Int), total: Int) -> Int {
  case list {
    [first, ..rest] -> sum(rest, total + first)
    [] -> total
  }
}

/// Compute the square of the sum of successive integers
/// in an inefficient way.
pub fn square_of_sum(n: Int) -> Int {
  list.range(1, n)
  |> sum(0)
  |> fn(x) { x * x }
}

/// Compute the square of the sum of successive integers
/// using the closed-form expression.
pub fn square_of_sum_efficient(n: Int) -> Int {
  { n * { n + 1 } / 2 }
  |> fn(x) { x * x }
}

/// Compute the sum of squares of successive integers
/// in an inefficient way.
pub fn sum_of_squares(n: Int) -> Int {
  list.range(1, n)
  |> list.map(fn(x) { x * x })
  |> sum(0)
}

/// Compute the sum of squares of successive integers
/// using the closed-form expression.
pub fn sum_of_squares_efficient(n: Int) -> Int {
  n * { n + 1 } * { 2 * n + 1 } / 6
}

/// Compute the difference between the square of the
/// sum of successive integers and the sum of successive
/// integers squared.
pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
