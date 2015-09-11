
class HRZones
{
	//	HeartRate
	//			Min										Max
	//  0		60		130		145		160		170		185
	// 	Zone
	//		<-		1		2		3		4		5		->

	var upperLimits = new[5];

    function initialize() 
    {
		Log("HRZones.ctor");	
	
		upperLimits[0] = 60;
		upperLimits[1] = 130;
		upperLimits[2] = 145;
		upperLimits[3] = 160;
		upperLimits[4] = 170;		
	}

	function getZone(heartRate)
	{
	    var result = 0;
	    
	    if(heartRate != null)
	    {
	    	if(heartRate <= upperLimits[1])
			{
				result = 1;	
			}
			else if(heartRate <= upperLimits[2])
			{
				result = 2;
			}
			else if(heartRate <= upperLimits[3])
			{
				result = 3;
			}
			else if(heartRate <= upperLimits[4])
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
		if(zone < 0)
		{
			return 0;
		}
		else
		{
			return upperLimits[zone];
		}
	}
}
