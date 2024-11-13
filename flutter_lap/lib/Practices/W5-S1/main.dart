import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top gray bar
            Container(
              height: 100,
              color: Colors.grey,
            ),
            
            // Blue section with remaining width and fixed-width pink container
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            
            // Green and pink section
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    color: Colors.green,
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.pink,
                ),
              ],
            ),
            
            // Yellow and gray blocks with equal spacing
            Row(
              children: [
                Container(width: 20, height: 100, color: Colors.grey),
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    height: 100,
                  ),
                ),
                Container(width: 20, height: 100, color: Colors.grey),
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    height: 100,
                  ),
                ),
                Container(width: 20, height: 100, color: Colors.grey),
                Expanded(
                  child: Container(
                    color: Colors.yellow,
                    height: 100,
                  ),
                ),
                Container(width: 20, height: 100, color: Colors.grey),
              ],
            ),

            // Bottom pink section with remaining space
            Expanded(
              child: Container(
                color: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
