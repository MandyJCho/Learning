// Count Clumps
/*
Say that a "clump" in an array is a series of 2 or more adjacent
elements of the same value. Return the number of clumps in the
given array.

countClumps([1, 2, 2, 3, 4, 4]) → 2
countClumps([1, 1, 2, 1, 1]) → 2
countClumps([1, 1, 1, 1, 1]) → 1

*/

public int countClumps(int[] nums) {

  int same = -1;
  int count = 0;

  for ( int i = 0; i < nums.length - 1; i++){
    if (nums[i]==nums[i+1] && same != nums[i]){
      same = nums[i];
      count++;
    }
    else {
      same = nums[i];
    }
  }
  return count;
}

// Exploiting the use of unsigned int test values
// To test for negatives, just switch out smae for a boolean datatype
