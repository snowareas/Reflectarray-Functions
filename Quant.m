function phaseq = Quant(phase,bit)
if bit == 0
    phaseq = phase;
else
    deg = 2*pi/(2^bit);
    phaseq = round(phase/deg) * deg;
    phaseq(abs(phaseq - 2*pi) < eps) = 0;
end
end

