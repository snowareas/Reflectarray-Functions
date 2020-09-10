function sll = GetSLL(Fdb,U,V)
%SLL ÊäÈëdb·½ÏòÍ¼£¬ÕÒÅÔ°ê
peaks = [];
for i = 2:size(Fdb,1)-1
    for j = 2:size(Fdb,2)-1
        if U(i,j)^2 + V(i,j)^2 >1
            continue
        end
        nearmax = max([Fdb(i-1,j-1),Fdb(i-1,j),Fdb(i-1,j+1),...
                       Fdb(i,j-1),Fdb(i,j+1),...
                       Fdb(i+1,j-1),Fdb(i+1,j),Fdb(i+1,j+1)]);
        if Fdb(i,j) > nearmax
            peaks = [peaks,Fdb(i,j)];
        end
    end
end
peaks = sort(peaks,'descend');
sll = peaks(2);
end

