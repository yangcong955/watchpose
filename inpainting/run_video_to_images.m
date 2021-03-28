clear all;
close all;

objectname = 'object11';
mydis = '2'; %0.5, 1, 2, 3(opti)

blurthreshold = 0.8;

%first step: collect the data from the original video
xyloObj = VideoReader(['videos/',objectname,'/',mydis,'.MOV']);
vidWidth = xyloObj.Width;
vidHeight = xyloObj.Height;
mycount = 0;
startcount = 1;
while hasFrame(xyloObj)
    myframe = readFrame(xyloObj);
    if mod(mycount,1) == 0
        %first step: transfer a single frame into 1024x768
        [resizedimage] = f_resize_image(myframe, [1024,768]);
        %blur checking
        blur = f_blur_level(resizedimage);
        display(['blur=',num2str(blur)]);
        if blur <= blurthreshold
            imshow(resizedimage);
            imwrite(resizedimage,['images/',objectname,'/backup/original/ar_',mydis,'m/', num2str(startcount),'.jpg']);
            display(['frame ID=', num2str(mycount), '-', num2str(blur)]);
            startcount = startcount + 1;
        end
        %pause(0.1);
    end
    mycount = mycount + 1;
end

display('Finished!!');