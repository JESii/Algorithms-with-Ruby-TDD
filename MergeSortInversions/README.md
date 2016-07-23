#Using MergeSort to count inversions

This exercise uses MergeSort to count the number of inversions, where an 'inversion' is an out-of-order set of elements.
I.e., for an array a: a\[i] \> a\[j], i\<j. for a sorted array, the inversion count is 0, while for an array sorted in reverse
order, the inversion count is the maximum (for an array of size n, that n(n-1)/2).

Inversions give an indication of the 'unsortedness' of any array and can als be used to determine how similar two arrays are:
the closer the inversion count, the more similar the arrays.

The first set of tests are for creating the MergeSort routine and the second set is for implementing the Inversions count.
There are more tests here than would normally be needed because of a bug I encountered that required additional testing.

The inversions\_prod.rb file actually runs the routine against the large array (10,000 integers).
