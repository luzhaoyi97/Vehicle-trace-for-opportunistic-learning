%n_block_x, n_block_y, block_size_x, block_size_y


mapParam.n_block_x = 3;
mapParam.n_block_y = 3;
mapParam.block_size_x = 80; % meters
mapParam.block_size_y = 80; % meters even number is required

mapParam.streatWidth = 24; % meters

veParam.velocity_min = 30 / 3.6;
veParam.velocity_max = 40 / 3.6;
veParam.intersectionredstay = 10; % stay 10s at intersection if red

simParam.timetick = 1 /0.05; % 10ms
simParam.duration = 2000; % 1000s

x_range = mapParam.streatWidth * (mapParam.n_block_x + 1) + mapParam.n_block_x * mapParam.block_size_x;
y_range = mapParam.streatWidth * (mapParam.n_block_y + 1) + mapParam.n_block_y * mapParam.block_size_y;


total_sample = simParam.timetick * simParam.duration;

neighbro_range = 80; % v2v communication range

num_User = 50;
% All_VeID = 1:200;

WorldX = zeros(num_User,total_sample );
WorldY = zeros(num_User,total_sample );

for user_ID = 1:num_User
    [WorldX(user_ID,:), WorldY(user_ID,:)] =  GenerateVeMobilitySquare(mapParam, veParam, simParam);
end


%% Plot Map
for i = 1:mapParam.n_block_x
    for j = 1:mapParam.n_block_y
        xx = mapParam.streatWidth*i  + (i-1)*mapParam.block_size_x;
        yy = mapParam.streatWidth*j  + (j-1)*mapParam.block_size_y;
        rectangle('Position',[xx yy mapParam.block_size_x mapParam.block_size_y],'Curvature',0.2);        
    end
    
end

%% let me calculate v2v contact time
cur_ID = 1;

[On_duration, Off_duration ] = calV2VOnOffDurationforOneUser(num_User, cur_ID, total_sample, WorldX, WorldY, neighbro_range);

return;



NB_vector = zeros(num_User, total_sample); % neighbor_ID, is_neighbor_tick

for time_tick = 1:total_sample
    cur_Pos_X = WorldX(cur_ID,time_tick);
    cur_Pos_Y = WorldY(cur_ID,time_tick);
    
    for neighborID = 1:num_User
        if neighborID ~= cur_ID
            % calculate all v2v contact time
             nb_WorldX = WorldX(neighborID,time_tick);
             nb_WorldY = WorldY(neighborID,time_tick);
             
             if calDist(nb_WorldX,cur_Pos_X,nb_WorldY,cur_Pos_Y) < neighbro_range
                 NB_vector(neighborID, time_tick) = 1;
             end         
            
        end
    end  
      
end

fprintf('I am using. \n');

V2VContactTimeALL = [];
V2VOffTimeALL = [];
for  neighborID = 1:num_User
    v2vOnStart = 0;
    v2vOnEnd = 0;
    v2vStartTick = 0;
    v2vEndTick = 0;
    
    if neighborID == cur_ID
        continue;
    end
    V2VContactTime = [];
    V2VOffTime = [];
    for time_tick = 1:total_sample
        if (NB_vector(neighborID,time_tick) ~= 0) && (v2vOnStart == 0)
            v2vOnStart = 1;
            v2vStartTick = time_tick;
            V2VOffTime = [V2VOffTime, v2vStartTick - v2vEndTick];
        end
        if ((NB_vector(neighborID,time_tick) == 0) || (time_tick == total_sample)) && (v2vOnStart == 1)
            v2vOnStart = 0;
            v2vEndTick = time_tick;
            V2VContactTime = [V2VContactTime, v2vEndTick - v2vStartTick];
            v2vStartTick = 0;
%             v2vEndTick = 0;           
        end
    end
    
    
    V2VContactTimeALL = [V2VContactTimeALL, V2VContactTime];
    V2VOffTimeALL = [V2VOffTimeALL, V2VOffTime];
    
end

return;



normalizedHistGram(V2VContactTimeALL,80);
return;
hist(V2VContactTimeALL);
fprintf('I am using. \n');



