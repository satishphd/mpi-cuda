# mpi-cuda
Sample code for MPI+CUDA integration.

It shows two programs, one mpi and another cuda program where mpi code calls cuda function. 

1) mpicxx -c mpi.cpp -o mpi.o

2) nvcc -w -m64 -gencode arch=compute_72,code=sm_72 -gencode arch=compute_70,code=sm_70 -c -w kernel.cu

3) mpicxx mpi.o kernel.o -lcudart -L/opt/nvidia/hpc_sdk/Linux_x86_64/21.2/cuda/11.2/lib64

4) Execute: ./a.out
