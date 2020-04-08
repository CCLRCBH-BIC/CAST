clear
clc
datadir = 'E:\ashs_atlas_umcutrecht_7t_20170810\deepmedic\mni_segv1\mni_seg';
imagedir = 'E:/mni_hisub25/mri_dataset_crop';
for s = 1:25
    testsub = ['s',sprintf('%02d',s)];
    t2native{s} = [imagedir,'/',testsub,'/','t2w_hires_L_zscore.nii.gz'];
    t1native{s} = [imagedir,'/',testsub,'/','t1w_hires_L_zscore.nii.gz'];
    GTlabel{s} = [imagedir,'/',testsub,'/hippolabels_hires_L.nii.gz'];
    NameofPrediction{s} = [testsub,'_L_deepmedic.nii.gz'];
end

for f=1:5
    testsub = 5*(f-1)+1:5*f;
    destdir = [datadir,'_5F',num2str(f),'f'];
    copyfile(datadir,destdir);
    if f==5
        valsub = 1;
    else
        valsub=5*f+1;
    end
    train_t1nativeid = fopen([destdir,'\configFiles\deepMedic\train\trainChannels_t1w.cfg'],'wt');
    train_t2nativeid = fopen([destdir,'\configFiles\deepMedic\train\trainChannels_t2w.cfg'],'wt');
    train_GTlabelid = fopen([destdir,'\configFiles\deepMedic\train\trainGtLabels.cfg'],'wt');
    val_t1nativeid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationChannels_t1w.cfg'],'wt');
    val_t2nativeid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationChannels_t2w.cfg'],'wt');
    val_GTlabelid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationGtLabels.cfg'],'wt');
    val_nameid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationNamesOfPredictions.cfg'],'wt');
    test_t1nativeid = fopen([destdir,'\configFiles\deepMedic\test\testChannels_t1w.cfg'],'wt');
    test_t2nativeid = fopen([destdir,'\configFiles\deepMedic\test\testChannels_t2w.cfg'],'wt');
    test_GTlabelid = fopen([destdir,'\configFiles\deepMedic\test\testGtLabels.cfg'],'wt');    
    test_nameid = fopen([destdir,'\configFiles\deepMedic\test\testNamesOfPredictions.cfg'],'wt');   
    for temp_s = 1:25
        if sum(valsub==temp_s)==0 && sum(testsub==temp_s)==0
            fprintf(train_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(train_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(train_GTlabelid,'%s\n',GTlabel{temp_s});
        elseif sum(valsub==temp_s)>0
            fprintf(val_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(val_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(val_GTlabelid,'%s\n',GTlabel{temp_s});
            fprintf(val_nameid,'%s\n',NameofPrediction{temp_s});
        elseif sum(testsub==temp_s)>0
            fprintf(test_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(test_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(test_GTlabelid,'%s\n',GTlabel{temp_s});
            fprintf(test_nameid,'%s\n',NameofPrediction{temp_s});
        end
    end
    fclose(train_t1nativeid);
    fclose(train_t2nativeid);
    fclose(train_GTlabelid);
    fclose(val_t1nativeid);
    fclose(val_t2nativeid);
    fclose(val_GTlabelid);
    fclose(val_nameid);
    fclose(test_t1nativeid);
    fclose(test_t2nativeid);
    fclose(test_GTlabelid);
    fclose(test_nameid);
end
    

clear
clc
datadir = 'Z:\ashs_atlas_umcutrecht_7t_20170810\deepmedic\mni_segv1\mni_seg';
imagedir = 'E:/mni_hisub25/mri_dataset_crop';
for s = 1:25
    testsub = ['s',sprintf('%02d',s)];
    t2native{s} = [imagedir,'/',testsub,'/','t2w_hires_R_zscore.nii.gz'];
    t1native{s} = [imagedir,'/',testsub,'/','t1w_hires_R_zscore.nii.gz'];
    GTlabel{s} = [imagedir,'/',testsub,'/hippolabels_hires_R.nii.gz'];
    NameofPrediction{s} = [testsub,'_R_deepmedic.nii.gz'];
end

for f=1:5
    testsub = 5*(f-1)+1:5*f;
    destdir = [datadir,'_R5F',num2str(f),'f'];
    copyfile(datadir,destdir);
    if f==5
        valsub = 1;
    else
        valsub=5*f+1;
    end
    train_t1nativeid = fopen([destdir,'\configFiles\deepMedic\train\trainChannels_t1w.cfg'],'wt');
    train_t2nativeid = fopen([destdir,'\configFiles\deepMedic\train\trainChannels_t2w.cfg'],'wt');
    train_GTlabelid = fopen([destdir,'\configFiles\deepMedic\train\trainGtLabels.cfg'],'wt');
    val_t1nativeid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationChannels_t1w.cfg'],'wt');
    val_t2nativeid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationChannels_t2w.cfg'],'wt');
    val_GTlabelid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationGtLabels.cfg'],'wt');
    val_nameid = fopen([destdir,'\configFiles\deepMedic\train\validation\validationNamesOfPredictions.cfg'],'wt');
    test_t1nativeid = fopen([destdir,'\configFiles\deepMedic\test\testChannels_t1w.cfg'],'wt');
    test_t2nativeid = fopen([destdir,'\configFiles\deepMedic\test\testChannels_t2w.cfg'],'wt');
    test_GTlabelid = fopen([destdir,'\configFiles\deepMedic\test\testGtLabels.cfg'],'wt');    
    test_nameid = fopen([destdir,'\configFiles\deepMedic\test\testNamesOfPredictions.cfg'],'wt');   
    for temp_s = 1:25
        if sum(valsub==temp_s)==0 && sum(testsub==temp_s)==0
            fprintf(train_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(train_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(train_GTlabelid,'%s\n',GTlabel{temp_s});
        elseif sum(valsub==temp_s)>0
            fprintf(val_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(val_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(val_GTlabelid,'%s\n',GTlabel{temp_s});
            fprintf(val_nameid,'%s\n',NameofPrediction{temp_s});
        elseif sum(testsub==temp_s)>0
            fprintf(test_t1nativeid,'%s\n',t1native{temp_s});
            fprintf(test_t2nativeid,'%s\n',t2native{temp_s});
            fprintf(test_GTlabelid,'%s\n',GTlabel{temp_s});
            fprintf(test_nameid,'%s\n',NameofPrediction{temp_s});
        end
    end
    fclose(train_t1nativeid);
    fclose(train_t2nativeid);
    fclose(train_GTlabelid);
    fclose(val_t1nativeid);
    fclose(val_t2nativeid);
    fclose(val_GTlabelid);
    fclose(val_nameid);
    fclose(test_t1nativeid);
    fclose(test_t2nativeid);
    fclose(test_GTlabelid);
    fclose(test_nameid);
end
    