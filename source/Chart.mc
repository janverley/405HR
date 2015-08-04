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

	var xGraphOffset = 15;
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
		blockWidth = (dc.getWidth() - xGraphOffset)/ ( model.getHistorySize() );
    	Log("blockWidth:" + blockWidth);
    }

    function draw(dc)
    {
    	Log("Chart.draw");
    
		var mainZone = model.getCurrentHRZone();

    	Log("current zone: " + mainZone);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        
        dc.drawText(10, screenSize[1]/2, Graphics.FONT_TINY, mainZone.toString(), Graphics.TEXT_JUSTIFY_VCENTER);

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

		dc.fillRectangle(xGraphOffset, screenSize[1]/4, screenSize[0] - xGraphOffset, screenSize[1]/2);

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        

   		dc.drawText(screenSize[0] - 3, screenSize[1]/2, Graphics.FONT_TINY, model.getCurrentHR().toString(), Graphics.TEXT_JUSTIFY_VCENTER);

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

				dc.drawLine(xGraphOffset + (x * blockWidth), y, xGraphOffset + (x * blockWidth) + blockWidth, y);            

            }
    	}
	}
}
