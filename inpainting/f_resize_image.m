function [ resizedimage ] = f_resize_image( origimage, reqsize )
%f_resize_image: this function is used to resize the origimage based 
%on the reqsize, without deform the image.

%input: 
%      origimage: the original image
%      reqsize: required size[width,height]
%output:
%      resizedimage: the image after resize

%first step: size of the original image
allsize = size(origimage);
mywidth = allsize(2);
myheight = allsize(1);

%if both width and height are bigger than the required size, then
%reize the bigger one and generate patch
if mywidth >= reqsize(1) && myheight >= reqsize(2)
    if (mywidth-reqsize(1)) >= (myheight-reqsize(2))
        resizedimage = imresize(origimage, [reqsize(2) NaN]); %confirm the height
        %start to cut the patch based on middle point
        tempsize = size(resizedimage);
        tempmiddle = round((tempsize(2)-reqsize(1))/2);
        resizedimage = imcrop(resizedimage, [tempmiddle,1, reqsize(1)-1, reqsize(2)]);
    else
        resizedimage = imresize(origimage, [NaN reqsize(1)]); %confirm the width
        %start to cut the patch based on middle point
        tempsize = size(resizedimage);
        tempmiddle = round((tempsize(1)-reqsize(2))/2);
        resizedimage = imcrop(resizedimage, [1, tempmiddle, reqsize(1), reqsize(2)]);
    end
end
end

