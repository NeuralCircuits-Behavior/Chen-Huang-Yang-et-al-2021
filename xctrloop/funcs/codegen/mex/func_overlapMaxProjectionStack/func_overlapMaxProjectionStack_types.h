/*
 * func_overlapMaxProjectionStack_types.h
 *
 * Code generation for function 'func_overlapMaxProjectionStack'
 *
 */

#ifndef FUNC_OVERLAPMAXPROJECTIONSTACK_TYPES_H
#define FUNC_OVERLAPMAXPROJECTIONSTACK_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_uint16_T
#define struct_emxArray_uint16_T

struct emxArray_uint16_T
{
  uint16_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_uint16_T*/

#ifndef typedef_emxArray_uint16_T
#define typedef_emxArray_uint16_T

typedef struct emxArray_uint16_T emxArray_uint16_T;

#endif                                 /*typedef_emxArray_uint16_T*/
#endif

/* End of code generation (func_overlapMaxProjectionStack_types.h) */
