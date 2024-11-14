enum Direction { north, east, south, west }
 
void main() {
  
  // Initial position {7, 3} and facing north
  int x = 7;
  int y = 3;
  Direction direction = Direction.north;

  // Example instruction sequence
  const instructions = "RAALAL";

  // Process the instructions and get the final position and direction
  for (var instruction in instructions.split('')) {
    // Turn right (clockwise)
    if (instruction == 'R' || instruction == 'r'){
      //Adding 1 allows to move clockwise through the direction enum
      direction = Direction.values[(direction.index + 1) % 4];
    }
    // Turn left (counterclockwise)
    else if (instruction == 'L' || instruction == 'l'){
      //Adding 3 to the current index effectively moves the robot counterclockwise
      direction = Direction.values[(direction.index + 3) % 4];
    }
    // Move forward based on the current direction
     else if (instruction == 'A' || instruction == 'a') {
      switch (direction) {
        case Direction.north:
          y += 1;
          break;
        case Direction.east:
          x += 1;
          break;
        case Direction.south:
          y -= 1;
          break;
        case Direction.west:
          x -= 1;
          break;
      }
    }
  }
  // Print the final position and direction
  print("Final position: ($x, $y)");
  print("Facing: $direction");
  print("Facing: ${direction.toString().split('.').last}");
}
