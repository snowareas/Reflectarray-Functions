function [AF,u,v] = Pifft(S,m,n,qe)
%PIFFT ���㷽����ϵ��
%   S ���з��ࣻm v������n u������
AF = ifft2(S',m,n);
% AF = [AF(floor(m/2)+1:end,:);AF(1:floor(m/2),:)];
AF = [rot90(AF(1:floor(n/2),1:floor(m/2)),2),...
     rot90(AF(1:floor(n/2),floor(m/2)+1:end),2);...
     rot90(AF(floor(n/2)+1:end,1:floor(m/2)),2),...
     rot90(AF(floor(n/2)+1:end,floor(m/2)+1:end),2)];
u = linspace(-1,1,n);
v = linspace(-1,1,m);
[u,v] = meshgrid(u,v);
AF = sqrt(1-u.^2-v.^2) .^qe .*AF;
% AF = AF/max(max(abs(AF)));

% uv1 = (u.^2+v.^2)<=1;
% AF(~uv1) = 0;
% u(~uv1) = 0;
% v(~uv1) = 0;
end

