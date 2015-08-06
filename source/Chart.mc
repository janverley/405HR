using Toybox.Graphics;
using Toybox.Sensor as Sensor;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class Chart
{
	var model;
	var zones;
	var screenSize = new[2];

	var xGraphLeftOffset = 15;
	var xGraphRightMargin = 0;
	var blockWidth;

    function initialize(a_model, a_zones)
    {
        model = a_model;
        zones = a_zones;
    }

    function onLayout(dc)
    {
    	Log("Chart.onLayout");
   
		screenSize[0] = dc.getWidth();
		screenSize[1] = dc.getHeight();
		blockWidth = 2;//(screenSize[0] - xGraphLeftOffset - xGraphRightMargin)/ ( model.getHistorySize() );
    	Log("blockWidth:" + blockWidth);
    }

    function draw(dc)
    {
    	Log("Chart.draw");
    
		var mainZone = model.getCurrentHRZone();

    	Log("current zone: " + mainZone);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        

        if(mainZone < 5)
        {
        	dc.drawText(10, screenSize[1]*1/8, Graphics.FONT_TINY, (mainZone + 1).toString(), Graphics.TEXT_JUSTIFY_VCENTER);
        }
        dc.drawText(10, screenSize[1]/2, Graphics.FONT_TINY, mainZone.toString(), Graphics.TEXT_JUSTIFY_VCENTER);
        if(mainZone > 1)
        {
        	dc.drawText(10, screenSize[1]*7/8, Graphics.FONT_TINY, (mainZone - 1).toString(), Graphics.TEXT_JUSTIFY_VCENTER);
		}
		
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

		dc.fillRectangle(xGraphLeftOffset, screenSize[1]/4, screenSize[0] - xGraphLeftOffset, screenSize[1]/2);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        

		if(model.getCurrentHR() != null)
		{
	   		dc.drawText(screenSize[0] - 3, screenSize[1]/2, Graphics.FONT_TINY, model.getCurrentHR().toString(), Graphics.TEXT_JUSTIFY_VCENTER);
		}

		var yPrevious = null;

		dc.setPenWidth(3);
		
    	for (var x = 0; x < model.getHistorySize(); x++)
    	{
         	var val = model.getValues()[x];
          	if (val != null)
            {

    			Log("val: " + val.toString());
    			
    			var zone = zones.getZone(val);
    			//Log("val zone: " + zone.toString());

		    	//Log("zones.getMax(zone): " + zones.getMax(zone));
		    	Log("zones.getMax(zone - 1): " + zones.getMax(zone - 1));
	
    			var hrRangeZone = zones.getMax(zone) - zones.getMax(zone - 1);
    			//Log("hrRangeZone: " + hrRangeZone.toString());
    				
				var rico = (screenSize[1] / 2)/(hrRangeZone).toFloat();
    			Log("rico: " + rico);

				Log("val- zones.getMax(mainZone - 1): " + (val - zones.getMax(mainZone - 1)).toString());
    			
				var y = (screenSize[1] * 3 / 4 ) - ((val - zones.getMax(mainZone - 1)) * rico);
				
				Log("y: " + y.toString());

				if(yPrevious != null)
				{
					dc.drawLine(xGraphLeftOffset + (x * blockWidth), yPrevious, xGraphLeftOffset + (x * blockWidth) + blockWidth, y);            
				}
				yPrevious = y;

            }
    	}
	}
}
