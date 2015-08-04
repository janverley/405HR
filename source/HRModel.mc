using Toybox.System as System;
using Toybox.Activity as Activity;
using Toybox.Math as Math;

class HRModel 
{

	var historySize = 60;
	var jumpSize = 15;

	var values = new [historySize];
	var currentPosition = 0;
	
	var ignore_sd = null;
	
	var current;
	var min;
	var max;
	var min_i;
    var max_i;
    var mean;
    var sd;
	
	var hrZones;
	
    function initialize(a_hrZones) 
    {
		Log("HRModel.ctor");
		hrZones = a_hrZones;
    }
    
    function getCurrentHR()
	{
		return current;
	}

    function getCurrentHRZone()
	{
		return hrZones.getZone(current);
	}

    function getHistorySize() 
    {
    	return historySize;
    }
    
    function getValues() 
    {
        return values;
    }

    function getMin() 
    {
        return min;
    }

    function getMax() 
    {
        return max;
    }

    function compute(info) 
    {
    	Log("compute");
    
		current = info.currentHeartRate;

		updateStats();
		
		if(currentPosition == values.size())
		{
			currentPosition -= jumpSize;
			
			for(var i = jumpSize; i < values.size(); i++)
			{
				values[i - jumpSize] = values[i];
			}
			
			// remove everything beyond
			for(var i = values.size() - jumpSize; i < values.size(); i++)
			{
				values[i] = null;
			}
		}
		
		values[currentPosition] = current;
		currentPosition = currentPosition + 1;
			
		Log("post");
		Log(values.toString());
	}

    function updateStats() 
    {
       	Log("updateStats");
    
        min = 99999999;
        max = -99999999;
        min_i = 0;
        max_i = 0;

        var m = 0f;
        var s = 0f;
        var total = 0f;
        var n = 0;

        for (var i = 0; i < values.size(); i++) 
        {
            var item = values[i];
            if (item != null) 
            {
                // Welford
                n++;
                var m2 = m;
                m += (item - m2) / n;
                s += (item - m2) * (item - m);
                total += item;
            }
        }
        if (n == 0) 
        {
            mean = null;
            sd = null;
        }
        else 
        {
            mean = total / n;
            sd = Math.sqrt(s / n);
        }

        var ignore = null;
        if (sd != null && ignore_sd != null) 
        {
            ignore = ignore_sd * sd;
        }

        for (var i = 0; i < values.size(); i++) 
        {
            var item = values[i];
            if (item != null) 
            {
                if (ignore != null &&
                    (item > mean + ignore || item < mean - ignore)) 
                {
                    continue;
                }
                if (item < min) 
                {
                    min_i = i;
                    min = item;
                }
                
                if (item > max) 
                {
                    max_i = i;
                    max = item;
                }
            }
        }
    }

}