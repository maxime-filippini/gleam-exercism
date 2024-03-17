import gleam/int

pub type Instruction {
  Instruction(divisor: Int, sound: String)
}

pub fn convert_rec(
  instructions instructions: List(Instruction),
  number number: Int,
  acc acc: String,
) -> String {
  case instructions {
    // Base case - We check if the accumulator was modified
    [] ->
      case acc {
        "" -> int.to_string(number)
        _ -> acc
      }

    // Recursion - Build the accumulator, and run the function on the tail of 
    // the list 
    [inst, ..rest] ->
      convert_rec(rest, number, case number % inst.divisor {
        0 -> acc <> inst.sound
        _ -> acc
      })
  }
}

pub fn convert(number: Int) -> String {
  let instructions = [
    Instruction(divisor: 3, sound: "Pling"),
    Instruction(divisor: 5, sound: "Plang"),
    Instruction(divisor: 7, sound: "Plong"),
  ]

  convert_rec(instructions: instructions, number: number, acc: "")
}
