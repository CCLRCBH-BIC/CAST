clear
clc
datadir = 'Z:\mni_hisub25\mri_dataset';
croppeddatadir = 'Z:\mni_hisub25\mri_dataset_crop';
data = {'_t2w_hires_defaced_MNI.nii.gz','_t1w_hires_defaced_MNI.nii.gz','_hippolabels_hres_L_MNI.nii.gz','_hippolabels_hres_R_MNI.nii.gz'};
savename = {'t2w_hires','t1w_hires','hippolabels_hires','hippolabels_hires'};
size_comp = zeros(25,4);
crop_size = [120,140,140]-1;
crop_left_corner = [119,192,100];
crop_right_corner = [232,192,100];
cropdata = cell(numel(data),3);% T2,T1,label
tag = zeros(25*2,1);
tag(1:2:end) = 1:25;
tag(2:2:end) = -(1:25);%left positive, right negative.
for s = 1:25
    subname = ['s',sprintf('%02d',s)];
    mkdir([croppeddatadir,'/',subname]);
    for d = 1:numel(data)
        nii = load_untouch_nii([datadir,'/',subname,'/',subname,data{d}]);
        mat = double(nii.img);
        %%% for subject 20, this step should not be used start %%%
        mat = nii.hdr.dime.scl_slope*double(mat)+nii.hdr.dime.scl_inter;
        if d<=2
            mat = mat/10;
        end
        %%% for subject 20, this step should not be used end %%%
        crop_L = mat(crop_left_corner(1):crop_left_corner(1)+crop_size(1),...
            crop_left_corner(2):crop_left_corner(2)+crop_size(2),...
            crop_left_corner(3):crop_left_corner(3)+crop_size(3));
        crop_R = mat(crop_right_corner(1):crop_right_corner(1)+crop_size(1),...
            crop_right_corner(2):crop_right_corner(2)+crop_size(2),...
            crop_right_corner(3):crop_right_corner(3)+crop_size(3));
        if d<=2
            crop_mean = mean([crop_L(:);crop_R(:)]);
            crop_std = std([crop_L(:);crop_R(:)]);
            crop_L=(crop_L-crop_mean)/crop_std;
            crop_R=(crop_R-crop_mean)/crop_std;
            ZY_savenii(crop_L,[croppeddatadir,'/',subname,'/',savename{d},'_L.nii.gz'],[datadir,'/',subname,'/',subname,data{1}]);
            ZY_savenii(crop_R,[croppeddatadir,'/',subname,'/',savename{d},'_R.nii.gz'],[datadir,'/',subname,'/',subname,data{1}]);
            cropdata{d}(2*s-1,:,:,:) = crop_L;
            cropdata{d}(2*s,:,:,:) = crop_R;
        elseif d==3
            ZY_savenii(crop_L,[croppeddatadir,'/',subname,'/',savename{d},'_L.nii.gz'],[croppeddatadir,'/',subname,'/',savename{1},'_L.nii.gz']);
            size_comp(s,1:2) = [sum(mat(:)>0),sum(crop_L(:)>0)];
            cropdata{d}(2*s-1,:,:,:) = crop_L;
        elseif d==4
            ZY_savenii(crop_R,[croppeddatadir,'/',subname,'/',savename{d},'_R.nii.gz'],[croppeddatadir,'/',subname,'/',savename{1},'_R.nii.gz']);
            size_comp(s,3:4) = [sum(mat(:)>0),sum(crop_R(:)>0)];
            cropdata{d-1}(2*s,:,:,:) = crop_L;
        end
    end
end

% cropped_T2 = single(cropdata{1});
% cropped_T1 = single(cropdata{2});
% cropped_label = int16(cropdata{3});
% 
% 
% gs_cropped_T2 = zeros(size(cropped_T2));
% gs_cropped_T1 = zeros(size(cropped_T1));
% for i = 1:size(cropped_T2,1)
%     gs_cropped_T2(i,:,:,:) = imgaussfilt3(squeeze(cropped_T2(i,:,:,:)),1);
%     gs_cropped_T1(i,:,:,:) = imgaussfilt3(squeeze(cropped_T1(i,:,:,:)),1);
% end
% % even sample: x direction should be reversed during training
% save H:\mni_hisub25\analysis\cropdata.mat cropped_T1 cropped_T2 cropped_label tag gs_cropped_T2 gs_cropped_T1

