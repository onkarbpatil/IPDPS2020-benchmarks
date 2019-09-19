/* -*- mode: C; tab-width: 2; indent-tabs-mode: nil; fill-column: 79; coding: iso-latin-1-unix -*- */
/*
  hpcc.c
*/

#include <hpcc.h>
#include <ctype.h>

double diff(struct timespec * start, struct timespec *end) {
    double s = start->tv_sec + (((double) start->tv_nsec) / 1e9);
    double e = end->tv_sec + (((double) end->tv_nsec) / 1e9);
    return e - s;
}

void sicm_setup(int sicm_tag) {
  unsigned cpu, numa;

  sicm_device_list devs = sicm_init();
  cpu = sched_getcpu();
  numa = numa_node_of_cpu(cpu);
//  getcpu(&cpu, &numa, NULL);

  sicm_device *adev = NULL;
  for(int i = 0; i < devs.count; i++) {
	sicm_device *dev = &devs.devices[i];
	if (dev->tag != sicm_tag)
		continue;

	switch (sicm_tag) {
	case SICM_OPTANE:
		if (dev->data.optane.page_size != 4)
			continue;

		if (dev->data.optane.compute_node == numa)
			adev = dev;
		break;

	case SICM_DRAM:
		if (dev->data.dram.page_size != 4)
			continue;

		if (dev->data.dram.node /*compute_node*/ == numa)
			adev = dev;
		break;
	  }

	if (adev)
		break;
  }

//  sicm_device *dev = sicm_find_device(&devs, SICM_OPTANE, 4, NULL);
  if (!adev) {
	fprintf(stderr, "can't find SICM device\n");
	exit(1);
  }

  printf("cpu %d numa %d optane %d\n", cpu, numa, adev->data.dram.node);
  sicm_arena sa = sicm_arena_create(0, adev);
  if (!sa) {
	fprintf(stderr, "can't create SICM arena\n");
	exit(1);
  }

  sicm_arena_set_default(sa);
}

int
main(int argc, char *argv[]) {
  int myRank, commSize;
  char *outFname;
  FILE *outputFile;
  HPCC_Params params;
  time_t currentTime;
  void *extdata;

     int sicm_tag = -1;
    argc--;
    if (!strncmp(argv[argc], "DRAM", 4)) {
        sicm_tag = SICM_DRAM;
    }
    else {
        sicm_tag = SICM_OPTANE;
    }

    sicm_setup(sicm_tag);

  MPI_Init( &argc, &argv );

  if (HPCC_external_init( argc, argv, &extdata ))
    goto hpcc_end;

  if (HPCC_Init( &params, argv[argc - 1] ))
    goto hpcc_end;

  MPI_Comm_size( MPI_COMM_WORLD, &commSize );
  MPI_Comm_rank( MPI_COMM_WORLD, &myRank );

  outFname = params.outFname;

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                 MPI RandomAccess                   *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of MPIRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunMPIRandomAccess) HPCC_MPIRandomAccess( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO(myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of MPIRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                  StarRandomAccess                  *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of StarRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunStarRandomAccess) HPCC_StarRandomAccess( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of StarRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                 SingleRandomAccess                 *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of SingleRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunSingleRandomAccess) HPCC_SingleRandomAccess( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of SingleRandomAccess section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                 MPI RandomAccess LCG               *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of MPIRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunMPIRandomAccess_LCG) HPCC_MPIRandomAccess_LCG( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO(myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of MPIRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                  StarRandomAccess LCG              *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of StarRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunStarRandomAccess_LCG) HPCC_StarRandomAccess_LCG( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of StarRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                 SingleRandomAccess LCG             *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of SingleRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunSingleRandomAccess_LCG) HPCC_SingleRandomAccess_LCG( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of SingleRandomAccess_LCG section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                       PTRANS                       *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of PTRANS section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunPTRANS) PTRANS( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of PTRANS section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* -------------------------------------------------- */
  /*                    StarDGEMM                       */
  /* -------------------------------------------------- */
  struct timespec start, end;

  MPI_Barrier( MPI_COMM_WORLD );

  BEGIN_IO( myRank, outFname, outputFile);
  fprintf( outputFile, "Begin of StarDGEMM section.\n" );
  END_IO( myRank, outputFile );

  clock_gettime(CLOCK_MONOTONIC, &start);
  if (params.RunStarDGEMM) HPCC_StarDGEMM( &params );
  clock_gettime(CLOCK_MONOTONIC, &end);
  printf("StarDGEMM %d %f\n", myRank, diff(&start, &end));

  time( &currentTime );
  BEGIN_IO( myRank, outFname, outputFile);
  fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime));
  fprintf( outputFile, "End of StarDGEMM section.\n" );
  END_IO( myRank, outputFile );

  /* -------------------------------------------------- */
  /*                    SingleDGEMM                     */
  /* -------------------------------------------------- */

  MPI_Barrier( MPI_COMM_WORLD );

  BEGIN_IO( myRank, outFname, outputFile);
  fprintf( outputFile, "Begin of SingleDGEMM section.\n" );
  END_IO( myRank, outputFile );

  clock_gettime(CLOCK_MONOTONIC, &start);
  if (params.RunSingleDGEMM) HPCC_SingleDGEMM( &params );
  clock_gettime(CLOCK_MONOTONIC, &end);
  printf("SingleDGEMM %d %f\n", myRank, diff(&start, &end));

  time( &currentTime );
  BEGIN_IO( myRank, outFname, outputFile);
  fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime));
  fprintf( outputFile, "End of SingleDGEMM section.\n" );
  END_IO( myRank, outputFile );

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                    StarSTREAM                      *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of StarSTREAM section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunStarStream) HPCC_StarStream( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of StarSTREAM section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                    SingleSTREAM                    *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of SingleSTREAM section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunSingleStream) HPCC_SingleStream( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of SingleSTREAM section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                       MPIFFT                       *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of MPIFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunMPIFFT) HPCC_MPIFFT( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of MPIFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                      StarFFT                       *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of StarFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunStarFFT) HPCC_StarFFT( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of StarFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                      SingleFFT                     *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of SingleFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunSingleFFT) HPCC_SingleFFT( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of SingleFFT section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                  Latency/Bandwidth                 *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* MPI_Barrier( MPI_COMM_WORLD ); */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of LatencyBandwidth section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunLatencyBandwidth) main_bench_lat_bw( &params ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of LatencyBandwidth section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* /\* -------------------------------------------------- *\/ */
  /* /\*                        HPL                         *\/ */
  /* /\* -------------------------------------------------- *\/ */

  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile, "Begin of HPL section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  /* if (params.RunHPL) HPL_main( argc, argv, &params.HPLrdata, &params.Failure ); */

  /* time( &currentTime ); */
  /* BEGIN_IO( myRank, outFname, outputFile); */
  /* fprintf( outputFile,"Current time (%ld) is %s\n",(long)currentTime,ctime(&currentTime)); */
  /* fprintf( outputFile, "End of HPL section.\n" ); */
  /* END_IO( myRank, outputFile ); */

  hpcc_end:

  HPCC_Finalize( &params );

  HPCC_external_finalize( argc, argv, extdata );

  MPI_Finalize();
  return 0;
}
