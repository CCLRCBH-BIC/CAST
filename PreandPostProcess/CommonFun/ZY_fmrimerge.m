function [TimeCourse,listing]=ZY_fmrimerge(directory,save4Dfile,selected_volumes)

listing=dir(directory);
if exist('selected_volumes','var')
    listing = listing(selected_volumes);
end
k=strfind(directory,'/');
k1=strfind(directory,'\');
k=sort([k,k1],'ascend');
path=directory(1:k(end));
T = numel(listing);

nii=load_untouch_nii([path,listing(1).name]);
sz=size(nii.img);
TimeCourse=zeros([T,sz]);
TimeCourse(1,:,:,:)=nii.img;
for ti=1:T
%     if rem(ti,100)==0
%         disp(ti);
%     end
    nii=load_untouch_nii([path,listing(ti).name]);
    TimeCourse(ti,:,:,:)=nii.img;
end 
if exist('save4Dfile','var')==1 && isempty(save4Dfile)==0
    ZY_savenii(permute(TimeCourse,[2,3,4,1]),save4Dfile,[path,listing(1).name]);
end
end