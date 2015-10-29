function clfa()
%clears all figues but doesn't close axes

fh=findall(0,'type','figure');
for i=1:length(fh)
     clf(fh(i));
end
