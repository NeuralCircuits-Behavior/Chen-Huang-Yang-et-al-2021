/*
 * flipud.c
 *
 * Code generation for function 'flipud'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthV.h"
#include "flipud.h"

/* Function Definitions */
void flipud(emxArray_uint16_T *x)
{
  int32_T m;
  int32_T n;
  int32_T md2;
  int32_T j;
  int32_T i;
  int32_T x_idx_0;
  uint16_T xtmp;
  int32_T b_x_idx_0;
  m = x->size[0];
  n = x->size[1];
  md2 = x->size[0] >> 1;
  for (j = 0; j + 1 <= n; j++) {
    for (i = 1; i <= md2; i++) {
      x_idx_0 = x->size[0];
      xtmp = x->data[(i + x_idx_0 * j) - 1];
      x_idx_0 = x->size[0];
      b_x_idx_0 = x->size[0];
      x->data[(i + b_x_idx_0 * j) - 1] = x->data[(m - i) + x_idx_0 * j];
      x_idx_0 = x->size[0];
      x->data[(m - i) + x_idx_0 * j] = xtmp;
    }
  }
}

/* End of code generation (flipud.c) */
