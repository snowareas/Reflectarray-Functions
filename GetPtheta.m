function [Pout,theta] = GetPtheta(Pin,th,ph,target_phi)
target_phi = mod(target_phi,pi);
phi = ph(:,1);
theta = th(1,:);
eps = 0.000001;
i1 = abs(phi+eps -target_phi) == min(abs(phi+eps-target_phi));
i2 = abs(phi+eps -target_phi-pi) == min(abs(phi+eps -target_phi-pi));
Pout = [fliplr(Pin(i2,2:end)),Pin(i1,:)];
theta = [-fliplr(theta(2:end)),theta];
end

