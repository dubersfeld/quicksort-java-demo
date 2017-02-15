package com.dub.site.quicksort;

import java.util.ArrayList;
import java.util.List;

/**
 * This class implements the basic Quick Sort algorithm **/
public class QuickSort {
	
	private List<Integer> values;
	private int mLength;
	private int count;// number of comparisons for display only 
	private int swapCount;// number of swaps for display only 
	
	private QuickSortResult results;
	
	
	public QuickSort(List<Integer> values, QuickSortResult results) {
		this.values = values;
		this.results = results;
		mLength = values.size();
		count = 0;
		swapCount = 0;
	}
	
	
	private void swap(int i, int j) {
		int temp = values.get(i);
		values.set(i, values.get(j));
		values.set(j, temp);			
	}

	private int partition(int p, int r) {
				
		int temp = values.get(r);
					
		int i = p;

		for (int j = p; j < r; j++) {
			if (values.get(j) <= temp) {
				i++;
				swap(i-1, j);
				swapCount++;
			    // used for animation only  
		        results.addResult(new ArrayList<Integer>(values));
			}
			count++;
		}

		swap(i, r);
		swapCount++;
	    // used for animation only  
        results.addResult(new ArrayList<Integer>(values));

		return i; 
	}// partition
	
	// main method, non recursive quicksort implementation, using explicit stack
    public void quickSort() {
                			
        Stack<Pair> stack = new Stack<>();

        int p, q, r;
        
        Pair top;

        // initial push to start
        stack.push(new Pair(0, mLength-1));

        // main loop
        while (!stack.isEmpty()) {     
       
        	top = stack.pop();
        	
        	p = top.getP();
        	r = top.getQ();
        	             
        	q = partition(p, r);     
        	     	
        	// push on stack
        	if (q > 0 && p < q-1) {                        
        		stack.push(new Pair(p, q-1));
        	}

        	if (r < mLength && q+1 < r) {                        
        		stack.push(new Pair(q+1, r));
        	}
                 
        }
 
        // used for animation only
        results.addResult(new ArrayList<Integer>(values));
       	
     	results.setCount(count);
     	results.setSwapCount(swapCount);
         	
    }// quickSort


	public int getmLength() {
		return mLength;
	}


	public void setmLength(int mLength) {
		this.mLength = mLength;
	}

}
