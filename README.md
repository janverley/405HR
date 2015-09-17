# 405HR
_Forerunner 405 styled HR graph Connect IQ Data Field for the Garmin Forerunner 920XT_

I missed the heart rate graph of the Forerunner 405 I had before on the Forerunner 920XT.

## Credits
I peeked at another chart implementation to get started:  
https://github.com/simonmacmullen/chart-datafields.git

## Heart rate zones
Since the current Connect IQ API version does not allow to retrieve the actual values,  
I simply hardcoded _my_ heart rate zones.

Minimum heart rate: 60  
Zone 1: 60 - 129  
Zone 2: 130 - 144  
Zone 3: 145 - 159  
Zone 4: 160 - 169  
Zone 5: 170 - 185  
Maximum heart rate: 185  

## Source
The code can be found on GitHub:  
https://github.com/janverley/405HR/

## License

Licensed under http://www.wtfpl.net/
