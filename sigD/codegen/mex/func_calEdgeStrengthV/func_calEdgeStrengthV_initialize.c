/*
 * func_calEdgeStrengthV_initialize.c
 *
 * Code generation for function 'func_calEdgeStrengthV_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthV.h"
#include "func_calEdgeStrengthV_initialize.h"
#include "_coder_func_calEdgeStrengthV_mex.h"
#include "func_calEdgeStrengthV_data.h"

/* Function Definitions */
void func_calEdgeStrengthV_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/* End of code generation (func_calEdgeStrengthV_initialize.c) */
