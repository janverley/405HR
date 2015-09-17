using Toybox.Activity as Activity;
using Toybox.Math as Math;

class DebugDataGenerator
{
    var hrMin = 50;
    var hrMax = 220;

    var phase = -1.0;
    var dir = 1;

    function initialize() 
    {
        Log("DebugDataGenerator.ctor"); 
    }

    function getInfoSin(info) 
    {
        Log("DebugDataGenerator.getInfoSin");

        var hr = hrMin + ((1 + Math.sin(phase)) * (hrMax - hrMin) / 2);

        info.currentHeartRate = hr.toNumber();
    

        phase = phase + 0.04;
        return info;
    }
 
    function getInfoLin(info) 
    {
        Log("DebugDataGenerator.getInfoLin");

        var hr = hrMin + ((1 + phase) * (hrMax - hrMin) / 2);

        info.currentHeartRate = hr.toNumber();
    
        if(phase > 1.0 || phase < -1.0)
        {
            dir = -1 * dir;
        }
        phase = phase + (dir * 0.04);

        return info;
    }
    
    function getInfoReasonable(info) 
    {
        Log("DebugDataGenerator.getInfoReasonable");

        var hr = hrMin + ((1 + phase) * (hrMax - hrMin) / 2);

        info.currentHeartRate = hr.toNumber();
    
        if(phase > 1.0 || phase < -1.0)
        {
            dir = -1 * dir;
        }
        
        var factor = 0.04;
        if(hr > 100)
        {
            factor = 0.02;
        }
        
        phase = phase + (dir * factor);

        return info;
    }

}