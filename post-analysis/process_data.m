function process_data(t, pos, c, mt, F1, outputdir)

% this function sorts out the average and std of different types of cells within a single movie

timestr = int2str(t);
posstr = int2str(pos);
constr = num2str(c);

m = dlmread(strcat(F1, 'sorts.dat'), ' ', 1, 0); % skip first line, zero columns to skip

timefile = fopen(strcat(outputdir, 'experiments_', constr,'_.time'), 'a');
fprintf(timefile, '%i %s\n', t, F1); 
fclose(timefile);

% frame#, total, stuck_rotator2, swimmer, wobbler, diffuser2, diffuser1, ambiguous, pivoter2, pivoter1, rotator1, undefined
%    1	    2           3           4        5         6          7          8         9         10        11        12

tot_number = (m(:,2));
tot_number_mean = mean(tot_number(102:length(tot_number)));
tot_number_st = std(tot_number(102:length(tot_number)));%/sqrt(length(stuck)-1);

undefined_number = (m(:,12));
undefined_number_mean = mean(undefined_number(102:length(undefined_number)));
undefined_number_st = std(undefined_number(102:length(undefined_number)));%/sqrt(length(stuck)-1);

diffuser1 = (m(:,7)./(m(:,2)-m(:,8)) );
diffuser1_mean = mean(diffuser1(102:length(diffuser1)));
diffuser1_st = std(diffuser1(102:length(diffuser1)));%/sqrt(length(stuck)-1);
diffuser1_number = (m(:,7));
diffuser1_number_mean = mean(diffuser1_number(102:length(diffuser1_number)));
diffuser1_number_std = std(diffuser1_number(102:length(diffuser1_number)));

diffuser2 = (m(:,6)./(m(:,2)-m(:,8)) );
diffuser2_mean = mean(diffuser2(102:length(diffuser2)));
diffuser2_st = std(diffuser2(102:length(diffuser2)));%/sqrt(length(stuck)-1);
diffuser2_number = (m(:,6) );
diffuser2_number_mean = mean(diffuser2_number(102:length(diffuser2_number)));
diffuser2_number_std = std(diffuser2_number(102:length(diffuser2_number)));

Diffusers1and2 = ((m(:,6)+m(:,7))./(m(:,2)-m(:,8)) );
Diffusers1and2_mean = mean(Diffusers1and2(102:length(Diffusers1and2)));
Diffusers1and2_st = std(Diffusers1and2(102:length(Diffusers1and2)));%/sqrt(length(stuck)-1);
Diffusers1and2_number = (m(:,6)+m(:,7) );
Diffusers1and2_number_mean = mean(Diffusers1and2_number(102:length(Diffusers1and2_number)));
Diffusers1and2_number_std = std(Diffusers1and2_number(102:length(Diffusers1and2_number)));

% all adherers
stuck_all = (m(:,3)+m(:,5)+m(:,9)+m(:,10)+m(:,11))./(m(:,2)-m(:,8));
stuck_all_mean = mean(stuck_all(102:length(stuck_all)));
stuck_all_st = std(stuck_all(102:length(stuck_all)));%/sqrt(length(stuck)-1);
stuck_all_number = (m(:,3)+m(:,5)+m(:,9)+m(:,10)+m(:,11));
stuck_all_number_mean = mean(stuck_all_number(102:length(stuck_all_number)));
stuck_all_number_std = std(stuck_all_number(102:length(stuck_all_number)));

% the checksum should be 1
checksum = (m(:,3)+m(:,4)+m(:,5)+m(:,6)+m(:,7)+m(:,9)+m(:,10)+m(:,11))./(m(:,2)-m(:,8));
checksum_mean = mean(checksum(102:length(checksum)));
checksum_st = std(checksum(102:length(checksum)));%/sqrt(length(stuck)-1);

