function [d,inter_sect_x,inter_sect_y] = checkIfIntersection(x1, y1, mapIntersection_x, mapIntersection_y, threshhold)
d = 0;

size_x = length(mapIntersection_x);
size_y = length(mapIntersection_y);
inter_sect_x = 0;
inter_sect_y = 0;

for i = 1:size_x
    for j = 1:size_y
        if calDist(x1,mapIntersection_x(i),y1,mapIntersection_y(j)) < threshhold
            d = 1;
            inter_sect_x = mapIntersection_x(i);
            inter_sect_y = mapIntersection_y(j);
            break;            
        end
    end    
end




