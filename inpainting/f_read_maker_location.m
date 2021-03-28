function [ makin, makout ] = f_read_maker_location( makertxt )
%f_read_maker_location: This function is used to load and read maker
%                       location from a txt file
%   input:
%         makertxt: the path of txt file that contains the maker location
%   output:
%         makin: four vertex inside the maker
%         makout: four vertex outside the maker

fidin = fopen(makertxt,'r');

mycount = 1;
tempsave = zeros(8,2);
while ~feof(fidin)
    tline = fgetl(fidin);
    tline = regexp(tline,' ','split');
    tempsave(mycount,1) = str2double(tline{1});
    tempsave(mycount,2) = str2double(tline{2});
    mycount = mycount + 1;
end
fclose(fidin);

makin = tempsave(1:4,:);
makout = tempsave(5:8,:);

end

