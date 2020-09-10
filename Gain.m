function G = Gain(tar_th,tar_ph,posx,posy,k,Feed,Rc,phase,qf,qe,P)
%GAIN ÔöÒæ
% D0 = Directivity_angle(F,th,ph,tar_th,tar_ph);
Nx = length(posx);
Ny = length(posy);
S = P*P * Nx * Ny;
Dm = S*k^2/pi;

etas = 0;
etaill1 = 0;
etaill2 = 0;
rf = Distance(Feed,Rc);
H = rf*Cos(Feed - Rc,[0,0,1]);

for i = 1:Nx
    for j = 1:Ny
        E = [posx(i),posy(j),0];
        rfij = Distance(Feed,E);
        etas = etas + 1/rfij^3 * Cos(Rc-Feed,E-Feed)^(2*qf) *P*P;
        A = Cos(Rc-Feed,E-Feed) ^qf/rfij * Cos(Feed-E,[0,0,1]) ^qe;
        AFij = (-k*rfij + phase(i,j) + ...
            k*(posx(i) * sin(tar_th) .* cos(tar_ph) +...
            posy(j) * sin(tar_th) .* sin(tar_ph)));
        AFij = A * exp(1j*AFij);
        etaill1 = etaill1 + AFij;
        etaill2 = etaill2 + A^2;
    end
end
etaill1 = cos(tar_th).^qe * etaill1;

% if tar_th<0
%     tar_th = -tar_th;
%     tar_ph = mod(tar_ph + pi,2*pi);
% end
% dth = th(1,2) - th(1,1);
% dph = ph(2,1) - ph(1,1);
% th1 = th(1,:);
% th1 = abs(th1-tar_th-eps);
% ph1 = ph(:,1);
% ph1 = abs(ph1-tar_ph-eps);
% pos1 = ph1 == min(ph1);
% pos2 = th1 == min(th1);
% if sum(pos1) ~= 1 || sum(pos2) ~= 1
%     error('there are 2 angles both near to the target');
% end
% etaill1aa = abs(F(pos1,pos2).^2);

etas = (2*qf+1)/(2*pi) * H * etas;
etaill1 = abs(etaill1).^2;

etaill = etaill1/etaill2/Nx/Ny;
% etaillaa = etaill1aa/etaill2/Nx/Ny;

eta = etas * etaill;
% etaaa = etas * etaillaa;
G = 10*log10(Dm * eta);
% G1 = 10*log10(Dm * etaaa);
% G2 = 10*log10(D0 * etas);
end

