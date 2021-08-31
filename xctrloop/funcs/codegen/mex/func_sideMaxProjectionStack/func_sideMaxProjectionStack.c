/*
 * func_sideMaxProjectionStack.c
 *
 * Code generation for function 'func_sideMaxProjectionStack'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_sideMaxProjectionStack.h"
#include "func_sideMaxProjectionStack_emxutil.h"
#include "eml_int_forloop_overflow_check.h"
#include "squeeze.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 9,     /* lineNo */
  "func_sideMaxProjectionStack",       /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 11,  /* lineNo */
  "func_sideMaxProjectionStack",       /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 13,  /* lineNo */
  "func_sideMaxProjectionStack",       /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 15,  /* lineNo */
  "func_sideMaxProjectionStack",       /* fcnName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 13,  /* lineNo */
  "max",                               /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\datafun\\max.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 19,  /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 160, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 21,  /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 210, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 214, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 376, /* lineNo */
  "minOrMax",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  26,                                  /* colNo */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m"/* pName */
};

static emlrtDCInfo emlrtDCI = { 9,     /* lineNo */
  23,                                  /* colNo */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo emlrtBCI = { 1,     /* iFirst */
  1200,                                /* iLast */
  9,                                   /* lineNo */
  23,                                  /* colNo */
  "ims",                               /* aName */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 11,  /* lineNo */
  25,                                  /* colNo */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = { 13,  /* lineNo */
  23,                                  /* colNo */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { 1,   /* iFirst */
  1200,                                /* iLast */
  13,                                  /* lineNo */
  23,                                  /* colNo */
  "ims",                               /* aName */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = { 15,  /* lineNo */
  21,                                  /* colNo */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { 1,   /* iFirst */
  1200,                                /* iLast */
  15,                                  /* lineNo */
  21,                                  /* colNo */
  "ims",                               /* aName */
  "func_sideMaxProjectionStack",       /* fName */
  "E:\\X\\xctrloop\\funcs\\func_sideMaxProjectionStack.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo b_emlrtRTEI = { 121,/* lineNo */
  27,                                  /* colNo */
  "minOrMax",                          /* fName */
  "C:\\Program Files\\MATLAB\\R2017b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pName */
};

/* Function Definitions */
void func_sideMaxProjectionStack(c_func_sideMaxProjectionStackSt *SD, const
  emlrtStack *sp, const uint16_T ims[361440000], real_T sideMaxProjPxl, uint16_T
  imTileSides40[1204800])
{
  int32_T loop_ub;
  emxArray_uint16_T *varargin_1;
  int32_T i0;
  int32_T i1;
  int32_T i2;
  int32_T npages;
  emxArray_uint16_T *b_ims;
  int32_T k;
  int32_T j;
  int32_T i;
  emxArray_uint16_T *c_ims;
  int32_T pagesize;
  int32_T ix;
  int32_T iy;
  int32_T ixstop;
  real_T d0;
  uint16_T mtmp;
  int32_T n;
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

  /*  zScanRange40N x 1200 x 4 */
  /*       1 */
  /*     2   3 */
  /*       4 */
  if (1.0 > sideMaxProjPxl) {
    loop_ub = 0;
  } else {
    if (sideMaxProjPxl != (int32_T)muDoubleScalarFloor(sideMaxProjPxl)) {
      emlrtIntegerCheckR2012b(sideMaxProjPxl, &emlrtDCI, sp);
    }

    loop_ub = (int32_T)sideMaxProjPxl;
    if (!((loop_ub >= 1) && (loop_ub <= 1200))) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, 1200, &emlrtBCI, sp);
    }
  }

  emxInit_uint16_T(sp, &varargin_1, 4, &emlrtRTEI, true);
  st.site = &emlrtRSI;
  i0 = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2] *
    varargin_1->size[3];
  varargin_1->size[0] = loop_ub;
  varargin_1->size[1] = 1200;
  varargin_1->size[2] = 1;
  varargin_1->size[3] = 251;
  emxEnsureCapacity_uint16_T(&st, varargin_1, i0, &emlrtRTEI);
  for (i0 = 0; i0 < 251; i0++) {
    for (i1 = 0; i1 < 1200; i1++) {
      for (i2 = 0; i2 < loop_ub; i2++) {
        varargin_1->data[(i2 + varargin_1->size[0] * i1) + varargin_1->size[0] *
          varargin_1->size[1] * varargin_1->size[2] * i0] = ims[(i2 + 1200 * i1)
          + 1440000 * i0];
      }
    }
  }

  b_st.site = &e_emlrtRSI;
  c_st.site = &f_emlrtRSI;
  if (!(loop_ub > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  npages = 1;
  emxInit_uint16_T(&c_st, &b_ims, 4, &emlrtRTEI, true);
  for (k = 0; k < 3; k++) {
    i0 = b_ims->size[0] * b_ims->size[1] * b_ims->size[2] * b_ims->size[3];
    b_ims->size[0] = loop_ub;
    b_ims->size[1] = 1200;
    b_ims->size[2] = 1;
    b_ims->size[3] = 251;
    emxEnsureCapacity_uint16_T(&c_st, b_ims, i0, &emlrtRTEI);
    for (i0 = 0; i0 < 251; i0++) {
      for (i1 = 0; i1 < 1200; i1++) {
        for (i2 = 0; i2 < loop_ub; i2++) {
          b_ims->data[(i2 + b_ims->size[0] * i1) + b_ims->size[0] * b_ims->size
            [1] * b_ims->size[2] * i0] = ims[(i2 + 1200 * i1) + 1440000 * i0];
        }
      }
    }

    npages *= b_ims->size[k + 1];
  }

  d_st.site = &g_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &h_emlrtRSI;
    f_st.site = &h_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (j = 0; j + 1 <= npages; j++) {
    SD->f0.maxval[j] = varargin_1->data[loop_ub * j];
    for (i = 1; i + 1 <= loop_ub; i++) {
      if (varargin_1->data[i + loop_ub * j] > SD->f0.maxval[j]) {
        SD->f0.maxval[j] = varargin_1->data[i + loop_ub * j];
      }
    }
  }

  squeeze(SD->f0.maxval, SD->f0.b);
  for (i0 = 0; i0 < 1200; i0++) {
    for (i1 = 0; i1 < 251; i1++) {
      imTileSides40[i1 + 251 * i0] = SD->f0.b[i0 + 1200 * i1];
    }
  }

  /*  z x 1200 */
  if (1.0 > sideMaxProjPxl) {
    loop_ub = 0;
  } else {
    if (sideMaxProjPxl != (int32_T)muDoubleScalarFloor(sideMaxProjPxl)) {
      emlrtIntegerCheckR2012b(sideMaxProjPxl, &b_emlrtDCI, sp);
    }

    loop_ub = (int32_T)sideMaxProjPxl;
  }

  st.site = &b_emlrtRSI;
  b_st.site = &e_emlrtRSI;
  c_st.site = &f_emlrtRSI;
  if (!(loop_ub > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  npages = 1;
  emxInit_uint16_T(&c_st, &c_ims, 4, &emlrtRTEI, true);
  for (k = 0; k < 2; k++) {
    i0 = c_ims->size[0] * c_ims->size[1] * c_ims->size[2] * c_ims->size[3];
    c_ims->size[0] = 1200;
    c_ims->size[1] = loop_ub;
    c_ims->size[2] = 1;
    c_ims->size[3] = 251;
    emxEnsureCapacity_uint16_T(&c_st, c_ims, i0, &emlrtRTEI);
    for (i0 = 0; i0 < 251; i0++) {
      for (i1 = 0; i1 < loop_ub; i1++) {
        for (i2 = 0; i2 < 1200; i2++) {
          c_ims->data[(i2 + c_ims->size[0] * i1) + c_ims->size[0] * c_ims->size
            [1] * c_ims->size[2] * i0] = ims[(i2 + 1200 * i1) + 1440000 * i0];
        }
      }
    }

    npages *= c_ims->size[k + 2];
  }

  pagesize = 1200 * loop_ub;
  d_st.site = &i_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &h_emlrtRSI;
    f_st.site = &h_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (i = 0; i + 1 <= npages; i++) {
    ix = i * pagesize + 1;
    iy = i * 1200;
    i0 = 1200 * loop_ub;
    for (j = 0; j < 1200; j++) {
      d_st.site = &j_emlrtRSI;
      k = ix + j;
      ixstop = k + (loop_ub - 1) * 1200;
      mtmp = ims[((k - 1) % 1200 + 1200 * ((k - 1) / 1200 % loop_ub)) + 1440000 *
        ((k - 1) / i0)];
      if ((loop_ub > 1) && (k < ixstop)) {
        e_st.site = &k_emlrtRSI;
        if ((!(k + 1200 > ixstop)) && (ixstop > 2147482447)) {
          f_st.site = &h_emlrtRSI;
          g_st.site = &h_emlrtRSI;
          check_forloop_overflow_error(&g_st);
        }

        for (k += 1199; k + 1 <= ixstop; k += 1200) {
          if (ims[(k % 1200 + 1200 * (k / 1200 % loop_ub)) + 1440000 * (k /
               (1200 * loop_ub))] > mtmp) {
            mtmp = ims[(k % 1200 + 1200 * (k / 1200 % loop_ub)) + 1440000 * (k /
              (1200 * loop_ub))];
          }
        }
      }

      SD->f0.maxval[iy + j] = mtmp;
    }
  }

  memcpy(&SD->f0.b[0], &SD->f0.maxval[0], 301200U * sizeof(uint16_T));
  for (i0 = 0; i0 < 1200; i0++) {
    for (i1 = 0; i1 < 251; i1++) {
      imTileSides40[301200 + (i1 + 251 * i0)] = SD->f0.b[i0 + 1200 * i1];
    }
  }

  /*  z x 1200 */
  if (1200.0 - sideMaxProjPxl > 1200.0) {
    i0 = 1;
    i1 = 1;
  } else {
    d0 = 1200.0 - sideMaxProjPxl;
    if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
      emlrtIntegerCheckR2012b(d0, &c_emlrtDCI, sp);
    }

    i0 = (int32_T)d0;
    if (!((i0 >= 1) && (i0 <= 1200))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 1200, &b_emlrtBCI, sp);
    }

    i1 = 1201;
  }

  st.site = &c_emlrtRSI;
  b_st.site = &e_emlrtRSI;
  c_st.site = &f_emlrtRSI;
  if (!(i1 - i0 > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  n = i1 - i0;
  npages = 1;
  loop_ub = i1 - i0;
  for (k = 0; k < 2; k++) {
    i2 = c_ims->size[0] * c_ims->size[1] * c_ims->size[2] * c_ims->size[3];
    c_ims->size[0] = 1200;
    c_ims->size[1] = i1 - i0;
    c_ims->size[2] = 1;
    c_ims->size[3] = 251;
    emxEnsureCapacity_uint16_T(&c_st, c_ims, i2, &emlrtRTEI);
    for (i2 = 0; i2 < 251; i2++) {
      for (j = 0; j < loop_ub; j++) {
        for (pagesize = 0; pagesize < 1200; pagesize++) {
          c_ims->data[(pagesize + c_ims->size[0] * j) + c_ims->size[0] *
            c_ims->size[1] * c_ims->size[2] * i2] = ims[(pagesize + 1200 * ((i0
            + j) - 1)) + 1440000 * i2];
        }
      }
    }

    npages *= c_ims->size[k + 2];
  }

  emxFree_uint16_T(&c_ims);
  pagesize = 1200 * (i1 - i0);
  d_st.site = &i_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &h_emlrtRSI;
    f_st.site = &h_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (i = 0; i + 1 <= npages; i++) {
    ix = i * pagesize + 1;
    iy = i * 1200;
    i2 = 1200 * (i1 - i0);
    for (j = 0; j < 1200; j++) {
      d_st.site = &j_emlrtRSI;
      k = ix + j;
      ixstop = k + (n - 1) * 1200;
      mtmp = ims[((k - 1) % 1200 + 1200 * ((i0 + (k - 1) / 1200 % (i1 - i0)) - 1))
        + 1440000 * ((k - 1) / i2)];
      if ((n > 1) && (k < ixstop)) {
        e_st.site = &k_emlrtRSI;
        if ((!(k + 1200 > ixstop)) && (ixstop > 2147482447)) {
          f_st.site = &h_emlrtRSI;
          g_st.site = &h_emlrtRSI;
          check_forloop_overflow_error(&g_st);
        }

        for (k += 1199; k + 1 <= ixstop; k += 1200) {
          if (ims[(k % 1200 + 1200 * ((i0 + k / 1200 % (i1 - i0)) - 1)) +
              1440000 * (k / (1200 * (i1 - i0)))] > mtmp) {
            mtmp = ims[(k % 1200 + 1200 * ((i0 + k / 1200 % (i1 - i0)) - 1)) +
              1440000 * (k / (1200 * (i1 - i0)))];
          }
        }
      }

      SD->f0.maxval[iy + j] = mtmp;
    }
  }

  memcpy(&SD->f0.b[0], &SD->f0.maxval[0], 301200U * sizeof(uint16_T));
  for (i0 = 0; i0 < 1200; i0++) {
    for (i1 = 0; i1 < 251; i1++) {
      imTileSides40[602400 + (i1 + 251 * i0)] = SD->f0.b[i0 + 1200 * i1];
    }
  }

  /*  z x 1200 */
  if (1200.0 - sideMaxProjPxl > 1200.0) {
    i0 = 1;
    i1 = 1;
  } else {
    d0 = 1200.0 - sideMaxProjPxl;
    if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
      emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, sp);
    }

    i0 = (int32_T)d0;
    if (!((i0 >= 1) && (i0 <= 1200))) {
      emlrtDynamicBoundsCheckR2012b(i0, 1, 1200, &c_emlrtBCI, sp);
    }

    i1 = 1201;
  }

  st.site = &d_emlrtRSI;
  i2 = varargin_1->size[0] * varargin_1->size[1] * varargin_1->size[2] *
    varargin_1->size[3];
  varargin_1->size[0] = i1 - i0;
  varargin_1->size[1] = 1200;
  varargin_1->size[2] = 1;
  varargin_1->size[3] = 251;
  emxEnsureCapacity_uint16_T(&st, varargin_1, i2, &emlrtRTEI);
  loop_ub = i1 - i0;
  for (i2 = 0; i2 < 251; i2++) {
    for (j = 0; j < 1200; j++) {
      for (pagesize = 0; pagesize < loop_ub; pagesize++) {
        varargin_1->data[(pagesize + varargin_1->size[0] * j) + varargin_1->
          size[0] * varargin_1->size[1] * varargin_1->size[2] * i2] = ims[(((i0
          + pagesize) + 1200 * j) + 1440000 * i2) - 1];
      }
    }
  }

  b_st.site = &e_emlrtRSI;
  c_st.site = &f_emlrtRSI;
  if (!(i1 - i0 > 0)) {
    emlrtErrorWithMessageIdR2012b(&c_st, &b_emlrtRTEI,
      "Coder:toolbox:eml_min_or_max_varDimZero", 0);
  }

  npages = 1;
  loop_ub = i1 - i0;
  for (k = 0; k < 3; k++) {
    i2 = b_ims->size[0] * b_ims->size[1] * b_ims->size[2] * b_ims->size[3];
    b_ims->size[0] = i1 - i0;
    b_ims->size[1] = 1200;
    b_ims->size[2] = 1;
    b_ims->size[3] = 251;
    emxEnsureCapacity_uint16_T(&c_st, b_ims, i2, &emlrtRTEI);
    for (i2 = 0; i2 < 251; i2++) {
      for (j = 0; j < 1200; j++) {
        for (pagesize = 0; pagesize < loop_ub; pagesize++) {
          b_ims->data[(pagesize + b_ims->size[0] * j) + b_ims->size[0] *
            b_ims->size[1] * b_ims->size[2] * i2] = ims[(((i0 + pagesize) + 1200
            * j) + 1440000 * i2) - 1];
        }
      }
    }

    npages *= b_ims->size[k + 1];
  }

  emxFree_uint16_T(&b_ims);
  d_st.site = &g_emlrtRSI;
  if ((!(1 > npages)) && (npages > 2147483646)) {
    e_st.site = &h_emlrtRSI;
    f_st.site = &h_emlrtRSI;
    check_forloop_overflow_error(&f_st);
  }

  for (j = 0; j + 1 <= npages; j++) {
    SD->f0.maxval[j] = varargin_1->data[(i1 - i0) * j];
    for (i = 1; i + 1 <= i1 - i0; i++) {
      if (varargin_1->data[i + (i1 - i0) * j] > SD->f0.maxval[j]) {
        SD->f0.maxval[j] = varargin_1->data[i + (i1 - i0) * j];
      }
    }
  }

  emxFree_uint16_T(&varargin_1);
  memcpy(&SD->f0.b[0], &SD->f0.maxval[0], 301200U * sizeof(uint16_T));
  for (i0 = 0; i0 < 1200; i0++) {
    for (i1 = 0; i1 < 251; i1++) {
      imTileSides40[903600 + (i1 + 251 * i0)] = SD->f0.b[i0 + 1200 * i1];
    }
  }

  /*  z x 1200 */
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (func_sideMaxProjectionStack.c) */
