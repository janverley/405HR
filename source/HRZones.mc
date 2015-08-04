
class HRZones
{
    function initialize() 
    {
		Log("HRZones.ctor");	
	}

	function getZone(heartRate)
	{
	    var result = 0;
	    
	    if(heartRate != null)
	    {
	    	if(heartRate < getMax(0))
			{
				result = 0;	
			}
			else if(heartRate < getMax(1))
			{
				result = 1;	
			}
			else if(heartRate < getMax(2))
			{
				result = 2;
			}
			else if(heartRate < getMax(3))
			{
				result = 3;
			}
			else if(heartRate < getMax(4))
			{
				result = 4;
			}
			else
			{
				result = 5;
			}		
		}
		//Log("HRZones.getZone " + heartRate + " -> " + result);	
		return result;
	}

	function getMax(zone)
	{
	    var result = 0;
	    
		//Log("HRZones.getMax " + zone);	
	    
		if(zone == -1)
		{
			result = 60;
		}
		else if(zone == 0)
		{
			result = 130;	
		}
		else if(zone == 1)
		{
			result = 145;
		}
		else if(zone == 2)
		{
			result = 150;
		}
		else if(zone == 3)
		{
			result = 160;
		}
		else if(zone == 4)
		{
			result = 170;
		}
		else
		{
			result = 185;
		}		
		
		//Log("HRZones.getMax" + zone + " -> " + result);	
		return result;
	}

}
