void main() {

  // List of texts to check 
  List<String> texts = ["{what is (42)}?", "[text}", "{{[(a)b]c}d}", "Hello}"];
  
  int parenthesesCount = 0; 
  int curlyBracesCount = 0;
  int squareBracketsCount = 0;

  // Loop through each text
  for (var text in texts) {
    // Loop through each character in the text
    for (var char in text.split('')) {
      // Count the opening brackets
      if (char == '(') {
        parenthesesCount += 1;
      } 
      else if (char == '{') {
        curlyBracesCount += 1;
      } 
      else if (char == '[') {
        squareBracketsCount += 1;
      }
      // Count the closing brackets
      else if (char == ')') {
        parenthesesCount -= 1;
      } 
      else if (char == '}') {
        curlyBracesCount -= 1;
      } 
      else if (char == ']') {
        squareBracketsCount -= 1;
      }
    }

    // Final check: The count should be zero for balanced brackets
    if (parenthesesCount == 0 && curlyBracesCount == 0 && squareBracketsCount == 0) {
      print("$text is Balanced");
    } else {
      print("$text is Not balanced");
    }
  }
}
