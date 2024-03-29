
# Code examples to run Landis using singularity

## Running the model locally using linux vm 
Use this to trouble shoot sdef set up before throwing it on hpc. Also useful for general containerizing reasons. 

Steps: 
1. Upload my small landis model 
```
vagrant upload "G:/My Drive/Chapter3/Calibration/Models/HPC_Trial"
``` 
2. Enter the VM through the vm-singularity folder 
```
vagrant up && vagrant ssh 
```
3. Run the model  
```
singularity exec --bind /home/vagrant/HPC_Trial:/landis --home /home/vagrant/HPC_Trial:/landis --cleanenv /home/vagrant/landis_necn_69r.sif dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/Scenario_Landscape.txt
```

4. Run the model when it is set up for multiple runs that save to sub-folders. In this case, we have a folder with the model called 'HPC_Trial' and then a subfolder 'Run1' that has the Scenario_Landscape.txt. We want the results of the run to save to folder 'Run1'. 
```
singularity exec --bind /home/vagrant/HPC_Trial:/landis --bind /home/vagrant/HPC_Trial/Run1:${PWD} --cleanenv /home/vagrant/landis_necn_69r.sif dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/Run1/Scenario_Landscape.txt

```

## Running the model on HPC 

### Helpful commands to look at singularity resources on hpc 
```
# List the nodes that can run singulairty. They are in the sif queue. 
bqueues -l sif |grep HOSTS

# Check for open nodes 
bhosts -X n3i3-4 # n3h3 

# Check if a node is owned by the root. Then check to see if root owns /scratch/singularity
bsub -Is -n 1 -W 1 -m "n3i3-2" ls -l /scratch | grep singularity
bsub -n 1 -W 1 -q sif -m "n3i3-2" -Is ls -l /scratch | grep sing

# Check run time of the queue you need to use
bqueues -l sif
```

#### Run the model interactively 
```
# Request resources to interactively run landis through singularity and load singulairty
bsub -n 1 -W 30 -q sif -Is tcsh 
module load singularity
singularity exec --bind /share/klmarti3/kmcquil/Chapter3/Calibration/Models/Landis_Flux_Tower_V1:/landis --home /share/klmarti3/kmcquil/Chapter3/Calibration/Models/Landis_Flux_Tower_V1:${PWD} --cleanenv /usr/local/usrapps/klmarti3/landis/singularity_images/landis_necn69.sif dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/Scenario_Landscape.txt
```

#### Run the model interactively through R 
Request resources and load modules 
```
bsub -n 1 -W 120 -q sif -Is tcsh
module load singularity
module load R
R
```
Interactively in R
```
system("singularity exec --bind /share/klmarti3/kmcquil/Chapter3/Calibration/Models/Landis_Flux_Tower_V1:/landis --home /share/klmarti3/kmcquil/Chapter3/Calibration/Models/Landis_Flux_Tower_V1:${PWD}--cleanenv /usr/local/usrapps/klmarti3/landis/singularity_images/landis_necn69.sif dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/Scenario_Landscape.txt", wait=T, intern=T)
print("Finished!")
```

#### Set up R environment on HPC for calibration using conda 
```
# on a login node
conda env create --prefix /usr/local/usrapps/klmarti3/R-Bayesian-Calibration -f bayesian_calibration.yml

# activate the environment, activate R, and install remotes and then install from github
conda activate /usr/local/usrapps/klmarti3/R-Bayesian-Calibration
R

# in R, install the remaining packages 
library(devtools)
devtools::install_github(repo = "florianhartig/BayesianTools", subdir = "BayesianTools", dependencies = T, build_vignettes = T)

```

#### Submit multiple model runs at once to run in parallel using MPI 
The following link has instructions to install pynodelauncher, a helpful program to use MPI in a smart/easy way. 
https://github.com/ncsu-landscape-dynamics/pynodelauncher

The /Example_Batch_Submit_MPI folder has examples of a submission script and text file with commands. 
```
```



