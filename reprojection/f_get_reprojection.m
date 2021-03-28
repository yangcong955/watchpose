function [ myx, myy ] = f_get_reprojection( K, Trans, Point )
%f_get_reprojection: This function is used to calculate the corrdinate system 
%on the image after the reproject.
%input:
%       K: the perspective(intrinsic) matrix 3x3
%       Trans: Transformation matrix 3x4
%       P: location of the point for reprojection, 1x4
%output:
%       myx: x location on the image
%       myy: y location on the image

%first step: calculate the projection matrix
prj = K * Trans;

%second step: project the point
Point(4) = 1;
Point = Point';
tempV = prj * Point;

%myx = abs(tempV(1)/tempV(3));
%myy = abs(tempV(2)/tempV(3));
myx = tempV(1)/tempV(3);
myy = tempV(2)/tempV(3);

end

