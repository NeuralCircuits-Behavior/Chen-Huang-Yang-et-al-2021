/*
 * func_overlapMaxProjectionStack_terminate.c
 *
 * Code generation for function 'func_overlapMaxProjectionStack_terminate'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_overlapMaxProjectionStack.h"
#include "func_overlapMaxProjectionStack_terminate.h"
#include "_coder_func_overlapMaxProjectionStack_mex.h"
#include "func_overlapMaxProjectionStack_data.h"

/* Function Definitions */
void func_overlapMaxProjectionStack_atexit(void)
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

void func_overlapMaxProjectionStack_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (func_overlapMaxProjectionStack_terminate.c) */
