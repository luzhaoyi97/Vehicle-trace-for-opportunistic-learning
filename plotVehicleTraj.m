


comet(WorldX,WorldY);
return;
vid=60;
comet(WorldX(find(VehNr==vid)),WorldY(find(VehNr==vid)));


hold;
for vid = 1:3
    comet(WorldX(find(VehNr==vid)),WorldY(find(VehNr==vid)));
end

return;
a=1:3;
for t=a
    fprintf('t=%d.\n', t);
end