% swimmers
swim = m(:,4)./(m(:,2)-m(:,8));
swim_mean = mean(swim(102:length(swim)));
swim_st = std(swim(102:length(swim)));%/sqrt(length(swim)-1);
swim_number = (m(:,4));
swim_number_mean = mean(swim_number(102:length(swim_number)));
swim_number_std = std(swim_number(102:length(swim_number)));

% adherers - rotators type 2
stuck_rotator2 = m(:,3)./(m(:,2)-m(:,8));
stuck_rotator2_mean = mean(stuck_rotator2(102:length(stuck_rotator2)));
stuck_rotator2_st = std(stuck_rotator2(102:length(stuck_rotator2)));%/sqrt(length(swim)-1);
stuck_rotator2_number = (m(:,3));
stuck_rotator2_number_mean = mean(stuck_rotator2_number(102:length(stuck_rotator2_number)));
stuck_rotator2_number_std = std(stuck_rotator2_number(102:length(stuck_rotator2_number)));

% diffusers 1 and 2 + swimmers:
allmoving = (m(:,4)+m(:,6)+m(:,7) )./(m(:,2)-m(:,8));
allmoving_mean = mean(allmoving(102:length(allmoving)));
allmoving_st = std(allmoving(102:length(allmoving)));%/sqrt(length(swim)-1);
allmoving_number = (m(:,4)+m(:,6)+m(:,7) );
allmoving_number_mean = mean(allmoving_number(102:length(allmoving_number)));
allmoving_number_std = std(allmoving_number(102:length(allmoving_number)));

% adherers - wobblers
stuck_wobbler = (m(:,5))./(m(:,2)-m(:,8));
stuck_wobbler_mean = mean(stuck_wobbler(102:length(stuck_wobbler)));
stuck_wobbler_st = std(stuck_wobbler(102:length(stuck_wobbler)));%/sqrt(length(stuck)-1);
stuck_wobbler_number = (m(:,5));
stuck_wobbler_number_mean = mean(stuck_wobbler_number(102:length(stuck_wobbler_number)));
stuck_wobbler_number_std = std(stuck_wobbler_number(102:length(stuck_wobbler_number)));

% adherers - pivoters type 2
stuck_pivoter2 = (m(:,9))./(m(:,2)-m(:,8));
stuck_pivoter2_mean = mean(stuck_pivoter2(102:length(stuck_pivoter2)));
stuck_pivoter2_st = std(stuck_pivoter2(102:length(stuck_pivoter2)));%/sqrt(length(stuck)-1);
stuck_pivoter2_number = (m(:,9));
stuck_pivoter2_number_mean = mean(stuck_pivoter2_number(102:length(stuck_pivoter2_number)));
stuck_pivoter2_number_std = std(stuck_pivoter2_number(102:length(stuck_pivoter2_number)));

% adherers - pivoters type 1
stuck_pivoter1 = (m(:,10))./(m(:,2)-m(:,8));
stuck_pivoter1_mean = mean(stuck_pivoter1(102:length(stuck_pivoter1)));
stuck_pivoter1_st = std(stuck_pivoter1(102:length(stuck_pivoter1)));%/sqrt(length(stuck)-1);
stuck_pivoter1_number = (m(:,10));
stuck_pivoter1_number_mean = mean(stuck_pivoter1_number(102:length(stuck_pivoter1_number)));
stuck_pivoter1_number_std = std(stuck_pivoter1_number(102:length(stuck_pivoter1_number)));

% adherers - rotators type 1
stuck_rotator1 = (m(:,11))./(m(:,2)-m(:,8));
stuck_rotator1_mean = mean(stuck_rotator1(102:length(stuck_rotator1)));
stuck_rotator1_st = std(stuck_rotator1(102:length(stuck_rotator1)));%/sqrt(length(stuck)-1);
stuck_rotator1_number = (m(:,11));
stuck_rotator1_number_mean = mean(stuck_rotator1_number(102:length(stuck_rotator1_number)));
stuck_rotator1_number_std = std(stuck_rotator1_number(102:length(stuck_rotator1_number)));

