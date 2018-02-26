function featureVector = gaborFeaturesExtract(img,gaborArray,d1,d2)
global gaborFigRes textMean textStd textSkew textVar textKurtosis
if (nargin ~= 4)
    error('The number of parameters must be 4, that is image data, gabor array, and downsampling factor for the length and height of the image')
end

%Convert the image into grayscale if the image data is not yet in grayscale
if size(img,3) == 3
    warning('This image will be converted to grayscale!')
    img = rgb2gray(img);
end

img = double(img);

%Perform filter process on image data using each matrix in gabor array
[u,v] = size(gaborArray);
gaborResult = cell(u,v);
for i = 1:u
    for j = 1:v
        gaborResult{i,j} = imfilter(img, gaborArray{i,j});
        gaborFigRes{i,j} = gaborResult{i,j};
    end
end

%Perform the feature vector extraction process from the image data
featureVector = [];

%Perform calculations on each above filter results
for i = 1:u
    for j = 1:v
        %Perform the downsampling process to reduce the size of the gabor filter results
        gaborAbs = abs(gaborResult{i,j});
        gaborAbs = downsample(gaborAbs,d1);
        gaborAbs = downsample(gaborAbs.',d2);
        gaborAbs = gaborAbs(:);
        
        %Perform normalization using the mean and standard deviation from the previous calculation result
        %This process can be skipped if normalization will not be applied to gabor calculations
%         gaborAbs = (gaborAbs-mean(gaborAbs))/std(gaborAbs,1);
        
        %Insert the result into feature vector
        featureVector =  [featureVector; gaborAbs];        
    end
end
        %Show result in GUI Text
        textMean = sprintf('%f', mean(gaborAbs));
        textStd = sprintf('%f', std(gaborAbs));
        textSkew = sprintf('%f', skewness(gaborAbs));
        textVar = sprintf('%f', var(gaborAbs));
        textKurtosis = sprintf('%f', kurtosis(gaborAbs));
        
% %% Display filtered images if needed
%
% % Show real parts of Gabor-filtered images
% figure('NumberTitle','Off','Name','Real parts of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(real(gaborResult{i,j}),[]);
%     end
% end
% 
% % Show magnitudes of Gabor-filtered images
% figure('NumberTitle','Off','Name','Magnitudes of Gabor filters');
% for i = 1:u
%     for j = 1:v        
%         subplot(u,v,(i-1)*v+j)    
%         imshow(abs(gaborResult{i,j}),[]);
%     end
% end