using Toybox.System as System;
using Toybox.Activity as Activity;
using Toybox.Math as Math;

class HRModel 
{

    var historySize = 70;
    var jumpSize = 10;

    var values = new [historySize];
    var currentPosition = 0;

    var validHRReceived = false;
    
    var currentHR;

    var hrZones;
    
    function initialize(a_hrZones) 
    {
        Log("HRModel.ctor");
        hrZones = a_hrZones;
    }
    
    function getCurrentPosition()
    {
        return currentPosition;
    }

    function getCurrentHR()
    {
        return currentHR;
    }

    function getCurrentHRZone()
    {
        return hrZones.getZone(currentHR);
    }

    function getHistorySize() 
    {
        return historySize;
    }
    
    function getValues() 
    {
        return values;
    }

    function compute(info) 
    {
        Log("compute");
    
        currentHR = info.currentHeartRate;
        
        if(! validHRReceivedGuard(currentHR))
        {
            return;
        }

        // jump
        if(currentPosition == values.size())
        {
            currentPosition -= jumpSize;
            
            for(var i = jumpSize; i < values.size(); i++)
            {
                values[i - jumpSize] = values[i];
            }
            
            // clear everything beyond jump
            for(var i = values.size() - jumpSize; i < values.size(); i++)
            {
                values[i] = null;
            }
        }
        
        values[currentPosition] = currentHR;
        currentPosition = currentPosition + 1;
            
        Log(values.toString());
    }
    
    function validHRReceivedGuard(currentHR)
    {
        if(currentHR != null)
        {
            validHRReceived = true;
        }

        return validHRReceived;
    }
}