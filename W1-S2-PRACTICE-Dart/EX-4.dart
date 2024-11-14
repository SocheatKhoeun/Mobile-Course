void main(){

  //Define the pizzaPrices map
  const Map<String, double> pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  //Define the order
  const List<String> order = ['margherita', 'pepperoni', 'domino'];

  //let total variable for Calculate the total of prices 
  double total = 0.0;
  //loop through the order list and add the price of each pizza to the total
  for (String pizza in order) {
    if (pizzaPrices.containsKey(pizza)) {  
      total += pizzaPrices[pizza]!;
    } else {
      // If pizza is not on the menu
      print('$pizza pizza is not on the menu');
    }
  }

  print('Total: \$$total');
  
}