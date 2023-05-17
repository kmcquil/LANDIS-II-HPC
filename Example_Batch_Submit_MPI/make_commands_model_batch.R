################################################################################
################################################################################
## Create the .txt file to run each model using mpi on hpc 

## Example of a command that works: 
model_folders <- list.dirs("G:/My Drive/Chapter3/Models/Future", recursive=F, full.names=F)
run_folders <- c("Run1", "Run2", "Run3", "Run4", "Run5")
sif_name <- "landis_necn_69r.sif"

string_lines <- c()
for(model_folder in model_folders){
  for(run_folder in run_folders){
    
    line <- paste0("singularity exec --bind /share/klmarti3/kmcquil/Chapter3/Models/Future/", model_folder, ":/landis --home /share/klmarti3/kmcquil/Chapter3/Models/Future/", model_folder, "/", run_folder, ":${PWD} --cleanenv /usr/local/usrapps/klmarti3/landis/singularity_images/", sif_name, " dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/", run_folder, "/Scenario_Landscape.txt")
    string_lines <- c(string_lines, line)
  }
}

writeLines(string_lines, "G:/My Drive/Chapter3/Scripts/commands.txt")