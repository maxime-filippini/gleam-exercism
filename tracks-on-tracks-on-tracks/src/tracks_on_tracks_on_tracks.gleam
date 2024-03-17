pub fn new_list() -> List(String) {
  []
}

pub fn existing_list() -> List(String) {
  ["Gleam", "Go", "TypeScript"]
}

pub fn add_language(languages: List(String), language: String) -> List(String) {
  [language, ..languages]
}

pub fn count_languages(languages: List(String)) -> Int {
  count_rec(languages, 0)
}

pub fn reverse_list(languages: List(String)) -> List(String) {
  reverse(languages, [])
}

pub fn exciting_list(languages: List(String)) -> Bool {
  case languages {
    ["Gleam", ..] -> True
    [_, "Gleam", _] -> True
    [_, "Gleam"] -> True
    _ -> False
  }
}

pub fn count_rec(list: List(a), acc: Int) -> Int {
  case list {
    [] -> acc
    [_, ..tail] -> count_rec(tail, acc + 1)
  }
}

pub fn reverse(list: List(a), acc: List(a)) -> List(a) {
  case list {
    [] -> acc
    [head, ..tail] -> reverse(tail, [head, ..acc])
  }
}
