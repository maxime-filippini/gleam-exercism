pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(pizza) -> pizza_price(pizza) + 1
    ExtraToppings(pizza) -> pizza_price(pizza) + 2
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [_] -> order_price_rec(order, 3)
    [_, _] -> order_price_rec(order, 2)
    _ -> order_price_rec(order, 0)
  }
}

pub fn order_price_rec(order: List(Pizza), acc: Int) -> Int {
  case order {
    [] -> acc
    [head, ..tail] -> order_price_rec(tail, acc + pizza_price(head))
  }
}
