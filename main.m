close all;
clear all;
test;
WorldY2save = WorldY';
WorldX2save = WorldX';

fid = fopen('WorldY.txt','wt');
fprintf(fid,'%g\n',WorldY2save);      
fclose(fid);

fid = fopen('WorldX.txt','wt');
fprintf(fid,'%g\n',WorldX2save);       
fclose(fid);

%close all;
%clear all;
