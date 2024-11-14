class MyDuration {
  final int _milliseconds;

  // Named constructors
  MyDuration.fromSeconds(int seconds): _milliseconds = seconds * 1000;
  MyDuration.fromMinutes(int minutes): _milliseconds = minutes * 60 * 1000;
  MyDuration.fromHours(int hours): _milliseconds = hours * 60 * 60 * 1000; 
  
  // Operator Overloading
  MyDuration operator +(MyDuration other) { // Add two durations 
    // We use ~/ for division to get the integer result
    return MyDuration.fromSeconds((_milliseconds + other._milliseconds) ~/ 1000);
  }

  // Compare two durations 
  bool operator >(MyDuration other) {
    return _milliseconds > other._milliseconds;
  }

  // Substraction two durations
  MyDuration operator -(MyDuration other){
  int resultMilliseconds = _milliseconds - other._milliseconds;
    if (resultMilliseconds < 0){
      throw Exception("Resulting duration cannot be negative");
    }
    return MyDuration.fromSeconds(resultMilliseconds ~/ 1000);
  }

  // Display the duration in a readable format
  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.fromHours(3); // 3 hours
  MyDuration duration2 = MyDuration.fromMinutes(45); // 45 minutes
  
  print(duration1);
  print(duration2);
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1 > duration2); // true
  
  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e);
  }
}
