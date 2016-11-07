// Add a number - Let's do it iteratively + tail recursively!
// https://coderbyte.com/editor/guest:Simple%20Adding:Java


import java.util.*;
import java.io.*;

class Add {
  public static void main(String[] args){
    Scanner scan  = new Scanner(System.in);
    System.out.print("Enter a number: ");
    int num = scan.nextInt();
    int sum = 0;
    System.out.println("Iteratively: " + iterate(num, sum) +
                       "\nRecursively: " + recursive(num, sum));

  }

  public static int iterate(int num, int sum) {
    for(int i = num; i > 0; --i){
        sum+= i;
    }
    return sum;
  }

  public static int recursive(int num, int sum){
    if(num <= 0){
      return sum;
    }
    else {
      return recursive(num - 1, sum + num);
    }
  }

}
