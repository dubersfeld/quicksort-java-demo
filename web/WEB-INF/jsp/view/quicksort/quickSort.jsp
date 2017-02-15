<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    												pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Quicksort</title>

<link rel="stylesheet"
              href="<c:url value="/resources/stylesheet/quickSort.css" />" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<script>
"use strict";

function canvasSupport() {
  return !!document.createElement('canvas').getContext;
} 


function canvasApp() {

    var N = 150;// number of elements to sort
    var delay = 50;

    var randomized = false;
 
    var values = [];// values to be sorted
    
    var displayData = [];// for display only

    function Sorter(values) {
   
        this.values = values;
        this.aux = [];

        this.results = [];
      
        this.swapCount = 0;
        this.count = 0;

        this.mLength = values.length;

        this.swap = function(i, j) {// swap aux[i] and aux[j], not i an j
            var temp = this.values[i];
            this.values[i] = this.values[j];
            this.values[j] = temp;
        };// swap

        this.partition = function(p, r) {
            var temp = this.values[r];
            var i = p;

            for (var j = p; j < r; j++) {
                if (this.values[j] <= temp) {
                    i++;
                    this.swap(i-1, j);
                    this.results.push(this.values.slice(0));// save copy for animation after each swap
                    this.swapCount++;
                }
                this.count++;
            }
            this.swap(i, r);
            this.results.push(this.values.slice(0));// save copy for animation after each swap
            this.swapCount++;
          
            return i; 
        };// partition

        // main method, non recursive quicksort implementation, using explicit stack
        this.quickSort = function() {    
            var stack = [];

            this.swapCount = 0;
            this.count = 0;

            var p, q, r, top;

            stack.push([0, this.mLength-1]);
           
            // main loop
            while (stack.length > 0) {         
                top = stack.pop();
                p = top[0];
                r = top[1];
                
                q = this.partition(p, r);        

                // push on stack
                if (q > 0 && p < q-1) {                        
                    stack.push([p, q-1]);
                }

                if (r < this.mLength && q+1 < r) {                        
                    stack.push([q+1, r]);
                }
                 
            }

            this.results.push(this.values.slice(0));// save copy for animation
        };// quickSort
 
    }// Sorter

    function initGeometry() {
        var deltaX = (xMax - 20) / N;

        for (var i = 0; i < N; i++) {
            xPos.push(10 + i * deltaX);
        }
    }// initGeometry


    function fillBackground() {
        // draw background
        context.fillStyle = '#ffffff';
        context.fillRect(xMin, yMin, xMax, yMax);    
    }// fillBackground

    function drawValues(values) {
        fillBackground();
        for (var i = 0; i < values.length; i++) {
            context.beginPath();
            context.strokeStyle = "black";
            context.lineWidth = 2;
            context.moveTo(xPos[i], yMax);
            context.lineTo(xPos[i], yMax - values[i]);
            context.stroke();
            context.closePath();
        }
    }// drawValues

    if (!canvasSupport()) {
        return;
    } else {
        var theCanvas = $('#canvas')[0];
        var context = theCanvas.getContext("2d");
    }

    var xMin = 0;
    var yMin = 0;
    var xMax = theCanvas.width;
    var yMax = theCanvas.height;

    var xPos = [];
  
    function init(values) {
    
        fillBackground();
        
	drawValues(values)	

        $('#stanim').find(':submit')[0].disabled = false;
        $('#initelem').find(':submit')[0].disabled = false;
   
    }// init
  
    function randomize() {   
        var val;
        var more;

        var values = [];

        for (var i = 0; i < N; i++) {
              more = true;// flag
              while(more) {
                more = false;
                val = Math.floor(Math.random() * 500 + 20);
                for (var j = 0; j < values.length; j++) {
                      if (val == values[j]) {// value already present
                           more = true;
                         break;
                      } 
                }           
              }
              values[i] = val;    
        }
     
        randomized = true;
        init(values);
    
        return values;  
    }// randomize

    $('#initelem').submit(function(event) { randomize(); return false; } );

    $('#stanim').submit(function(event) { 
        startAnim(); 
        $('#stanim').find(':submit')[0].disabled = true; 
        $('#initelem').find(':submit')[0].disabled = true;  
        return false; 
    });

    function startAnim() {// this is an event handler  
    	/* startAnim sends an AJAX request to the server. 
	    This request should be an Array of integers */
	    
        var rand = $('#random').prop('checked');// random pivot choice selection
	    
        var message = {"rand": rand, "values": values};
        
		$.ajax({
			type : "POST",
			contentType : "application/json",
			url : '<c:url value="/sort" />',
			data : JSON.stringify(message),
			dataType : 'json',
			timeout : 100000,
			success : function(data) {
				console.log("SUCCESS");
				displayData = data; 
				display(displayData); 
			},
			
			error : function(e) {
				console.log("ERROR: ", e);
			},
			done : function(e) {
				console.log("DONE");
			}
		});
		
	    console.log("startAnim completed");
	  
    }
    
    
    function display(data) {
		// extract display results from the AJAX response
		var results = data["results"];
		var count = data["count"];
		var swapCount = data["swapCount"];
		
        // display number of comparisons
        $('#countDisp').text(count);

        // display number of swaps
        $('#swapCountDisp').text(swapCount);
                
        // initialize
        var iAnim = 0;
        var temp = [];

        function act() {               
            temp = results[iAnim];

	    	drawValues(temp);
        
        	// schedule next step
        	if (iAnim < results.length-1) {
            	iAnim++;
              	setTimeout(act, delay);
        	} else {// animation completed
                $('#stanim').find(':submit')[0].disabled = false;
                $('#initelem').find(':submit')[0].disabled = false;
        	}
    	}// act

        window.location.hash = "#animanc";

        act();
    }

    initGeometry();

    values = randomize();
    
    console.log("canvasApp completed");
}// canvasApp

$(document).ready(canvasApp);

</script>
</head>

<body id="all">

  <div id="intro">
  <h1>Quicksort algorithm demonstration</h1>
  <p>I present here a Javascript only demonstration of Quicksort.<br/> 
The number of values to be sorted is fixed to 150.<br/> The actual values are randomized.<br/>
You can choose between the basic Quicksort and the version with random pivot choice.
  </p>
  </div>

  <div id="counts">
    <p id="compars">Number of comparisons: <span id="countDisp"></span></p>
    <p id="swaps">Number of swaps: <span id="swapCountDisp"></span></p>
  </div>

  <div id="display">
    <canvas id="canvas" width="620" height="600">
    Your browser does not support HTML 5 Canvas
    </canvas>
    <a id=animanc></a>
    <footer>
    <br><br>
    Dominique Ubersfeld, Cachan, France
    </footer>
  </div>

  <div id="controls">
    <div>
      <form id="partition">
        <input type="checkbox" name="random" id="random">Random pivot choice<br>
      </form>
    </div>   
  
  
    <div id="randomize">
      <p>Click here to randomize the values to be sorted</p>
      <form name="initialize" id="initelem">
        <input type="submit" name="randomize-btn" value="Randomize">
      </form>
    </div>
   
    <div id="anim">
      <p>Click here to run the Quicksort algorithm and start the animation</p>
      <form id="stanim">
        <input type="submit" name="stanim-btn" value="Start animation">
      </form>
    </div>

  </div>

</body>
</html>