%n_block_x, n_block_y, block_size_x, block_size_y


mapParam.n_block_x = 2; %block number
mapParam.n_block_y = 2; %block number
mapParam.block_size_x = 80; % meters
mapParam.block_size_y = 80; % meters even number is required

mapParam.streatWidth = 24; % meters

veParam.velocity_min = 30 / 3.6;
veParam.velocity_max = 35 / 3.6;
veParam.intersectionredstay = 10; % stay 10s at intersection if red

simParam.timetick = 1 /0.05; % 10ms
simParam.duration = 300; % 100s

x_range = mapParam.streatWidth * (mapParam.n_block_x + 1) + mapParam.n_block_x * mapParam.block_size_x;
y_range = mapParam.streatWidth * (mapParam.n_block_y + 1) + mapParam.n_block_y * mapParam.block_size_y;


total_sample = simParam.timetick * simParam.duration;
WorldX = zeros(1,total_sample );
WorldY = zeros(1,total_sample );


[WorldX, WorldY] =  GenerateVeMobilitySquare(mapParam, veParam, simParam);

% sample_num = 50;
% return;
% comet(WorldX,WorldY);

figure;
hold;
% plot block
for i = 1:mapParam.n_block_x
    for j = 1:mapParam.n_block_y
        xx = mapParam.streatWidth*i  + (i-1)*mapParam.block_size_x;
        yy = mapParam.streatWidth*j  + (j-1)*mapParam.block_size_y;
        rectangle('Position',[xx yy mapParam.block_size_x mapParam.block_size_y],'Curvature',0.2);        
    end
    
end

% plot AP position
% plot(200,200,'ro','MarkerSize',20); % 4 x 4
% plot(140,140,'ro','MarkerSize',20); % 3 * 3
 plot(100,100,'ro','MarkerSize',15); % 2 * 2
% plot(65,65,'r^','MarkerSize',15); % 1*1

comet(WorldX,WorldY);

fprintf('end of it. \n');