Kstick_all_p = [t-0.5*mt stuck_all_mean stuck_all_st pos];
Kstick_wobbler_p = [t-0.5*mt stuck_wobbler_mean stuck_wobbler_st pos];
Kstick_pivoter2_p = [t-0.5*mt stuck_pivoter2_mean stuck_pivoter2_st pos];
Kstick_pivoter1_p = [t-0.5*mt stuck_pivoter1_mean stuck_pivoter1_st pos];
Kstick_rotator1_p = [t-0.5*mt stuck_rotator1_mean stuck_rotator1_st pos];
Kstuck_rotator2_p = [t-0.5*mt stuck_rotator2_mean stuck_rotator2_st pos];

Kswim_p = [t-0.5*mt swim_mean swim_st pos];
Kdiffuser1_p = [t-0.5*mt diffuser1_mean diffuser1_st pos];
Kchecksum_p = [t-0.5*mt checksum_mean checksum_st pos];
Kdiffuser2_p = [t-0.5*mt diffuser2_mean diffuser2_st pos];
K_Diffusers1and2_p = [t-0.5*mt Diffusers1and2_mean Diffusers1and2_st pos];
Kallmoving_p = [t-0.5*mt allmoving_mean allmoving_st pos];

Kstick_all_number_p = [t-0.5*mt stuck_all_number_mean stuck_all_number_std pos];
Kstuck_pivoter2_number_p = [t-0.5*mt stuck_pivoter2_number_mean stuck_pivoter2_number_std pos];
Kstuck_wobbler_number_p = [t-0.5*mt stuck_wobbler_number_mean stuck_wobbler_number_std pos];
Kstuck_pivoter1_number_p = [t-0.5*mt stuck_pivoter1_number_mean stuck_pivoter1_number_std pos];
Kstuck_rotator1_number_p = [t-0.5*mt stuck_rotator1_number_mean stuck_rotator1_number_std pos];
Kstuck_rotator2_number_p = [t-0.5*mt stuck_rotator2_number_mean stuck_rotator2_number_std pos];

Ktot_number_p = [t-0.5*mt tot_number_mean tot_number_st pos];
Kdiffuser2_number_p = [t-0.5*mt diffuser2_number_mean diffuser2_number_std pos];
Kswim_number_p = [t-0.5*mt swim_number_mean swim_number_std pos];
K_Diffusers1and2_number_p = [t-0.5*mt Diffusers1and2_number_mean Diffusers1and2_number_std pos];
Kallmoving_number_p = [t-0.5*mt allmoving_number_mean allmoving_number_std pos];
Kdiffuser1_number_p = [t-0.5*mt diffuser1_number_mean diffuser1_number_std pos];

Kundefined_number_p = [t-0.5*mt undefined_number_mean undefined_number_st pos];

TOT = stuck_pivoter1_mean+stuck_pivoter2_mean+stuck_wobbler_mean+swim_mean+diffuser2_mean+diffuser1_mean+stuck_rotator2_mean+stuck_rotator1_mean

outFile2=strcat(outputdir, 'stuckALL_conc_', constr, '_.dat');
outFile4=strcat(outputdir, 'stuckWOBBLER_conc_', constr, '_.dat');
outFile6=strcat(outputdir, 'stuckPIVOTER2_conc_', constr, '_.dat');
outFile8=strcat(outputdir, 'stuckPIVOTER1_conc_', constr, '_.dat');

outFile10=strcat(outputdir, 'swim_conc_', constr, '_.dat');
outFile12=strcat(outputdir, 'diffuser1_conc_', constr, '_.dat');
outFile14=strcat(outputdir, 'checksum_conc_', constr, '_.dat');
outFile16=strcat(outputdir, 'tot_number_', constr, '_.dat');
outFile18=strcat(outputdir, 'diffuser2_conc_', constr, '_.dat');
outFile20=strcat(outputdir, 'allmoving_conc_', constr, '_.dat');

