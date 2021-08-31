/*
 * _coder_func_sideMaxProjectionStack_mex.c
 *
 * Code generation for function '_coder_func_sideMaxProjectionStack_mex'
 *
 */

/* Include files */
#include "func_sideMaxProjectionStack.h"
#include "_coder_func_sideMaxProjectionStack_mex.h"
#include "func_sideMaxProjectionStack_terminate.h"
#include "_coder_func_sideMaxProjectionStack_api.h"
#include "func_sideMaxProjectionStack_initialize.h"
#include "func_sideMaxProjectionStack_data.h"

/* Function Declarations */
static void c_func_sideMaxProjectionStack_m(c_func_sideMaxProjectionStackSt *SD,
  int32_T nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */
static void c_func_sideMaxProjectionStack_m(c_func_sideMaxProjectionStackSt *SD,
  int32_T nlhs, mxArray *plhs[1], int32_T nrhs, const mxArray *prhs[2])
{
  int32_T n;
  const mxArray *inputs[2];
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        27, "func_sideMaxProjectionStack");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 27,
                        "func_sideMaxProjectionStack");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  func_sideMaxProjectionStack_api(SD, inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  func_sideMaxProjectionStack_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  c_func_sideMaxProjectionStackSt *d_func_sideMaxProjectionStackSt = NULL;
  d_func_sideMaxProjectionStackSt = (c_func_sideMaxProjectionStackSt *)
    emlrtMxCalloc(1, 1U * sizeof(c_func_sideMaxProjectionStackSt));
  mexAtExit(func_sideMaxProjectionStack_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  func_sideMaxProjectionStack_initialize();

  /* Dispatch the entry-point. */
  c_func_sideMaxProjectionStack_m(d_func_sideMaxProjectionStackSt, nlhs, plhs,
    nrhs, prhs);
  emlrtMxFree(d_func_sideMaxProjectionStackSt);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_func_sideMaxProjectionStack_mex.c) */
