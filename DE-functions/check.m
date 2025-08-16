function V=check(V,lu)
L=lu(1,:);
H=lu(2,:);
for i = 1:length(V)
    if V(i)<L(i)
        V(i) = 2*L(i)-V(i);
    elseif V(i)>H(i)
        V(i)=2*H(i)-V(i);
    else
        V(i)=V(i);
    end
end
