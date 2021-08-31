/*
 * func_calEdgeStrengthV_terminate.c
 *
 * Code generation for function 'func_calEdgeStrengthV_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthV.h"
#include "func_calEdgeStrengthV_terminate.h"
#include "_coder_func_calEdgeStrengthV_mex.h"
#include "func_calEdgeStrengthV_data.h"

/* Function Definitions */
void func_calEdgeStrengthV_atexit(void)
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

void func_calEdgeStrengthV_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (func_calEdgeStrengthV_terminate.c) */
