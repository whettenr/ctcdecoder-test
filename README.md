# ctcdecoder-test

The purpose of this repo is to test out ctc decoders using speechbrain and pyctc.

### To run
Note I have not tested this repo... sorry. I just threw this together quick to share my code.
If there are any errors, they sould be minor, but feel free to reach out if you can't get it working.


#### create env with speech brain
```bash
# create conda env
conda create --name NAME_OF_ENV python=3.11

conda activate NAME_OF_ENV
# conda deactivate NAME_OF_ENV # to deactivate

pip install speechbrain # i didnt do this because I'm using a forked version
```

#### set up
- make sure you have the correctlocations for following files
    - the checkpoint for the model
    - csv files 
    - language models 
    - other ???
    - you can see examples of these in ```run_bench_brq.sh``` and ```ssl_brq.yaml``` files

#### run
There are two train files ```train.py``` and ```train_sb_dec.yaml```. 
The ```run_bench_brq.sh``` should give you an example for how to run them.

Running just on the test set doesn't take too long (maybe 10 - 20min)


