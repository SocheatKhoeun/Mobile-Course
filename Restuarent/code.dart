import 'dart:io';

enum OrderStatus { pending, completed, cancelled }
enum PaymentStatus { unpaid, paid }
enum CategoryStatus { food, drink, dessert }

class MenuItem {
  final int itemID; 
  final String name;
  final double price; 
  final CategoryStatus category; 
  MenuItem({
    required this.itemID,
    required this.name,
    required this.price,
    required this.category,
  });

  void displayProduct() {
    print("ID: $itemID, Name: $name, Price: \$${price.toStringAsFixed(2)}, Category: ${category.name}");
  }
}

class Menu {
  final List<MenuItem> _items = <MenuItem>[];

  void addItem(MenuItem item) => _items.add(item);

  void removeItem(int itemID) {
    final itemIndex = _items.indexWhere((item) => item.itemID == itemID);
    if (itemIndex != -1) {
      _items.removeAt(itemIndex);
      print("Item removed!");
    } else {
      print("Item not found in menu!");
    }
  }

  void displayMenu() {
    print("============== Menu ==============");
    if (_items.isEmpty) {
      print("No items in menu!");
    } else {
      for (var item in _items) {
        item.displayProduct();
      }
    }
  }

  List<MenuItem> get items => List.unmodifiable(_items);
}

class Order {
  OrderStatus _orderStatus = OrderStatus.pending;
  PaymentStatus _paymentStatus = PaymentStatus.unpaid; 
  final Customer customer; 
  final List<MenuItem> _items = <MenuItem>[]; 
  final DateTime orderDateTime;
  final int tableNum; 
  double totalPrice = 0.0; 

  Order({required this.customer, required this.tableNum, required this.orderDateTime});

  void addItem(MenuItem item) {
    _items.add(item);
    calculateTotal();
  }

  void updateOrderStatus(OrderStatus status) => _orderStatus = status;
  void updatePaymentStatus(PaymentStatus status) => _paymentStatus = status;

  void calculateTotal() {
    totalPrice = _items.fold(0.0, (sum, item) => sum + item.price);
  }

  void displayReceipt() {
  // Format the order date & time manually
  String formattedDateTime = '${orderDateTime.year}-${orderDateTime.month.toString().padLeft(2, '0')}-${orderDateTime.day.toString().padLeft(2, '0')} ${orderDateTime.hour.toString().padLeft(2, '0')}:${orderDateTime.minute.toString().padLeft(2, '0')}:${orderDateTime.second.toString().padLeft(2, '0')}';

  print("\n===== Order Receipt =====");
  print("Customer: ${customer.name}, Contact: ${customer.contactDetails}");
  print("Table: $tableNum, Date & Time: $formattedDateTime");

  print("Items:");
  for (var item in _items) {
    print("- ${item.name} (${item.category.name}), Price: \$${item.price.toStringAsFixed(2)}");
  }

  print("Order Status: ${_orderStatus.name}, Payment Status: ${_paymentStatus.name}");
  print("Total Price: \$${totalPrice.toStringAsFixed(2)}\n=========================\n");
}
}

class Customer {
  final String name; 
  final String contactDetails;

  Customer({required this.name, required this.contactDetails});
}

void main() {
  Menu menu = Menu();
  List<Order> orders = [];
  bool isRunning = true;

  while (isRunning) {
    print("\n=========== Main Menu ===========");
    print("1. Display Menu");
    print("2. Place an Order");
    print("3. Show Order Information");
    print("4. Exit");
    stdout.write("Select an option: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        showMenu(menu);
        break;
      case '2':
        orders.add(placeOrder(menu));
        break;
      case '3':
        showOrders(orders);
        break;
      case '4':
        isRunning = false;
        print("Good Byeeeee......!");
        break;
      default:
        print("Invalid choice. Please try again!");
    }
  }
}

