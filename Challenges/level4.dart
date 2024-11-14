class Distance {
  final double meters; 
  // Constructors
  Distance.cms(double cms): meters = cms / 100;
  Distance.meters(double meters): meters = meters;
  Distance.kms(double kms): meters = kms * 1000;

  // methods
  double get cms => meters * 100;
  double get kms => meters / 1000;

  // Operator Overloading for addition
  Distance operator +(Distance other) {
    return Distance.meters(this.meters + other.meters);
  }
}

void main() {
  Distance d1 = Distance.kms(3.4);   
  Distance d2 = Distance.meters(1000); 

  // Display values
  print(d1.kms);       
  print(d2.kms);
  print((d1 + d2).kms);
  print((d1 + d2).meters); 
  print((d1 + d2).cms);
}
