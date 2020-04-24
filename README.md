CAST-multi-scale-CNN-for-segmentation-of-hippocamal-subfields
===============================================================
### Instruction

### 1. Required libraries
- [Python](https://www.python.org/downloads/): Python 3 by default, the script is tested on Python 3.6.8.
- [Tensorflow](https://www.https://www.tensorflow.org/): Python 3 by default, the script is tested on Python 3.6.
- [deepmedic](https://github.com/pipiyang/deepmedic): The deepmedic is revised based on https://github.com/deepmedic/deepmedic. When we run the original code on a multiple GPU workstation, it will exhaust all the memories but without reducing computational time. I have modified the code to enable multiple GPUs train a model separately.
### 2. Training and segmentation
Both training and segmentation pipelines is carried out by running the command CastRun.
CastRun [options]
* -path [pathdir] 
  directory of the model configuration. 
* -model [modelconffile] 
  directory or filenames of the configuration file for the deep neural network. The parameters used to setup the network architecture are included in this file.
* -train [trainconffile] 
  directory or filenames of the configuration file for the training pipeline. The parameters used to setup the training scheme are included in this file.
* -test [testconffile]
  directory or filenames of the configuration file for the testing pipeline. The parameters used to setup the testing scheme are included in this file.
* -load [trainedparametersfile]
  directory or filenames of the trained parameters.
* -dev [cudaname]
  cudaname
  
  If [pathdir] is specified, then only the filenames should be specified for option [modelconffile], [trainconffile], [testconffile] and [trainedparametersfile]. [pathdir] can be absolute directory or relative directory. In this case, model configuratopm file is under the directory [pathdir]/configFiles/deepMedic/model/[modelconffile], training configuration file is under the directory [pathdir]/configFiles/deepMedic/train/[trainconffile], testing configuration file is under the directory [pathdir]/configFiles/deepMedic/test/[testconffile], trained parameters is under the directory [pathdir]/output/saved_models/trainSessionDm/[trainedparametersfile]
  
  If [pathdir] is not specified, then the relative or absolute directory for [modelconffile], [trainconffile], [testconffile] and [trainedparametersfile] should be included.
  
  #### 2.1. Training pipeline
```cshell
./CastRun -model ./examples/configFiles/tinyCnn/model/modelConfig.cfg \
               -train examples/configFiles/tinyCnn/train/trainConfigWithValidation.cfg
```

* 3. Segment a new subject.
