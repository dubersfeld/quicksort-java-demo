package com.dub.spring.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dub.spring.quicksort.Message;
import com.dub.spring.quicksort.QuickSort;
import com.dub.spring.quicksort.QuickSortResult;

@Controller
public class QuickSortController {

	@RequestMapping(value="quicksort")
	public String quicksort() {
		return "quicksort/quickSort";
	}
	
	
	@RequestMapping(value="sort", method=RequestMethod.POST)
	@ResponseBody
	public  QuickSortResult sort(@RequestBody Message message) {
			
		List<Integer> values = message.getValues();
		boolean rand = message.isRand();
			
		QuickSortResult results = new QuickSortResult();
		
		QuickSort sorter = new QuickSort(values, results);
		
		sorter.quickSort(rand);
		
		return results;
	}
	
}
