#!/usr/bin/env bash

echo "optane: $(hostname)"

module load openmpi likwid

export OMP_NUM_THREADS=1
RESULTS="${HOME}/memsys19-optane/results"
# rm -rf ${RESULTS}
# mkdir -p ${RESULTS}

# cd /home/jlee/memsys19-optane/vpic/optane

# # vpic weak scaling for optane modes
# export MACRO="USE_OPTANE"
# make -j
# bin/vpic lpi_weak.cxx
# for p in 1 2 4 8
# do
#     mpirun -np $p likwid-perfctr -g ENERGY ./lpi_weak.Linux   &> ${RESULTS}/vpic_weak_scaling.optane.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lpi_weak.Linux &> ${RESULTS}/vpic_weak_scaling.optane.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM ./lpi_weak.Linux      &> ${RESULTS}/vpic_weak_scaling.optane.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE ./lpi_weak.Linux  &> ${RESULTS}/vpic_weak_scaling.optane.$p.L3CACHE
# done

# export MACRO="USE_DRAM"
# bin/vpic lpi_weak.cxx
# for p in 1 2 4 8
# do
#     mpirun -np $p likwid-perfctr -g ENERGY ./lpi_weak.Linux   &> ${RESULTS}/vpic_weak_scaling.DRAM.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lpi_weak.Linux &> ${RESULTS}/vpic_weak_scaling.DRAM.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM ./lpi_weak.Linux      &> ${RESULTS}/vpic_weak_scaling.DRAM.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE ./lpi_weak.Linux  &> ${RESULTS}/vpic_weak_scaling.DRAM.$p.L3CACHE
# done

# # vpic strong scaling for optane modes
# export MACRO="USE_OPTANE"
# for npcc in 256 512 1024 2048
# do
#     bin/vpic strongscaling-${npcc}.cxx
# done

# declare -A npccranks
# npccranks[256]=8
# npccranks[512]=4
# npccranks[1024]=2
# npccranks[2048]=1

# for i in "${!npccranks[@]}"
# do
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g ENERGY   ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.optane.$i.${npccranks[$i]}.ENERGY"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g FLOPS_DP ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.optane.$i.${npccranks[$i]}.FLOPS_DP"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g MEM      ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.optane.$i.${npccranks[$i]}.MEM"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g L3CACHE  ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.optane.$i.${npccranks[$i]}.L3CACHE"
# done

# export MACRO="USE_DRAM"
# for npcc in 256 512 1024 2048
# do
#     bin/vpic strongscaling-${npcc}.cxx
# done

# for i in "${!npccranks[@]}"
# do
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g ENERGY   ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.DRAM.$i.${npccranks[$i]}.ENERGY"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g FLOPS_DP ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.DRAM.$i.${npccranks[$i]}.FLOPS_DP"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g MEM      ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.DRAM.$i.${npccranks[$i]}.MEM"
#     mpirun -np "${npccranks[$i]}" likwid-perfctr -g L3CACHE  ./strongscaling-"$i".Linux   &> "${RESULTS}/vpic_strong_scaling.DRAM.$i.${npccranks[$i]}.L3CACHE"
# done

# # SNAP strong scaling
# # process count increases 1,2,4,8, nx, ny, nz stay at 32
# cd /home/jlee/memsys19-optane/SNAP/ports/snap-c
# make
# for p in 1 2 4 8
# do
#     mpirun -np $p likwid-perfctr -g ENERGY   ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.optane.$p.ENERGY OPTANE &> ${RESULTS}/snap_strong_scaling.optane.$p.ENERGY.likwid
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.optane.$p.FLOPS_DP OPTANE &> ${RESULTS}/snap_strong_scaling.optane.$p.FLOPS_DP.likwid
#     mpirun -np $p likwid-perfctr -g MEM      ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.optane.$p.MEM OPTANE &> ${RESULTS}/snap_strong_scaling.optane.$p.MEM.likwid
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.optane.$p.L3CACHE OPTANE &> ${RESULTS}/snap_strong_scaling.optane.$p.L3CACHE.likwid

