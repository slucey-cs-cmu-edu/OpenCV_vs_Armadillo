//
//  MyMultiply.cpp
//  OpenCV_versus_Armadillo
//
//  Created by Simon Lucey on 9/16/16.
//  Copyright © 2016 CMU_16432. All rights reserved.
//

#include <opencv2/opencv.hpp> // Includes the opencv library
#include <stdlib.h> // Include the standard library
#include "Accelerate/Accelerate.h" // Includes the Accelerate framework

//==============================================================================
// Function that needs to be filled in for 16623 Assignment 1
// attempt to use the cblas_sgemv function in the Accelerate framework's BLAS
// library in order to achieve efficient matrix by vector multiplication
//
// Should be equivalent to writing in OpenCV,
//
// y = A*x;
//
// where A is a matrix, and x & y are column vectors
//
void MyMultiply(cv::Mat &A, cv::Mat &x, cv::Mat &y) {
    
    // Fill in code here
    
}
