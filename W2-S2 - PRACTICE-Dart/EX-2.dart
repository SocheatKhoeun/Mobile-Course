enum Status { active, closed, suspended }

class BankAccount {
  final int accID;
  final String accOwner;
  final Status status;
  double _balance = 0.0;

  BankAccount({
    required this.accID,  
    required this.accOwner, 
    this.status = Status.active,
  });

  double get balance => _balance;

  void credit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount > _balance) {
      print("Insufficient balance for withdrawal!");
    } else {
      _balance -= amount;
    }
  }

  @override
  String toString() {
    return "Id: $accID, Owner: $accOwner, Status: ${status.toString().split('.').last.toUpperCase()}, Balance: \$$_balance";
  }
}

class Bank {
  final String name;
  List<BankAccount> _accounts = [];

  Bank({required this.name});

  BankAccount createAccount({required int accID, required String accOwner, Status status = Status.active}) {
    for (var acc in _accounts) {
      if (acc.accID == accID) {
        throw Exception("Account with ID $accID already exists!");
      }
    }
    BankAccount newAccount = BankAccount(accID: accID, accOwner: accOwner, status: status);
    _accounts.add(newAccount);
    return newAccount;
  }

  @override
  String toString() {
    return "Bank Name: $name, Accounts: $_accounts";
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(accID: 100, accOwner: 'Ronan');
  print(ronanAccount);
  print(myBank);

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(myBank);

  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  BankAccount? honglyAccount;
  try {
    ronanAccount.withdraw(75); // This will print a warning
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    honglyAccount = myBank.createAccount(accID: 100, accOwner: 'Hongly', status: Status.closed); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }

  Bank myBank1 = Bank(name: "ABA Bank");
  honglyAccount = myBank1.createAccount(accID: 99, accOwner: 'Hongly', status: Status.closed);
  print(honglyAccount);
  print(myBank1);
  
}