#     mpirun -np $p likwid-perfctr -g ENERGY   ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.DRAM.$p.ENERGY DRAM &> ${RESULTS}/snap_strong_scaling.DRAM.$p.ENERGYY.likwid
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.DRAM.$p.FLOPS_DP DRAM  &> ${RESULTS}/snap_strong_scaling.DRAM.$p.FLOPS_DP.likwid
#     mpirun -np $p likwid-perfctr -g MEM      ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.DRAM.$p.MEM DRAM  &> ${RESULTS}/snap_strong_scaling.DRAM.$p.MEM.likwid
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./snap --fi ${p}_strong --fo ${RESULTS}/snap_strong_scaling.DRAM.$p.L3CACHE DRAM &> ${RESULTS}/snap_strong_scaling.DRAM.$p.L3CACHE.likwid
# done

# # SNAP weak scaling
# # process count increases nx,ny,nz 8-64
# for p in 1 2 4 8
# do
#     mpirun -np $p likwid-perfctr -g ENERGY   ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.optane.$p.ENERGY OPTANE &> ${RESULTS}/snap_weak_scaling.optane.$p.ENERGY.likwid
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.optane.$p.FLOPS_DP OPTANE &> ${RESULTS}/snap_weak_scaling.optane.$p.FLOPS_DP.likwid
#     mpirun -np $p likwid-perfctr -g MEM      ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.optane.$p.MEM OPTANE &> ${RESULTS}/snap_weak_scaling.optane.$p.MEM.likwid
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.optane.$p.L3CACHE OPTANE &> ${RESULTS}/snap_weak_scaling.optane.$p.L3CACHE.likwid

#     mpirun -np $p likwid-perfctr -g ENERGY   ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.DRAM.$p.ENERGY DRAM &> ${RESULTS}/snap_weak_scaling.DRAM.$p.ENERGY.likwid
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.DRAM.$p.FLOPS_DP DRAM  &> ${RESULTS}/snap_weak_scaling.DRAM.$p.FLOPS_DP.likwid
#     mpirun -np $p likwid-perfctr -g MEM      ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.DRAM.$p.MEM DRAM  &> ${RESULTS}/snap_weak_scaling.DRAM.$p.MEM.likwid
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./snap --fi ${p}_weak --fo ${RESULTS}/snap_weak_scaling.DRAM.$p.L3CACHE DRAM &> ${RESULTS}/snap_weak_scaling.DRAM.$p.L3CACHE.likwid
# done

# # AMG weakscaling
# # process 1, 2, 4, 8; n = 64
cd /home/jlee/memsys19-optane/AMG/test

declare -A P
P[1]="1 1 1"
P[2]="1 1 2"
P[4]="1 2 2"
P[8]="2 2 2"

for p in 1 2 4 8
do
    mpirun -np $p likwid-perfctr -g ENERGY   ./amg -n 256 256 256 -P ${P[$p]} OPTANE &> ${RESULTS}/amg_weak_scaling.optane.$p.ENERGY
    mpirun -np $p likwid-perfctr -g FLOPS_DP ./amg -n 256 256 256 -P ${P[$p]} OPTANE &> ${RESULTS}/amg_weak_scaling.optane.$p.FLOPS_DP
    mpirun -np $p likwid-perfctr -g MEM      ./amg -n 256 256 256 -P ${P[$p]} OPTANE &> ${RESULTS}/amg_weak_scaling.optane.$p.MEM
    mpirun -np $p likwid-perfctr -g L3CACHE  ./amg -n 256 256 256 -P ${P[$p]} OPTANE &> ${RESULTS}/amg_weak_scaling.optane.$p.L3CACHE

    mpirun -np $p likwid-perfctr -g ENERGY   ./amg -n 256 256 256 -P ${P[$p]} DRAM &> ${RESULTS}/amg_weak_scaling.DRAM.$p.ENERGY
    mpirun -np $p likwid-perfctr -g FLOPS_DP ./amg -n 256 256 256 -P ${P[$p]} DRAM &> ${RESULTS}/amg_weak_scaling.DRAM.$p.FLOPS_DP
    mpirun -np $p likwid-perfctr -g MEM      ./amg -n 256 256 256 -P ${P[$p]} DRAM &> ${RESULTS}/amg_weak_scaling.DRAM.$p.MEM
    mpirun -np $p likwid-perfctr -g L3CACHE  ./amg -n 256 256 256 -P ${P[$p]} DRAM &> ${RESULTS}/amg_weak_scaling.DRAM.$p.L3CACHE
