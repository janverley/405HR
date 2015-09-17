using Toybox.WatchUi as Ui;
using Toybox.Activity as Activity;

class HRView extends Ui.DataField 
{
    var zones;
    var model;
    var chart;

    //var debug;

    function initialize() 
    {
        Log("HRView.ctor"); 

        zones = new HRZones();
        model = new HRModel(zones);
        chart = new Chart(model, zones);

        //debug = new DebugDataGenerator();
    }

    function compute(info) 
    {
        Log("HRview.compute");
    
        //model.compute(debug.getInfoReasonable(info));
        model.compute(info);
    }

    function onLayout(dc) 
    {
        Log("HRView.onLayout");

        chart.onLayout(dc); 
    }

    function onUpdate(dc) 
    {
        Log("HRView.onUpdate");

        chart.draw(dc);
    }
}