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

