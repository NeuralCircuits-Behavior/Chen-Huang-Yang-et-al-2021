/*
 * func_calEdgeStrengthH_initialize.c
 *
 * Code generation for function 'func_calEdgeStrengthH_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthH.h"
#include "func_calEdgeStrengthH_initialize.h"
#include "_coder_func_calEdgeStrengthH_mex.h"
#include "func_calEdgeStrengthH_data.h"

/* Function Definitions */
void func_calEdgeStrengthH_initialize(void)
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

/* End of code generation (func_calEdgeStrengthH_initialize.c) */
