% Script for testing vertical strip layouts
% Part of my attempt to create a mechanical display inspired by RYNX
% Andy Ding 8/8/21
clear
clc
close all;
load('mapV.mat');

% Layouts:
s1 = [0,0,0,0,0,1,1,1,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,0,0,1,0,1,0,0,1];
s2 = [0,0,0,0,0,1,1,1,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,0,0,1,0,1,0,0,1];
s3 = [0,0,0,0,0,1,1,1,1,1,0,1,1,1,0,0,1,1,0,1,0,1,1,0,0,0,1,0,1,0,0,1];
strips = {s1,s2,s3};
pos = [1,1,1];

% Draw grid
hold all;
for k1 = 1:3
    for k2 = 1:5
        plotGrid(k1,k2,0);
    end
end
axis tight;
set(gca,'visible','off');
set(gcf,'Color',[.17,.17,.17]);
daspect([1 1 1]);
plotStrips(strips);

% Random character
% keys = keys(map);
% while true
%     in = keys{randi([1 numel(keys)])};
%     disp(in);
%     [pos,strips] = moveStrips(map(in),pos,strips);
%     pause(2);
% end

% User input character
% in = input('Character:','s');
% while ~strcmp(in,'exit')
%     [pos,strips] = moveStrips(map(in),pos,strips);
%     disp(pos)
%     in = input('Character:','s');
% end

% Move individual strips
in = input('Strip:');
while ~strcmp(in,'exit')
    if in == 1
        strips{1} = circshift(strips{1},-1);
        pos(1) = pos(1) + 1;
    elseif in == 2
        strips{2} = circshift(strips{2},-1);
        pos(2) = pos(2) + 1;
    elseif in == 3
        strips{3} = circshift(strips{3},-1);
        pos(3) = pos(3) + 1;
    end
    plotStrips(strips);
    disp(pos)
    in = input('Strip:');
end

function [pos,strips] = moveStrips(goal,pos,strips)
while goal(1) ~= pos(1) || goal(2) ~= pos(2) || goal(3) ~= pos(3)
    pause(0.1);
    % strip 1
    if pos(1) > goal(1)
        strips{1} = circshift(strips{1},1);
        pos(1) = pos(1) - 1;
    elseif pos(1) < goal(1)
        strips{1} = circshift(strips{1},-1);
        pos(1) = pos(1) + 1;
    end
    % strip 2
    if pos(2) > goal(2)
        strips{2} = circshift(strips{2},1);
        pos(2) = pos(2) - 1;
    elseif pos(2) < goal(2)
        strips{2} = circshift(strips{2},-1);
        pos(2) = pos(2) + 1;
    end
    % strip 3
    if pos(3) > goal(3)
        strips{3} = circshift(strips{3},1);
        pos(3) = pos(3) - 1;
    elseif pos(3) < goal(3)
        strips{3} = circshift(strips{3},-1);
        pos(3) = pos(3) + 1;
    end
    plotStrips(strips);
end
end

% Plot strips
function plotStrips(strips)
for i = 1:3
    for j = 1:5
        plotGrid(i,j,strips{i}(j));
    end
end
end

% Plot grid
function plotGrid(x,y,c)
% Spacing:
xSize = 34;
xGap = 1;
ySize = 26;
yGap = 1;

if c == 1
    color = 'w';
elseif c == 2
    color = 'r';
else
    color = 'k';
end
patch([0 xSize xSize 0]-(1-x)*(xSize+xGap), [0 0 ySize ySize]-(-5+y)*(ySize+yGap),...
    color,'EdgeColor','none');
end