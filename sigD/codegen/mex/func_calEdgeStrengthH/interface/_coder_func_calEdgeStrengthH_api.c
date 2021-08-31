/*
 * _coder_func_calEdgeStrengthH_api.c
 *
 * Code generation for function '_coder_func_calEdgeStrengthH_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthH.h"
#include "_coder_func_calEdgeStrengthH_api.h"
#include "func_calEdgeStrengthH_emxutil.h"
#include "func_calEdgeStrengthH_data.h"

/* Variable Definitions */
static emlrtRTEInfo d_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_func_calEdgeStrengthH_api",  /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_uint16_T *y);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *d, const
  char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_uint16_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *im, const
  char_T *identifier, emxArray_uint16_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_uint16_T *y)
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *d, const
  char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(d), &thisId);
  emlrtDestroyArray(&d);
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

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_uint16_T *ret)
{
  static const int32_T dims[2] = { 1200, 1200 };

  const boolean_T bv0[2] = { true, true };

  int32_T iv2[2];
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "uint16", false, 2U, dims, &bv0[0],
    iv2);
  ret->size[0] = iv2[0];
  ret->size[1] = iv2[1];
  ret->allocatedSize = ret->size[0] * ret->size[1];
  ret->data = (uint16_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *im, const
  char_T *identifier, emxArray_uint16_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(im), &thisId, y);
  emlrtDestroyArray(&im);
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv1[2] = { 0, 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv1, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u->data[0]);
  emlrtSetDimensions((mxArray *)m0, u->size, 2);
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

void func_calEdgeStrengthH_api(const mxArray * const prhs[2], const mxArray
  *plhs[1])
{
  emxArray_uint16_T *im;
  emxArray_real_T *eh;
  real_T d;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_uint16_T(&st, &im, 2, &d_emlrtRTEI, true);
  emxInit_real_T(&st, &eh, 2, &d_emlrtRTEI, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "im", im);
  d = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "d");

  /* Invoke the target function */
  func_calEdgeStrengthH(&st, im, d, eh);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(eh);
  eh->canFreeData = false;
  emxFree_real_T(&eh);
  im->canFreeData = false;
  emxFree_uint16_T(&im);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_func_calEdgeStrengthH_api.c) */
