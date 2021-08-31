/*
 * func_calEdgeStrength.c
 *
 * Code generation for function 'func_calEdgeStrength'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "func_calEdgeStrength.h"
#include "func_calEdgeStrength_emxutil.h"
#include "scalexpAlloc.h"
#include "func_calEdgeStrength_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 2,     /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 9,   /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 15,  /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 18,  /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 33,  /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 35,  /* lineNo */
  "func_calEdgeStrength",              /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 18,  /* lineNo */
  "indexShapeCheck",                   /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pathName */
};

static emlrtRSInfo h_emlrtRSI = { 13,  /* lineNo */
  "max",                               /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\lib\\matlab\\datafun\\max.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 19,  /* lineNo */
  "minOrMax",                          /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 37,  /* lineNo */
  "minOrMax",                          /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\minOrMax.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 60,  /* lineNo */
  "binaryMinOrMax",                    /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\binaryMinOrMax.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 45,  /* lineNo */
  "applyBinaryScalarFunction",         /* fcnName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\applyBinaryScalarFunction.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 7,   /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 13,/* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 9, /* lineNo */
  16,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 9, /* lineNo */
  11,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 15,/* lineNo */
  16,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo f_emlrtRTEI = { 45,/* lineNo */
  6,                                   /* colNo */
  "applyBinaryScalarFunction",         /* fName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\applyBinaryScalarFunction.m"/* pName */
};

static emlrtRTEInfo g_emlrtRTEI = { 18,/* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo h_emlrtRTEI = { 15,/* lineNo */
  11,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo i_emlrtRTEI = { 35,/* lineNo */
  8,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo j_emlrtRTEI = { 2, /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo k_emlrtRTEI = { 1, /* lineNo */
  14,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo l_emlrtRTEI = { 22,/* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo m_emlrtRTEI = { 23,/* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo n_emlrtRTEI = { 23,/* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo o_emlrtRTEI = { 23,/* lineNo */
  29,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo p_emlrtRTEI = { 24,/* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo q_emlrtRTEI = { 24,/* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo r_emlrtRTEI = { 24,/* lineNo */
  37,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo s_emlrtRTEI = { 25,/* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo t_emlrtRTEI = { 25,/* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo u_emlrtRTEI = { 25,/* lineNo */
  29,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo v_emlrtRTEI = { 26,/* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo w_emlrtRTEI = { 26,/* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo x_emlrtRTEI = { 26,/* lineNo */
  37,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo y_emlrtRTEI = { 27,/* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo ab_emlrtRTEI = { 27,/* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo bb_emlrtRTEI = { 21,/* lineNo */
  16,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo emlrtDCI = { 9,     /* lineNo */
  22,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  9,                                   /* lineNo */
  22,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo b_emlrtDCI = { 15,  /* lineNo */
  20,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  15,                                  /* lineNo */
  20,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  9,                                   /* lineNo */
  6,                                   /* colNo */
  "ev",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo emlrtECI = { -1,    /* nDims */
  9,                                   /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  15,                                  /* lineNo */
  4,                                   /* colNo */
  "eh",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo b_emlrtECI = { -1,  /* nDims */
  15,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtRTEInfo db_emlrtRTEI = { 32,/* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo c_emlrtDCI = { 33,  /* lineNo */
  23,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  33,                                  /* lineNo */
  23,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = { 35,  /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  35,                                  /* lineNo */
  13,                                  /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = { 35,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  35,                                  /* lineNo */
  17,                                  /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo eb_emlrtRTEI = { 88,/* lineNo */
  9,                                   /* colNo */
  "indexShapeCheck",                   /* fName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\indexShapeCheck.m"/* pName */
};

static emlrtRTEInfo fb_emlrtRTEI = { 18,/* lineNo */
  23,                                  /* colNo */
  "scalexpAlloc",                      /* fName */
  "E:\\Prog\\MATLAB\\2018b\\toolbox\\eml\\eml\\+coder\\+internal\\scalexpAlloc.m"/* pName */
};

static emlrtDCInfo f_emlrtDCI = { 33,  /* lineNo */
  36,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  33,                                  /* lineNo */
  5,                                   /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  33,                                  /* lineNo */
  36,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  33,                                  /* lineNo */
  60,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  32,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo g_emlrtDCI = { 23,  /* lineNo */
  34,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  34,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo h_emlrtDCI = { 24,  /* lineNo */
  40,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  40,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  48,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  34,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo i_emlrtDCI = { 25,  /* lineNo */
  36,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  36,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo j_emlrtDCI = { 26,  /* lineNo */
  42,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  42,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  50,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo k_emlrtDCI = { 23,  /* lineNo */
  7,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  7,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo l_emlrtDCI = { 23,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo m_emlrtDCI = { 23,  /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  23,                                  /* lineNo */
  13,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo c_emlrtECI = { -1,  /* nDims */
  23,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo n_emlrtDCI = { 24,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  13,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo o_emlrtDCI = { 24,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  17,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo p_emlrtDCI = { 24,  /* lineNo */
  21,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  24,                                  /* lineNo */
  21,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo d_emlrtECI = { -1,  /* nDims */
  24,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo q_emlrtDCI = { 25,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo r_emlrtDCI = { 25,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo s_emlrtDCI = { 25,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  25,                                  /* lineNo */
  17,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo e_emlrtECI = { -1,  /* nDims */
  25,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo t_emlrtDCI = { 26,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo u_emlrtDCI = { 26,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo v_emlrtDCI = { 26,  /* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  23,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo f_emlrtECI = { -1,  /* nDims */
  26,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo w_emlrtDCI = { 27,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo x_emlrtDCI = { 27,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo y_emlrtDCI = { 27,  /* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo lb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo ab_emlrtDCI = { 27, /* lineNo */
  19,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo mb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  27,                                  /* lineNo */
  19,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo g_emlrtECI = { -1,  /* nDims */
  27,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m"/* pName */
};

static emlrtDCInfo bb_emlrtDCI = { 22, /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  1                                    /* checkKind */
};

static emlrtDCInfo cb_emlrtDCI = { 22, /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrength",              /* fName */
  "E:\\X\\sigD\\func_calEdgeStrength.m",/* pName */
  4                                    /* checkKind */
};

/* Function Declarations */
static void pad(const emlrtStack *sp, const emxArray_real_T *im, real_T d,
                emxArray_real_T *im1);

/* Function Definitions */
static void pad(const emlrtStack *sp, const emxArray_real_T *im, real_T d,
                emxArray_real_T *im1)
{
  real_T xtmp;
  real_T unnamed_idx_0;
  int32_T i6;
  int32_T i7;
  int32_T i;
  int32_T loop_ub;
  int32_T b_loop_ub;
  emxArray_int32_T *r2;
  emxArray_int32_T *r3;
  emxArray_real_T *x;
  int32_T md2;
  int32_T iv2[2];
  int32_T m;
  int32_T n;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  xtmp = 2.0 * d;
  unnamed_idx_0 = (real_T)im->size[0] + xtmp;
  if (!(unnamed_idx_0 >= 0.0)) {
    emlrtNonNegativeCheckR2012b(unnamed_idx_0, &cb_emlrtDCI, sp);
  }

  if (unnamed_idx_0 != (int32_T)muDoubleScalarFloor(unnamed_idx_0)) {
    emlrtIntegerCheckR2012b(unnamed_idx_0, &bb_emlrtDCI, sp);
  }

  xtmp += (real_T)im->size[1];
  if (!(xtmp >= 0.0)) {
    emlrtNonNegativeCheckR2012b(xtmp, &cb_emlrtDCI, sp);
  }

  if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
    emlrtIntegerCheckR2012b(xtmp, &bb_emlrtDCI, sp);
  }

  i6 = im1->size[0] * im1->size[1];
  i7 = (int32_T)unnamed_idx_0;
  im1->size[0] = i7;
  i = (int32_T)xtmp;
  im1->size[1] = i;
  emxEnsureCapacity_real_T(sp, im1, i6, &l_emlrtRTEI);
  loop_ub = i7 * i;
  for (i6 = 0; i6 < loop_ub; i6++) {
    im1->data[i6] = 0.0;
  }

  if (1.0 > d) {
    loop_ub = 0;
    b_loop_ub = 0;
  } else {
    i6 = im->size[0];
    if (1 > i6) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i6, &k_emlrtBCI, sp);
    }

    xtmp = (int32_T)muDoubleScalarFloor(d);
    if (d != xtmp) {
      emlrtIntegerCheckR2012b(d, &g_emlrtDCI, sp);
    }

    i6 = im->size[0];
    loop_ub = (int32_T)d;
    if ((loop_ub < 1) || (loop_ub > i6)) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i6, &l_emlrtBCI, sp);
    }

    if (1 > i7) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i7, &s_emlrtBCI, sp);
    }

    if (d != xtmp) {
      emlrtIntegerCheckR2012b(d, &k_emlrtDCI, sp);
    }

    if ((loop_ub < 1) || (loop_ub > i7)) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i7, &t_emlrtBCI, sp);
    }

    b_loop_ub = loop_ub;
  }

  xtmp = (real_T)i - d;
  if (d + 1.0 > xtmp) {
    i6 = 0;
    i7 = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &l_emlrtDCI, sp);
    }

    i6 = (int32_T)(d + 1.0);
    if ((i6 < 1) || (i6 > i)) {
      emlrtDynamicBoundsCheckR2012b(i6, 1, i, &u_emlrtBCI, sp);
    }

    i6--;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &m_emlrtDCI, sp);
    }

    i7 = (int32_T)xtmp;
    if ((i7 < 1) || (i7 > i)) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, i, &v_emlrtBCI, sp);
    }
  }

  emxInit_int32_T(sp, &r2, 1, &bb_emlrtRTEI, true);
  i = r2->size[0];
  r2->size[0] = b_loop_ub;
  emxEnsureCapacity_int32_T(sp, r2, i, &m_emlrtRTEI);
  for (i = 0; i < b_loop_ub; i++) {
    r2->data[i] = i;
  }

  emxInit_int32_T(sp, &r3, 1, &bb_emlrtRTEI, true);
  i = r3->size[0];
  b_loop_ub = i7 - i6;
  r3->size[0] = b_loop_ub;
  emxEnsureCapacity_int32_T(sp, r3, i, &n_emlrtRTEI);
  for (i7 = 0; i7 < b_loop_ub; i7++) {
    r3->data[i7] = i6 + i7;
  }

  emxInit_real_T(sp, &x, 2, &o_emlrtRTEI, true);
  b_loop_ub = im->size[1];
  i6 = x->size[0] * x->size[1];
  x->size[0] = loop_ub;
  x->size[1] = b_loop_ub;
  emxEnsureCapacity_real_T(sp, x, i6, &o_emlrtRTEI);
  for (i6 = 0; i6 < b_loop_ub; i6++) {
    for (i7 = 0; i7 < loop_ub; i7++) {
      x->data[i7 + x->size[0] * i6] = im->data[i7 + im->size[0] * i6];
    }
  }

  i6 = im->size[1];
  md2 = loop_ub >> 1;
  for (b_loop_ub = 0; b_loop_ub < i6; b_loop_ub++) {
    for (i = 0; i < md2; i++) {
      xtmp = x->data[i + x->size[0] * b_loop_ub];
      x->data[i + x->size[0] * b_loop_ub] = x->data[((loop_ub - i) + x->size[0] *
        b_loop_ub) - 1];
      x->data[((loop_ub - i) + x->size[0] * b_loop_ub) - 1] = xtmp;
    }
  }

  iv2[0] = r2->size[0];
  iv2[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv2[0], 2, &(*(int32_T (*)[2])x->size)[0], 2,
    &c_emlrtECI, sp);
  loop_ub = x->size[1];
  for (i6 = 0; i6 < loop_ub; i6++) {
    b_loop_ub = x->size[0];
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      im1->data[r2->data[i7] + im1->size[0] * r3->data[i6]] = x->data[i7 +
        x->size[0] * i6];
    }
  }

  xtmp = ((real_T)im->size[0] - d) + 1.0;
  if (xtmp > im->size[0]) {
    i7 = 1;
    i6 = 1;
  } else {
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &h_emlrtDCI, sp);
    }

    i6 = im->size[0];
    i7 = (int32_T)xtmp;
    if ((i7 < 1) || (i7 > i6)) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, i6, &m_emlrtBCI, sp);
    }

    i6 = im->size[0];
    i = im->size[0];
    if ((i < 1) || (i > i6)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, i6, &n_emlrtBCI, sp);
    }

    i6 = i + 1;
  }

  xtmp = ((real_T)im1->size[0] - d) + 1.0;
  if (xtmp > im1->size[0]) {
    i = 0;
    m = 0;
  } else {
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &n_emlrtDCI, sp);
    }

    i = im1->size[0];
    md2 = (int32_T)xtmp;
    if ((md2 < 1) || (md2 > i)) {
      emlrtDynamicBoundsCheckR2012b(md2, 1, i, &w_emlrtBCI, sp);
    }

    i = md2 - 1;
    md2 = im1->size[0];
    m = im1->size[0];
    if ((m < 1) || (m > md2)) {
      emlrtDynamicBoundsCheckR2012b(m, 1, md2, &x_emlrtBCI, sp);
    }
  }

  xtmp = (real_T)im1->size[1] - d;
  if (d + 1.0 > xtmp) {
    md2 = 0;
    b_loop_ub = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &o_emlrtDCI, sp);
    }

    md2 = im1->size[1];
    n = (int32_T)(d + 1.0);
    if ((n < 1) || (n > md2)) {
      emlrtDynamicBoundsCheckR2012b(n, 1, md2, &y_emlrtBCI, sp);
    }

    md2 = n - 1;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &p_emlrtDCI, sp);
    }

    n = im1->size[1];
    b_loop_ub = (int32_T)xtmp;
    if ((b_loop_ub < 1) || (b_loop_ub > n)) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, n, &ab_emlrtBCI, sp);
    }
  }

  n = r2->size[0];
  loop_ub = m - i;
  r2->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r2, n, &p_emlrtRTEI);
  for (m = 0; m < loop_ub; m++) {
    r2->data[m] = i + m;
  }

  i = r3->size[0];
  loop_ub = b_loop_ub - md2;
  r3->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r3, i, &q_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = md2 + i;
  }

  loop_ub = im->size[1];
  i = x->size[0] * x->size[1];
  b_loop_ub = i6 - i7;
  x->size[0] = b_loop_ub;
  x->size[1] = loop_ub;
  emxEnsureCapacity_real_T(sp, x, i, &r_emlrtRTEI);
  for (i6 = 0; i6 < loop_ub; i6++) {
    for (i = 0; i < b_loop_ub; i++) {
      x->data[i + x->size[0] * i6] = im->data[((i7 + i) + im->size[0] * i6) - 1];
    }
  }

  m = b_loop_ub - 1;
  i6 = im->size[1];
  md2 = b_loop_ub >> 1;
  for (b_loop_ub = 0; b_loop_ub < i6; b_loop_ub++) {
    for (i = 0; i < md2; i++) {
      xtmp = x->data[i + x->size[0] * b_loop_ub];
      x->data[i + x->size[0] * b_loop_ub] = x->data[(m - i) + x->size[0] *
        b_loop_ub];
      x->data[(m - i) + x->size[0] * b_loop_ub] = xtmp;
    }
  }

  iv2[0] = r2->size[0];
  iv2[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv2[0], 2, &(*(int32_T (*)[2])x->size)[0], 2,
    &d_emlrtECI, sp);
  loop_ub = x->size[1];
  for (i6 = 0; i6 < loop_ub; i6++) {
    b_loop_ub = x->size[0];
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      im1->data[r2->data[i7] + im1->size[0] * r3->data[i6]] = x->data[i7 +
        x->size[0] * i6];
    }
  }

  if (1.0 > d) {
    loop_ub = 0;
  } else {
    i6 = im->size[1];
    if (1 > i6) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i6, &o_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &i_emlrtDCI, sp);
    }

    i6 = im->size[1];
    loop_ub = (int32_T)d;
    if ((loop_ub < 1) || (loop_ub > i6)) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i6, &p_emlrtBCI, sp);
    }
  }

  xtmp = (real_T)im1->size[0] - d;
  if (d + 1.0 > xtmp) {
    i6 = 0;
    i = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &q_emlrtDCI, sp);
    }

    i6 = im1->size[0];
    i7 = (int32_T)(d + 1.0);
    if ((i7 < 1) || (i7 > i6)) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, i6, &bb_emlrtBCI, sp);
    }

    i6 = i7 - 1;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &r_emlrtDCI, sp);
    }

    i7 = im1->size[0];
    i = (int32_T)xtmp;
    if ((i < 1) || (i > i7)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, i7, &cb_emlrtBCI, sp);
    }
  }

  if (1.0 > d) {
    b_loop_ub = 0;
  } else {
    i7 = im1->size[1];
    if (1 > i7) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i7, &db_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &s_emlrtDCI, sp);
    }

    i7 = im1->size[1];
    b_loop_ub = (int32_T)d;
    if ((b_loop_ub < 1) || (b_loop_ub > i7)) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i7, &eb_emlrtBCI, sp);
    }
  }

  i7 = r2->size[0];
  md2 = i - i6;
  r2->size[0] = md2;
  emxEnsureCapacity_int32_T(sp, r2, i7, &s_emlrtRTEI);
  for (i7 = 0; i7 < md2; i7++) {
    r2->data[i7] = i6 + i7;
  }

  i6 = r3->size[0];
  r3->size[0] = b_loop_ub;
  emxEnsureCapacity_int32_T(sp, r3, i6, &t_emlrtRTEI);
  for (i6 = 0; i6 < b_loop_ub; i6++) {
    r3->data[i6] = i6;
  }

  b_loop_ub = im->size[0];
  i6 = x->size[0] * x->size[1];
  x->size[0] = b_loop_ub;
  x->size[1] = loop_ub;
  emxEnsureCapacity_real_T(sp, x, i6, &u_emlrtRTEI);
  for (i6 = 0; i6 < loop_ub; i6++) {
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      x->data[i7 + x->size[0] * i6] = im->data[i7 + im->size[0] * i6];
    }
  }

  i6 = im->size[0];
  md2 = loop_ub >> 1;
  for (b_loop_ub = 0; b_loop_ub < md2; b_loop_ub++) {
    m = (loop_ub - b_loop_ub) - 1;
    for (i = 0; i < i6; i++) {
      xtmp = x->data[i + x->size[0] * b_loop_ub];
      x->data[i + x->size[0] * b_loop_ub] = x->data[i + x->size[0] * m];
      x->data[i + x->size[0] * m] = xtmp;
    }
  }

  iv2[0] = r2->size[0];
  iv2[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv2[0], 2, &(*(int32_T (*)[2])x->size)[0], 2,
    &e_emlrtECI, sp);
  loop_ub = x->size[1];
  for (i6 = 0; i6 < loop_ub; i6++) {
    b_loop_ub = x->size[0];
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      im1->data[r2->data[i7] + im1->size[0] * r3->data[i6]] = x->data[i7 +
        x->size[0] * i6];
    }
  }

  xtmp = ((real_T)im->size[1] - d) + 1.0;
  if (xtmp > im->size[1]) {
    i7 = 1;
    i6 = 1;
  } else {
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &j_emlrtDCI, sp);
    }

    i6 = im->size[1];
    i7 = (int32_T)xtmp;
    if ((i7 < 1) || (i7 > i6)) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, i6, &q_emlrtBCI, sp);
    }

    i6 = im->size[1];
    i = im->size[1];
    if ((i < 1) || (i > i6)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, i6, &r_emlrtBCI, sp);
    }

    i6 = i + 1;
  }

  xtmp = (real_T)im1->size[0] - d;
  if (d + 1.0 > xtmp) {
    i = 0;
    m = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &t_emlrtDCI, sp);
    }

    i = im1->size[0];
    md2 = (int32_T)(d + 1.0);
    if ((md2 < 1) || (md2 > i)) {
      emlrtDynamicBoundsCheckR2012b(md2, 1, i, &fb_emlrtBCI, sp);
    }

    i = md2 - 1;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &u_emlrtDCI, sp);
    }

    md2 = im1->size[0];
    m = (int32_T)xtmp;
    if ((m < 1) || (m > md2)) {
      emlrtDynamicBoundsCheckR2012b(m, 1, md2, &gb_emlrtBCI, sp);
    }
  }

  xtmp = ((real_T)im1->size[1] - d) + 1.0;
  if (xtmp > im1->size[1]) {
    md2 = 0;
    b_loop_ub = 0;
  } else {
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &v_emlrtDCI, sp);
    }

    md2 = im1->size[1];
    n = (int32_T)xtmp;
    if ((n < 1) || (n > md2)) {
      emlrtDynamicBoundsCheckR2012b(n, 1, md2, &hb_emlrtBCI, sp);
    }

    md2 = n - 1;
    n = im1->size[1];
    b_loop_ub = im1->size[1];
    if ((b_loop_ub < 1) || (b_loop_ub > n)) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, n, &ib_emlrtBCI, sp);
    }
  }

  n = r2->size[0];
  loop_ub = m - i;
  r2->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r2, n, &v_emlrtRTEI);
  for (m = 0; m < loop_ub; m++) {
    r2->data[m] = i + m;
  }

  i = r3->size[0];
  loop_ub = b_loop_ub - md2;
  r3->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r3, i, &w_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    r3->data[i] = md2 + i;
  }

  loop_ub = im->size[0];
  i = x->size[0] * x->size[1];
  x->size[0] = loop_ub;
  b_loop_ub = i6 - i7;
  x->size[1] = b_loop_ub;
  emxEnsureCapacity_real_T(sp, x, i, &x_emlrtRTEI);
  for (i6 = 0; i6 < b_loop_ub; i6++) {
    for (i = 0; i < loop_ub; i++) {
      x->data[i + x->size[0] * i6] = im->data[i + im->size[0] * ((i7 + i6) - 1)];
    }
  }

  i6 = im->size[0];
  n = b_loop_ub - 1;
  md2 = b_loop_ub >> 1;
  for (b_loop_ub = 0; b_loop_ub < md2; b_loop_ub++) {
    m = n - b_loop_ub;
    for (i = 0; i < i6; i++) {
      xtmp = x->data[i + x->size[0] * b_loop_ub];
      x->data[i + x->size[0] * b_loop_ub] = x->data[i + x->size[0] * m];
      x->data[i + x->size[0] * m] = xtmp;
    }
  }

  iv2[0] = r2->size[0];
  iv2[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv2[0], 2, &(*(int32_T (*)[2])x->size)[0], 2,
    &f_emlrtECI, sp);
  loop_ub = x->size[1];
  for (i6 = 0; i6 < loop_ub; i6++) {
    b_loop_ub = x->size[0];
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      im1->data[r2->data[i7] + im1->size[0] * r3->data[i6]] = x->data[i7 +
        x->size[0] * i6];
    }
  }

  emxFree_real_T(&x);
  xtmp = (real_T)im1->size[0] - d;
  if (d + 1.0 > xtmp) {
    i6 = 0;
    i = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &w_emlrtDCI, sp);
    }

    i6 = im1->size[0];
    i7 = (int32_T)(d + 1.0);
    if ((i7 < 1) || (i7 > i6)) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, i6, &jb_emlrtBCI, sp);
    }

    i6 = i7 - 1;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &x_emlrtDCI, sp);
    }

    i7 = im1->size[0];
    i = (int32_T)xtmp;
    if ((i < 1) || (i > i7)) {
      emlrtDynamicBoundsCheckR2012b(i, 1, i7, &kb_emlrtBCI, sp);
    }
  }

  xtmp = (real_T)im1->size[1] - d;
  if (d + 1.0 > xtmp) {
    i7 = 0;
    m = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &y_emlrtDCI, sp);
    }

    i7 = im1->size[1];
    md2 = (int32_T)(d + 1.0);
    if ((md2 < 1) || (md2 > i7)) {
      emlrtDynamicBoundsCheckR2012b(md2, 1, i7, &lb_emlrtBCI, sp);
    }

    i7 = md2 - 1;
    if (xtmp != (int32_T)muDoubleScalarFloor(xtmp)) {
      emlrtIntegerCheckR2012b(xtmp, &ab_emlrtDCI, sp);
    }

    md2 = im1->size[1];
    m = (int32_T)xtmp;
    if ((m < 1) || (m > md2)) {
      emlrtDynamicBoundsCheckR2012b(m, 1, md2, &mb_emlrtBCI, sp);
    }
  }

  md2 = r2->size[0];
  loop_ub = i - i6;
  r2->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r2, md2, &y_emlrtRTEI);
  for (i = 0; i < loop_ub; i++) {
    r2->data[i] = i6 + i;
  }

  i6 = r3->size[0];
  loop_ub = m - i7;
  r3->size[0] = loop_ub;
  emxEnsureCapacity_int32_T(sp, r3, i6, &ab_emlrtRTEI);
  for (i6 = 0; i6 < loop_ub; i6++) {
    r3->data[i6] = i7 + i6;
  }

  iv2[0] = r2->size[0];
  iv2[1] = r3->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv2[0], 2, &(*(int32_T (*)[2])im->size)[0], 2,
    &g_emlrtECI, sp);
  loop_ub = im->size[1];
  for (i6 = 0; i6 < loop_ub; i6++) {
    b_loop_ub = im->size[0];
    for (i7 = 0; i7 < b_loop_ub; i7++) {
      im1->data[r2->data[i7] + im1->size[0] * r3->data[i6]] = im->data[i7 +
        im->size[0] * i6];
    }
  }

  emxFree_int32_T(&r3);
  emxFree_int32_T(&r2);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void func_calEdgeStrength(const emlrtStack *sp, const emxArray_real_T *im,
  real_T d, emxArray_real_T *E)
{
  emxArray_real_T *im1;
  int16_T sz_idx_0;
  int16_T sz_idx_1;
  emxArray_real_T *ev;
  int32_T i0;
  int32_T loop_ub_tmp;
  emxArray_real_T *r0;
  emxArray_real_T *col;
  int32_T k;
  int16_T i1;
  int32_T loop_ub;
  emxArray_real_T *eh;
  int32_T i2;
  int16_T tmp_data[1200];
  int32_T i3;
  real_T b_k;
  emxArray_real_T *r1;
  emxArray_real_T *b_col;
  emxArray_real_T *b_im1;
  int32_T nx;
  emxArray_real_T *z;
  boolean_T b;
  int32_T i4;
  real_T col1_tmp_idx_1;
  real_T col1_tmp_idx_0;
  int32_T i5;
  int32_T iv0[1];
  int32_T iv1[2];
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
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
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_real_T(sp, &im1, 2, &j_emlrtRTEI, true);
  st.site = &emlrtRSI;
  pad(&st, im, d, im1);
  sz_idx_0 = (int16_T)im->size[0];
  sz_idx_1 = (int16_T)im->size[1];
  emxInit_real_T(sp, &ev, 2, &emlrtRTEI, true);

  /*  verti */
  i0 = ev->size[0] * ev->size[1];
  ev->size[0] = sz_idx_0;
  ev->size[1] = sz_idx_1;
  emxEnsureCapacity_real_T(sp, ev, i0, &emlrtRTEI);
  loop_ub_tmp = sz_idx_0 * sz_idx_1;
  for (i0 = 0; i0 < loop_ub_tmp; i0++) {
    ev->data[i0] = 0.0;
  }

  i0 = sz_idx_1;
  emxInit_real_T(sp, &r0, 1, &k_emlrtRTEI, true);
  emxInit_real_T(sp, &col, 1, &c_emlrtRTEI, true);
  for (k = 0; k < i0; k++) {
    i1 = (int16_T)ev->size[0];
    loop_ub = i1 - 1;
    for (i2 = 0; i2 <= loop_ub; i2++) {
      tmp_data[i2] = (int16_T)i2;
    }

    i2 = ev->size[1];
    i3 = 1 + k;
    if (i3 > i2) {
      emlrtDynamicBoundsCheckR2012b(i3, 1, i2, &c_emlrtBCI, sp);
    }

    st.site = &b_emlrtRSI;
    loop_ub = im1->size[0];
    b_k = d + (1.0 + (real_T)k);
    if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
      emlrtIntegerCheckR2012b(b_k, &emlrtDCI, &st);
    }

    i2 = im1->size[1];
    nx = (int32_T)b_k;
    if ((nx < 1) || (nx > i2)) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, i2, &emlrtBCI, &st);
    }

    i2 = col->size[0];
    col->size[0] = loop_ub;
    emxEnsureCapacity_real_T(&st, col, i2, &c_emlrtRTEI);
    for (i2 = 0; i2 < loop_ub; i2++) {
      col->data[i2] = im1->data[i2 + im1->size[0] * (nx - 1)];
    }

    loop_ub = im1->size[0];
    i2 = r0->size[0];
    r0->size[0] = loop_ub;
    emxEnsureCapacity_real_T(&st, r0, i2, &d_emlrtRTEI);
    for (i2 = 0; i2 < loop_ub; i2++) {
      r0->data[i2] = 0.0;
    }

    i2 = im1->size[0];
    b_k = (real_T)i2 - d;
    i2 = (int32_T)(b_k + (1.0 - (d + 1.0)));
    emlrtForLoopVectorCheckR2012b(d + 1.0, 1.0, b_k, mxDOUBLE_CLASS, i2,
      &db_emlrtRTEI, &st);
    for (loop_ub = 0; loop_ub < i2; loop_ub++) {
      b_k = (d + 1.0) + (real_T)loop_ub;
      b_st.site = &e_emlrtRSI;
      i3 = im1->size[0];
      c_st.site = &g_emlrtRSI;
      if (i3 == 1) {
        emlrtErrorWithMessageIdR2018a(&c_st, &eb_emlrtRTEI,
          "Coder:FE:PotentialVectorVector", "Coder:FE:PotentialVectorVector", 0);
      }

      b_st.site = &e_emlrtRSI;
      i3 = im1->size[0];
      c_st.site = &g_emlrtRSI;
      if (i3 == 1) {
        emlrtErrorWithMessageIdR2018a(&c_st, &eb_emlrtRTEI,
          "Coder:FE:PotentialVectorVector", "Coder:FE:PotentialVectorVector", 0);
      }

      col1_tmp_idx_0 = -d + b_k;
      if (col1_tmp_idx_0 != (int32_T)muDoubleScalarFloor(col1_tmp_idx_0)) {
        emlrtIntegerCheckR2012b(col1_tmp_idx_0, &f_emlrtDCI, &st);
      }

      col1_tmp_idx_1 = d + b_k;
      if (col1_tmp_idx_1 != (int32_T)muDoubleScalarFloor(col1_tmp_idx_1)) {
        emlrtIntegerCheckR2012b(col1_tmp_idx_1, &f_emlrtDCI, &st);
      }

      i3 = im1->size[0];
      i4 = (int32_T)col1_tmp_idx_0;
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &i_emlrtBCI, &st);
      }

      i5 = (int32_T)col1_tmp_idx_1;
      if ((i5 < 1) || (i5 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &i_emlrtBCI, &st);
      }

      i3 = im1->size[0];
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &j_emlrtBCI, &st);
      }

      if ((i5 < 1) || (i5 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &j_emlrtBCI, &st);
      }

      i3 = im1->size[0];
      if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
        emlrtIntegerCheckR2012b(b_k, &c_emlrtDCI, &st);
      }

      i4 = (int32_T)b_k;
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &e_emlrtBCI, &st);
      }

      i3 = r0->size[0];
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &h_emlrtBCI, &st);
      }

      i3 = (int32_T)(uint32_T)col1_tmp_idx_1 - 1;
      i5 = (int32_T)(uint32_T)col1_tmp_idx_0 - 1;
      r0->data[i4 - 1] = muDoubleScalarMax(im1->data[(i4 + im1->size[0] *
        ((int32_T)(d + (1.0 + (real_T)k)) - 1)) - 1] - ((col->data[i5] +
        col->data[i3]) / 2.0 + muDoubleScalarAbs(col->data[i3] - col->data[i5])),
        0.0);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    i2 = im1->size[0];
    b_k = (real_T)i2 - d;
    if (d + 1.0 > b_k) {
      i3 = 1;
      i2 = 1;
    } else {
      if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
        emlrtIntegerCheckR2012b(d + 1.0, &d_emlrtDCI, &st);
      }

      i2 = r0->size[0];
      i3 = (int32_T)(d + 1.0);
      if ((i3 < 1) || (i3 > i2)) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, i2, &f_emlrtBCI, &st);
      }

      if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
        emlrtIntegerCheckR2012b(b_k, &e_emlrtDCI, &st);
      }

      i2 = r0->size[0];
      i4 = (int32_T)b_k;
      if ((i4 < 1) || (i4 > i2)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i2, &g_emlrtBCI, &st);
      }

      i2 = i4 + 1;
    }

    b_st.site = &f_emlrtRSI;
    b = (r0->size[0] == 1);
    if (b) {
      b = false;
      if (i2 - i3 != 1) {
        b = true;
      }

      if (b) {
        b = true;
      } else {
        b = false;
      }
    } else {
      b = false;
    }

    c_st.site = &g_emlrtRSI;
    if (b) {
      emlrtErrorWithMessageIdR2018a(&c_st, &eb_emlrtRTEI,
        "Coder:FE:PotentialVectorVector", "Coder:FE:PotentialVectorVector", 0);
    }

    i4 = col->size[0];
    col->size[0] = i2 - i3;
    emxEnsureCapacity_real_T(&st, col, i4, &i_emlrtRTEI);
    loop_ub = i2 - i3;
    for (i2 = 0; i2 < loop_ub; i2++) {
      col->data[i2] = r0->data[(i3 + i2) - 1];
    }

    i2 = r0->size[0];
    r0->size[0] = col->size[0];
    emxEnsureCapacity_real_T(&st, r0, i2, &d_emlrtRTEI);
    loop_ub = col->size[0];
    for (i2 = 0; i2 < loop_ub; i2++) {
      r0->data[i2] = col->data[i2];
    }

    iv0[0] = i1;
    emlrtSubAssignSizeCheckR2012b(&iv0[0], 1, &(*(int32_T (*)[1])r0->size)[0], 1,
      &emlrtECI, sp);
    loop_ub = r0->size[0];
    for (i2 = 0; i2 < loop_ub; i2++) {
      ev->data[tmp_data[i2] + ev->size[0] * k] = r0->data[i2];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&col);
  emxFree_real_T(&r0);
  emxInit_real_T(sp, &eh, 2, &b_emlrtRTEI, true);

  /*  horiz */
  i0 = eh->size[0] * eh->size[1];
  eh->size[0] = sz_idx_0;
  eh->size[1] = sz_idx_1;
  emxEnsureCapacity_real_T(sp, eh, i0, &b_emlrtRTEI);
  for (i0 = 0; i0 < loop_ub_tmp; i0++) {
    eh->data[i0] = 0.0;
  }

  i0 = sz_idx_0;
  emxInit_real_T(sp, &r1, 2, &k_emlrtRTEI, true);
  emxInit_real_T(sp, &b_col, 2, &e_emlrtRTEI, true);
  emxInit_real_T(sp, &b_im1, 2, &e_emlrtRTEI, true);
  for (k = 0; k < i0; k++) {
    i2 = eh->size[0];
    i3 = 1 + k;
    if (i3 > i2) {
      emlrtDynamicBoundsCheckR2012b(i3, 1, i2, &d_emlrtBCI, sp);
    }

    i1 = (int16_T)eh->size[1];
    loop_ub = i1 - 1;
    for (i2 = 0; i2 <= loop_ub; i2++) {
      tmp_data[i2] = (int16_T)i2;
    }

    st.site = &c_emlrtRSI;
    loop_ub = im1->size[1];
    b_k = d + (1.0 + (real_T)k);
    if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
      emlrtIntegerCheckR2012b(b_k, &b_emlrtDCI, &st);
    }

    i2 = im1->size[0];
    nx = (int32_T)b_k;
    if ((nx < 1) || (nx > i2)) {
      emlrtDynamicBoundsCheckR2012b(nx, 1, i2, &b_emlrtBCI, &st);
    }

    i2 = b_col->size[0] * b_col->size[1];
    b_col->size[0] = 1;
    b_col->size[1] = loop_ub;
    emxEnsureCapacity_real_T(&st, b_col, i2, &e_emlrtRTEI);
    for (i2 = 0; i2 < loop_ub; i2++) {
      b_col->data[i2] = im1->data[(nx + im1->size[0] * i2) - 1];
    }

    loop_ub = im1->size[1];
    nx = (int32_T)(d + (1.0 + (real_T)k));
    i2 = b_im1->size[0] * b_im1->size[1];
    b_im1->size[0] = 1;
    b_im1->size[1] = loop_ub;
    emxEnsureCapacity_real_T(&st, b_im1, i2, &e_emlrtRTEI);
    for (i2 = 0; i2 < loop_ub; i2++) {
      b_im1->data[i2] = im1->data[(nx + im1->size[0] * i2) - 1];
    }

    col1_tmp_idx_1 = b_im1->size[1];
    i2 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = (int32_T)col1_tmp_idx_1;
    emxEnsureCapacity_real_T(&st, r1, i2, &h_emlrtRTEI);
    loop_ub = (int32_T)col1_tmp_idx_1;
    for (i2 = 0; i2 < loop_ub; i2++) {
      r1->data[i2] = 0.0;
    }

    i2 = im1->size[1];
    b_k = (real_T)i2 - d;
    i2 = (int32_T)(b_k + (1.0 - (d + 1.0)));
    emlrtForLoopVectorCheckR2012b(d + 1.0, 1.0, b_k, mxDOUBLE_CLASS, i2,
      &db_emlrtRTEI, &st);
    for (loop_ub = 0; loop_ub < i2; loop_ub++) {
      b_k = (d + 1.0) + (real_T)loop_ub;
      col1_tmp_idx_0 = -d + b_k;
      if (col1_tmp_idx_0 != (int32_T)muDoubleScalarFloor(col1_tmp_idx_0)) {
        emlrtIntegerCheckR2012b(col1_tmp_idx_0, &f_emlrtDCI, &st);
      }

      col1_tmp_idx_1 = d + b_k;
      if (col1_tmp_idx_1 != (int32_T)muDoubleScalarFloor(col1_tmp_idx_1)) {
        emlrtIntegerCheckR2012b(col1_tmp_idx_1, &f_emlrtDCI, &st);
      }

      i3 = im1->size[1];
      i4 = (int32_T)col1_tmp_idx_0;
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &i_emlrtBCI, &st);
      }

      i5 = (int32_T)col1_tmp_idx_1;
      if ((i5 < 1) || (i5 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &i_emlrtBCI, &st);
      }

      i3 = im1->size[1];
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &j_emlrtBCI, &st);
      }

      if ((i5 < 1) || (i5 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &j_emlrtBCI, &st);
      }

      i3 = im1->size[1];
      if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
        emlrtIntegerCheckR2012b(b_k, &c_emlrtDCI, &st);
      }

      nx = (int32_T)b_k;
      if ((nx < 1) || (nx > i3)) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, i3, &e_emlrtBCI, &st);
      }

      i3 = r1->size[1];
      if ((nx < 1) || (nx > i3)) {
        emlrtDynamicBoundsCheckR2012b(nx, 1, i3, &h_emlrtBCI, &st);
      }

      i3 = i5 - 1;
      i4--;
      r1->data[nx - 1] = muDoubleScalarMax(b_col->data[nx - 1] - ((b_col->
        data[i4] + b_col->data[i3]) / 2.0 + muDoubleScalarAbs(b_col->data[i3] -
        b_col->data[i4])), 0.0);
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    i2 = im1->size[1];
    b_k = (real_T)i2 - d;
    if (d + 1.0 > b_k) {
      i2 = 0;
      i4 = 0;
    } else {
      if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
        emlrtIntegerCheckR2012b(d + 1.0, &d_emlrtDCI, &st);
      }

      i2 = r1->size[1];
      i3 = (int32_T)(d + 1.0);
      if ((i3 < 1) || (i3 > i2)) {
        emlrtDynamicBoundsCheckR2012b(i3, 1, i2, &f_emlrtBCI, &st);
      }

      i2 = i3 - 1;
      if (b_k != (int32_T)muDoubleScalarFloor(b_k)) {
        emlrtIntegerCheckR2012b(b_k, &e_emlrtDCI, &st);
      }

      i3 = r1->size[1];
      i4 = (int32_T)b_k;
      if ((i4 < 1) || (i4 > i3)) {
        emlrtDynamicBoundsCheckR2012b(i4, 1, i3, &g_emlrtBCI, &st);
      }
    }

    i3 = b_col->size[0] * b_col->size[1];
    b_col->size[0] = 1;
    loop_ub = i4 - i2;
    b_col->size[1] = loop_ub;
    emxEnsureCapacity_real_T(&st, b_col, i3, &i_emlrtRTEI);
    for (i3 = 0; i3 < loop_ub; i3++) {
      b_col->data[i3] = r1->data[i2 + i3];
    }

    i2 = r1->size[0] * r1->size[1];
    r1->size[0] = 1;
    r1->size[1] = b_col->size[1];
    emxEnsureCapacity_real_T(&st, r1, i2, &h_emlrtRTEI);
    loop_ub = b_col->size[0] * b_col->size[1];
    for (i2 = 0; i2 < loop_ub; i2++) {
      r1->data[i2] = b_col->data[i2];
    }

    iv1[0] = 1;
    iv1[1] = i1;
    emlrtSubAssignSizeCheckR2012b(&iv1[0], 2, &(*(int32_T (*)[2])r1->size)[0], 2,
      &b_emlrtECI, sp);
    loop_ub = r1->size[1];
    for (i2 = 0; i2 < loop_ub; i2++) {
      eh->data[k + eh->size[0] * tmp_data[i2]] = r1->data[i2];
    }

    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_real_T(&b_im1);
  emxFree_real_T(&b_col);
  emxFree_real_T(&r1);
  emxFree_real_T(&im1);
  emxInit_real_T(sp, &z, 2, &f_emlrtRTEI, true);
  st.site = &d_emlrtRSI;
  b_st.site = &h_emlrtRSI;
  c_st.site = &i_emlrtRSI;
  d_st.site = &j_emlrtRSI;
  e_st.site = &k_emlrtRSI;
  f_st.site = &l_emlrtRSI;
  if (ev->size[0] <= eh->size[0]) {
    sz_idx_0 = (int16_T)ev->size[0];
  } else {
    sz_idx_0 = (int16_T)eh->size[0];
  }

  if (ev->size[1] <= eh->size[1]) {
    sz_idx_1 = (int16_T)ev->size[1];
  } else {
    sz_idx_1 = (int16_T)eh->size[1];
  }

  i0 = z->size[0] * z->size[1];
  z->size[0] = sz_idx_0;
  z->size[1] = sz_idx_1;
  emxEnsureCapacity_real_T(&f_st, z, i0, &f_emlrtRTEI);
  if (!dimagree(z, ev, eh)) {
    emlrtErrorWithMessageIdR2018a(&f_st, &fb_emlrtRTEI, "MATLAB:dimagree",
      "MATLAB:dimagree", 0);
  }

  i0 = E->size[0] * E->size[1];
  E->size[0] = z->size[0];
  E->size[1] = z->size[1];
  emxEnsureCapacity_real_T(&e_st, E, i0, &g_emlrtRTEI);
  nx = sz_idx_0 * sz_idx_1;
  emxFree_real_T(&z);
  for (k = 0; k < nx; k++) {
    E->data[k] = muDoubleScalarMax(ev->data[k], eh->data[k]);
  }

  emxFree_real_T(&eh);
  emxFree_real_T(&ev);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (func_calEdgeStrength.c) */
