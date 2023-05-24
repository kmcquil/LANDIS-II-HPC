#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# create a text file of commands for the jobs that haven't been run yet 
home <- "/share/klmarti3/kmcquil/Chapter3/Models/Future_V2"
model_folders <- list.dirs(home, recursive=F, full.names=F)
run_folders <- c("Run1", "Run2", "Run3", "Run4", "Run5")
sif_name <- "landis_necn_69r.sif"

#model_folder <- model_folders[1]
#run_folder <- run_folders[1]

string_lines <- c()
for(model_folder in model_folders){
  for(run_folder in run_folders){
    
    # the number of files in the folder. If there is only 1, then the run failed 
    if(length(list.files(paste0(home, "/",model_folder, "/", run_folder))) == 1){
      line <- paste0("singularity exec --bind ", home, "/", model_folder, ":/landis --home /share/klmarti3/kmcquil/Chapter3/Models/Future_V2/", model_folder, "/", run_folder, ":${PWD} --cleanenv /usr/local/usrapps/klmarti3/landis/singularity_images/", sif_name, " dotnet /Core-Model-v7-LINUX-7/build/Release/Landis.Console.dll /landis/", run_folder, "/Scenario_Landscape.txt")
      string_lines <- c(string_lines, line)
    }
    else{
      next
    }
    
  }
}

writeLines(string_lines, paste0("/share/klmarti3/kmcquil/Chapter3/Scripts/", args[1]))
