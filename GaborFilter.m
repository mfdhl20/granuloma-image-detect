function [matriksFeature] = GaborFilter(gaborFB, gaborFE, im)

%Perform create gabor filter calculation to get the gabor array
%gabor array will be generated in the size of u x v, with each cell will contain an m x n sized matrix
gaborArray = createGaborfilter(gaborFB.u, gaborFB.v, gaborFB.m, gaborFB.n);

%Perform calculations on each sample data
%Perform the gabor feature extraction calculation to get the feature vector from the sample data
matriksFeature = [];
matriksFeature = gaborFeaturesExtract(im, gaborArray, gaborFE.d1, gaborFE.d2);