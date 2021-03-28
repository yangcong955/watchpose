%In this function, we remove the marker by the inpaint method

clear all;
close all;
clc
addpath(genpath(pwd));

objectname = 'object10';
mydis = '0.5'; %0.5, 1, 2, 3 (opt)
padding = 1;

%first step: read image, marker and label information

origidata = ['images/',objectname,'/backup/original/ar_',mydis,'m/'];
filetype = '.jpg';
imfileformat = ['img_0_%d',filetype];
mafileformat = 'makloca_0_';
%%%%%%%%%%%%%%%

allpic = dir(fullfile([origidata, ['img_*',filetype]]));
allnames = {allpic.name};
str  = sprintf('%s#', allnames{:});
num  = sscanf(str, ['img_0_%d',filetype,'#']);
[~, index] = sort(num);
allnames = allnames(index);

numall = length(allnames);
for i = 1:numall
    try
       %load the image
        orimg = imread([origidata,allnames{i}]);
        num  = sscanf(allnames{i}, imfileformat);

        %load the marker location data
        transpath = ['images/',objectname,'/backup/labels/ar_',mydis,'m/',mafileformat,num2str(num),'.txt'];
        [makin, makout] = f_read_maker_location(transpath);

        [makout] = f_marker_enlarge(makout, padding);

    %     makout(5,1) = makout(1,1);
    %     makout(5,2) = makout(1,2);

        %just for checking
    %     imshow(orimg);
    %     hold on;
    %     plot(makin(:,1),makin(:,2),'r*');
    %     plot(makout(:,1),makout(:,2),'g*');
    %     hold off;

        %make mask for inpaint
        mysize = size(orimg);
        mymask = zeros(mysize(1),mysize(2));
        xv = makout(:,1);
        yv = makout(:,2);

        minx = round(min(makout(:,1)));
        maxx = round(max(makout(:,1)));
        miny = round(min(makout(:,2)));
        maxy = round(max(makout(:,2)));


        for aaa = miny:maxy
            for bbb = minx:maxx
                in = inpolygon(aaa,bbb,yv,xv);
                if in == 1
                    mymask(aaa,bbb) = 255;
                end
            end
        end

        %remove the marker from original image
        newimage = f_patch_inpaint(orimg,mymask,true);

        imwrite(newimage,['images/',objectname,'/backup/processed/ar_',mydis,'m/',allnames{i}]);

        display(['saved--------',num2str(i),'--', num2str(numall)]); 
    catch
        orifile = [origidata,allnames{i}];
        desfile = ['images/',objectname,'/backup/processed/ar_',mydis,'m/',allnames{i}];
        copyfile(orifile, desfile);
        clear orifile desfile
    end
end