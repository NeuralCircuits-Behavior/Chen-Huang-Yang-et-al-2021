/*
 * fliplr.c
 *
 * Code generation for function 'fliplr'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthH.h"
#include "fliplr.h"

/* Function Definitions */
void fliplr(emxArray_uint16_T *x)
{
  int32_T m;
  int32_T n;
  int32_T nd2;
  int32_T b_j1;
  int32_T j2;
  int32_T i;
  int32_T x_idx_0;
  uint16_T xtmp;
  int32_T b_x_idx_0;
  m = x->size[0];
  n = x->size[1] - 1;
  nd2 = x->size[1] >> 1;
  for (b_j1 = 0; b_j1 + 1 <= nd2; b_j1++) {
    j2 = n - b_j1;
    for (i = 0; i + 1 <= m; i++) {
      x_idx_0 = x->size[0];
      xtmp = x->data[i + x_idx_0 * b_j1];
      x_idx_0 = x->size[0];
      b_x_idx_0 = x->size[0];
      x->data[i + b_x_idx_0 * b_j1] = x->data[i + x_idx_0 * j2];
      x_idx_0 = x->size[0];
      x->data[i + x_idx_0 * j2] = xtmp;
    }
  }
}

/* End of code generation (fliplr.c) */
