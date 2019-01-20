# GIX digital portfolio application

This is a code repository for projects featured in my GIX digital portfolio. 

There are 3 projects in the repository: UW BioRobotics Lab, Java Drawing Pannel, and Python X. 

## UW BioRobotics Lab

This folder features my ongoing volunteer work in [Smart Step project](https://rombolabs.github.io/#project-smartStep) at the UW BioRobitics Lab. Smart Step is a wearable device that can help people with prosthetic leg descend stairs easily and intuitively. 

<img src="https://rombolabs.github.io/img/portfolio/ss1.png" width="700">

Part of necessary work is to identify starting and ending time of steps taken during experiment for each patient volunteer. Although I could have achieved this by looking through the time series data and guess these times, I wanted to practice coding and create an automated system that could be used in the future by other students working in Lower-Limb TMR. 

First part of the work was smoothing the noisy raw data based on initial filter (smooth_data.m). Then the filter location is iteratively refined for each set of data. Based on the final filter location, I determine the starting and ending time position for each foot and plot them for verification. 

### To run the code

Press ```F5``` or ```Run``` from SmartStep_DataSplice.m 


<img src="https://github.com/nywieck/GIX/blob/master/UW%20BioRobotics%20Lab/xsensExample.jpg" width="700">



