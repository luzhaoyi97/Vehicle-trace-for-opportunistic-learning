function [All_On_duration, All_Off_duration] = calV2VOnOffDurationforOneUser(num_User, cur_ID, total_sample, WorldX, WorldY, neighbro_range)

%% This function is to calculate the v2v on and off duration based on the mobility of Num_User users.

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



All_On_duration = [];
All_Off_duration = [];
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
    
    
    All_On_duration = [All_On_duration, V2VContactTime];
    All_Off_duration = [All_Off_duration, V2VOffTime];
    
end


