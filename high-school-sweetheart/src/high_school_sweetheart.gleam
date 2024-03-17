import gleam/string
import gleam/list
import gleam/result

pub fn first_letter(name: String) -> String {
  name
  |> string.trim
  |> string.first
  |> result.unwrap("")
}

pub fn initial(name: String) {
  name
  |> first_letter
  |> string.uppercase
  |> string.append(".")
}

pub fn initials(full_name: String) -> String {
  full_name
  |> string.split(" ")
  |> list.map(initial)
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  let top =
    "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **"
  let bottom =
    " **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"

  let middle =
    "\n**     "
    <> initials(full_name1)
    <> "  +  "
    <> initials(full_name2)
    <> "     **\n"

  top <> middle <> bottom
}
