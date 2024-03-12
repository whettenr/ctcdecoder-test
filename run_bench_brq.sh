#!/bin/bash -l
#SBATCH --partition=gpu
#SBATCH --time=72:00:00
#SBATCH --job-name=ls_brq
#SBATCH --cpus-per-task=10
#SBATCH --mem=32G
#SBATCH --gpus-per-node=1
#SBATCH --constraint='GPURAM_Min_24GB&GPURAM_Max_32GB'
#SBATCH --mail-type=BEGIN,END,FAIL

cd /users/rwhetten/attention_alt
conda activate aa

hub=/users/rwhetten/attention_alt/store/jz_ckpt/brq/1000/save/CKPT+2024-02-01+05-33-06+00
num_layers='13'
encoder_dim='576'
output_folder='results/MP3/brq'

DatasetsFolders=('/corpus/LibriSpeech/')
ConsideredTasks=('LibriSpeech')
DownStreams=('contextnet')
csv_location=/gpfswork/rech/nkp/uaj64gk/attention_alt/brq-att-alt-exp/results/MP3S
benchmark_location=/gpfswork/rech/nkp/uaj64gk/attention_alt/benchmarks

# run pyctcdecode
for i in "${!ConsideredTasks[@]}"; do
	task=${ConsideredTasks[i]}
	downstream=${DownStreams[i]}
	dataset_folder=${DatasetsFolders[i]}
	python train.py ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --output_folder $output_folder/$task/$downstream --data_folder $dataset_folder \
		--ngram_lm_path /users/rwhetten/best-rq-test/benchmark/4-gram.arpa.gz --language_modelling True --test_only \
		--csv_location /users/rwhetten/best-rq-test/results
done

# run with speachbrain decode
for i in "${!ConsideredTasks[@]}"; do
	task=${ConsideredTasks[i]}
	downstream=${DownStreams[i]}
	dataset_folder=${DatasetsFolders[i]}
	python train_sb_dec.py ssl_brq.yaml \
		--num_layers_ssl $num_layers --ssl_hub $hub --encoder_dim $encoder_dim --output_folder $output_folder/$task/$downstream --data_folder $dataset_folder \
		--ngram_lm_path /users/rwhetten/best-rq-test/benchmark/4-gram.arpa.gz --language_modelling True --test_only \
		--csv_location /users/rwhetten/best-rq-test/results
done
