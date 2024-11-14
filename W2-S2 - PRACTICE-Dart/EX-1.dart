enum Skill { FLUTTER, DART, PHP, LARAVEL, C, CPP, OTHER }

class Address {
  final String street;
  final String city;
  final String zipCode;

  Address(this.street, this.city, this.zipCode);

  @override
  String toString() => "Street: $street, City: $city, ZipCode: $zipCode";
}

class Employee {
  final String _name;
  final double _baseSalary = 40000;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  // Constructor
  Employee(this._name, this._skills, this._address, this._yearsOfExperience);

  Employee.mobileDeveloper(String name, Address address, int yearsOfExperience):
    this._name = name,
    this._skills = [Skill.FLUTTER, Skill.DART],
    this._address = address,
    this._yearsOfExperience = yearsOfExperience;

  // methods
  String get name => this._name;
  List<Skill> get skills => this._skills;
  Address get address => this._address;
  int get yearsOfExperience => this._yearsOfExperience;

  // Method to calculate salary
  double calculateSalary() {
    double salary = _baseSalary + (_yearsOfExperience * 2000);
    for (var skill in _skills) {
      if (skill == Skill.FLUTTER) {
        salary += 5000;
      } else if (skill == Skill.DART) {
        salary += 3000;
      } else if (skill == Skill.OTHER) {
        salary += 1000;
      }
    }
    return salary;
  }

  @override
  String toString() {
    return "Employee Name: $name\nAddress: $address\nYears Of Experience: $_yearsOfExperience\nSkills: ${_skills.map((skill) => skill.name).join(', ')}\nSalary: \$${calculateSalary()}";
  }

  // Method to display information of employees 
  void displayInf(){
    print("Employee Name: $name");
    print("Address: $address");
    print("Years Of Experience: $_yearsOfExperience");
    print("Skills: ${_skills.map((skill) => skill.name).join(', ')}");
    print("Salary: \$${calculateSalary()}");
  }
}

void main() {
  var address1 = Address("WP", "WP City", "12345");
  var emp1 = Employee("Sokea", [Skill.DART, Skill.C], address1, 5);
  // print(emp1);
  emp1.displayInf();

  var emp2 = Employee.mobileDeveloper("Socheat", address1, 1);
  print(emp2);
}

