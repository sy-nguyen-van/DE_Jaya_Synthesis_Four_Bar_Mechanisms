function v=check_bound(v,lu)
vioLow = find(v < lu(1, : ));
    if ~isempty(vioLow)
        v(1, vioLow) = 2 .* lu(1, vioLow) - v(1, vioLow);
        vioLowUpper = find(v(1, vioLow) > lu(2, vioLow));
        if ~isempty(vioLowUpper)
            v(1, vioLow(vioLowUpper)) = lu(2, vioLow(vioLowUpper));
        end
    end    
    vioUpper = find(v > lu(2, : ));
    if ~isempty(vioUpper)
        v(1, vioUpper) = 2 .* lu(2, vioUpper) - v(1, vioUpper);
        vioUpperLow = find(v(1, vioUpper) < lu(1, vioUpper));
        if ~isempty(vioUpperLow)
            v(1, vioUpper(vioUpperLow)) = lu(1, vioUpper(vioUpperLow));
        end
    end
end