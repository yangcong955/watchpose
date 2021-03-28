clear all;
close all;

%set the image id that we used in the paper
imageid = '442'; %225, 297, 442

kmatrixpath = 'data/K.txt';
[K] = f_read_perspective_matrix(kmatrixpath); %load the intrinsic matrix

%load image
mypic = imread(['data/img_ori_',imageid,'.jpg']);

%% here we show the ground truth
%load ground truth data
gtfile = fopen(['data/GT_',imageid,'.txt']);
gtresults = textscan(gtfile,'%f %f %f %f %f %f %f');
fclose(gtfile);

figure(1) ; set(gcf, 'name', ['Validation-',imageid]) ; clf;
    
%ground truth rotation and translation matrix
LTra = [gtresults{1}(1),gtresults{2}(1),gtresults{3}(1)];
Lqua = [gtresults{4}(1),gtresults{5}(1),gtresults{6}(1),gtresults{7}(1)];

RotMax = quat2rotm(Lqua);
myMax = RotMax;
myMax(1:3,4) = LTra;
[copoints] = scnn_f_3D_camera_position(myMax, K); %marker corners

%save it for check
GT_Rotation = RotMax;
GT_Translation = LTra';

%plotting
subplot(1,2,1) ; imagesc(mypic) ;
hold on;
p1 = [copoints(1,1),copoints(1,2),0];
p2 = [copoints(2,1),copoints(2,2),0];
p3 = [copoints(3,1),copoints(3,2),0];
p4 = [copoints(4,1),copoints(4,2),0];
x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];
fill3(x,y,z,'g');
plot(copoints(:,1),copoints(:,2),'g*');
hold off;
axis off image ; title('Ground Truth') ;


%% here we show the output from CNN
%load cnn estimation file
cnnfile = fopen(['data/PoseNet_',imageid,'.txt']);
cnnresults = textscan(cnnfile,'%f %f %f %f %f %f %f');
fclose(cnnfile);

%estimated rotation and translation matrix
CNNTra = [cnnresults{1}(1),cnnresults{2}(1),cnnresults{3}(1)];
CNNqua = [cnnresults{4}(1),cnnresults{5}(1),cnnresults{6}(1),cnnresults{7}(1)];

RotMax = quat2rotm(CNNqua);
myMax = RotMax;
myMax(1:3,4) = CNNTra;
[copoints] = scnn_f_3D_camera_position(myMax, K);

%save it for check
PoseNet_Rotation = RotMax;
PoseNet_Translation = CNNTra';

%plotting
subplot(1,2,2) ; imagesc(mypic) ;
hold on;
p1 = [copoints(1,1),copoints(1,2),0];
p2 = [copoints(2,1),copoints(2,2),0];
p3 = [copoints(3,1),copoints(3,2),0];
p4 = [copoints(4,1),copoints(4,2),0];
x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];
fill3(x,y,z,'g');
plot(copoints(:,1),copoints(:,2),'*r');
hold off;
axis image off ;
title('PoseNet Output');

%% clear all except the saved rotation and translation files
clearvars -except mypic K GT_Rotation GT_Translation PoseNet_Rotation PoseNet_Translation