done

# AMG strong scaling
# process 1, 2, 3, 8; n = (32, 32, 32), (64, 32, 32), (64, 64, 32), (64, 64, 64)

declare -A N
N[1]="256 256 256"
N[2]="256 256 128"
N[4]="256 128 128"
N[8]="128 128 128"

for p in "${!N[@]}"
do
    mpirun -np $p likwid-perfctr -g ENERGY   ./amg -n ${N[$p]} -P ${P[$p]} OPTANE &> ${RESULTS}/amg_strong_scaling.optane.$p.ENERGY
    mpirun -np $p likwid-perfctr -g FLOPS_DP ./amg -n ${N[$p]} -P ${P[$p]} OPTANE &> ${RESULTS}/amg_strong_scaling.optane.$p.FLOPS_DP
    mpirun -np $p likwid-perfctr -g MEM      ./amg -n ${N[$p]} -P ${P[$p]} OPTANE &> ${RESULTS}/amg_strong_scaling.optane.$p.MEM
    mpirun -np $p likwid-perfctr -g L3CACHE  ./amg -n ${N[$p]} -P ${P[$p]} OPTANE &> ${RESULTS}/amg_strong_scaling.optane.$p.L3CACHE

    mpirun -np $p likwid-perfctr -g ENERGY   ./amg -n ${N[$p]} -P ${P[$p]} DRAM &> ${RESULTS}/amg_strong_scaling.DRAM.$p.ENERGY
    mpirun -np $p likwid-perfctr -g FLOPS_DP ./amg -n ${N[$p]} -P ${P[$p]} DRAM &> ${RESULTS}/amg_strong_scaling.DRAM.$p.FLOPS_DP
    mpirun -np $p likwid-perfctr -g MEM      ./amg -n ${N[$p]} -P ${P[$p]} DRAM &> ${RESULTS}/amg_strong_scaling.DRAM.$p.MEM
    mpirun -np $p likwid-perfctr -g L3CACHE  ./amg -n ${N[$p]} -P ${P[$p]} DRAM &> ${RESULTS}/amg_strong_scaling.DRAM.$p.L3CACHE
done

# # DGEMM strong scaling
# # process 1, 2, 4, 8; N = 64000
cd /home/jlee/memsys19-optane/hpcc-1.5.0
# make arch=skylake
# for p in 4 8 16 32
# do
#     mpirun -np $p likwid-perfctr -g ENERGY   ./hpcc hpccinf.txt OPTANE &> ${RESULTS}/hpcc_strong_scaling.optane.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./hpcc hpccinf.txt OPTANE &> ${RESULTS}/hpcc_strong_scaling.optane.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./hpcc hpccinf.txt OPTANE &> ${RESULTS}/hpcc_strong_scaling.optane.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./hpcc hpccinf.txt OPTANE &> ${RESULTS}/hpcc_strong_scaling.optane.$p.L3CACHE

#     mpirun -np $p likwid-perfctr -g ENERGY   ./hpcc hpccinf.txt DRAM &> ${RESULTS}/hpcc_strong_scaling.DRAM.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./hpcc hpccinf.txt DRAM &> ${RESULTS}/hpcc_strong_scaling.DRAM.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./hpcc hpccinf.txt DRAM &> ${RESULTS}/hpcc_strong_scaling.DRAM.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./hpcc hpccinf.txt DRAM &> ${RESULTS}/hpcc_strong_scaling.DRAM.$p.L3CACHE
# done

# DGEMM weak scaling
# process 1, 2, 3, 8; N = 8K, 16K, 32K, 64K
# unset n
# declare -A n
# n[4]=8000
# n[8]=16000
# n[16]=32000
# n[32]=64000

