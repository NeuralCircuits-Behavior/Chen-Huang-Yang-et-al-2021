/*
 * _coder_func_calEdgeStrength_api.c
 *
 * Code generation for function '_coder_func_calEdgeStrength_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrength.h"
#include "_coder_func_calEdgeStrength_api.h"
#include "func_calEdgeStrength_emxutil.h"
#include "func_calEdgeStrength_data.h"

/* Variable Definitions */
static emlrtRTEInfo cb_emlrtRTEI = { 1,/* lineNo */
  1,                                   /* colNo */
  "_coder_func_calEdgeStrength_api",   /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *d, const
  char_T *identifier);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *im, const
  char_T *identifier, emxArray_real_T *y);
static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_real_T *y)
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
  emlrtMsgIdentifier *msgId, emxArray_real_T *ret)
{
  static const int32_T dims[2] = { 1200, 1200 };

  const boolean_T bv0[2] = { true, true };

  int32_T iv4[2];
  int32_T i8;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims, &bv0[0],
    iv4);
  ret->allocatedSize = iv4[0] * iv4[1];
  i8 = ret->size[0] * ret->size[1];
  ret->size[0] = iv4[0];
  ret->size[1] = iv4[1];
  emxEnsureCapacity_real_T(sp, ret, i8, (emlrtRTEInfo *)NULL);
  ret->data = (real_T *)emlrtMxGetData(src);
  ret->canFreeData = false;
  ret->canFreeData = false;
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *im, const
  char_T *identifier, emxArray_real_T *y)
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
  static const int32_T iv3[2] = { 0, 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(2, iv3, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, &u->data[0]);
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

void func_calEdgeStrength_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1])
{
  emxArray_real_T *im;
  emxArray_real_T *E;
  real_T d;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &im, 2, &cb_emlrtRTEI, true);
  emxInit_real_T(&st, &E, 2, &cb_emlrtRTEI, true);

  /* Marshall function inputs */
  im->canFreeData = false;
  emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "im", im);
  d = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "d");

  /* Invoke the target function */
  func_calEdgeStrength(&st, im, d, E);

  /* Marshall function outputs */
  E->canFreeData = false;
  plhs[0] = emlrt_marshallOut(E);
  emxFree_real_T(&E);
  emxFree_real_T(&im);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_func_calEdgeStrength_api.c) */
