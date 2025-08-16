function x1=Arrange(x,Cdx)
            index=INDEX(x,Cdx);
            Co2=sequence(x,index);
            x1=x;
            while Co2>0
                [~,index1]=sort(x(10:end));
                index1=index1+9;
                for ij=1:length(index);
                    x1(index(ij))=x(index1(ij));
                end
                Co2=sequence(x1,index);
            end
end