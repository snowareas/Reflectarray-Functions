function S = Pfft(P,Nx,Ny,qe)
%PFFT 方向性系数反推阵列幅相分布
%   P u,v线性坐标系下的方向图；Nx Ny 方阵阵元数量
[m,n] = size(P);
u = linspace(-1,1,n);
v = linspace(-1,1,m);
[u,v] = meshgrid(u,v);
P = P./ (sqrt(1-u.^2-v.^2) .^qe);
P(u.^2 + v.^2 == 1) = 0;
P = [rot90(P(1:floor(n/2),1:floor(m/2)),2),...
     rot90(P(1:floor(n/2),floor(m/2)+1:end),2);...
     rot90(P(floor(n/2)+1:end,1:floor(m/2)),2),...
     rot90(P(floor(n/2)+1:end,floor(m/2)+1:end),2)];
S = fft2(P)';
S = S(1:Nx,1:Ny);
end

