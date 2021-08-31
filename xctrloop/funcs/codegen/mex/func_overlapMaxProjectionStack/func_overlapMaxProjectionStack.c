/*
 * func_overlapMaxProjectionStack.c
 *
 * Code generation for function 'func_overlapMaxProjectionStack'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_overlapMaxProjectionStack.h"
#include "func_overlapMaxProjectionStack_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "error.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 11,    /* lineNo */
  "func_overlapMaxProjectionStack",    /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 14,  /* lineNo */
  "func_overlapMaxProjectionStack",    /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 16,  /* lineNo */
  "func_overlapMaxProjectionStack",    /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 22,  /* lineNo */
  "reshape",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 54,  /* lineNo */
  "reshape",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 13,  /* lineNo */
  "max",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\max.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 19,  /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 160, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 21,  /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 28,  /* lineNo */
  "squeeze",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elmat\\squeeze.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 58,  /* lineNo */
  "squeeze",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elmat\\squeeze.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 210, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 213, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 214, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 376, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  22,                                  /* colNo */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 19,/* lineNo */
  16,                                  /* colNo */
  "minOrMax",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 14,/* lineNo */
  5,                                   /* colNo */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 16,/* lineNo */
  5,                                   /* colNo */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m"/* pName */
};

static emlrtRTEInfo f_emlrtRTEI = { 121,/* lineNo */
  27,                                  /* colNo */
  "minOrMax",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 59,/* lineNo */
  15,                                  /* colNo */
  "assertValidSizeArg",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"/* pName */
};

static emlrtRTEInfo h_emlrtRTEI = { 44,/* lineNo */
  19,                                  /* colNo */
  "assertValidSizeArg",                /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\assertValidSizeArg.m"/* pName */
};

