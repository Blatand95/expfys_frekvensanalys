%% 4
clear
clf
upg4_data = readtable('upg4.txt');
vin = upg4_data.Var1;
vut = upg4_data.Var2;
f = upg4_data.Var3;
peaks = [upg4_data.Var4,upg4_data.Var5,upg4_data.Var6,upg4_data.Var7];

peaksdb = peaks(vin~=0.5,:);
peaksdb(peaksdb == 0) = -inf;
peaksdb2V = dB2V(peaksdb);



peaks(vin~=0.5,:) = peaksdb2V*0.2236;
thd = THD(peaks);
fvekt = linspace(min(f),max(f),20);
vutvekt = linspace(min(vut),max(vut),20);
[V,F] = meshgrid(vutvekt,fvekt);
THD_mesh = griddata(vut,f,thd,V,F);
surface(V,F,THD_mesh)
xlabel("utspänning [V]");
ylabel("signalfrekvens [Hz]");
zlabel("THD");
c = colorbar;
c.Label.String = "THD";
%% upg5
clear
upg4_data = [4.6	14.61	1000];
vin = upg4_data(1);
vut = upg4_data(2);
f = upg4_data(3);
peaks = [33.6	-18	-17.2	-17.2	-17.6];

peaksdb2V = dB2V(peaks);
thd = THD(peaksdb2V*0.2236)

%% upg5
clear
upg4_data = [0.4	0.7	400];
vin = upg4_data(1);
vut = upg4_data(2);
f = upg4_data(3);
peaks = [7.6	-8.8	-19,6 	-31.6];

peaksdb2V = dB2V(peaks);
thd = THD(peaksdb2V*0.2236)

thd2 = THD([0.55 0.09 0.02])