# for p in "${!n[@]}"
# do
    # mpirun -np $p likwid-perfctr -g ENERGY   ./hpcc $p OPTANE &> ${RESULTS}/hpcc_weak_scaling.optane.$p.ENERGY
    # mpirun -np $p likwid-perfctr -g FLOPS_DP ./hpcc $p OPTANE &> ${RESULTS}/hpcc_weak_scaling.optane.$p.FLOPS_DP
    # mpirun -np $p likwid-perfctr -g MEM      ./hpcc $p OPTANE &> ${RESULTS}/hpcc_weak_scaling.optane.$p.MEM
    # mpirun -np $p likwid-perfctr -g L3CACHE  ./hpcc $p OPTANE &> ${RESULTS}/hpcc_weak_scaling.optane.$p.L3CACHE

    # mpirun -np $p likwid-perfctr -g ENERGY   ./hpcc $p DRAM &> ${RESULTS}/hpcc_weak_scaling.DRAM.$p.ENERGYY
    # mpirun -np $p likwid-perfctr -g FLOPS_DP ./hpcc $p DRAM &> ${RESULTS}/hpcc_weak_scaling.DRAM.$p.FLOPS_DP
    # mpirun -np $p likwid-perfctr -g MEM      ./hpcc $p DRAM &> ${RESULTS}/hpcc_weak_scaling.DRAM.$p.MEM
    # mpirun -np $p likwid-perfctr -g L3CACHE  ./hpcc $p DRAM &> ${RESULTS}/hpcc_weak_scaling.DRAM.$p.L3CACHE
# done


# # LULESH weak scaling
# # processes 1, 8, 27, 64
# cd /home/jlee/memsys19-optane/LULESH
# make
# for p in 1 8 27
# do
#     mpirun -np $p likwid-perfctr -g ENERGY   ./lulesh2.0 -s 25 OPTANE &> ${RESULTS}/lulesh_weak_scaling.optane.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lulesh2.0 -s 25 OPTANE &> ${RESULTS}/lulesh_weak_scaling.optane.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./lulesh2.0 -s 25 OPTANE &> ${RESULTS}/lulesh_weak_scaling.optane.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./lulesh2.0 -s 25 OPTANE &> ${RESULTS}/lulesh_weak_scaling.optane.$p.L3CACHE

#     mpirun -np $p likwid-perfctr -g ENERGY   ./lulesh2.0 -s 25 DRAM &> ${RESULTS}/lulesh_weak_scaling.DRAM.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lulesh2.0 -s 25 DRAM &> ${RESULTS}/lulesh_weak_scaling.DRAM.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./lulesh2.0 -s 25 DRAM &> ${RESULTS}/lulesh_weak_scaling.DRAM.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./lulesh2.0 -s 25 DRAM &> ${RESULTS}/lulesh_weak_scaling.DRAM.$p.L3CACHE
# done

# # LULESH strong scaling
# # processes 1, 8, 27, 64; problem size 40, 20, 13, 10

# declare -A procsize
# procsize[1]=50
# procsize[8]=25
# procsize[27]=17
# #procsize[64]=10

# for p in "${!procsize[@]}"
# do
#     mpirun -np $p likwid-perfctr -g ENERGY   ./lulesh2.0 -s ${procsize[$p]} OPTANE &> ${RESULTS}/lulesh_strong_scaling.optane.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lulesh2.0 -s ${procsize[$p]} OPTANE &> ${RESULTS}/lulesh_strong_scaling.optane.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./lulesh2.0 -s ${procsize[$p]} OPTANE &> ${RESULTS}/lulesh_strong_scaling.optane.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./lulesh2.0 -s ${procsize[$p]} OPTANE &> ${RESULTS}/lulesh_strong_scaling.optane.$p.L3CACHE

#     mpirun -np $p likwid-perfctr -g ENERGY   ./lulesh2.0 -s ${procsize[$p]} DRAM &> ${RESULTS}/lulesh_strong_scaling.DRAM.$p.ENERGY
#     mpirun -np $p likwid-perfctr -g FLOPS_DP ./lulesh2.0 -s ${procsize[$p]} DRAM &> ${RESULTS}/lulesh_strong_scaling.DRAM.$p.FLOPS_DP
#     mpirun -np $p likwid-perfctr -g MEM      ./lulesh2.0 -s ${procsize[$p]} DRAM &> ${RESULTS}/lulesh_strong_scaling.DRAM.$p.MEM
#     mpirun -np $p likwid-perfctr -g L3CACHE  ./lulesh2.0 -s ${procsize[$p]} DRAM &> ${RESULTS}/lulesh_strong_scaling.DRAM.$p.L3CACHE
# done
