/*
 * _coder_func_sideMaxProjectionStack_api.c
 *
 * Code generation for function '_coder_func_sideMaxProjectionStack_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_sideMaxProjectionStack.h"
#include "_coder_func_sideMaxProjectionStack_api.h"
#include "func_sideMaxProjectionStack_data.h"

/* Function Declarations */
static uint16_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[361440000];
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *sideMaxProjPxl, const char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static uint16_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[361440000];
static uint16_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *ims,
  const char_T *identifier))[361440000];
static const mxArray *emlrt_marshallOut(const uint16_T u[1204800]);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static uint16_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[361440000]
{
  uint16_T (*y)[361440000];
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *sideMaxProjPxl, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(sideMaxProjPxl), &thisId);
  emlrtDestroyArray(&sideMaxProjPxl);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static uint16_T (*e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[361440000]
{
  uint16_T (*ret)[361440000];
  static const int32_T dims[4] = { 1200, 1200, 1, 251 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "uint16", false, 4U, dims);
  ret = (uint16_T (*)[361440000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static uint16_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *ims,
  const char_T *identifier))[361440000]
{
  uint16_T (*y)[361440000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(ims), &thisId);
  emlrtDestroyArray(&ims);
  return y;
}

static const mxArray *emlrt_marshallOut(const uint16_T u[1204800])
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[3] = { 0, 0, 0 };

  static const int32_T iv1[3] = { 251, 1200, 4 };

  y = NULL;
  m0 = emlrtCreateNumericArray(3, iv0, mxUINT16_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u[0]);
  emlrtSetDimensions((mxArray *)m0, iv1, 3);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void func_sideMaxProjectionStack_api(c_func_sideMaxProjectionStackSt *SD, const
  mxArray * const prhs[2], const mxArray *plhs[1])
{
  uint16_T (*imTileSides40)[1204800];
  uint16_T (*ims)[361440000];
  real_T sideMaxProjPxl;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  imTileSides40 = (uint16_T (*)[1204800])mxMalloc(sizeof(uint16_T [1204800]));

  /* Marshall function inputs */
  ims = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "ims");
  sideMaxProjPxl = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]),
    "sideMaxProjPxl");

  /* Invoke the target function */
  func_sideMaxProjectionStack(SD, &st, *ims, sideMaxProjPxl, *imTileSides40);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(*imTileSides40);
}

/* End of code generation (_coder_func_sideMaxProjectionStack_api.c) */
