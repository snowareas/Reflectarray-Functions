function c = Cos(vec1,vec2)
    r1 = Distance(vec1,[0,0,0]);
    r2 = Distance(vec2,[0,0,0]);
    c = vec1*vec2'/(r1*r2);
end

