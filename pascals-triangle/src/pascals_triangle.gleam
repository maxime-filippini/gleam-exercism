import gleam/list
import gleam/result

pub fn rows(n: Int) -> List(List(Int)) {
  // We build the first row with 0s to enable summing
  let first_row =
    list.flatten([list.repeat(0, times: n), [1], list.repeat(0, times: n)])

  // Handling the case where no row is applied
  case n == 0 {
    True -> []
    False ->
      triangle_rec(n, n, first_row, [])
      |> list.map(list.filter(_, fn(x) { x > 0 }))
  }
}

/// Builds a single row of the triangle based on the previous row
pub fn single_row_rec(prev_row: List(Int), acc: List(Int)) -> List(Int) {
  case prev_row {
    [] -> acc

    // If only one or two elements are found, we are at the end of our row
    [i, _] | [i] -> {
      list.append(acc, [i])
    }

    // If three elements are found, we sum #1 and #3 (#2 will always be 0), and
    // we call the function on the same row to which we removed #1.
    [first, second, third, ..tail] -> {
      single_row_rec([second, third, ..tail], list.append(acc, [first + third]))
    }
  }
}

/// Build the rows of the triangle
pub fn triangle_rec(
  n: Int,
  n_current: Int,
  first_row: List(Int),
  acc: List(List(Int)),
) -> List(List(Int)) {
  case n_current {
    // The first row is known in advance as a function of the number of rows
    i if i == n ->
      triangle_rec(n, n_current - 1, first_row, list.append(acc, [first_row]))

    // No more rows needed
    i if i < 1 -> acc

    // We recurse by decrementing `n_current` by calling the row builder with
    // the last element of our accumulator as argument.
    _ ->
      triangle_rec(
        n,
        n_current - 1,
        first_row,
        list.append(acc, [
          single_row_rec(result.unwrap(list.last(acc), []), [0]),
        ]),
      )
  }
}
