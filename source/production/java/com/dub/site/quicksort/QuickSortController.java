package com.dub.site.quicksort;

import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dub.config.annotation.WebController;
import com.dub.site.quicksort.QuickSortResult;

@WebController
public class QuickSortController {

	@RequestMapping(value="quicksort")
	public String quicksort() {
		return "quicksort/quickSort";
	}
	
	
	@RequestMapping(value="sort", method=RequestMethod.POST)
	@ResponseBody
	public  QuickSortResult sort(@RequestBody List<Integer> values) {
			
		QuickSortResult results = new QuickSortResult();
				
		QuickSort sorter = new QuickSort(values, results);
		
		sorter.quickSort();
		
		return results;
	}
	
}
