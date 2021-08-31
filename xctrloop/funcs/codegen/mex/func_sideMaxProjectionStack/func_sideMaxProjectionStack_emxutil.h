/*
 * func_sideMaxProjectionStack_emxutil.h
 *
 * Code generation for function 'func_sideMaxProjectionStack_emxutil'
 *
 */

#ifndef FUNC_SIDEMAXPROJECTIONSTACK_EMXUTIL_H
#define FUNC_SIDEMAXPROJECTIONSTACK_EMXUTIL_H

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
extern void emxEnsureCapacity_uint16_T(const emlrtStack *sp, emxArray_uint16_T
  *emxArray, int32_T oldNumel, const emlrtRTEInfo *srcLocation);
extern void emxFree_uint16_T(emxArray_uint16_T **pEmxArray);
extern void emxInit_uint16_T(const emlrtStack *sp, emxArray_uint16_T **pEmxArray,
  int32_T numDimensions, const emlrtRTEInfo *srcLocation, boolean_T doPush);

#endif

/* End of code generation (func_sideMaxProjectionStack_emxutil.h) */