datadir = 'Z:\mni_hisub25\mri_dataset_crop';
sublist = dir([datadir,'/s*']);
for s = 1:numel(sublist)
    nii = load_untouch_nii([datadir,'/',sublist(s).name,'/t2w_hires_L.nii.gz']);
    nii.img = (nii.img-mean(nii.img(:)))./std(nii.img(:));
    save_untouch_nii(nii,[datadir,'/',sublist(s).name,'/t2w_hires_L_zscore.nii.gz']);
    nii = load_untouch_nii([datadir,'/',sublist(s).name,'/t2w_hires_R.nii.gz']);
    nii.img = (nii.img-mean(nii.img(:)))./std(nii.img(:));
    save_untouch_nii(nii,[datadir,'/',sublist(s).name,'/t2w_hires_R_zscore.nii.gz']);
end

for s = 1:numel(sublist)
    nii = load_untouch_nii([datadir,'/',sublist(s).name,'/t1w_hires_L.nii.gz']);
    nii.img = (nii.img-mean(nii.img(:)))./std(nii.img(:));
    save_untouch_nii(nii,[datadir,'/',sublist(s).name,'/t1w_hires_L_zscore.nii.gz']);
    nii = load_untouch_nii([datadir,'/',sublist(s).name,'/t1w_hires_R.nii.gz']);
    nii.img = (nii.img-mean(nii.img(:)))./std(nii.img(:));
    save_untouch_nii(nii,[datadir,'/',sublist(s).name,'/t1w_hires_R_zscore.nii.gz']);
end

datadir = 'Z:\mni_hisub25\mri_dataset_crop';
hipp_label = {'hippolabels_hires_L.nii.gz','hippolabels_hires_R.nii.gz'};
image_name = {{'t1w_hires_L.nii.gz','t1w_hires_L_zscore.nii.gz','t2w_hires_L.nii.gz','t2w_hires_L_zscore.nii.gz'},...
    {'t1w_hires_R.nii.gz','t1w_hires_R_zscore.nii.gz','t2w_hires_R.nii.gz','t2w_hires_R_zscore.nii.gz'}};
for s = 1:25
    subname = ['s',sprintf('%02d',s)];
    for l = 1:numel(hipp_label)
        label_nii = load_untouch_nii([datadir,'/',subname,'/',hipp_label{l}]);
        sz = size(label_nii.img);
        temp1 = find(sum(squeeze(sum(label_nii.img>0,3)),2)>0);
        temp2 = find(sum(squeeze(sum(label_nii.img>0,3)),1)>0);
        temp3 = find(sum(squeeze(sum(label_nii.img>0,2)),1)>0);
        ind={max([min(temp1)-3,1]):min([max(temp1)+3,sz(1)]),max([min(temp2)-3,1]):min([max(temp2)+3,sz(2)]),...
            max([min(temp3)-3,1]):min([max(temp3)+3,sz(3)])};
        label_nii.img = label_nii.img(ind{1},ind{2},ind{3});
        label_nii.hdr.dime.dim(2:4) = size(label_nii.img);
        save_untouch_nii(label_nii,[datadir,'/',subname,'/',hipp_label{l}]);
        for i = 1:numel(image_name{l})
            image_nii = load_untouch_nii([datadir,'/',subname,'/',image_name{l}{i}]);
            zscore_ind = strfind(image_name{l}{i},'zscore');
            image_nii.img = image_nii.img(ind{1},ind{2},ind{3});
            if numel(zscore_ind)>0
                image_nii.img(:) = zscore(image_nii.img(:));
            end
            image_nii.hdr.dime.dim(2:4) = size(image_nii.img);
            save_untouch_nii(image_nii,[datadir,'/',subname,'/',image_name{l}{i}]);
        end
    end
end
    
