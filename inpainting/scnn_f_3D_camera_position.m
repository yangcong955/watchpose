function [ mylocation ] = scnn_f_3D_camera_position( R, K )
%scnn_f_3D_camera_position: In this function, we reproject 4 points onto
%the image and then generate the intersection point of two lines specified 
%by the reproejcted four points.
%   R: transformation matrix 3x4
%   K: the perspective matrix (intrinsic)
%   myposition: Center point of the reprojected maker coner points.


p1 = [-20 -20 0 1];
p2 = [20 -20 0 1];
p3 = [20 20 0 1];
p4 = [-20 20 0 1];

%get reprojected locations of four points
[GT(1),GT(2)] = f_get_reprojection(K, R, p1);
mylocation(1,1:2) = GT;
[GT(1),GT(2)] = f_get_reprojection(K, R, p2);
mylocation(2,1:2) = GT;
[GT(1),GT(2)] = f_get_reprojection(K, R, p3);
mylocation(3,1:2) = GT;
[GT(1),GT(2)] = f_get_reprojection(K, R, p4);
mylocation(4,1:2) = GT;

%calculate the intersection point among two lines specified by 
%p1p3 and p2p4
% calculate intersection point of two 2d lines specified with 2 points each
% (X1, Y1; X2, Y2; X3, Y3; X4, Y4), while 1&2 and 3&4 specify a line.
% Gives back NaN or Inf/-Inf if lines are parallel (= when denominator = 0)
% see http://en.wikipedia.org/wiki/Line-line_intersection

% lines(1,:) = mylocation(1,:);
% lines(2,:) = mylocation(3,:);
% lines(3,:) = mylocation(2,:);
% lines(4,:) = mylocation(4,:);
% 
% % Input Check
% if size(lines,1) ~= 4 || size(lines,2) ~= 2
%     error('Input lines have to be specified with 2 points')
% end
% 
% x = lines(:,1);
% y = lines(:,2);
% % Calculation
% denominator = (x(1)-x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)-x(4));
% myposition = [((x(1)*y(2)-y(1)*x(2))*(x(3)-x(4))-(x(1)-x(2))*(x(3)*y(4)-y(3)*x(4)))/denominator ...
%     ,((x(1)*y(2)-y(1)*x(2))*(y(3)-y(4))-(y(1)-y(2))*(x(3)*y(4)-y(3)*x(4)))/denominator];
end

