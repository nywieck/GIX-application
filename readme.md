# GIX digital portfolio application

This is a code repository for projects featured in my GIX digital portfolio. There are 3 projects in the repository: Lo Shu square verification in Python, a Drawing Pannel in Java, and a UW Bio-Robotics data-parsing project in Matlab. 

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

The second project features a recent assignment in Java class (currently enrolled). The objective here was to produce specific geometric shapes as well as creating a panel of art using different shapes, sizes, and colors - I chose to ranomize it and have the computer draw whatever came to "mind". 

### To run the code

Using your favorite IDE (e.g., [Eclipse](https://www.eclipse.org/) or [BlueJ](https://www.bluej.org/)), run **GraphProj** in **\Java_shapes** folder. Due to the randomized nature of the code, output figure will vary. Example shapes are shown below.

<p float="left">
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%201.PNG" width="250" />
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%202.PNG" width="250" /> 
  <img src="https://github.com/nywieck/GIX-application/blob/master/Java_shapes/Java%203.PNG" width="250" />
</p>

## UW BioRobotics Lab (2019, current)

The last project features my ongoing volunteer work with the [Smart Step project](https://rombolabs.github.io/#project-smartStep) at the UW BioRobitics Lab. I work under one of the doctoral students, helping her with what I can while gaining valuable lab experience.

<img src="https://rombolabs.github.io/img/portfolio/ss1.png" width="600">

Part of my work is to parse the data by identifying starting and ending times of steps taken during the experiment. Although I can do this by manually combing through the data and selecting times, I wanted to practice coding and am creating an automated system that could be used in the future by other students working on similar projects.

First, I programmed the algorithm to smooth noisy raw data based on an initial filter (smooth_data.m). Then the filter location is iteratively refined for each set of data. Based on the final filter location, the algorithm determines the starting and ending time position for each foot, then plots them for verification. 

*_Disclosure_*: The main script **SmartStep_DataSplice.m** contains code (lines 1-77) from existing work. This portion parses XSENS data and aggregates force measures from different sensors. The rest of the code (lines 80-219, written by me) takes the total force data and splices them into individual steps.  

### To run the code

Enter **\UW BioRobotics Lab** directory. Open **SmartStep_DataSplice.m** using Matlab and press ```F5``` or ```Run```. Below figure will be produced. 
<img src="https://github.com/nywieck/GIX-application/blob/master/UW%20BioRobotics%20Lab/xsensExample.jpg" width="700">



