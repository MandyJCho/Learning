import java.util.*;
import java.io.*;

// Replace any letter in a string to the
// letter following it in the alphabet.
// Then capitalize all vowels.
// https://coderbyte.com/editor/guest:Letter%20Changes:Java


class NextLetter{

  public static void main(String[] args) {
    Scanner scan = new Scanner(System.in);
    System.out.print("Enter a sentence: ");
    String sen = scan.nextLine();
    change(sen);
  }

  public static void change(String sen){
    for (char ch : sen.toCharArray()){
      // Z and non-letters stay constant
      if (ch == 'z' || ch == 'Z' || !Character.isLetter(ch)){
        System.out.print(ch);
        continue;
      }

      // Typecasting for regex
      String chStr = Character.toString(++ch);

      if(chStr.matches("[aeiou]")){
        chStr = chStr.toUpperCase();
      }
      System.out.print(chStr);
    }

    System.out.println();
  }

}
