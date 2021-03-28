function [ newmakout ] = f_marker_enlarge( pointpositions, padding )
%enlarge a marker by adding padding
%             p1,p2
%             p3,p4

%first step: find the points p1, p2, p3, p4
sorty = sortrows(pointpositions,2); %sort the points based on their y
uppers = sorty(1:2,:); %top two are upper points
lowers = sorty(3:4,:); %rest two are lower points

sortx = sortrows(uppers,1); %sort the points based on their x
p1 = sortx(1,:); %most left is the upperleft point p1
p2 = sortx(2,:); %rest one is the upperright point p2

sortx = sortrows(lowers,1);
p3 = sortx(1,:); %most left is the lowerleft point p3
p4 = sortx(2,:); %rest one is the lowerright point p4

%enlarge the marker
p1 = p1(:,:) - padding;
p2(1) = p2(1) + padding;
p2(2) = p2(2) - padding;
p3(1) = p3(1) - padding;
p3(2) = p3(2) + padding;
p4 = p4(:,:) + padding;

if p1(1) <= 0
    p1(1) = 1;
end
if p1(2) <= 0
    p1(2) = 1;
end
if p2(2) <= 0
    p2(2) = 1;
end
if p3(1) <= 0
    p3(1) = 1;
end


newmakout(1,:) = p1;
newmakout(2,:) = p2;
newmakout(3,:) = p4;
newmakout(4,:) = p3;

end

