function newDir = chooseDirection(x1, y1, mapIntersection_x, mapIntersection_y, threshold, predir)

%Choices = [4 2 1 3]; 
%Choices = mod(round(rand(1,100)*10),4)+1;
% Choices = Choices(Choices ~= predir);
Choices = [4 2 1 3 ]; 
while 1
    %Choices = mod(round(rand(1,100)*97),4)+1;
    idx = randi(length(Choices), 1, 1); 
%    idx = mod(round(rand(1,1)*100),4)+1;
    newDir = Choices(idx);
    
    if newDir == (mod(predir+1, 4) + 1)
        continue;
    end
    
    if ((predir == 1) && (newDir==3)) || ((predir == 2) && (newDir==4)) || ((predir == 3) && (newDir==1)) || ((predir == 4) && (newDir==2))
        fprintf('newdir = %d, predir = %d \n', newDir, predir);
    end
    
    if rand > 0.8
        newDir = predir;
%         fprintf('continue on previous dir. \n');
    end
    
    if newDir == 1
        dir_x = 1;
        dir_y = 0;        
    elseif newDir == 2
        dir_x = 0;
        dir_y = 1;
    elseif newDir == 3
        dir_x = -1;
        dir_y = 0;
    elseif newDir == 4
        dir_x = 0;
        dir_y = -1;
    else
        fprintf('fatal error. \n');
    end
  
    
    if chechDirectionFeasible(x1, y1, mapIntersection_x, mapIntersection_y, dir_x, dir_y, threshold)
        if newDir == (mod(predir+1, 4) + 1)
            fprintf('should not appear. \n');
        end
        break;        
    else
%         fprintf('Not good dir. \n');
        continue;
    end   
end






