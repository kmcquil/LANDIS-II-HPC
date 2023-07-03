#!/bin/tcsh
#BSUB -n 30  # number of MPI processes
#BSUB -W 12:00  # maximum time
#BSUB -R "rusage[mem=25GB]"
#BSUB -q sif
#BSUB -oo tasks_out_all
#BSUB -eo tasks_err_all
#BSUB -J tasks  # job name

module load PrgEnv-intel
module load singularity
module load conda
conda activate /usr/local/usrapps/klmarti3/python-gis
mpiexec python -m mpi4py -m pynodelauncher /share/klmarti3/kmcquil/Chapter3/Scripts/commands_model_batch.txt

