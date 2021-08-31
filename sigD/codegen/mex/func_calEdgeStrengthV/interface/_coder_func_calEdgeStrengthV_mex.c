/*
 * _coder_func_calEdgeStrengthV_mex.c
 *
 * Code generation for function '_coder_func_calEdgeStrengthV_mex'
 *
 */

/* Include files */
#include "func_calEdgeStrengthV.h"
#include "_coder_func_calEdgeStrengthV_mex.h"
#include "func_calEdgeStrengthV_terminate.h"
#include "_coder_func_calEdgeStrengthV_api.h"
#include "func_calEdgeStrengthV_initialize.h"
#include "func_calEdgeStrengthV_data.h"

/* Function Declarations */
static void c_func_calEdgeStrengthV_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */
static void c_func_calEdgeStrengthV_mexFunc(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2])
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
                        21, "func_calEdgeStrengthV");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "func_calEdgeStrengthV");
  }

  /* Temporary copy for mex inputs. */
  for (n = 0; n < nrhs; n++) {
    inputs[n] = prhs[n];
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(&st);
    }
  }

  /* Call the function. */
  func_calEdgeStrengthV_api(inputs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  func_calEdgeStrengthV_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(func_calEdgeStrengthV_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  func_calEdgeStrengthV_initialize();

  /* Dispatch the entry-point. */
  c_func_calEdgeStrengthV_mexFunc(nlhs, plhs, nrhs, prhs);
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_func_calEdgeStrengthV_mex.c) */
