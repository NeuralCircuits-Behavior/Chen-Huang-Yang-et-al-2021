/*
 * _coder_func_calEdgeStrength_mex.c
 *
 * Code generation for function '_coder_func_calEdgeStrength_mex'
 *
 */

/* Include files */
#include "func_calEdgeStrength.h"
#include "_coder_func_calEdgeStrength_mex.h"
#include "func_calEdgeStrength_terminate.h"
#include "_coder_func_calEdgeStrength_api.h"
#include "func_calEdgeStrength_initialize.h"
#include "func_calEdgeStrength_data.h"

/* Function Declarations */
static void c_func_calEdgeStrength_mexFunct(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2]);

/* Function Definitions */
static void c_func_calEdgeStrength_mexFunct(int32_T nlhs, mxArray *plhs[1],
  int32_T nrhs, const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4,
                        20, "func_calEdgeStrength");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 20,
                        "func_calEdgeStrength");
  }

  /* Call the function. */
  func_calEdgeStrength_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(func_calEdgeStrength_atexit);

  /* Module initialization. */
  func_calEdgeStrength_initialize();

  /* Dispatch the entry-point. */
  c_func_calEdgeStrength_mexFunct(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  func_calEdgeStrength_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_func_calEdgeStrength_mex.c) */
