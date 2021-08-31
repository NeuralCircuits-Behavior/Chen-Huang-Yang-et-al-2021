/*
 * func_calEdgeStrength_terminate.c
 *
 * Code generation for function 'func_calEdgeStrength_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrength.h"
#include "func_calEdgeStrength_terminate.h"
#include "_coder_func_calEdgeStrength_mex.h"
#include "func_calEdgeStrength_data.h"

/* Function Definitions */
void func_calEdgeStrength_atexit(void)
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

void func_calEdgeStrength_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (func_calEdgeStrength_terminate.c) */
