import gleam/string

pub fn hey(remark: String) -> String {
  let trimmed = string.trim(remark)

  // Need to make sure that we don't consider remarks with no letters
  // as shouting
  let is_shouting =
    trimmed
    |> fn(x) { string.uppercase(x) == x && string.lowercase(x) != x }

  let is_question = string.ends_with(trimmed, "?")

  case trimmed {
    _ if is_shouting && is_question -> "Calm down, I know what I'm doing!"
    _ if is_shouting -> "Whoa, chill out!"
    _ if is_question -> "Sure."
    "" -> "Fine. Be that way!"
    _ -> "Whatever."
  }
}
