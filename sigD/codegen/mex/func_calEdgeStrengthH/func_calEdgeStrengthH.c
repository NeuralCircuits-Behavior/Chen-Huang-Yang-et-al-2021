/*
 * func_calEdgeStrengthH.c
 *
 * Code generation for function 'func_calEdgeStrengthH'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_calEdgeStrengthH.h"
#include "func_calEdgeStrengthH_emxutil.h"
#include "fliplr.h"
#include "flipud.h"
#include "func_calEdgeStrengthH_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 2,     /* lineNo */
  "func_calEdgeStrengthH",             /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 9,   /* lineNo */
  "func_calEdgeStrengthH",             /* fcnName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pathName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 2, /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 14,/* lineNo */
  16,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo emlrtDCI = { 9,     /* lineNo */
  20,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  9,                                   /* lineNo */
  20,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo b_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  9,                                   /* lineNo */
  4,                                   /* colNo */
  "eh",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo emlrtECI = { -1,    /* nDims */
  9,                                   /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtRTEInfo e_emlrtRTEI = { 25,/* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo b_emlrtDCI = { 28,  /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  13,                                  /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo c_emlrtDCI = { 28,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo d_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  28,                                  /* lineNo */
  17,                                  /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo d_emlrtDCI = { 26,  /* lineNo */
  36,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo e_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  36,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo e_emlrtDCI = { 26,  /* lineNo */
  60,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo f_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  60,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo g_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  23,                                  /* colNo */
  "col",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo f_emlrtDCI = { 26,  /* lineNo */
  23,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo h_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  26,                                  /* lineNo */
  10,                                  /* colNo */
  "col1",                              /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo i_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  32,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo g_emlrtDCI = { 16,  /* lineNo */
  34,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo j_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  34,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo h_emlrtDCI = { 17,  /* lineNo */
  40,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo k_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  40,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo l_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  48,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo m_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  34,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo i_emlrtDCI = { 18,  /* lineNo */
  36,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo n_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  36,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo j_emlrtDCI = { 19,  /* lineNo */
  42,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo o_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  42,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo p_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  50,                                  /* colNo */
  "im",                                /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo q_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo k_emlrtDCI = { 16,  /* lineNo */
  7,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo r_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  7,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo l_emlrtDCI = { 16,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo s_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo m_emlrtDCI = { 16,  /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo t_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  16,                                  /* lineNo */
  13,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo b_emlrtECI = { -1,  /* nDims */
  16,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo n_emlrtDCI = { 17,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo u_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo v_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  13,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo o_emlrtDCI = { 17,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo w_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  17,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo p_emlrtDCI = { 17,  /* lineNo */
  21,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo x_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  17,                                  /* lineNo */
  21,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo c_emlrtECI = { -1,  /* nDims */
  17,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo q_emlrtDCI = { 18,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo y_emlrtBCI = { -1,  /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo r_emlrtDCI = { 18,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo ab_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo bb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo s_emlrtDCI = { 18,  /* lineNo */
  17,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo cb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  18,                                  /* lineNo */
  17,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo d_emlrtECI = { -1,  /* nDims */
  18,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo t_emlrtDCI = { 19,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo db_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo u_emlrtDCI = { 19,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo eb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo v_emlrtDCI = { 19,  /* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo fb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtBCInfo gb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  19,                                  /* lineNo */
  23,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo e_emlrtECI = { -1,  /* nDims */
  19,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo w_emlrtDCI = { 20,  /* lineNo */
  5,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo hb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  5,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo x_emlrtDCI = { 20,  /* lineNo */
  9,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo ib_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  9,                                   /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo y_emlrtDCI = { 20,  /* lineNo */
  15,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo jb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  15,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtDCInfo ab_emlrtDCI = { 20, /* lineNo */
  19,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

static emlrtBCInfo kb_emlrtBCI = { -1, /* iFirst */
  -1,                                  /* iLast */
  20,                                  /* lineNo */
  19,                                  /* colNo */
  "im1",                               /* aName */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  0                                    /* checkKind */
};

static emlrtECInfo f_emlrtECI = { -1,  /* nDims */
  20,                                  /* lineNo */
  1,                                   /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m"/* pName */
};

static emlrtDCInfo bb_emlrtDCI = { 15, /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  4                                    /* checkKind */
};

static emlrtDCInfo cb_emlrtDCI = { 15, /* lineNo */
  13,                                  /* colNo */
  "func_calEdgeStrengthH",             /* fName */
  "E:\\X\\sigD\\func_calEdgeStrengthH.m",/* pName */
  1                                    /* checkKind */
};

/* Function Declarations */
static void pad(const emlrtStack *sp, const emxArray_uint16_T *im, real_T d,
                emxArray_uint16_T *im1);

/* Function Definitions */
static void pad(const emlrtStack *sp, const emxArray_uint16_T *im, real_T d,
                emxArray_uint16_T *im1)
{
  real_T d1;
  int32_T i3;
  real_T d2;
  real_T dv0[2];
  int32_T loop_ub;
  int32_T b_loop_ub;
  int32_T i4;
  int32_T i5;
  emxArray_int32_T *r1;
  emxArray_int32_T *r2;
  emxArray_uint16_T *r3;
  int32_T iv0[2];
  int32_T i6;
  int32_T i7;
  int32_T c_loop_ub;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  d1 = 2.0 * d;
  for (i3 = 0; i3 < 2; i3++) {
    d2 = (real_T)im->size[i3] + d1;
    if (!(d2 >= 0.0)) {
      emlrtNonNegativeCheckR2012b(d2, &bb_emlrtDCI, sp);
    }

    if (d2 != (int32_T)muDoubleScalarFloor(d2)) {
      emlrtIntegerCheckR2012b(d2, &cb_emlrtDCI, sp);
    }

    dv0[i3] = d2;
  }

  i3 = im1->size[0] * im1->size[1];
  im1->size[0] = (int32_T)dv0[0];
  im1->size[1] = (int32_T)dv0[1];
  emxEnsureCapacity_uint16_T(sp, im1, i3, &c_emlrtRTEI);
  loop_ub = (int32_T)dv0[0] * (int32_T)dv0[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    im1->data[i3] = 0;
  }

  if (1.0 > d) {
    loop_ub = 0;
    b_loop_ub = 0;
  } else {
    i3 = im->size[0];
    if (!(1 <= i3)) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i3, &i_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &g_emlrtDCI, sp);
    }

    i3 = im->size[0];
    loop_ub = (int32_T)d;
    if (!((loop_ub >= 1) && (loop_ub <= i3))) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i3, &j_emlrtBCI, sp);
    }

    i3 = (int32_T)dv0[0];
    if (!(1 <= i3)) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i3, &q_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &k_emlrtDCI, sp);
    }

    i3 = (int32_T)dv0[0];
    b_loop_ub = (int32_T)d;
    if (!((b_loop_ub >= 1) && (b_loop_ub <= i3))) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i3, &r_emlrtBCI, sp);
    }
  }

  d1 = (real_T)(int32_T)dv0[1] - d;
  if (d + 1.0 > d1) {
    i3 = 0;
    i4 = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &l_emlrtDCI, sp);
    }

    i3 = (int32_T)dv0[1];
    i5 = (int32_T)(d + 1.0);
    if (!((i5 >= 1) && (i5 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &s_emlrtBCI, sp);
    }

    i3 = i5 - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &m_emlrtDCI, sp);
    }

    i5 = (int32_T)dv0[1];
    i4 = (int32_T)d1;
    if (!((i4 >= 1) && (i4 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i5, &t_emlrtBCI, sp);
    }
  }

  emxInit_int32_T(sp, &r1, 1, &c_emlrtRTEI, true);
  i5 = r1->size[0];
  r1->size[0] = b_loop_ub;
  emxEnsureCapacity_int32_T(sp, r1, i5, &c_emlrtRTEI);
  for (i5 = 0; i5 < b_loop_ub; i5++) {
    r1->data[i5] = i5;
  }

  emxInit_int32_T(sp, &r2, 1, &c_emlrtRTEI, true);
  i5 = r2->size[0];
  r2->size[0] = i4 - i3;
  emxEnsureCapacity_int32_T(sp, r2, i5, &c_emlrtRTEI);
  b_loop_ub = i4 - i3;
  for (i5 = 0; i5 < b_loop_ub; i5++) {
    r2->data[i5] = i3 + i5;
  }

  emxInit_uint16_T(sp, &r3, 2, &c_emlrtRTEI, true);
  b_loop_ub = im->size[1];
  i3 = r3->size[0] * r3->size[1];
  r3->size[0] = loop_ub;
  r3->size[1] = b_loop_ub;
  emxEnsureCapacity_uint16_T(sp, r3, i3, &c_emlrtRTEI);
  for (i3 = 0; i3 < b_loop_ub; i3++) {
    for (i5 = 0; i5 < loop_ub; i5++) {
      r3->data[i5 + r3->size[0] * i3] = im->data[i5 + im->size[0] * i3];
    }
  }

  flipud(r3);
  iv0[0] = r1->size[0];
  iv0[1] = r2->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv0[0], 2, &(*(int32_T (*)[2])r3->size)[0], 2,
    &b_emlrtECI, sp);
  loop_ub = r3->size[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    b_loop_ub = r3->size[0];
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      im1->data[r1->data[i5] + im1->size[0] * r2->data[i3]] = r3->data[i5 +
        r3->size[0] * i3];
    }
  }

  d1 = ((real_T)im->size[0] - d) + 1.0;
  if (d1 > im->size[0]) {
    i3 = 0;
    i4 = 0;
  } else {
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &h_emlrtDCI, sp);
    }

    i3 = im->size[0];
    i5 = (int32_T)d1;
    if (!((i5 >= 1) && (i5 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &k_emlrtBCI, sp);
    }

    i3 = i5 - 1;
    i5 = im->size[0];
    i4 = im->size[0];
    if (!((i4 >= 1) && (i4 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i5, &l_emlrtBCI, sp);
    }
  }

  d1 = ((real_T)im1->size[0] - d) + 1.0;
  if (d1 > im1->size[0]) {
    i5 = 0;
    b_loop_ub = 0;
  } else {
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &n_emlrtDCI, sp);
    }

    i5 = im1->size[0];
    i6 = (int32_T)d1;
    if (!((i6 >= 1) && (i6 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i6, 1, i5, &u_emlrtBCI, sp);
    }

    i5 = i6 - 1;
    i6 = im1->size[0];
    b_loop_ub = im1->size[0];
    if (!((b_loop_ub >= 1) && (b_loop_ub <= i6))) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i6, &v_emlrtBCI, sp);
    }
  }

  d1 = (real_T)im1->size[1] - d;
  if (d + 1.0 > d1) {
    i6 = 0;
    i7 = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &o_emlrtDCI, sp);
    }

    i6 = im1->size[1];
    c_loop_ub = (int32_T)(d + 1.0);
    if (!((c_loop_ub >= 1) && (c_loop_ub <= i6))) {
      emlrtDynamicBoundsCheckR2012b(c_loop_ub, 1, i6, &w_emlrtBCI, sp);
    }

    i6 = c_loop_ub - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &p_emlrtDCI, sp);
    }

    c_loop_ub = im1->size[1];
    i7 = (int32_T)d1;
    if (!((i7 >= 1) && (i7 <= c_loop_ub))) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, c_loop_ub, &x_emlrtBCI, sp);
    }
  }

  c_loop_ub = r1->size[0];
  r1->size[0] = b_loop_ub - i5;
  emxEnsureCapacity_int32_T(sp, r1, c_loop_ub, &c_emlrtRTEI);
  loop_ub = b_loop_ub - i5;
  for (b_loop_ub = 0; b_loop_ub < loop_ub; b_loop_ub++) {
    r1->data[b_loop_ub] = i5 + b_loop_ub;
  }

  i5 = r2->size[0];
  r2->size[0] = i7 - i6;
  emxEnsureCapacity_int32_T(sp, r2, i5, &c_emlrtRTEI);
  loop_ub = i7 - i6;
  for (i5 = 0; i5 < loop_ub; i5++) {
    r2->data[i5] = i6 + i5;
  }

  loop_ub = im->size[1];
  i5 = r3->size[0] * r3->size[1];
  r3->size[0] = i4 - i3;
  r3->size[1] = loop_ub;
  emxEnsureCapacity_uint16_T(sp, r3, i5, &c_emlrtRTEI);
  for (i5 = 0; i5 < loop_ub; i5++) {
    b_loop_ub = i4 - i3;
    for (i6 = 0; i6 < b_loop_ub; i6++) {
      r3->data[i6 + r3->size[0] * i5] = im->data[(i3 + i6) + im->size[0] * i5];
    }
  }

  flipud(r3);
  iv0[0] = r1->size[0];
  iv0[1] = r2->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv0[0], 2, &(*(int32_T (*)[2])r3->size)[0], 2,
    &c_emlrtECI, sp);
  loop_ub = r3->size[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    b_loop_ub = r3->size[0];
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      im1->data[r1->data[i5] + im1->size[0] * r2->data[i3]] = r3->data[i5 +
        r3->size[0] * i3];
    }
  }

  if (1.0 > d) {
    loop_ub = 0;
  } else {
    i3 = im->size[1];
    if (!(1 <= i3)) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i3, &m_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &i_emlrtDCI, sp);
    }

    i3 = im->size[1];
    loop_ub = (int32_T)d;
    if (!((loop_ub >= 1) && (loop_ub <= i3))) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i3, &n_emlrtBCI, sp);
    }
  }

  d1 = (real_T)im1->size[0] - d;
  if (d + 1.0 > d1) {
    i3 = 0;
    i4 = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &q_emlrtDCI, sp);
    }

    i3 = im1->size[0];
    i5 = (int32_T)(d + 1.0);
    if (!((i5 >= 1) && (i5 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &y_emlrtBCI, sp);
    }

    i3 = i5 - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &r_emlrtDCI, sp);
    }

    i5 = im1->size[0];
    i4 = (int32_T)d1;
    if (!((i4 >= 1) && (i4 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i5, &ab_emlrtBCI, sp);
    }
  }

  if (1.0 > d) {
    b_loop_ub = 0;
  } else {
    i5 = im1->size[1];
    if (!(1 <= i5)) {
      emlrtDynamicBoundsCheckR2012b(1, 1, i5, &bb_emlrtBCI, sp);
    }

    if (d != (int32_T)muDoubleScalarFloor(d)) {
      emlrtIntegerCheckR2012b(d, &s_emlrtDCI, sp);
    }

    i5 = im1->size[1];
    b_loop_ub = (int32_T)d;
    if (!((b_loop_ub >= 1) && (b_loop_ub <= i5))) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i5, &cb_emlrtBCI, sp);
    }
  }

  i5 = r1->size[0];
  r1->size[0] = i4 - i3;
  emxEnsureCapacity_int32_T(sp, r1, i5, &c_emlrtRTEI);
  c_loop_ub = i4 - i3;
  for (i5 = 0; i5 < c_loop_ub; i5++) {
    r1->data[i5] = i3 + i5;
  }

  i3 = r2->size[0];
  r2->size[0] = b_loop_ub;
  emxEnsureCapacity_int32_T(sp, r2, i3, &c_emlrtRTEI);
  for (i3 = 0; i3 < b_loop_ub; i3++) {
    r2->data[i3] = i3;
  }

  b_loop_ub = im->size[0];
  i3 = r3->size[0] * r3->size[1];
  r3->size[0] = b_loop_ub;
  r3->size[1] = loop_ub;
  emxEnsureCapacity_uint16_T(sp, r3, i3, &c_emlrtRTEI);
  for (i3 = 0; i3 < loop_ub; i3++) {
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      r3->data[i5 + r3->size[0] * i3] = im->data[i5 + im->size[0] * i3];
    }
  }

  fliplr(r3);
  iv0[0] = r1->size[0];
  iv0[1] = r2->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv0[0], 2, &(*(int32_T (*)[2])r3->size)[0], 2,
    &d_emlrtECI, sp);
  loop_ub = r3->size[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    b_loop_ub = r3->size[0];
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      im1->data[r1->data[i5] + im1->size[0] * r2->data[i3]] = r3->data[i5 +
        r3->size[0] * i3];
    }
  }

  d1 = ((real_T)im->size[1] - d) + 1.0;
  if (d1 > im->size[1]) {
    i3 = 0;
    i4 = 0;
  } else {
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &j_emlrtDCI, sp);
    }

    i3 = im->size[1];
    i5 = (int32_T)d1;
    if (!((i5 >= 1) && (i5 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &o_emlrtBCI, sp);
    }

    i3 = i5 - 1;
    i5 = im->size[1];
    i4 = im->size[1];
    if (!((i4 >= 1) && (i4 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i5, &p_emlrtBCI, sp);
    }
  }

  d1 = (real_T)im1->size[0] - d;
  if (d + 1.0 > d1) {
    i5 = 0;
    b_loop_ub = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &t_emlrtDCI, sp);
    }

    i5 = im1->size[0];
    i6 = (int32_T)(d + 1.0);
    if (!((i6 >= 1) && (i6 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i6, 1, i5, &db_emlrtBCI, sp);
    }

    i5 = i6 - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &u_emlrtDCI, sp);
    }

    i6 = im1->size[0];
    b_loop_ub = (int32_T)d1;
    if (!((b_loop_ub >= 1) && (b_loop_ub <= i6))) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i6, &eb_emlrtBCI, sp);
    }
  }

  d1 = ((real_T)im1->size[1] - d) + 1.0;
  if (d1 > im1->size[1]) {
    i6 = 0;
    i7 = 0;
  } else {
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &v_emlrtDCI, sp);
    }

    i6 = im1->size[1];
    c_loop_ub = (int32_T)d1;
    if (!((c_loop_ub >= 1) && (c_loop_ub <= i6))) {
      emlrtDynamicBoundsCheckR2012b(c_loop_ub, 1, i6, &fb_emlrtBCI, sp);
    }

    i6 = c_loop_ub - 1;
    c_loop_ub = im1->size[1];
    i7 = im1->size[1];
    if (!((i7 >= 1) && (i7 <= c_loop_ub))) {
      emlrtDynamicBoundsCheckR2012b(i7, 1, c_loop_ub, &gb_emlrtBCI, sp);
    }
  }

  c_loop_ub = r1->size[0];
  r1->size[0] = b_loop_ub - i5;
  emxEnsureCapacity_int32_T(sp, r1, c_loop_ub, &c_emlrtRTEI);
  loop_ub = b_loop_ub - i5;
  for (b_loop_ub = 0; b_loop_ub < loop_ub; b_loop_ub++) {
    r1->data[b_loop_ub] = i5 + b_loop_ub;
  }

  i5 = r2->size[0];
  r2->size[0] = i7 - i6;
  emxEnsureCapacity_int32_T(sp, r2, i5, &c_emlrtRTEI);
  loop_ub = i7 - i6;
  for (i5 = 0; i5 < loop_ub; i5++) {
    r2->data[i5] = i6 + i5;
  }

  loop_ub = im->size[0];
  i5 = r3->size[0] * r3->size[1];
  r3->size[0] = loop_ub;
  r3->size[1] = i4 - i3;
  emxEnsureCapacity_uint16_T(sp, r3, i5, &c_emlrtRTEI);
  b_loop_ub = i4 - i3;
  for (i5 = 0; i5 < b_loop_ub; i5++) {
    for (i4 = 0; i4 < loop_ub; i4++) {
      r3->data[i4 + r3->size[0] * i5] = im->data[i4 + im->size[0] * (i3 + i5)];
    }
  }

  fliplr(r3);
  iv0[0] = r1->size[0];
  iv0[1] = r2->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv0[0], 2, &(*(int32_T (*)[2])r3->size)[0], 2,
    &e_emlrtECI, sp);
  loop_ub = r3->size[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    b_loop_ub = r3->size[0];
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      im1->data[r1->data[i5] + im1->size[0] * r2->data[i3]] = r3->data[i5 +
        r3->size[0] * i3];
    }
  }

  emxFree_uint16_T(&r3);
  d1 = (real_T)im1->size[0] - d;
  if (d + 1.0 > d1) {
    i3 = 0;
    i4 = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &w_emlrtDCI, sp);
    }

    i3 = im1->size[0];
    i5 = (int32_T)(d + 1.0);
    if (!((i5 >= 1) && (i5 <= i3))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i3, &hb_emlrtBCI, sp);
    }

    i3 = i5 - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &x_emlrtDCI, sp);
    }

    i5 = im1->size[0];
    i4 = (int32_T)d1;
    if (!((i4 >= 1) && (i4 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i4, 1, i5, &ib_emlrtBCI, sp);
    }
  }

  d1 = (real_T)im1->size[1] - d;
  if (d + 1.0 > d1) {
    i5 = 0;
    b_loop_ub = 0;
  } else {
    if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
      emlrtIntegerCheckR2012b(d + 1.0, &y_emlrtDCI, sp);
    }

    i5 = im1->size[1];
    i6 = (int32_T)(d + 1.0);
    if (!((i6 >= 1) && (i6 <= i5))) {
      emlrtDynamicBoundsCheckR2012b(i6, 1, i5, &jb_emlrtBCI, sp);
    }

    i5 = i6 - 1;
    if (d1 != (int32_T)muDoubleScalarFloor(d1)) {
      emlrtIntegerCheckR2012b(d1, &ab_emlrtDCI, sp);
    }

    i6 = im1->size[1];
    b_loop_ub = (int32_T)d1;
    if (!((b_loop_ub >= 1) && (b_loop_ub <= i6))) {
      emlrtDynamicBoundsCheckR2012b(b_loop_ub, 1, i6, &kb_emlrtBCI, sp);
    }
  }

  i6 = r1->size[0];
  r1->size[0] = i4 - i3;
  emxEnsureCapacity_int32_T(sp, r1, i6, &c_emlrtRTEI);
  loop_ub = i4 - i3;
  for (i4 = 0; i4 < loop_ub; i4++) {
    r1->data[i4] = i3 + i4;
  }

  i3 = r2->size[0];
  r2->size[0] = b_loop_ub - i5;
  emxEnsureCapacity_int32_T(sp, r2, i3, &c_emlrtRTEI);
  loop_ub = b_loop_ub - i5;
  for (i3 = 0; i3 < loop_ub; i3++) {
    r2->data[i3] = i5 + i3;
  }

  iv0[0] = r1->size[0];
  iv0[1] = r2->size[0];
  emlrtSubAssignSizeCheckR2012b(&iv0[0], 2, &(*(int32_T (*)[2])im->size)[0], 2,
    &f_emlrtECI, sp);
  loop_ub = im->size[1];
  for (i3 = 0; i3 < loop_ub; i3++) {
    b_loop_ub = im->size[0];
    for (i5 = 0; i5 < b_loop_ub; i5++) {
      im1->data[r1->data[i5] + im1->size[0] * r2->data[i3]] = im->data[i5 +
        im->size[0] * i3];
    }
  }

  emxFree_int32_T(&r2);
  emxFree_int32_T(&r1);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void func_calEdgeStrengthH(const emlrtStack *sp, const emxArray_uint16_T *im,
  real_T d, emxArray_real_T *eh)
{
  emxArray_uint16_T *im1;
  int32_T i0;
  int16_T sz[2];
  int32_T loop_ub;
  int32_T k;
  emxArray_uint16_T *r0;
  emxArray_uint16_T *col;
  emxArray_uint16_T *b_im1;
  int32_T i1;
  int16_T i2;
  int16_T tmp_data[1200];
  real_T d0;
  int32_T b_d;
  uint32_T uv0[2];
  int32_T b_k;
  real_T c_k;
  int32_T c_d[2];
  uint16_T x[2];
  uint32_T qY;
  uint16_T varargin_1;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_uint16_T(sp, &im1, 2, &b_emlrtRTEI, true);
  st.site = &emlrtRSI;
  pad(&st, im, d, im1);
  for (i0 = 0; i0 < 2; i0++) {
    sz[i0] = (int16_T)im->size[i0];
  }

  /*  horiz */
  i0 = eh->size[0] * eh->size[1];
  eh->size[0] = sz[0];
  eh->size[1] = sz[1];
  emxEnsureCapacity_real_T(sp, eh, i0, &emlrtRTEI);
  loop_ub = sz[0] * sz[1];
  for (i0 = 0; i0 < loop_ub; i0++) {
    eh->data[i0] = 0.0;
  }

  k = 0;
  emxInit_uint16_T(sp, &r0, 2, &emlrtRTEI, true);
  emxInit_uint16_T(sp, &col, 2, &emlrtRTEI, true);
  emxInit_uint16_T(sp, &b_im1, 2, &emlrtRTEI, true);
  while (k <= sz[0] - 1) {
    i0 = eh->size[0];
    i1 = 1 + k;
    if (!(i1 <= i0)) {
      emlrtDynamicBoundsCheckR2012b(i1, 1, i0, &b_emlrtBCI, sp);
    }

    i2 = (int16_T)((int16_T)eh->size[1] - 1);
    loop_ub = i2;
    for (i0 = 0; i0 <= loop_ub; i0++) {
      tmp_data[i0] = (int16_T)i0;
    }

    st.site = &b_emlrtRSI;
    loop_ub = im1->size[1];
    d0 = d + (1.0 + (real_T)k);
    if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
      emlrtIntegerCheckR2012b(d0, &emlrtDCI, &st);
    }

    i0 = im1->size[0];
    b_d = (int32_T)d0;
    if (!((b_d >= 1) && (b_d <= i0))) {
      emlrtDynamicBoundsCheckR2012b(b_d, 1, i0, &emlrtBCI, &st);
    }

    i0 = col->size[0] * col->size[1];
    col->size[0] = 1;
    col->size[1] = loop_ub;
    emxEnsureCapacity_uint16_T(&st, col, i0, &emlrtRTEI);
    for (i0 = 0; i0 < loop_ub; i0++) {
      col->data[col->size[0] * i0] = im1->data[(b_d + im1->size[0] * i0) - 1];
    }

    loop_ub = im1->size[1];
    b_d = (int32_T)(d + (1.0 + (real_T)k));
    i0 = b_im1->size[0] * b_im1->size[1];
    b_im1->size[0] = 1;
    b_im1->size[1] = loop_ub;
    emxEnsureCapacity_uint16_T(&st, b_im1, i0, &emlrtRTEI);
    for (i0 = 0; i0 < loop_ub; i0++) {
      b_im1->data[b_im1->size[0] * i0] = im1->data[(b_d + im1->size[0] * i0) - 1];
    }

    for (i0 = 0; i0 < 2; i0++) {
      uv0[i0] = (uint32_T)b_im1->size[i0];
    }

    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = (int32_T)uv0[1];
    emxEnsureCapacity_uint16_T(&st, r0, i0, &emlrtRTEI);
    loop_ub = (int32_T)uv0[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r0->data[i0] = 0;
    }

    i0 = im1->size[1];
    d0 = (real_T)i0 - d;
    i0 = (int32_T)(d0 + (1.0 - (d + 1.0)));
    emlrtForLoopVectorCheckR2012b(d + 1.0, 1.0, d0, mxDOUBLE_CLASS, i0,
      &e_emlrtRTEI, &st);
    b_k = 0;
    while (b_k <= i0 - 1) {
      c_k = (d + 1.0) + (real_T)b_k;
      i1 = im1->size[1];
      d0 = -d + c_k;
      if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
        emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, &st);
      }

      b_d = (int32_T)d0;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &e_emlrtBCI, &st);
      }

      c_d[0] = b_d - 1;
      d0 = d + c_k;
      if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
        emlrtIntegerCheckR2012b(d0, &d_emlrtDCI, &st);
      }

      b_d = (int32_T)d0;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &e_emlrtBCI, &st);
      }

      c_d[1] = b_d - 1;
      for (i1 = 0; i1 < 2; i1++) {
        x[i1] = col->data[c_d[i1]];
      }

      i1 = im1->size[1];
      d0 = -d + c_k;
      if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
        emlrtIntegerCheckR2012b(d0, &e_emlrtDCI, &st);
      }

      b_d = (int32_T)d0;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &f_emlrtBCI, &st);
      }

      d0 = d + c_k;
      if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
        emlrtIntegerCheckR2012b(d0, &e_emlrtDCI, &st);
      }

      b_d = (int32_T)d0;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &f_emlrtBCI, &st);
      }

      i1 = im1->size[1];
      if (c_k != (int32_T)muDoubleScalarFloor(c_k)) {
        emlrtIntegerCheckR2012b(c_k, &f_emlrtDCI, &st);
      }

      b_d = (int32_T)c_k;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &g_emlrtBCI, &st);
      }

      loop_ub = col->data[b_d - 1];
      b_d = col->data[(int32_T)(d + c_k) - 1];
      qY = (uint32_T)b_d - col->data[(int32_T)(-d + c_k) - 1];
      if (qY > (uint32_T)b_d) {
        qY = 0U;
      }

      i1 = (int32_T)qY;
      i1 = (int32_T)muDoubleScalarRound((real_T)(x[0] + col->data[(int32_T)(d +
        c_k) - 1]) / 2.0 + (real_T)i1);
      if (i1 < 65536) {
        varargin_1 = (uint16_T)i1;
      } else {
        varargin_1 = MAX_uint16_T;
      }

      qY = (uint32_T)loop_ub - varargin_1;
      if (qY > (uint32_T)loop_ub) {
        qY = 0U;
      }

      i1 = (int32_T)qY;
      varargin_1 = (uint16_T)i1;
      i1 = r0->size[1];
      b_d = (int32_T)c_k;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &h_emlrtBCI, &st);
      }

      if (varargin_1 > 0) {
        r0->data[b_d - 1] = varargin_1;
      } else {
        r0->data[b_d - 1] = 0;
      }

      b_k++;
      if (*emlrtBreakCheckR2012bFlagVar != 0) {
        emlrtBreakCheckR2012b(&st);
      }
    }

    i0 = im1->size[1];
    d0 = (real_T)i0 - d;
    if (d + 1.0 > d0) {
      i0 = 0;
      b_d = 0;
    } else {
      if (d + 1.0 != (int32_T)muDoubleScalarFloor(d + 1.0)) {
        emlrtIntegerCheckR2012b(d + 1.0, &b_emlrtDCI, &st);
      }

      i0 = r0->size[1];
      i1 = (int32_T)(d + 1.0);
      if (!((i1 >= 1) && (i1 <= i0))) {
        emlrtDynamicBoundsCheckR2012b(i1, 1, i0, &c_emlrtBCI, &st);
      }

      i0 = i1 - 1;
      if (d0 != (int32_T)muDoubleScalarFloor(d0)) {
        emlrtIntegerCheckR2012b(d0, &c_emlrtDCI, &st);
      }

      i1 = r0->size[1];
      b_d = (int32_T)d0;
      if (!((b_d >= 1) && (b_d <= i1))) {
        emlrtDynamicBoundsCheckR2012b(b_d, 1, i1, &d_emlrtBCI, &st);
      }
    }

    i1 = b_im1->size[0] * b_im1->size[1];
    b_im1->size[0] = 1;
    b_im1->size[1] = b_d - i0;
    emxEnsureCapacity_uint16_T(&st, b_im1, i1, &emlrtRTEI);
    loop_ub = b_d - i0;
    for (i1 = 0; i1 < loop_ub; i1++) {
      b_im1->data[b_im1->size[0] * i1] = r0->data[i0 + i1];
    }

    i0 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    r0->size[1] = b_im1->size[1];
    emxEnsureCapacity_uint16_T(&st, r0, i0, &emlrtRTEI);
    loop_ub = b_im1->size[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      r0->data[r0->size[0] * i0] = b_im1->data[b_im1->size[0] * i0];
    }

    c_d[0] = 1;
    c_d[1] = i2 + 1;
    emlrtSubAssignSizeCheckR2012b(&c_d[0], 2, &(*(int32_T (*)[2])r0->size)[0], 2,
      &emlrtECI, sp);
    loop_ub = r0->size[1];
    for (i0 = 0; i0 < loop_ub; i0++) {
      eh->data[k + eh->size[0] * tmp_data[i0]] = r0->data[r0->size[0] * i0];
    }

    k++;
    if (*emlrtBreakCheckR2012bFlagVar != 0) {
      emlrtBreakCheckR2012b(sp);
    }
  }

  emxFree_uint16_T(&b_im1);
  emxFree_uint16_T(&col);
  emxFree_uint16_T(&r0);
  emxFree_uint16_T(&im1);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

/* End of code generation (func_calEdgeStrengthH.c) */
