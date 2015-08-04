using Toybox.WatchUi as Ui;
using Toybox.Activity as Activity;

class HRView extends Ui.DataField 
{
	var zones;
	var model;
	var chart;

    function initialize() 
    {
		Log("HRView.ctor");	

		zones = new HRZones();
		model = new HRModel(zones);
    	chart = new Chart(model, zones);
    }

    function compute(info) 
    {
    	Log("HRview.compute");
    
		model.compute(info);
    }

    function onLayout(dc) 
    {
    	Log("HRView.onLayout");
    	chart.onLayout(dc); 

    //Log(dc.getWidth());
    //Log(dc.getHeight());
    }

	function onUpdate(dc) 
	{
    	Log("HRView.onUpdate");

		chart.draw(dc);
	}
}