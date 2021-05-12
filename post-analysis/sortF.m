function sortF(F1);

M = dlmread(F1);
M(:,1) = (M(:,1)-M(1,1))./3600; % convert to hours

dlmwrite(F1, M, 'delimiter', ' ');
