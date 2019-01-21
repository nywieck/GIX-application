# GIX digital portfolio application

This is a code repository for projects featured in my GIX digital portfolio. There are 3 projects in the repository: Lo Shu square verification in Python, a Drawing Pannel in Java, and UW Smart Step project work in Matlab. 

## Lo Shu Verification in Python (2018)

This code is from my previous Python class assignment. Objective was to verify if an input file represented a valid [Lo Shu square](https://en.wikipedia.org/wiki/Lo_Shu_Square), which is a unique normal magic square of order three. 

### To run the code

Enter **\Python_LoShuSquare** folder and type 
```console 
python H14_LoShu.py
``` 
The program will prompt for an input file. Two example input files are included in the repository: **test_input_false.txt** and **test_input_true.txt**. Enter either file name, including the extension, to verify if it contains a valid Lo Shu square. If the latter file is chosen, the below outcome should be produced. 

<img src="https://github.com/nywieck/GIX-application/blob/master/Python_LoShuSquare/LoShu_true.PNG" width="700">

## Java Drawing Pannel (2019)

Second project features a recent assignment in Java class (currently enrolled). The objective here was to produce specific geometric shapes as well as creating a panel of objects where color, size, and location of shapes and texts are randomized. 

### To run the code

Using your favorite IDE (e.g., [Eclipse](https://www.eclipse.org/) or [BlueJ](https://www.bluej.org/)), run **GraphProj** in **\Java_shapes** folder. Due to the randomized nature of the code, output figure will vary. Example shapes are shown below.

<p float="left">
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%201.PNG" width="250" />
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%202.PNG" width="250" /> 
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%203.PNG" width="250" />
</p>

## UW BioRobotics Lab (2019, current)

Last project features my ongoing volunteer work in [Smart Step project](https://rombolabs.github.io/#project-smartStep) at the UW BioRobitics Lab. Smart Step is a wearable device that can help people with prosthetic leg descend stairs easily and intuitively. 

<img src="https://rombolabs.github.io/img/portfolio/ss1.png" width="700">

Part of necessary work is to identify starting and ending time of steps taken during experiment for each patient volunteer. Although I could have achieved this by looking through the time series data and guess these times, I wanted to practice coding and create an automated system that could be used in the future by other students working in Lower-Limb TMR. 

First part of the work was smoothing the noisy raw data based on initial filter (smooth_data.m). Then the filter location is iteratively refined for each set of data. Based on the final filter location, I determine the starting and ending time position for each foot and plot them for verification. 

### To run the code

Enter **\UW BioRobotics Lab** directory. Open **SmartStep_DataSplice.m** using Matlab and press ```F5``` or ```Run```. Below figure will be produced. 
<img src="https://github.com/nywieck/GIX-application/blob/master/UW%20BioRobotics%20Lab/xsensExample.jpg" width="700">



