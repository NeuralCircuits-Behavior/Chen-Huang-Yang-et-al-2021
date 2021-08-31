/*
 * func_calEdgeStrengthH_terminate.c
 *
 * Code generation for function 'func_calEdgeStrengthH_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthH.h"
#include "func_calEdgeStrengthH_terminate.h"
#include "_coder_func_calEdgeStrengthH_mex.h"
#include "func_calEdgeStrengthH_data.h"

/* Function Definitions */
void func_calEdgeStrengthH_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

void func_calEdgeStrengthH_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (func_calEdgeStrengthH_terminate.c) */