void showMenu(Menu menu) {
  bool inMenu = true;

  while (inMenu) {
    print("\n=========== Menu Management ===========");
    print("1. Show Menu Items");
    print("2. Add Menu Item");
    print("3. Remove Menu Item");
    print("4. Back to Main Menu");
    stdout.write("Select an option: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        menu.displayMenu(); 
        break;
      case '2':
        addMenuItem(menu);
        break;
      case '3':
        removeMenuItem(menu);
        break;
      case '4':
        inMenu = false;
        break;
      default:
        print("Invalid choice. Please try again!");
    }
  }
}

void addMenuItem(Menu menu) {
  stdout.write("Enter Item ID: ");
  int? itemID = int.tryParse(stdin.readLineSync() ?? '');
  if (itemID == null) {
    print("Invalid input. Please enter a valid number!");
    return;
  }

  stdout.write("Enter Item Name: ");
  String name = stdin.readLineSync() ?? '';

  stdout.write("Enter Item Price: ");
  double? price = double.tryParse(stdin.readLineSync() ?? '');
  if (price == null) {
    print("Invalid input. Please enter a valid price!");
    return;
  }

  stdout.write("Enter Item Category (1: Food, 2: Drink, 3: Dessert): ");
  int? categoryChoice = int.tryParse(stdin.readLineSync() ?? '');
  if (categoryChoice == null || categoryChoice < 1 || categoryChoice > 3) {
    print("Invalid category selection!");
    return;
  }
  var category = CategoryStatus.values[categoryChoice - 1];

  menu.addItem(MenuItem(itemID: itemID, name: name, price: price, category: category));
  print("Item added to menu!");
}

void removeMenuItem(Menu menu) {
  stdout.write("Enter Item ID to remove: ");
  int? itemID = int.tryParse(stdin.readLineSync() ?? '');
  if (itemID == null) {
    print("Invalid input. Please enter a valid number!");
    return;
  }
  menu.removeItem(itemID);
}

Order placeOrder(Menu menu) {
  stdout.write("Enter Customer Name: ");
  String name = stdin.readLineSync() ?? '';

  stdout.write("Enter Customer Contact: ");
  String contact = stdin.readLineSync() ?? '';

  Customer customer = Customer(name: name, contactDetails: contact);

  stdout.write("Enter Table Number for Reservation: ");
  int? tableNum = int.tryParse(stdin.readLineSync() ?? '');
  if (tableNum == null) {
    print("Invalid input. Setting table number to 0!");
    return Order(customer: customer, tableNum: 0, orderDateTime: DateTime.timestamp());
  }

  Order order = Order(customer: customer, tableNum: tableNum, orderDateTime: DateTime.timestamp());

  bool addingItems = true;
  while (addingItems) {
    menu.displayMenu();
    stdout.write("Enter Menu Item ID to add to order (or type 0 to finish): ");
    int? itemID = int.tryParse(stdin.readLineSync() ?? '');
    if (itemID == null || itemID == 0) {
      addingItems = false;
    } else {
      try {
        MenuItem foundItem = menu.items.firstWhere((menuItem) => menuItem.itemID == itemID);
        order.addItem(foundItem);
        print("Item added to order!");
      } catch (e) {
        print("Item not found. Please try again!");
      }
    }
  }

  print("Select Order Status (1: Pending, 2: Completed, 3: Cancelled): ");
  int? statusChoice = int.tryParse(stdin.readLineSync() ?? '');
  if (statusChoice != null && statusChoice >= 1 && statusChoice <= 3) {
    order.updateOrderStatus(OrderStatus.values[statusChoice - 1]);
  } else {
    print("Invalid choice, setting status to Pending by default!");
  }

  print("Select Payment Status (1: Unpaid, 2: Paid): ");
  int? paymentChoice = int.tryParse(stdin.readLineSync() ?? '');
  if (paymentChoice != null && paymentChoice >= 1 && paymentChoice <= 2) {
    order.updatePaymentStatus(PaymentStatus.values[paymentChoice - 1]);
  } else {
    print("Invalid choice, setting payment status to Unpaid by default!");
  }

  return order;
}

void showOrders(List<Order> orders) {
  if (orders.isEmpty) {
    print("No orders have been placed!");
  } else {
    for (var order in orders) {
      order.displayReceipt();
    }
  }
}
