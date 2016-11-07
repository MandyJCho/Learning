/**
 * Created by choma on 10/25/2016.
 */

import java.util.*;

public class Test{

    public static void main (String... args){

        ArrayList<Integer> arr = new ArrayList<>();
        for (int i = 0; i < 10; i++)
            arr.add((int)(Math.random() * 15));

        //bubbleSort(arr);
        //selectionSort(arr);
        arr.forEach(System.out::println);


    }

   // Bubble Sort - O(n^2) Omega(n) - you reduce the number of iterations by 1 every time
   // If the number on the left is larger than the right, swap
   // Continue so long as no swaps occur (Best Case of n)
    public static void bubbleSort(ArrayList<Integer> bean){
        Boolean doRepeat;

       do {
            int i = bean.size() - 1;
            doRepeat = false;

            for (int j = 0; j < i; j++){
                if (bean.get(j) > bean.get(j + 1)) {
                    int temp = bean.get(j);
                    bean.set(j, bean.get(j + 1));
                    bean.set(j + 1, temp);
                    doRepeat = true;
                }
            }
            i--;

       } while (doRepeat);
    }

    // Selection Sort - O(n^2) Omega(n^2) - swaps the value at index n with the nth smallest value
    // Iterations reduce by starting at n+1 for every iteration rather than from the beginning
    // So the first iteration will loop n times, the second iteration will loop n - 1 times, etc.
    public static void selectionSort(ArrayList<Integer> arr){
        int min, swapIndex = 0, swapValue = 0;

        for (int i = 0; i < arr.size() - 1; i++){
            min = arr.get(i);
            swapIndex = i;
            swapValue = min;

            for (int j = i + 1; j < arr.size(); j++){
                if (min > arr.get(j)){
                    min = arr.get(j);
                    swapIndex = j;
                }
            }
            swapValue = arr.get(i);
            arr.set(i, arr.get(swapIndex));
            arr.set(swapIndex, swapValue);
        }
    }



}




