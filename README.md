# **MDDet**
### <u>M</u>ineral <u>D</u>ust <u>Det</u>ection

## About
MDDet provides interactive MATLAB scripts and functions for binarizing mineral dust images.

The morphological characteristics (i.e., shapes and sizes) of mineral dust particles have important implications in climate science and glaciology. Identifying these morphological characteristics typically requires microscopy and image processing, and the MDDet repository is designed to simplify the procedure for users who are less familiar with the computer-programming side of things.

After binarizing your mineral dust images in MATLAB they should be imported into the open-source software Fiji [Schindelin et al. 2012]. Navigate to `Image > Threshold > Manual Threshold` and set the upper and lower threshold limits equal to 1. After that, you can go to `Analyze > Analyze Particles` to quantify the morphological characteristics of every particle in the binary image almost instantaneously.
