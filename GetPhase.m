function phase = GetPhase(posx,posy,beamvec,Feed,Rc,k)
%GETAPHI 获得单个未交叠阵列相位

Nx = length(posx);
Ny = length(posy);

phase = zeros(Nx,Ny);
for i = 1:Nx
    for j = 1:Ny
        E = [posx(i),posy(j),0];
        rfij = Distance(Feed,E);
        rf = Distance(Feed,Rc);
        phase(i,j) = k* (rfij - rf - beamvec*E');
    end
end
phase = mod(phase + pi,2*pi) - pi;
end

