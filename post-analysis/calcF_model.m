function calcF_model(F1, p, t_hour, t_min, t_sec, outputdir);

pos = str2num(p);
h = str2num(t_hour);
m = str2num(t_min);
s = str2num(t_sec);

mt=33.333;

t=3600*h+60*m+s;

C = [0 0 0 0 1 1 1 1 1 1];

c = C(pos+1); % because octave starts at 1

process_data(t, pos, c, mt, F1, outputdir);
