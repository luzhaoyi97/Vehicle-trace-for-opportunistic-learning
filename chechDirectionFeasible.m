function d = chechDirectionFeasible(x1, y1, mapIntersection_x, mapIntersection_y, move_vect_x, move_vect_y, threshold)
d=1;

% moving direction is described in [1,1] [1 -1] [-1 1] [-1 -1] 
if abs(y1 - min(mapIntersection_y)) < threshold
    if move_vect_y == -1
        d=0;
    end
end

if abs(y1 - max(mapIntersection_y)) < threshold
    if move_vect_y == 1
        d=0;
    end
end

if abs(x1 - min(mapIntersection_x)) < threshold
    if move_vect_x == -1
        d=0;
    end
end

if abs(x1 - max(mapIntersection_x)) < threshold
    if move_vect_x == 1
        d=0;
    end
end







