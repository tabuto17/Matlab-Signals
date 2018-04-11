function [y]=sa(x)
y=ones(1,length(x));
i=find(x~=0);
y(i)=sin(x(i))./x(i);