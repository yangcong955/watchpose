function [ K ] = f_read_perspective_matrix( textpath )
%f_get_perspective_matrix: This function is used to read the
%                          perspective matrix from the textpath.


fidin = fopen(textpath,'r');

mycount = 1;
tempsave = zeros(3,3);
while ~feof(fidin)
    tline = fgetl(fidin);
    tline = regexp(tline,' ','split');
    tempsave(mycount,1) = str2double(tline{1});
    tempsave(mycount,2) = str2double(tline{2});
    tempsave(mycount,3) = str2double(tline{3});
    mycount = mycount + 1;
end
fclose(fidin);

K = tempsave;



end