static emlrtRTEInfo i_emlrtRTEI = { 59,/* lineNo */
  15,                                  /* colNo */
  "reshape",                           /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\elmat\\reshape.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  50,                                  /* colNo */
  "ims0",                              /* aName */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  28,                                  /* colNo */
  "ims0",                              /* aName */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo emlrtDCI = { 16,    /* lineNo */
  28,                                  /* colNo */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  14,                                  /* lineNo */
  50,                                  /* colNo */
  "ims0",                              /* aName */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  14,                                  /* lineNo */
  28,                                  /* colNo */
  "ims0",                              /* aName */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 14,  /* lineNo */
  28,                                  /* colNo */
  "func_overlapMaxProjectionStack",    /* fName */
  "E:\\X\\xctrloop\\funcs\\func_overlapMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

/* Function Definitions */
void func_overlapMaxProjectionStack(const emlrtStack *sp, const uint16_T ims0_
  [361440000], const real_T ims0Size[4], real_T zSectionOverlap,
  emxArray_uint16_T *im1, emxArray_uint16_T *im2)
{
  int32_T pagesize;
  int32_T exitg1;
  boolean_T p;
  real_T n;
  int32_T i0;
  int32_T sz_idx_0;
  int32_T num[4];
  int32_T sz_idx_1;
  int32_T sz_idx_2;
  int32_T i1;
  emxArray_uint16_T *varargin_1;
  int32_T num_idx_0;
  int32_T i2;
  int32_T ix;
  int32_T iy;
  int32_T i3;
  int32_T ixstop;
  emxArray_uint16_T *a;
  int32_T j;
  int32_T loop_ub;
  int32_T npages;
  boolean_T exitg2;
  int32_T sqsz[4];
  emxArray_uint16_T *b_a;
  uint16_T mtmp;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);

  /*  2019/9/30,CH */
  /*  obj.zSectionOverlap x 1200 x 2 */
  /*       1 */
  /*     2   (3) */
  /*       (4) */
  /*  only use 1,2 */
  /*  ims need from piezo small to big val */
  st.site = &emlrtRSI;
  b_st.site = &d_emlrtRSI;
  pagesize = 0;
  do {
    exitg1 = 0;
    if (pagesize < 4) {
      if ((ims0Size[pagesize] != muDoubleScalarFloor(ims0Size[pagesize])) ||
          muDoubleScalarIsInf(ims0Size[pagesize])) {
        p = false;
        exitg1 = 1;
      } else {
        pagesize++;
      }
    } else {
      p = true;
      exitg1 = 1;
    }
  } while (exitg1 == 0);

  if (p) {
    pagesize = 0;
    do {
      exitg1 = 0;
      if (pagesize < 4) {
        if ((-2.147483648E+9 > ims0Size[pagesize]) || (2.147483647E+9 <
             ims0Size[pagesize])) {
          p = false;
          exitg1 = 1;
        } else {
          pagesize++;
        }
      } else {
        p = true;
        exitg1 = 1;
      }
    } while (exitg1 == 0);

    if (p) {
      p = true;
    } else {
      p = false;
    }
  } else {
    p = false;
  }

  if (!p) {
    emlrtErrorWithMessageIdR2012b(&b_st, &h_emlrtRTEI,
      "Coder:toolbox:eml_assert_valid_size_arg_invalidSizeVector", 4, 12,
      MIN_int32_T, 12, MAX_int32_T);
  }

  n = 1.0;
  for (pagesize = 0; pagesize < 4; pagesize++) {
    if (ims0Size[pagesize] <= 0.0) {
      n = 0.0;
    } else {
      n *= ims0Size[pagesize];
    }
  }

  if (!(2.147483647E+9 >= n)) {
    emlrtErrorWithMessageIdR2012b(&b_st, &g_emlrtRTEI, "Coder:MATLAB:pmaxsize",
      0);
  }

  for (i0 = 0; i0 < 4; i0++) {
    num[i0] = (int32_T)ims0Size[i0];
  }

  sz_idx_0 = num[0];
  sz_idx_1 = num[1];
  sz_idx_2 = num[2];
  if (num[0] > 361440000) {
    b_st.site = &e_emlrtRSI;
    c_st.site = &e_emlrtRSI;
    error(&c_st);
  }

  if (num[1] > 361440000) {
    b_st.site = &e_emlrtRSI;
    c_st.site = &e_emlrtRSI;
    error(&c_st);
  }

  if (num[2] > 361440000) {
    b_st.site = &e_emlrtRSI;
    c_st.site = &e_emlrtRSI;
    error(&c_st);
  }

  if (num[3] > 361440000) {
    b_st.site = &e_emlrtRSI;
    c_st.site = &e_emlrtRSI;
    error(&c_st);
  }

  if (num[0] * num[1] * num[2] * num[3] != 361440000) {
    emlrtErrorWithMessageIdR2012b(&st, &i_emlrtRTEI,
      "Coder:MATLAB:getReshapeDims_notSameNumel", 0);
  }

  n = ((real_T)num[3] - zSectionOverlap) + 1.0;
  if (n > num[3]) {
    i0 = 0;
    i1 = 0;
  } else {
    if (n != (int32_T)muDoubleScalarFloor(n)) {
      emlrtIntegerCheckR2012b(n, &b_emlrtDCI, sp);
    }

    i0 = (int32_T)n;
    if (!((i0 >= 1) && (i0 <= num[3]))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, num[3], &d_emlrtBCI, sp);
    }

    i0--;
    if (!(num[3] >= 1)) {
      emlrtDynamicBoundsCheckR2012b(num[3], 1, num[3], &c_emlrtBCI, sp);
    }

    i1 = num[3];
  }

  emxInit_uint16_T(sp, &varargin_1, 4, &emlrtRTEI, true);
  st.site = &b_emlrtRSI;
  num_idx_0 = num[0];
  pagesize = num[1];
  i2 = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2] *
    varargin_1->size[3];
  varargin_1->size[0] = num[0];
  varargin_1->size[1] = num[1];
  varargin_1->size[2] = num[2];
  varargin_1->size[3] = i1 - i0;
  emxEnsureCapacity_uint16_T(&st, varargin_1, i2, &emlrtRTEI);
  ix = i1 - i0;
  for (i2 = 0; i2 < ix; i2++) {
    iy = num[2];
    for (i3 = 0; i3 < iy; i3++) {
      ixstop = num[1];
      for (j = 0; j < ixstop; j++) {
        loop_ub = num[0];
        for (npages = 0; npages < loop_ub; npages++) {
          varargin_1->data[((npages + varargin_1->size[0] * j) +
                            varargin_1->size[0] * varargin_1->size[1] * i3) +
            varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2] * i2]
            = ims0_[((npages + num_idx_0 * j) + num_idx_0 * pagesize * i3) +
            num_idx_0 * pagesize * num[2] * (i0 + i2)];
        }
      }
    }
  }

  b_st.site = &f_emlrtRSI;
  c_st.site = &g_emlrtRSI;
  if (!(num[0] > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &f_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  emxInit_uint16_T(&c_st, &a, 4, &emlrtRTEI, true);
  i2 = a->size[0] * a->size[1] * a->size[2] * a->size[3];
  a->size[0] = 1;
  a->size[1] = num[1];
  a->size[2] = num[2];
  a->size[3] = i1 - i0;
  emxEnsureCapacity_uint16_T(&c_st, a, i2, &b_emlrtRTEI);
  npages = 1;
  pagesize = 4;
  exitg2 = false;
  while ((!exitg2) && (pagesize > 2)) {
    sqsz[0] = sz_idx_0;
    sqsz[1] = sz_idx_1;
    sqsz[2] = sz_idx_2;
    sqsz[3] = i1 - i0;
    if (sqsz[pagesize - 1] == 1) {
      pagesize--;
    } else {
      exitg2 = true;
    }
  }

  for (num_idx_0 = 2; num_idx_0 <= pagesize; num_idx_0++) {
    sqsz[0] = sz_idx_0;
    sqsz[1] = sz_idx_1;
    sqsz[2] = sz_idx_2;
    sqsz[3] = i1 - i0;
    npages *= sqsz[num_idx_0 - 1];
  }

  d_st.site = &h_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    f_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (j = 0; j + 1 <= npages; j++) {
    a->data[j] = varargin_1->data[num[0] * j];
    for (loop_ub = 1; loop_ub + 1 <= sz_idx_0; loop_ub++) {
      if (varargin_1->data[loop_ub + num[0] * j] > a->data[j]) {
        a->data[j] = varargin_1->data[loop_ub + num[0] * j];
      }
    }
  }

  emxFree_uint16_T(&varargin_1);
  st.site = &b_emlrtRSI;
  pagesize = 4;
  while ((pagesize > 2) && (a->size[pagesize - 1] == 1)) {
    pagesize--;
  }

  if (pagesize <= 2) {
    sqsz[1] = a->size[1];
    i0 = im1->size[0] * im1->size[1] * im1->size[2];
    im1->size[0] = 1;
    im1->size[1] = sqsz[1];
    im1->size[2] = 1;
    emxEnsureCapacity_uint16_T1(&st, im1, i0, &c_emlrtRTEI);
    num_idx_0 = a->size[1] * a->size[2] * a->size[3];
    b_st.site = &j_emlrtRSI;
    if ((!(1 > num_idx_0)) && (num_idx_0 > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (pagesize = 0; pagesize + 1 <= num_idx_0; pagesize++) {
      im1->data[pagesize] = a->data[pagesize];
    }
  } else {
    for (i0 = 0; i0 < 4; i0++) {
      sqsz[i0] = 1;
    }

    j = 0;
    if (a->size[1] != 1) {
      sqsz[0] = a->size[1];
      j = 1;
    }

    if (a->size[2] != 1) {
      sqsz[j] = a->size[2];
      j++;
    }

    if (a->size[3] != 1) {
      sqsz[j] = a->size[3];
    }

    i0 = im1->size[0] * im1->size[1] * im1->size[2];
    im1->size[0] = sqsz[0];
    im1->size[1] = sqsz[1];
    im1->size[2] = sqsz[2];
    emxEnsureCapacity_uint16_T1(&st, im1, i0, &c_emlrtRTEI);
    num_idx_0 = a->size[1] * a->size[2] * a->size[3];
    b_st.site = &k_emlrtRSI;
    if ((!(1 > num_idx_0)) && (num_idx_0 > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (pagesize = 0; pagesize + 1 <= num_idx_0; pagesize++) {
      im1->data[pagesize] = a->data[pagesize];
    }
  }

  emxFree_uint16_T(&a);
  n = ((real_T)num[3] - zSectionOverlap) + 1.0;
  if (n > num[3]) {
    i0 = 0;
    i1 = 0;
  } else {
    if (n != (int32_T)muDoubleScalarFloor(n)) {
      emlrtIntegerCheckR2012b(n, &emlrtDCI, sp);
    }

    i0 = (int32_T)n;
    if (!((i0 >= 1) && (i0 <= num[3]))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, num[3], &b_emlrtBCI, sp);
    }

    i0--;
    if (!(num[3] >= 1)) {
      emlrtDynamicBoundsCheckR2012b(num[3], 1, num[3], &emlrtBCI, sp);
    }

    i1 = num[3];
  }

  st.site = &c_emlrtRSI;
  b_st.site = &f_emlrtRSI;
  c_st.site = &g_emlrtRSI;
  if (!(num[1] > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &f_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  emxInit_uint16_T(&c_st, &b_a, 4, &emlrtRTEI, true);
  i2 = b_a->size[0] * b_a->size[1] * b_a->size[2] * b_a->size[3];
  b_a->size[0] = num[0];
  b_a->size[1] = 1;
  b_a->size[2] = num[2];
  b_a->size[3] = i1 - i0;
  emxEnsureCapacity_uint16_T(&c_st, b_a, i2, &b_emlrtRTEI);
  i2 = num[1];
  npages = 1;
  pagesize = 4;
  exitg2 = false;
  while ((!exitg2) && (pagesize > 2)) {
    sqsz[0] = sz_idx_0;
    sqsz[1] = sz_idx_1;
    sqsz[2] = sz_idx_2;
    sqsz[3] = i1 - i0;
    if (sqsz[pagesize - 1] == 1) {
      pagesize--;
    } else {
      exitg2 = true;
    }
  }

  for (num_idx_0 = 3; num_idx_0 <= pagesize; num_idx_0++) {
    sqsz[0] = sz_idx_0;
    sqsz[1] = sz_idx_1;
    sqsz[2] = sz_idx_2;
    sqsz[3] = i1 - i0;
    npages *= sqsz[num_idx_0 - 1];
  }

  i1 = num[0];
  pagesize = num[0] * num[1];
  d_st.site = &l_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &i_emlrtRSI;
    f_st.site = &i_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (loop_ub = 0; loop_ub + 1 <= npages; loop_ub++) {
    ix = loop_ub * pagesize;
    iy = loop_ub * i1;
    d_st.site = &m_emlrtRSI;
    for (j = 1; j <= i1; j++) {
      d_st.site = &n_emlrtRSI;
      num_idx_0 = ix + j;
      ixstop = num_idx_0 + (i2 - 1) * i1;
      i3 = num[0] * num[1];
      mtmp = ims0_[(((num_idx_0 - 1) % num[0] + num[0] * ((num_idx_0 - 1) / num
        [0] % num[1])) + num[0] * num[1] * ((num_idx_0 - 1) / i3 % num[2])) +
        num[0] * num[1] * num[2] * (i0 + (num_idx_0 - 1) / (i3 * num[2]))];
      if ((i2 > 1) && (num_idx_0 < ixstop)) {
        num_idx_0 += i1;
        e_st.site = &o_emlrtRSI;
        if ((!(num_idx_0 > ixstop)) && (ixstop > MAX_int32_T - i1)) {
          f_st.site = &i_emlrtRSI;
          g_st.site = &i_emlrtRSI;
          check_forloop_overflow_error(&g_st);
        }

        while (num_idx_0 <= ixstop) {
          i3 = num[0] * num[1];
          if (ims0_[(((num_idx_0 - 1) % num[0] + num[0] * ((num_idx_0 - 1) /
                 num[0] % num[1])) + num[0] * num[1] * ((num_idx_0 - 1) / i3 %
                num[2])) + num[0] * num[1] * num[2] * (i0 + (num_idx_0 - 1) /
               (i3 * num[2]))] > mtmp) {
            i3 = num[0] * num[1];
            mtmp = ims0_[(((num_idx_0 - 1) % num[0] + num[0] * ((num_idx_0 - 1) /
              num[0] % num[1])) + num[0] * num[1] * ((num_idx_0 - 1) / i3 % num
              [2])) + num[0] * num[1] * num[2] * (i0 + (num_idx_0 - 1) / (i3 *
              num[2]))];
          }

          num_idx_0 += i1;
        }
      }

      b_a->data[(iy + j) - 1] = mtmp;
    }
  }

  st.site = &c_emlrtRSI;
  pagesize = 4;
  while ((pagesize > 2) && (b_a->size[pagesize - 1] == 1)) {
    pagesize--;
  }

  if (pagesize <= 2) {
    sqsz[0] = b_a->size[0];
    i0 = im2->size[0] * im2->size[1] * im2->size[2];
    im2->size[0] = sqsz[0];
    im2->size[1] = 1;
    im2->size[2] = 1;
    emxEnsureCapacity_uint16_T1(&st, im2, i0, &d_emlrtRTEI);
    num_idx_0 = b_a->size[0] * b_a->size[2] * b_a->size[3];
    b_st.site = &j_emlrtRSI;
    if ((!(1 > num_idx_0)) && (num_idx_0 > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (pagesize = 0; pagesize + 1 <= num_idx_0; pagesize++) {
      im2->data[pagesize] = b_a->data[pagesize];
    }
  } else {
    for (i0 = 0; i0 < 4; i0++) {
      sqsz[i0] = 1;
    }

    j = 0;
    if (b_a->size[0] != 1) {
      sqsz[0] = b_a->size[0];
      j = 1;
    }

    if (b_a->size[2] != 1) {
      sqsz[j] = b_a->size[2];
      j++;
    }

    if (b_a->size[3] != 1) {
      sqsz[j] = b_a->size[3];
    }

    i0 = im2->size[0] * im2->size[1] * im2->size[2];
    im2->size[0] = sqsz[0];
    im2->size[1] = sqsz[1];
    im2->size[2] = sqsz[2];
    emxEnsureCapacity_uint16_T1(&st, im2, i0, &d_emlrtRTEI);
    num_idx_0 = b_a->size[0] * b_a->size[2] * b_a->size[3];
    b_st.site = &k_emlrtRSI;
    if ((!(1 > num_idx_0)) && (num_idx_0 > 2147483646)) {
      c_st.site = &i_emlrtRSI;
      d_st.site = &i_emlrtRSI;
      check_forloop_overflow_error(&d_st);
    }

    for (pagesize = 0; pagesize + 1 <= num_idx_0; pagesize++) {
      im2->data[pagesize] = b_a->data[pagesize];
    }
  }

  emxFree_uint16_T(&b_a);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (func_overlapMaxProjectionStack.c) */
