using Toybox.Graphics;
using Toybox.Sensor as Sensor;
using Toybox.System as System;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class Chart
{
    var model;
    var HRzones;

    var screenSize = new[2];

    var mainZone = 0;
    var threshold = 3;

    var xGraphLeftOffset = 15;
    var blockWidth;

    function initialize(a_model, a_HRzones)
    {
        model = a_model;
        HRzones = a_HRzones;
    }

    function onLayout(dc)
    {
        Log("Chart.onLayout");
   
        screenSize[0] = dc.getWidth();
        screenSize[1] = dc.getHeight();
        blockWidth = (screenSize[0] - xGraphLeftOffset)/ ( model.getHistorySize() );
        Log("blockWidth:" + blockWidth);
    }

    function draw(dc)
    {
        Log("Chart.draw");
        
        evaluateMainZone();

        drawBackground(dc);
        drawZoneLabels(dc);
        drawCurrentHR(dc);
        drawGraph(dc);

    }

    function evaluateMainZone()
    {
        if(model.getCurrentHR() != null && 
        mainZone != model.getCurrentHRZone())
        {
            // if the last [threshold] HRs are all in this new zone, switch to it
            var changeToNewZone = true;
            for (var x = 1; x <= threshold; x++)
            {
                if( model.getCurrentPosition() - x >= 0)
                {
                    var pVal = model.getValues()[model.getCurrentPosition() - x ];
                    
                    if(pVal != null)
                    {
                        Log("HRzones.getZone(pVal): " + (HRzones.getZone(pVal)).toString());
                        if(model.getCurrentHRZone() != HRzones.getZone(pVal))
                        {
                            changeToNewZone = false;    
                        }
                    }
                }
            }
            
            if(changeToNewZone)
            {
                mainZone = model.getCurrentHRZone();
            }
        }
    }

    function drawBackground(dc)
    {
        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, screenSize[0], screenSize[1]);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);

        dc.fillRectangle(xGraphLeftOffset, screenSize[1]/4, screenSize[0] - xGraphLeftOffset, screenSize[1]/2);     
    }

    function drawZoneLabels(dc)
    {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        

        if(mainZone < 5)
        {
            dc.drawText(10, screenSize[1]*1/8, Graphics.FONT_MEDIUM, (mainZone + 1).toString(), Graphics.TEXT_JUSTIFY_VCENTER);
        }

        dc.drawText(13, screenSize[1]/2, Graphics.FONT_NUMBER_MILD, mainZone.toString(), Graphics.TEXT_JUSTIFY_VCENTER);

        if(mainZone > 1)
        {
            dc.drawText(10, screenSize[1]*7/8, Graphics.FONT_MEDIUM, (mainZone - 1).toString(), Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }

    function drawCurrentHR(dc)
    {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);        

        if(model.getCurrentHR() != null)
        {
            dc.drawText(screenSize[0] - 3, screenSize[1]/2, Graphics.FONT_NUMBER_MEDIUM, model.getCurrentHR().toString(), Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
    
    function drawGraph(dc)
    {
        var hrRangeZone = HRzones.getMax(mainZone) - HRzones.getMax(mainZone - 1);
                    
        var yPrevious = null;

        dc.setPenWidth(4);
        
        for (var i = 0; i < model.getHistorySize(); i++)
        {
            var value = model.getValues()[i];
            if (value != null)
            {
                var zone = HRzones.getZone(value);
    
                var rico = (screenSize[1] / 2)/(hrRangeZone).toFloat();

                var y = (screenSize[1] * 3 / 4 ) - ( ( value - HRzones.getMax(mainZone - 1) ) * rico );
                
                //Log(rico + " " + y + " " + zone + " " + value);
                
                if(yPrevious != null)
                {
                    var x = xGraphLeftOffset + (i * blockWidth);
                    dc.drawLine(x, yPrevious, x + blockWidth, y);            
                }

                yPrevious = y;
            }
        }
    }
}
