//
//  ViewController.m
//  OpenCV_versus_Armadillo
//
//  Created by Simon Lucey on 9/16/15.
//  Copyright (c) 2016 CMU_16623. All rights reserved.
//

#import "ViewController.h"

#ifdef __cplusplus
#include "armadillo" // Includes the armadillo library
#include <opencv2/opencv.hpp> // Includes the opencv library
#include <stdlib.h> // Include the standard library
#endif

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Simple comparison between Armadillo and OpenCV
    using namespace std;
    
    int D = 3000; // Number of columns in A
    int M = 400; // Number of rows in A
    int trials = 3000; // Number of trials
    
    // Step 1. initialize random data
    // In MATLAB: x = randn(D,1);
    arma::fmat x; x.randn(D,1);
    // In MATLAB: A = randn(D,D);
    arma::fmat A; A.randn(M,D);
    
    // Step 2. intialize the clock
    arma::wall_clock timer;
    
    // Step 3. apply matrix multiplication operation in OpenCV
    // Remember: in OpenCV everything is stored in row order
    // so cvA is a DxM matrix not a MxD matrix!!!!
    
    cv::Mat cvA = Arma2Cv(A); // Convert to an OpenCV matrix
    cv::Mat cvx = Arma2Cv(x); // Convert to an OpenCV vector
    cv::Mat cvy(1,M,CV_32F); // Allocate space for y
    timer.tic();
    for(int i=0; i<trials; i++) {
        cvy = cvx*cvA; // Apply multiplication in OpenCV
    }
    double cv_n_secs = timer.toc();
    cout << "OpenCV took " << cv_n_secs << " seconds." << endl;
    
    // Step 4. apply matrix multiplication in Armadillo
    arma::fmat y(M,1); // Allocate space first
    timer.tic();
    for(int i=0; i<trials; i++) {
        y = A*x; // Apply multiplication in Armadillo
    }
    double arma_n_secs = timer.toc();
    cout << "Armadillo took " << arma_n_secs << " seconds." << endl;
    cout << "Armadillo is " << cv_n_secs/arma_n_secs << " times faster than OpenCV!!!" << endl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//==============================================================================
// Function that needs to be filled in for 16623 Assignment 1
// attempt to use the cblas_sgemv function in the Accelerate framework's BLAS
// library in order to achieve efficient matrix by vector multiplication
//
// Should be equivalent to writing in Armadillo,
//
// y = A*x;
//
// where A is a matrix, and x & y are column vectors
void MyMultiply(arma::fmat &A, arma::fvec &x, arma::fvec &y)
{
    
}

//==============================================================================
// Quick function to convert to Armadillo matrix header
arma::fmat Cv2Arma(cv::Mat &cvX)
{
    arma::fmat X(cvX.ptr<float>(0), cvX.cols, cvX.rows, false); // This is the transpose of the OpenCV X_
    return X; // Return the new matrix (no new memory allocated)
}
//==============================================================================
// Quick function to convert to OpenCV (floating point) matrix header
cv::Mat Arma2Cv(arma::fmat &X)
{
    cv::Mat cvX = cv::Mat(X.n_cols, X.n_rows,CV_32F, X.memptr()).clone();
    return cvX; // Return the new matrix (new memory allocated)
}

@end