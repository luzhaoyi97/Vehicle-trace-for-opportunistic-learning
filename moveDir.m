function [newPos_x, newPos_y] = moveDir(x1, y1, dir, step)

newPos_x = x1;
newPos_y = y1;
if dir == 1
    newPos_x = x1 + step;    
elseif dir == 2
    newPos_y = y1 + step;
elseif dir == 3
    newPos_x = x1 - step;
elseif dir == 4
    newPos_y = y1 - step;
else
    fprintf('Alert: dir can not be %d. \n', dir);
end
