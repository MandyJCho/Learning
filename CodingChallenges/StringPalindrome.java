/* Write code to check a String is palindrome or not?
Palindrome are those String whose reverse is equal to original.
http://javarevisited.blogspot.com/2011/06/top-programming-interview-questions.html
*/

import java.util.*;
import java.io.*;

class StringPalindrome {
  public static void main(String[] args){
      // Niceties
      Scanner scan = new Scanner(System.in);
      System.out.print("Enter a string: ");
      String str = scan.nextLine();
      str = str.toLowerCase();

      // Flippity Flip
      StringBuffer rts = new StringBuffer(str);
      rts = rts.reverse();

      // Check
      if (str.equals(rts.toString())) {
          System.out.println("Is palindromic");
      }

      else {
        System.out.println("Not palindromic");
      }

  }

}
