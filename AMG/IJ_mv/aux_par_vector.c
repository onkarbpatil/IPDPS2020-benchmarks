/*BHEADER**********************************************************************
 * Copyright (c) 2017,  Lawrence Livermore National Security, LLC.
 * Produced at the Lawrence Livermore National Laboratory.
 * Written by Ulrike Yang (yang11@llnl.gov) et al. CODE-LLNL-738-322.
 * This file is part of AMG.  See files README and COPYRIGHT for details.
 *
 * AMG is free software; you can redistribute it and/or modify it under the
 * terms of the GNU Lesser General Public License (as published by the Free
 * Software Foundation) version 2.1 dated February 1999.
 *
 * This software is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the IMPLIED WARRANTY OF MERCHANTIBILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the terms and conditions of the
 * GNU General Public License for more details.
 *
 ***********************************************************************EHEADER*/

/******************************************************************************
 *
 * Member functions for hypre_AuxParVector class.
 *
 *****************************************************************************/

#include "_hypre_IJ_mv.h"
#include "aux_par_vector.h"

/*--------------------------------------------------------------------------
 * hypre_AuxParVectorCreate
 *--------------------------------------------------------------------------*/

HYPRE_Int
hypre_AuxParVectorCreate( hypre_AuxParVector **aux_vector)
{
   hypre_AuxParVector  *vector;
   
   vector = hypre_CTAlloc(hypre_AuxParVector, 1);
  
   /* set defaults */
   hypre_AuxParVectorMaxOffProcElmts(vector) = 0;
   hypre_AuxParVectorCurrentNumElmts(vector) = 0;
   /* stash for setting or adding off processor values */
   hypre_AuxParVectorOffProcI(vector) = NULL;
   hypre_AuxParVectorOffProcData(vector) = NULL;


   *aux_vector = vector;
   return 0;
}

/*--------------------------------------------------------------------------
 * hypre_AuxParVectorDestroy
 *--------------------------------------------------------------------------*/

HYPRE_Int 
hypre_AuxParVectorDestroy( hypre_AuxParVector *vector )
{
   HYPRE_Int ierr=0;

   if (vector)
   {
      if (hypre_AuxParVectorOffProcI(vector))
         hypre_TFree(hypre_AuxParVectorOffProcI(vector));
      if (hypre_AuxParVectorOffProcData(vector))
         hypre_TFree(hypre_AuxParVectorOffProcData(vector));
      hypre_TFree(vector);
   }

   return ierr;
}

/*--------------------------------------------------------------------------
 * hypre_AuxParVectorInitialize
 *--------------------------------------------------------------------------*/

HYPRE_Int 
hypre_AuxParVectorInitialize( hypre_AuxParVector *vector )
{
   HYPRE_Int max_off_proc_elmts = hypre_AuxParVectorMaxOffProcElmts(vector);

   /* allocate stash for setting or adding off processor values */
   if (max_off_proc_elmts > 0)
   {
      hypre_AuxParVectorOffProcI(vector) = hypre_CTAlloc(HYPRE_Int,
                                                         max_off_proc_elmts);
      hypre_AuxParVectorOffProcData(vector) = hypre_CTAlloc(HYPRE_Complex,
                                                            max_off_proc_elmts);
   }

   return 0;
}

/*--------------------------------------------------------------------------
 * hypre_AuxParVectorSetMaxOffProcElmts
 *--------------------------------------------------------------------------*/

HYPRE_Int 
hypre_AuxParVectorSetMaxOffPRocElmts( hypre_AuxParVector *vector,
                                      HYPRE_Int max_off_proc_elmts )
{
   HYPRE_Int ierr = 0;
   hypre_AuxParVectorMaxOffProcElmts(vector) = max_off_proc_elmts;
   return ierr;
}

