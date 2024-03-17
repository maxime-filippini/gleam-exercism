pub type TreasureChest(treasure) {
  TreasureChest(password: String, treasure: treasure)
}

pub type UnlockResult(treasure) {
  Unlocked(treasure: treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case password == chest.password {
    True -> Unlocked(chest.treasure)
    False -> WrongPassword
  }
}
