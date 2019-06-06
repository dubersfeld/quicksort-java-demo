package com.dub.spring.quicksort;


import java.util.ArrayList;
import java.util.List;

/**
 * This helper class is used for display only 
 */

public class QuickSortResult {

    private List<List<Integer>> results;
    private int count;
    private int swapCount;
    
    
    public QuickSortResult() {
    	 results = new ArrayList<>();
    	 count = 0;
    	 swapCount = 0;
    }
    
    
	public List<List<Integer>> getResults() {
		return results;
	}
	public void setResults(List<List<Integer>> results) {
		this.results = results;
	}
	
	public int getSwapCount() {
		return swapCount;
	}
	public void setSwapCount(int swapCount) {
		this.swapCount = swapCount;
	}
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	
	
	// convenience methods
	
	void addResult(List<Integer> newResult) {
		results.add(newResult);
	}
	
}
