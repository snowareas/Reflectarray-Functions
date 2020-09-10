function dist = distance(p1,p2)
    dist2 = sum((p1-p2).^2);
    dist = sqrt(dist2);
end