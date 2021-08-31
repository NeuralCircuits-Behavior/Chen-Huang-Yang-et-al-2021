/*
 * func_overlapMaxProjectionStack_initialize.c
 *
 * Code generation for function 'func_overlapMaxProjectionStack_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_overlapMaxProjectionStack.h"
#include "func_overlapMaxProjectionStack_initialize.h"
#include "_coder_func_overlapMaxProjectionStack_mex.h"
#include "func_overlapMaxProjectionStack_data.h"

/* Function Definitions */
void func_overlapMaxProjectionStack_initialize(void)
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

/* End of code generation (func_overlapMaxProjectionStack_initialize.c) */
