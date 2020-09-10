function [Pout,th,ph] = Puv2tp(Pin,u,v)
%UV2TP 方向图由uv线性分割空间到theta phi线性分割空间转换
if size(u) ~= size(v)
    error('U,V have different size');
end
unum = size(u,2);
vnum = size(v,1);
du = 2/unum;
dv = 2/vnum;

theta = linspace(0,pi/2,unum);
phi = linspace(0,2*pi,vnum+1);
phi = phi(1:end-1);
[th, ph] = meshgrid(theta, phi);
Pout = Pin;
parfor i = 1:unum
    for j = 1:vnum
        thij = th(i,j);
        phij = ph(i,j);
        uij = sin(thij)*cos(phij);
        vij = sin(thij)*sin(phij);
        localu = abs(u(1,:)-uij) < du;
        localv = abs(v(:,1)-vij) < dv;
        Plocal = Pin(localv,localu);
        ulocal = u(localv,localu);
        vlocal = v(localv,localu);
        if size(Plocal) == [1,1]
            P3 = Plocal(1,1);
        elseif size(Plocal) == [1,2]
            P3 = Plocal(1,1) + (Plocal(1,2) - Plocal(1,1)) * ...
                 (uij - ulocal(1,1))/(ulocal(1,2) - ulocal(1,1));
        elseif size(Plocal) == [2,1]
            P3 = Plocal(1,1) + (Plocal(2,1) - Plocal(1,1)) * ...
                 (vij - vlocal(1,1))/(vlocal(2,1) - vlocal(1,1));
        elseif size(Plocal) == [2,2]
            P1 = Plocal(1,1) + (Plocal(1,2) - Plocal(1,1)) * ...
                 (uij - ulocal(1,1))/(ulocal(1,2) - ulocal(1,1));
            P2 = Plocal(2,1) + (Plocal(2,2) - Plocal(2,1)) * ...
                 (uij - ulocal(2,1))/(ulocal(2,2) - ulocal(2,1));
            P3 = P1 + (P2 - P1) * (vij - vlocal(1,1)) / (vlocal(2,1) - vlocal(1,1));
        else
            Size = size(Plocal)
            error('wrong local size');
        end
        Pout(i,j) = P3;  
    end
end  
end

