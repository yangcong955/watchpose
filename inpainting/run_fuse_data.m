%In this script, we will fuse all data from different camera distance into
%one folder.

clear all;
close all;

objectname = 'object11';
fusedistance = {'0.5','1','2','3'};

kmatrixpath = 'images/K.txt';
[K] = f_read_perspective_matrix(kmatrixpath); %load the intrinsic matrix

originaldata = ['images/',objectname,'/backup/']; %folder where original data
fusedata = ['images/',objectname,'/']; %folder where fused data saved
imgoriformat = '.jpg';

newimgcount = 1;
for i = 1:length(fusedistance)
    mydis = fusedistance{i};
    myfolder = [originaldata,'processed/ar_',mydis,'m/'];
    allpic = dir(fullfile([myfolder, ['img_*',imgoriformat]])); %read all images in current dis
    
    %order image names
    allnames = {allpic.name};
    str  = sprintf('%s#', allnames{:});
    num  = sscanf(str, ['img_0_%d',imgoriformat,'#']);
    [~, index] = sort(num);
    allnames = allnames(index);
    
    %start to copy files
    for j = 1:length(allnames)
        
        %first step: Copy the processed
        orifile = [originaldata,'processed/ar_',mydis,'m/',allnames{j}];
        desfile = [fusedata,'processed/img_0_',num2str(newimgcount),imgoriformat];
        copyfile(orifile, desfile);
        clear orifile desfile
    
        %second step: Copy the original
        orifile = [originaldata,'original/ar_',mydis,'m/',allnames{j}];
        desfile = [fusedata,'original/img_0_',num2str(newimgcount),imgoriformat];
        copyfile(orifile, desfile);
        clear orifile desfile
        
        %third step: Copy the labels
        num  = sscanf(allnames{j}, 'img_0_%d.jpg');
        orifile = [originaldata,'labels/ar_',mydis,'m/makloca_0_',num2str(num),'.txt'];
        desfile = [fusedata,'labels/makloca_0_',num2str(newimgcount),'.txt'];
        copyfile(orifile, desfile);
        clear orifile desfile
        
        orifile = [originaldata,'labels/ar_',mydis,'m/tran_0_',num2str(num),'.txt'];
        desfile = [fusedata,'labels/tran_0_',num2str(newimgcount),'.txt'];
        copyfile(orifile, desfile);
        clear orifile desfile
        
        %fourth step: Vis
%         orimg = imread([fusedata,'original/img_0_',num2str(newimgcount),imgoriformat]);
%         [rotMax, traMax] = f_read_transfor_matrix([fusedata,'labels/tran_0_',num2str(newimgcount),'.txt']);
%         scnn_f_show_maker_location(orimg, rotMax, traMax, K);
%         myfilename = [fusedata,'vis/',num2str(newimgcount),'.jpg'];
%         saveas(gcf,myfilename);
%         close all;
        
        newimgcount = newimgcount + 1;
        display([mydis,' -- ', allnames{j}]);
    end
end