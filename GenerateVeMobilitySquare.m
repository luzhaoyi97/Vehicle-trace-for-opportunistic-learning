function [WorldX, WorldY] = GenerateVeMobilitySquare(mapParam, veParam, simParam)

%% this function is to generate vehicle trace 
%% when considering the access procedure
fprintf('In function GenerateVeMobilitySquare: Generating trace. \n');
%%
%n_block_x, n_block_y, block_size_x, block_size_y

% all time instant
t = 0:simParam.timetick:simParam.duration;
total_sample = simParam.timetick * simParam.duration;

WorldX = zeros(1,total_sample );
WorldY = zeros(1,total_sample );
% generate intersection point
mapIntersection_x = zeros(1,1+mapParam.n_block_x);
mapIntersection_y = zeros(1,1+mapParam.n_block_y);

for idx_x = 1:(1+mapParam.n_block_x)
    mapIntersection_x(idx_x) = (idx_x - 1) * (mapParam.block_size_x + mapParam.streatWidth) + 0.5 * mapParam.streatWidth;
end
for idx_y = 1:(1+mapParam.n_block_y)
    mapIntersection_y(idx_y) = (idx_y - 1) * (mapParam.block_size_y + mapParam.streatWidth) + 0.5 * mapParam.streatWidth;
end


x_range = mapParam.streatWidth * (mapParam.n_block_x + 1) + mapParam.n_block_x * mapParam.block_size_x;
y_range = mapParam.streatWidth * (mapParam.n_block_y + 1) + mapParam.n_block_y * mapParam.block_size_y;

curPos_x = (randi([1 mapParam.n_block_x + 1]) - 1) * (mapParam.block_size_x + mapParam.streatWidth) + 0.5 * mapParam.streatWidth;
curPos_y = (randi([1 mapParam.n_block_y + 1]) - 1) * (mapParam.block_size_y + mapParam.streatWidth) + 0.5 * mapParam.streatWidth;
% curPos_x = mapIntersection_x(1);
% curPos_y = mapIntersection_y(1);

% t,VehNr,WorldX,WorldY,vMS
velocity = rand * (veParam.velocity_max - veParam.velocity_min) + veParam.velocity_min;
distPerStep = velocity / simParam.timetick;
red_stay = 0;
red_stay_proc = 0; % already stayed duration
red_stay_tick = veParam.intersectionredstay * simParam.timetick;
curDir = 1; % 1 2 3 4
for t_idx = 1:total_sample
    % deal with red light situation
    if red_stay 
        if red_stay_proc < red_stay_tick
            WorldX(t_idx) = curPos_x;
            WorldY(t_idx) = curPos_y;
            red_stay_proc = red_stay_proc + 1;
            continue;
        else
            red_stay = 0;
            red_stay_proc = 0;
            % randomly choose a direction
            preDir = curDir;
            curDir = chooseDirection(curPos_x, curPos_y, mapIntersection_x, mapIntersection_y, distPerStep*3, preDir);
            %add a function to update pos according direction  huasion
            
%             if ((preDir == 1) && (curDir==3)) || ((preDir == 2) && (curDir==4)) || ((preDir == 3) && (curDir==1)) || ((preDir == 4) && (curDir==2))
%                 fprintf('Fatal: newdir = %d, predir = %d \n', curDir, preDir);
%             end
            
%             fprintf('at time %d: Info: newdir = %d, predir = %d \n',t_idx, curDir, preDir);
%             fprintf('OldPos: x = %d, y = %d \n', curPos_x, curPos_y);
            [curPos_x, curPos_y] = moveDir(curPos_x, curPos_y, curDir, distPerStep*6);
%             fprintf('NewPos: x = %d, y = %d \n', curPos_x, curPos_y);
            WorldX(t_idx) = curPos_x;
            WorldY(t_idx) = curPos_y;
            % some times we dont need to wait, e.g., green light
%             if rand > 0.5
%                 if preDir == curDir
%                     red_stay_proc = red_stay_tick;
%                 end
%             end
            
            
            continue;
        end
    end
    %
    
    
    % if arrived at an intersection
    [d,inter_sect_x,inter_sect_y] =  checkIfIntersection(curPos_x, curPos_y, mapIntersection_x, mapIntersection_y, distPerStep*2);
    if d
        curPos_x = inter_sect_x;
        curPos_y = inter_sect_y;
        WorldX(t_idx) = curPos_x;
        WorldY(t_idx) = curPos_y;
%         fprintf('At intersection at %f. \n', t_idx);
        red_stay = 1;
        red_stay_proc = rand * red_stay_tick;
        continue;
    end
    
   
%     if ((preDir == 1) && (curDir==3)) || ((preDir == 2) && (curDir==4)) || ((preDir == 3) && (curDir==1)) || ((preDir == 4) && (curDir==2))
%         fprintf('Fatal2: newdir = %d, predir = %d \n', curDir, preDir);
%     end
    % if on non-intersection road
    [curPos_x, curPos_y] = moveDir(curPos_x, curPos_y, curDir, distPerStep);
    WorldX(t_idx) = curPos_x;
    WorldY(t_idx) = curPos_y;    
    
    
%     
%     fprintf('I am a breakpoint. \n');
%     fprintf('I am a breakpoint. \n');
    
end



mapParam.n_block_x = 5;
mapParam.n_block_y = 5;

veParam.velocity_min = 0;
veParam.velocity_max = 60 / 3.6;

simParam.timetick = 0.001; % 1ms
simParam.duration = 1000; % 1000s



% fprintf('End of simulation. \n');


















