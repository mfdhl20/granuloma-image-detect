clear
close all
clc

train_feature = [];
group = [];
target = {};
path = uigetdir;
folder = dir(path);
size =32;
gaborFB.u = 5;
gaborFB.v = 8;
gaborFB.m = 39;
gaborFB.n = 39;
gaborFE.d1 = 4;
gaborFE.d2 = 4;
for i=3:length(folder)
    foldername = folder(i).name;
    imageplace = [path '\' foldername];
    image = dir(imageplace);
    target{i-2} = foldername;
    for j=3:length(image),
        imagename = image(j).name;
        if~strcmp(imagename,'Thumbs.db')
            readimage = [imageplace '\' imagename];
            img = imread(readimage);
            gbrresize=imresize(img,[size size]);
            gbrgray=rgb2gray(gbrresize);
            [matriksFeature] = GaborFilter(gaborFB, gaborFE, gbrgray);
            train_feature = [train_feature; matriksFeature'];
            group=[group;i-2];
        end
    end
end

save train_data.mat train_feature target group