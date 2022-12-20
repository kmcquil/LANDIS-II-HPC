# Convert an .SDEF file to a Singularity and put it on HPC
This is specific to my workflow. For more useful tutorials see the helpful resources below. 

### Helpful resources: 
1. Elyssa’s Henry 2 Singularity repo: https://github.com/elyssac02/singularity-on-hpc-henry2
2. Kate Jones landis-ii hpc repo: https://github.com/kejones8/ncsu-landis-ii-hpc


### Steps
1. Make or obtain an sdef file that basically installs landis and sets it up to run in a contained environment.
See setting_up_landis_sdef.txt for details on troubleshooting how to update that file. 

2. Convert the .sdef file to a singularity (.sif) file. This must be done on a linux machine. If on Windows or Mac, create a virtual machine that runs Linux following these instructions 
https://docs.sylabs.io/guides/3.5/admin-guide/installation.html#singularity-vagrant-box. 	
    1. Install git, virtual box, vagrant, and vagrant manager for windows 
    2. Open git and navigate to the folder of your choice and run the following commands: 
    ```
	mkdir vm-singularity && cd vm-singularity
    # this is just in case you already had a vagrant file created 
	vagrant destroy &&  rm Vagrantfile 
	export VM=sylabs/singularity-3.5-ubuntu-bionic64 && vagrant init $VM && vagrant up && 	vagrant ssh
    ```

3. Now you are inside the virtual machine run these commands: 
```
sudo apt-get update
sudo apt install vagrant 
exit
```

4. Still within the vm-singularity folder you created and just exited from the vm, run this command to upload the .sdef file to the vm
``` 
vagrant upload C:/Users/kmcquil/Documents/LANDIS-II-HPC/landis_necn69.sdef
```

5. Now go into the vm to build it using these commands: 
```
vagrant up && vagrant ssh
sudo apt install debootstrap 
sudo singularity build --notest landis_necn69.sif landis_necn69.sdef
```

6. Stay in the folder where the .sif was created and copy it to the correct folder so that it will show back up on our local machine 
```
cp -p landis_necn69.sif /vagrant
```

7. Put the .sif on hpc 
```
scp landis_necn69.sif kmcquil@login.hpc.ncsu.edu:/usr/local/usrapps/klmarti3/landis/singularity_images
```
