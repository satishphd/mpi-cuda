#include <stdio.h>
//#include "util.h"

// CUDA path: -L/opt/nvidia/hpc_sdk/Linux_x86_64/21.2/cuda/11.2/lib64
// nvcc -w -m64 -gencode arch=compute_72,code=sm_72 -gencode arch=compute_70,code=sm_70 -c -w kernel.cu


__global__ void kernel(int *array1, int *array2, int *array3)

{
  // to do: verify the gpu id by using function cudaGetDevice()

  int index = blockIdx.x * blockDim.x + threadIdx.x;

  array3[index] = array1[index] + array2[index];

}

void run_kernel(int processID)
{

  printf("Par is %d\n",par);
  int i, array1[6], array2[6], array3[6], *devarray1, *devarray2, *devarray3;

  for(i = 0; i < 6; i++)

  {

    array1[i] = i;

    array2[i] = i;

  }
  // select a unique GPU id based on MPI process ID
  cudaSetDevice(processID);

  cudaMalloc((void**) &devarray1, sizeof(int)*6);

  cudaMalloc((void**) &devarray2, sizeof(int)*6);

  cudaMalloc((void**) &devarray3, sizeof(int)*6);

  cudaMemcpy(devarray1, array1, sizeof(int)*6, cudaMemcpyHostToDevice);

  cudaMemcpy(devarray2, array2, sizeof(int)*6, cudaMemcpyHostToDevice);

  kernel<<<2, 3>>>(devarray1, devarray2, devarray3);

  cudaMemcpy(array3, devarray3, sizeof(int)*6, cudaMemcpyDeviceToHost);

  for(i = 0; i < 6; i++)
  {

   printf("%d ", array3[i]);

  }

  printf("\n");

  cudaFree(devarray1);

  cudaFree(devarray2);

  cudaFree(devarray3);

}
