function ZY_savenii(mat,savedir,templatedir)
if exist('templatedir','var')==1 && isempty(templatedir)==0 && ischar(templatedir)
    template = load_untouch_nii(templatedir);
elseif exist('templatedir','var')==1 && isempty(templatedir)==0 && ischar(templatedir)==0
    template = templatedir;
else
    template=load_untouch_nii('MNI_template.nii.gz');

end
if isempty(mat) && exist('templatedir','var')==1
    nii = load_untouch_nii(templatedir);mat = nii.img; % empty mat is used to convert template to float with slope=1.
end
sz=size(mat);
template.hdr.dime.dim(1)=numel(sz);
if numel(sz)==3
    sz=[sz,1];
end
template.hdr.dime.dim(2:5)=sz;
template.hdr.dime.datatype = 16;
template.hdr.dime.bitpix = 16;

template.hdr.dime.scl_slope = 1;
template.hdr.dime.scl_inter = 0;
template.img=single(mat);
save_untouch_nii(template,savedir);