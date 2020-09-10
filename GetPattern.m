function [pattern,th,ph] = GetPattern(phase,posx,posy,k,Feed,Rc,qf,qe,needplot)
%GET_PATTERN 得到3维方向图

Nx = length(posx);
Ny = length(posy);

pattern = 0;
div = 361;
theta = linspace(0,pi/2,div);
phi = linspace(0,2*pi*(1-1/div),div-1);
[th, ph] = meshgrid(theta, phi);
for i = 1:Nx
    for j = 1:Ny
        E = [posx(i),posy(j),0];
        rfij = Distance(Feed,E);
        
        A = Cos(Rc-Feed,E-Feed) ^qf/rfij * Cos(Feed-E,[0,0,1]) ^qe;
        p = (-k*rfij + phase(i,j) + ...
            k*(posx(i) * sin(th) .* cos(ph) +...
            posy(j) * sin(th) .* sin(ph)));
        p = A * exp(1j*p);
        pattern = pattern + p;
    end
end
pattern = cos(th) .^qe .*pattern;

if needplot
    mindb = -60;
    patterndb = 20* log10(abs(pattern));
    patterndb = - max(max(patterndb)) + patterndb;
    patterndb(patterndb < mindb) = mindb;

    u = sin(th).*cos(ph);
    v = sin(th).*sin(ph);
    figure;
    mesh(u,v,patterndb);
    view(0,90);
    title('pattern');
    xlabel('$\sin\theta \cos\phi$','Interpreter','LaTex');
    ylabel('$\sin\theta \sin\phi$','Interpreter','LaTex');
    zlabel('E/dB');
    cbar = colorbar;
    drawnow;
end
end

