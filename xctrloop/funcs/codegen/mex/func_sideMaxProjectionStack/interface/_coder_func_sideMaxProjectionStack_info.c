/*
 * _coder_func_sideMaxProjectionStack_info.c
 *
 * Code generation for function '_coder_func_sideMaxProjectionStack_info'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "func_sideMaxProjectionStack.h"
#include "_coder_func_sideMaxProjectionStack_info.h"

/* Function Definitions */
mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xResult;
  mxArray *xEntryPoints;
  const char * fldNames[4] = { "Name", "NumberOfInputs", "NumberOfOutputs",
    "ConstantInputs" };

  mxArray *xInputs;
  const char * b_fldNames[4] = { "Version", "ResolvedFunctions", "EntryPoints",
    "CoverageInfo" };

  xEntryPoints = emlrtCreateStructMatrix(1, 1, 4, fldNames);
  xInputs = emlrtCreateLogicalMatrix(1, 2);
  emlrtSetField(xEntryPoints, 0, "Name", emlrtMxCreateString(
    "func_sideMaxProjectionStack"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs", emlrtMxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs", emlrtMxCreateDoubleScalar
                (1.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  xResult = emlrtCreateStructMatrix(1, 1, 4, b_fldNames);
  emlrtSetField(xResult, 0, "Version", emlrtMxCreateString(
    "9.3.0.713579 (R2017b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions", (mxArray *)
                emlrtMexFcnResolvedFunctionsInfo());
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  return xResult;
}

const mxArray *emlrtMexFcnResolvedFunctionsInfo(void)
{
  const mxArray *nameCaptureInfo;
  const char * data[25] = {
    "789ced5d4b6cdbd81565d26426b3484360fa99a268274907692733b06c4bb6a314282ccb9425593f5bb22d3b0d2c8aa224dafc891f49ceca4081b68b2eba2a66"
    "d1c52c8b769365816eb4e862d06ea745511468816e82765fa0bb521fda26ab1771ac2732a4ee03eca7a76bbe73797d79eefbf2113752d91b04417cd9f8b969fc",
    "2cfe9b18a4bbc38c2047f94dc29aecf21ba3fcbbb6b2996e13b72cd799f25f8e72461235b6ab0d0b3c27b2395da8b28a51106981bda8a626099c488b5ae94c66"
    "09855525becdd606923ac7b3254e6033d2954292330a42e28ae8a2d017f53fc79b2c735ad4054269aa97eaf2570bc415fb7c82b8ff5b0eed1341d887b4c99f51",
    "cfa9a7a172a8cb680a2f4972a8ae8b8c3af87dac7235364b770b8a74c2321a2789458d664e1784ab7a9e23f478cba19eb76c6533bd33caef5bbe7db83ecc1f8d"
    "f2c7a37c61ddd4a782c0736ab72f21f421471281ee0e725c786fd9ca97784389ce89dad2ea25decb29f152483cabfc592a53a69ec79f868cff7e43a185fb7d1f",
    "5643d9582913db08ed2e2f2ead55439a24f155a91b62053ec473d590406b3c5d0dd5688d361cc8287687ce424cb697537fb1e7667a87b8637eecfdbdfaa7988b"
    "7883342f785d447d4efdef6b083cd226a7f4484ea9470ba210a74a4cf42c1eee9e64372ef5284cc099a4078128bb553f3cc7e3f5b7faddfd755c7ef71e028fb4",
    "c919a9c62a0b06e9b28a48f30b22ad343891699e4ecbf7f684d2c34c265eef9a7866fd3f9c8067cabf909fa84d5a616ba181ad46bf3f1a65a6e5421796b3b617"
    "2a087df1f9cdf93fefed7e0efc3f233cb7f8ffacdb4945e944bdb1b2c8e429a97892d0d73a5470f8bf87b8deafcf35ca2f9cfa21aadd6df603deb37cfb707d98",
    "9bfd808fb1b5ff6f23f4204792bad149eaf716dd6affd724bdcab3fe6a37b07cbfd530b09417ed86bbdf7b04ed7fbff3ff93d65abed4e237574e379aa59dada2"
    "d6dadc6412c1e17f788ec7eb8f6aff9f23ea736aaff71178a44d6e6bff73ea86cef15a4acce902ab708c67bcffdb29f1ca483cabfc0bfb4bffe7ff1a0976b32d",
    "082eb6ff7ff2c7bf02fffb9dfff3ed563c564fb69f947622670c2588cb89233e09fc3f5ffcff0136feff26028fb4c96dfcaf32344f2b0b66ab7ffa76bf3d391d"
    "079a96fff726e099723cfcffd1d06e577cc745feffcf87df00fef73bff579bab85b2c86bb5a22450ba980c57a98df416f0ffbcf2ffcf11f539b5d787083cd226",
    "b7f13f2dcbfc59714066095d1c4c82a7c4024f33e65201533f794afdee4dd0cf94d7475a1c3769b16674104cfccfa6c4af4ec037e578e203daaca6a3b9e867ef"
    "3e5bf933c48b19e1b9152f32e96de6b05588c60eb311455d96b9e5f65a7a3338f1029eeff1f7e5cc1f1702d78ff06a1c09fa11b3c21ba679c1837e049efafdd0",
    "8ff07e1dd1636ceb88be8ec0236d721bff0b9c9857b274d7b7eb460bb63261fb3b538e87f74d73b9396f40fce5d51de807f89defd55c6eaf43755a72a6b5934a"
    "64eab98db4d00ed0ba21788ec7eb6ff5bb8fb1f13dac1b1d8f07eb46a7c51ba679c18375a378eaef21ae776ac7e788fa499b1c37ff3f30e4c76c5753584177b7",
    "1fdf4f518807d7c48378301ffcec361ec4033cf5f710d7433cb0268b1ff60eb1cd077c0b8147dae4f679655565156d9fe6b9da26e7e4fedfd4f9807d249e558e"
    "695ec962b67e4470d16f7efd8b77617cc8eff1403fcc84b7d2d9ddbdf412cb76c2e5b0925d4d04685f013ccfe3733359fd6f0df61710b0bfe0aade0efa05b0bf",
    "608678b0bf004ffd1007c6e766b2fadf13d83fec106f0ed61dc3fee119e2c1fe613cf503bf8fcfcd64f5bfa7d8f87d12df1ab73c78451c2e3cd4fbf1c8918469"
    "d28305a5b8f83d8dc4b3caa7e377e343686829f7d7039fdffa17acf3f13dbf2bad45f98453233161b5b02616aae5f0f6beba111c7eef21ae87717d6bb2f8e1fd",
    "8ad7eb3c87ebd5a906acf374e437a6b95c1dbf11d4bf41fbdeeffcbf98ebac09254e38dae6766bd4f62653acd7cf02c4fff01c8fd7dfe277e7d90bbe9711f539"
    "b5d75d5b99b0fd9d29e7547138e4acf5df0ceede380e6e9ecf23f1acf26bb5f3eb5c97adc992a172c8622fa3b1efa27ffc17f66ff99fe7b7c2a767c55683e3e3",
    "a5f8e96e6ba3513adda302b4af17787ebcfe289e47e139b5d71d5b99b8f8bba18453eb9c406b4dbff2fa4cc76f2cbc3eb49307fbb981d76788372daf7f158147"
    "dae4ed164bc96d468d963b61492aa8c5a5f0e111111c5ef7d77a8a4b5e7f50e71455ab73aefadf3f2ad8f87dd278799fb7fab957fcfeab29f112483cab1c07bf",
    "bb3c4ff3535857f3e6f2bad3f67af14ce68495d6eec11257ad4552473b85ec523b40ed75787eadc9ea6f8b81198f717bde15c663b0e30dd2bce0c1780c9efa7b"
    "88ebfd3aef8ae261a77e7813713fe6b92ce4d52f2bd5f5e18713afe7616545aaa9dc0bd6b376bebfc6f54c73c13afaa0e0b9150f4e5bc55c4c4e55f35c4aceed",
    "35db7b4f165b1accc3ced173dc4fdbd8f6517d1b8147dae4fd7067dcf6715d1a1c5b7c2cb559a5ce4b9d63a67fcef2f4fd007b42e963265ced878aad6cc733e5"
    "53adbf1cbacf6bece76a1cf8d9ef6ec37a4cbfc701759bea529b2f5e14d2dde548767931be135b5a0cd07b165e21ae776ac71f23ea276df2593fd70f5eff07c7",
    "4d969759c56d7fddf26cfcdfa3fe0927d6d86e4ad4605c11a137cc0bb88307f30278ea87f860d517afbfa660ff96433cd8bf851b6f98e6050ff66fe1a91fe281"
    "555fbceb41dd8d079c08f1c0593ce0440fe2c1db100ffc1f0f1af4e15a3e7c906bad55635a7c85ce47d8c84e80ce69e921aef7ebbc7205a12f563ffcb48a6d5e",
    "e19aefe9d455b6402b46ec8b4ba2aa11dec5017fbdefc36a3677c78bcebfb3b40af1c0eff1e0ac25c8d17234cd47f6b9e60ebb91ecb6db87011a2f82e7797c6e"
    "26d4fbd9ce11f5cdf8fc46a3c8898d84a46c1586271c7a35bf3caddf9426e099723c7e73d56caebfbfff478b10077c1f079ae1b546b4d1a134b6b8af17849546",
    "a1b0918f431c98bfe7b99f2ecff17577deb621eb0b0d56db92754aa4ab3c5bf3edfaa2a30978a6fc590acb312e86e14216c379b05ff807cd3588037e8f03f9dc"
    "8e9ade2d2f47f495523726ca72ab93cfc3fb3ce7b43ff07d6c71e09ae7795d18c0affd809d0978a61cb3bf78f03ee7f3df9c423fc0f7fcbf7a20d1a9657e7f3b",
    "92d8cbd6326ae4854c3503345fdc435cefd7f9817384be4efd10353e6eee3bbb6ff9b6b63ec82aa37cfd64987f7a826ddc08f625bc1ecf94c3be84ebe20dd3bc"
    "e0c1be043cf5f710d7fb356e5410fae25d3f54c3d67ff80a028fb4c96dfd0785e525b9fffda47dda4ef5b837410f535ed74546e324f1b8498b35fe727ff4cb29",
    "f1b313f04d391e3f1a986fc15dbf81fdcab3c4732b1ed0cdd5acb4c225334a6249523abbc503e9201ca071a44f10d73bb56304513f69933fa39e534f43e55097"
    "d1060db5509f58d4c1ef6395abb106c91b4ff8093b209ba24633b6f3bbcf117acca67ff0707d983f1ae58f47f9e57c420581e7d46e6f23f4214712b5a5b3ac8f",
    "df47b18dc4b3caa75f473ab2d468a4c8457e877d6633c4738bdfc32b9d5c34cd28f293836872b7d590e3e9432940e3446fec7b45d1cff183d1a7e3fe9b29dcf5"
    "bf5dafe70906fb7c0bbcaebac5fbb8cff575779ee0c25c5e9cfbf8e895fa39f0ff8cf0dce2ff6431592e17c3f9036d8bce9f9ea4b6b38d954e80f611403b6ebc",
    "fed6f19d8c47eb84e01c30ff9c2b01e780cd120fce01c3533ff0fd78fdad7e77793ecc39a23e98e77d3d9e597fc556b6e3997298e7bd2ede30cd0b1eccf3e2a9"
    "bf87b81ee679adc9e287eb2cb6f1fdc9e78619e4a6705dbfb6f733483cab1cc37b224696727dffc81f7e0fe3fbbee7f9b6c664154eda1356965f88a7fb996827",
    "5b4e0668fef633c4f54eed4823ea276df299f2fcb1aa576df75541e88d77dc47c7c6f7b71178e448c2a9222d12f8de07e136dfa7907856390ebe372ce5c5ba7f"
    "98cf9d219e5be744b6627a5e889c95238bbbcab21e5f62a36d21470487efe1391eafbfd5ef3ec036bef33e028fb4c9edf3b8ea86cef15a4acc0d4fcff28cf7df",
    "d8f9fff1f3b936b3c1f93241c1736ddf6fbb158fd593ed27a59dc8194309e272e2884f0687ffa1bd3ffebe9cb5f73b30ee4fc0b8ffb8fb81717f6ff160dc1f4f"
    "fd101fc6df97237f7cd9857d5eb0cfcba22ff41bbcc5837d5ed3d5ff3fb66b12dd", "" };

  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(data, 60232U, &nameCaptureInfo);
  return nameCaptureInfo;
}

/* End of code generation (_coder_func_sideMaxProjectionStack_info.c) */
