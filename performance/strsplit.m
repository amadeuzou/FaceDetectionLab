function c=strsplit(s,sep)
if (numel(s)==0)
    c{1}='';
    return
end
s=uint16(s);
sep=uint16(sprintf(sep));
if (s(end)~=sep)
    s=[s sep];
end
pos_sep=find(s==sep);
c=cell(1,numel(pos_sep));
pos_sep=[0 pos_sep];
for k=1:numel(c)
    c{k}=char(s(pos_sep(k)+1:pos_sep(k+1)-1));
end