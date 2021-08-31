/*
 * _coder_func_overlapMaxProjectionStack_mex.c
 *
 * Code generation for function '_coder_func_overlapMaxProjectionStack_mex'
 *
 */

/* Include files */
#include "func_overlapMaxProjectionStack.h"
#include "_coder_func_overlapMaxProjectionStack_mex.h"
#include "func_overlapMaxProjectionStack_terminate.h"
#include "_coder_func_overlapMaxProjectionStack_api.h"
#include "func_overlapMaxProjectionStack_initialize.h"
#include "func_overlapMaxProjectionStack_data.h"

/* Function Declarations */
static void c_func_overlapMaxProjectionStac(int32_T nlhs, mxArray *plhs[2],
  int32_T nrhs, const mxArray *prhs[3]);

/* Function Definitions */
static void c_func_overlapMaxProjectionStac(int32_T nlhs, mxArray *plhs[2],
  int32_T nrhs, const mxArray *prhs[3])
{
  int32_T n;
  const mxArray *inputs[3];
  const mxArray *outputs[2];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 3, 4,
                        30, "func_overlapMaxProjectionStack");
  }

  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 30,
                        "func_overlapMaxProjectionStack");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  func_overlapMaxProjectionStack_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  func_overlapMaxProjectionStack_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(func_overlapMaxProjectionStack_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  func_overlapMaxProjectionStack_initialize();

  /* Dispatch the entry-point. */
  c_func_overlapMaxProjectionStac(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_func_overlapMaxProjectionStack_mex.c) */
