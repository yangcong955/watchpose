function scnn_f_show_maker_location( im, rotMax, traMax, K)


myMax(1:3,1:3) = rotMax(1:3,1:3);
myMax(1:3,4) = traMax(1:3,1);

[CamPosition] = scnn_f_3D_camera_position(myMax, K);

p1 = [CamPosition(1,1),CamPosition(1,2),0];
p2 = [CamPosition(2,1),CamPosition(2,2),0];
p3 = [CamPosition(3,1),CamPosition(3,2),0];
p4 = [CamPosition(4,1),CamPosition(4,2),0];
x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

imshow(im);
hold on;
fill3(x,y,z,'g');
hold off;

end

