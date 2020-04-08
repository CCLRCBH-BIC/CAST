clear
clc
predictiondir ='H:/ashs_atlas_umcutrecht_7t_20170810/deepmedic/example_sevenT_sub000/output/predictions/testSessionDm/predictions';
datadir = 'F:/mni-hisub25/cropped_mri_dataset';
for s = 1:25
    subdir = [datadir,'/s',sprintf('%02d',s)];
    Transdir = [subdir,'/registration'];
    for p = 0:8
        predpro = [predictiondir,'/s',sprintf('%02d',s),'_t2w_hires_L_chunk_deepmed_ProbMapClass',num2str(p),'.nii.gz'];
        refpath = [subdir,'/s',sprintf('%02d',s),'_t2w_hires_L.nii.gz'];
        antsWarp = ['antsapplyTransforms -d 3 -e 0 -i ',predpro,' -r ',refpath,' -t [',...
            Transdir,'/T22TemAffine.txt,1] -o ',subdir,'/t2w_hires_L_ProbMapClass',num2str(p),'.nii.gz'];
        system(['"C:/cygwin64/bin/bash" -c "',antsWarp,'"']);
    end
    temp = ZY_fmrimerge([subdir,'/t2w_hires_L_ProbMapClass*.nii.gz']);
    [~,ind] = max(temp,[],1);ind = squeeze(ind)-1;
    ZY_savenii(ind,[subdir,'/s',sprintf('%02d',s),'_t2w_hires_L_pred_deepmedic.nii.gz'],refpath);
    delete([subdir,'/t2w_hires_L_ProbMapClass*.nii.gz']);
end