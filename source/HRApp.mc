using Toybox.Application as App;

class HRApp extends App.AppBase 
{
    function onStart() 
    {
    }

    function onStop() 
    {
    }

    function getInitialView() 
    {
        return [ new HRView() ];
    }
}