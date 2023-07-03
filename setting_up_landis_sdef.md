# Make a .sdef file to download and compile landis + extensions for running in a linux environment (hpc)

The .sdef file in this folder (landis_necn69.sdef) is an example .sdef that runs my updated version of NECN that includes transpiration at species level and can be used as a template going forward. 

The landis_necn_69r.sdef can be compiled into a .sif file that will run LANDIS-II NECN (my transpiration version) on linux. The landis_necn_scrpple_bioharvest.sdef can be compiled into a .sif file that includes NECN (my transpiration version), SCRPPLE, Biomass Harvest, and Biomass Reclass extensions. 

The compiled .sif files were too big to upload to Github.

### Notes on creating the .sdef file: 
- Structure generally consists of downloading from github, unzipping, compiling/putting dlls in the right place, and setting up file structure to bind/ for outputs
- Permissions must be added to the top of the script because landis runs from the root (chmod -R 777 /root)
- I didn't make any changes to the core model.
- Extension releases (ie necn, scrpple, ect) will not work without updating the .csproj file. Steps: 
    - Fork the extension
    - Update the .csproj file following instructions here: https://github.com/LANDIS-II-Foundation/Core-Model-v7-LINUX#landis-ii-v7-extensions under "Compiling LANDIS-II-v7 Extension". 
        - Go to step 5 and add code identified by (i) and (ii) but not (iii)
    - Make sure the right version number of the .txt file is in /deploy/installer to match the sdef when it is compiling
    - Create a release 
    - Use the link to the release in the sdef 
    - These instructions are a little vague but its tough to describe how everything is supposed to match. It's sort of common sense and the compile errors produced by sdef are helpful.
- Make sure you are pulling the correct .dlls. The official landis repo for support dlls doesn't create releases. Instead, create a repo of the dlls you've been using to run the model locally and pull from that so you can be sure the dlls aren't changing each time you rebuild the sif from sdef