outFile22=strcat(outputdir, 'stuckALL_number_', constr, '_.dat');
outFile24=strcat(outputdir, 'stuckWOBBLER_number_', constr, '_.dat');
outFile26=strcat(outputdir, 'stuckPIVOTER2_number_', constr, '_.dat');
outFile28=strcat(outputdir, 'stuckPIVOTER1_number_', constr, '_.dat');

outFile30=strcat(outputdir, 'swim_number_', constr, '_.dat');
outFile32=strcat(outputdir, 'diffuser1_number_', constr, '_.dat');
outFile34=strcat(outputdir, 'checksum_number_', constr, '_.dat');
outFile36=strcat(outputdir, 'tot_number_', constr, '_.dat');
outFile38=strcat(outputdir, 'diffuser2_number_', constr, '_.dat');
outFile40=strcat(outputdir, 'allmoving_number_', constr, '_.dat');

outFile42=strcat(outputdir, 'diffusers1and2_conc_', constr, '_.dat');
outFile44=strcat(outputdir, 'diffusers1and2_number_', constr, '_.dat');
outFile46=strcat(outputdir, 'allmoving_number_', constr, '_.dat');

outFile48=strcat(outputdir, 'stuckROTATOR2_conc_', constr, '_.dat');
outFile50=strcat(outputdir, 'stuckROTATOR2_number_', constr, '_.dat');

outFile52=strcat(outputdir, 'stuckROTATOR1_conc_', constr, '_.dat');
outFile54=strcat(outputdir, 'stuckROTATOR1_number_', constr, '_.dat');

outFile56=strcat(outputdir, 'undefined_number_', constr, '_.dat');

dlmwrite(outFile2, Kstick_all_p, 'delimiter', ' ', '-append');
dlmwrite(outFile4, Kstick_wobbler_p, 'delimiter', ' ', '-append');
dlmwrite(outFile6, Kstick_pivoter2_p, 'delimiter', ' ', '-append');
dlmwrite(outFile8, Kstick_pivoter1_p, 'delimiter', ' ', '-append');

dlmwrite(outFile10, Kswim_p, 'delimiter', ' ', '-append');
dlmwrite(outFile12, Kdiffuser1_p, 'delimiter', ' ', '-append');
dlmwrite(outFile14, Kchecksum_p, 'delimiter', ' ', '-append');

dlmwrite(outFile16, Ktot_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile18, Kdiffuser2_p, 'delimiter', ' ', '-append');
dlmwrite(outFile20, Kallmoving_p, 'delimiter', ' ', '-append');

dlmwrite(outFile22, Kstick_all_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile24, Kstuck_wobbler_number_p, 'delimiter', ' ', '-append');
dlmwrite(outFile26, Kstuck_pivoter2_number_p, 'delimiter', ' ', '-append');
dlmwrite(outFile28, Kstuck_pivoter1_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile30, Kswim_number_p, 'delimiter', ' ', '-append');
dlmwrite(outFile32, Kdiffuser1_number_p, 'delimiter', ' ', '-append');
dlmwrite(outFile38, Kdiffuser2_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile42, K_Diffusers1and2_p , 'delimiter', ' ', '-append');
dlmwrite(outFile44, K_Diffusers1and2_number_p, 'delimiter', ' ', '-append');
dlmwrite(outFile46, Kallmoving_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile48, Kstuck_rotator2_p, 'delimiter', ' ', '-append');
dlmwrite(outFile50, Kstuck_rotator2_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile52, Kstick_rotator1_p, 'delimiter', ' ', '-append');
dlmwrite(outFile54, Kstuck_rotator1_number_p, 'delimiter', ' ', '-append');

dlmwrite(outFile56, Kundefined_number_p, 'delimiter', ' ', '-append');
