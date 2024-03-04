# mpi-cuda
Sample code for MPI+CUDA integration.

It shows two programs, one mpi and another cuda program where mpi code calls cuda function. 

To run this code on Missouri S&T Lab Workstation Nvidia RTX 6000 Ada Generation

1) mpicxx -c mpi.cpp -o mpi.o

2) nvcc -w -m64 -gencode arch=compute_89,code=sm_89 -c -w kernel.cu

3) mpicxx mpi.o kernel.o -o mpi_prog -lcudart -L/usr/local/cuda-11.8/targets/x86_64-linux/lib

4) mpirun -np 4 ./mpi_prog


To run on Everest server,
1) mpicxx -c mpi.cpp -o mpi.o

2) nvcc -w -m64 -gencode arch=compute_72,code=sm_72 -gencode arch=compute_70,code=sm_70 -c -w kernel.cu

3) mpicxx mpi.o kernel.o -lcudart -L/opt/nvidia/hpc_sdk/Linux_x86_64/21.2/cuda/11.2/lib64

4) Execute: mpirun -np 4 ./a.out

**To run MPI code on Hellbender HPC cluster**
Write a batch script like this:
#! /bin/bash
 
#SBATCH -p general  # use the general partition

#SBATCH -J saving_the_world  # give the job a custom name

#SBATCH -o results-%j.out  # give the job output a custom name

#SBATCH -t 0-02:00  # two hour time limit
 
#SBATCH -N 2  # number of nodes

#SBATCH -n 2  # number of cores (AKA tasks) total tasks need to be mentioned here across all nodes
 
#Commands here run only on the first core
echo "$(hostname), reporting for duty."
 
module load openmpi/4.1.1_gcc_9.5.0
 
#Commands with srun will run on all cores in the allocation
srun ./a.out

Now run the batch script using: sbatch scriptname
