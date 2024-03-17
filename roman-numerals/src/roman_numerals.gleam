import gleam/string

pub type RomanConversion {
  RomanConversion(current: String, remainder: Int)
}

/// When getting the number of thousands, we consider the case where the 
/// remainder with 1000 is above 900, in which case we need to add "CM" after 
/// the full number of multiples of 1000 in the number.
pub fn get_thousands(number: Int) -> RomanConversion {
  case number % 1000 {
    i if i > 900 ->
      RomanConversion(
        current: string.repeat("M", number / 1000) <> "CM",
        remainder: { number - 900 } % 1000,
      )
    _ ->
      RomanConversion(
        current: string.repeat("M", number / 1000),
        remainder: number % 1000,
      )
  }
}

/// We can only have a maximum of one "D" in our number, so we only need to 
/// make sure if we need to add a "C" before.
pub fn add_five_hundreds(c: RomanConversion) -> RomanConversion {
  case c.remainder {
    i if i > 500 ->
      RomanConversion(current: c.current <> "D", remainder: c.remainder % 500)
    i if i > 400 ->
      RomanConversion(current: c.current <> "CD", remainder: c.remainder % 500)
    _ -> c
  }
}

/// When adding hundreds, we only consider cases where the remainder is below 
/// 400, since in that case, we would have had added "CD" at the previous step.
/// We need to handle the case where the remainder is between 90 and 99, in 
/// which case we need to add "XC", rather than a number of "C"s.
pub fn add_hundreds(c: RomanConversion) -> RomanConversion {
  case c.remainder {
    i if i < 90 -> c
    i if i < 100 ->
      RomanConversion(current: c.current <> "XC", remainder: c.remainder % 90)
    i if i < 400 ->
      RomanConversion(
        current: c.current <> string.repeat("C", i / 100),
        remainder: c.remainder % 100,
      )
    _ -> RomanConversion(current: c.current, remainder: c.remainder % 400)
  }
}

/// Same logic here, can only have one "L".
pub fn add_fifties(c: RomanConversion) -> RomanConversion {
  case c.remainder {
    i if i > 50 ->
      RomanConversion(current: c.current <> "L", remainder: c.remainder % 50)
    i if i > 40 ->
      RomanConversion(current: c.current <> "XL", remainder: c.remainder % 40)
    _ -> c
  }
}

pub fn add_tens(c: RomanConversion) -> RomanConversion {
  case c.remainder {
    9 -> RomanConversion(current: c.current <> "IX", remainder: 0)
    i ->
      RomanConversion(
        current: c.current <> string.repeat("X", i / 10),
        remainder: c.remainder % 10,
      )
  }
}

pub fn add_fives(c: RomanConversion) -> RomanConversion {
  case c.remainder {
    4 -> RomanConversion(current: c.current <> "IV", remainder: c.remainder % 5)
    i if i > 4 ->
      RomanConversion(current: c.current <> "V", remainder: c.remainder % 5)
    _ -> RomanConversion(..c, remainder: c.remainder % 5)
  }
}

pub fn add_ones(c: RomanConversion) -> String {
  c.current
  <> case c.remainder {
    i if i < 4 -> string.repeat("I", i)
    _ -> ""
  }
}

/// The conversion process carries out the operations in sequence.
pub fn convert(number: Int) -> String {
  number
  |> get_thousands
  |> add_five_hundreds
  |> add_hundreds
  |> add_fifties
  |> add_tens
  |> add_fives
  |> add_ones
}
