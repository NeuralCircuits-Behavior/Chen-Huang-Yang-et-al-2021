/*
 * func_sideMaxProjectionStack.h
 *
 * Code generation for function 'func_sideMaxProjectionStack'
 *
 */

#ifndef FUNC_SIDEMAXPROJECTIONSTACK_H
#define FUNC_SIDEMAXPROJECTIONSTACK_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mwmathutil.h"
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "rtwtypes.h"
#include "func_sideMaxProjectionStack_types.h"

/* Function Declarations */
extern void func_sideMaxProjectionStack(c_func_sideMaxProjectionStackSt *SD,
  const emlrtStack *sp, const uint16_T ims[361440000], real_T sideMaxProjPxl,
  uint16_T imTileSides40[1204800]);

#endif

/* End of code generation (func_sideMaxProjectionStack.h) */
