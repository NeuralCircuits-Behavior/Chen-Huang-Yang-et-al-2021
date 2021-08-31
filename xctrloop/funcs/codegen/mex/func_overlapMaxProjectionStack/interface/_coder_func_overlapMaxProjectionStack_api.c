/*
 * _coder_func_overlapMaxProjectionStack_api.c
 *
 * Code generation for function '_coder_func_overlapMaxProjectionStack_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_overlapMaxProjectionStack.h"
#include "_coder_func_overlapMaxProjectionStack_api.h"
#include "func_overlapMaxProjectionStack_emxutil.h"
#include "func_overlapMaxProjectionStack_data.h"

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_func_overlapMaxProjectionStack_api",/* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static uint16_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[361440000];
static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *ims0Size,
  const char_T *identifier))[4];
static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[4];
static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *zSectionOverlap, const char_T *identifier);
static uint16_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *ims0_,
  const char_T *identifier))[361440000];
static const mxArray *emlrt_marshallOut(const emxArray_uint16_T *u);
static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static uint16_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[361440000];
static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4];
static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);

/* Function Definitions */
static uint16_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
  const emlrtMsgIdentifier *parentId))[361440000]
{
  uint16_T (*y)[361440000];
  y = g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T (*c_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *ims0Size, const char_T *identifier))[4]
{
  real_T (*y)[4];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(ims0Size), &thisId);
  emlrtDestroyArray(&ims0Size);
  return y;
}

static real_T (*d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId))[4]
{
  real_T (*y)[4];
  y = h_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}
  static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray
  *zSectionOverlap, const char_T *identifier)
{
  real_T y;
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(zSectionOverlap), &thisId);
  emlrtDestroyArray(&zSectionOverlap);
  return y;
}

static uint16_T (*emlrt_marshallIn(const emlrtStack *sp, const mxArray *ims0_,
  const char_T *identifier))[361440000]
{
  uint16_T (*y)[361440000];
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(ims0_), &thisId);
  emlrtDestroyArray(&ims0_);
  return y;
}
  static const mxArray *emlrt_marshallOut(const emxArray_uint16_T *u)
{
  const mxArray *y;
  const mxArray *m0;
  static const int32_T iv0[3] = { 0, 0, 0 };

  y = NULL;
  m0 = emlrtCreateNumericArray(3, iv0, mxUINT16_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m0, (void *)&u->data[0]);
  emlrtSetDimensions((mxArray *)m0, u->size, 3);
  emlrtAssign(&y, m0);
  return y;
}

static real_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = i_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static uint16_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[361440000]
{
  uint16_T (*ret)[361440000];
  static const int32_T dims[1] = { 361440000 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "uint16", false, 1U, dims);
  ret = (uint16_T (*)[361440000])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}
  static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
  const emlrtMsgIdentifier *msgId))[4]
{
  real_T (*ret)[4];
  static const int32_T dims[2] = { 1, 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 2U, dims);
  ret = (real_T (*)[4])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

void func_overlapMaxProjectionStack_api(const mxArray * const prhs[3], const
  mxArray *plhs[2])
{
  emxArray_uint16_T *im1;
  emxArray_uint16_T *im2;
  uint16_T (*ims0_)[361440000];
  real_T (*ims0Size)[4];
  real_T zSectionOverlap;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_uint16_T1(&st, &im1, 3, &e_emlrtRTEI, true);
  emxInit_uint16_T1(&st, &im2, 3, &e_emlrtRTEI, true);

  /* Marshall function inputs */
  ims0_ = emlrt_marshallIn(&st, emlrtAlias(prhs[0]), "ims0_");
  ims0Size = c_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "ims0Size");
  zSectionOverlap = e_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]),
    "zSectionOverlap");

  /* Invoke the target function */
  func_overlapMaxProjectionStack(&st, *ims0_, *ims0Size, zSectionOverlap, im1,
    im2);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(im1);
  plhs[1] = emlrt_marshallOut(im2);
  im2->canFreeData = false;
  emxFree_uint16_T(&im2);
  im1->canFreeData = false;
  emxFree_uint16_T(&im1);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_func_overlapMaxProjectionStack_api.c) */
