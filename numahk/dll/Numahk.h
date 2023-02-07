// The following ifdef block is the standard way of creating macros which make exporting
// from a DLL simpler. All files within this DLL are compiled with the NUMAHK_EXPORTS
// symbol defined on the command line. This symbol should not be defined on any project
// that uses this DLL. This way any other project whose source files include this file see
// NUMAHK_API functions as being imported from a DLL, whereas this DLL sees symbols
// defined with this macro as being exported.
#ifdef NUMAHK_EXPORTS
#define NUMAHK_API __declspec(dllexport)
#else
#define NUMAHK_API __declspec(dllimport)
#endif

#include <random>
using namespace std;

// Var
extern NUMAHK_API int nNumahk;
extern NUMAHK_API int NDArray_Length;
extern NUMAHK_API double Random_Seeds;
extern NUMAHK_API std::mt19937 Random_Generator;
extern NUMAHK_API char* i1;
extern NUMAHK_API unsigned char* u1;
extern NUMAHK_API short* i2;
extern NUMAHK_API unsigned short* u2;
extern NUMAHK_API int* i4;
extern NUMAHK_API unsigned int* u4;
extern NUMAHK_API __int64* i8;
extern NUMAHK_API unsigned __int64* u8;
extern NUMAHK_API float* f4;
extern NUMAHK_API double* f8;
extern NUMAHK_API long double* f16;
extern NUMAHK_API bool* bool_;

// // Func
// Base
extern "C" NUMAHK_API int* NDArray_Copy(int* NDArray, int length, int type, int type_length);
extern "C" NUMAHK_API int* NDArray_Change(int* NDArray, int length, int type, int new_type);
extern "C" NUMAHK_API int* NDArray_Init(__int64* arr, int length, int type);
extern "C" NUMAHK_API int* NDArray_Get(int* NDArray, __int64* point, __int64* strides, int length, int type, int ahk_flag);
extern "C" NUMAHK_API void NDArray_Set(int* NDArray, __int64* point, __int64* strides, __int64* value, int length, int type, int ahk_flag);
extern "C" NUMAHK_API void NDArray_Free(int* NDArray, int type);
// Usage
extern "C" NUMAHK_API int* NDArray_Add(int* NDArray1, int* NDArray2, int type1, int type2, int length, int new_type);
extern "C" NUMAHK_API int* NDArray_Any_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Any(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_All_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_All(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Argmax_(int* NDArray, __int64* shape, int shape_length, int type, int ahk_flag);
extern "C" NUMAHK_API int* NDArray_Argmax(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type, int ahk_flag);
extern "C" NUMAHK_API int* NDArray_Argmin_(int* NDArray, __int64* shape, int shape_length, int type, int ahk_flag);
extern "C" NUMAHK_API int* NDArray_Argmin(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type, int ahk_flag);
extern "C" NUMAHK_API int* NDArray_Argpartition(int* NDArray, __int64* shape, int shape_length, int jump_step, int kth, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Choose(int* NDArray, __int64* choices, int length, int type, int ahk_flag);
extern "C" NUMAHK_API int* NDArray_Clip(int* NDArray, double ndarray_min, double ndarray_max, int length, int type);
extern "C" NUMAHK_API int* NDArray_Compress(int* NDArray, bool* bool_arr, int arr_length, int length, int type);
extern "C" NUMAHK_API int* NDArray_Cumprod_(int* NDArray, __int64* shape, int shape_length, int jump_step, int type);
extern "C" NUMAHK_API int* NDArray_Cumprod(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Cumsum_(int* NDArray, __int64* shape, int shape_length, int jump_step, int type);
extern "C" NUMAHK_API int* NDArray_Cumsum(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Diag(int* NDArray, int arr_length, int length, int offset, int type);
extern "C" NUMAHK_API int* NDArray_Diagonal(int* NDArray, __int64* shape, __int64* strides, int shape_length, int jump_step, int axis_length, int length, int offset, int type);
extern "C" NUMAHK_API int* NDArray_Divide(int* NDArray1, int* NDArray2, int type1, int type2, int length, int new_type);
extern "C" NUMAHK_API int* NDArray_Dot(int* NDArray1, int* NDArray2, __int64* shape1, __int64* shape2, __int64* strides1, __int64* strides2, int shape_length1, int shape_length2, int jump_step1, int jump_step2, int arr_length, int type1, int type2, int new_type);
extern "C" NUMAHK_API void NDArray_Dump(int* NDArray, int length, int type, const char* filename);
extern "C" NUMAHK_API int* NDArray_Load(int length, int type, const char* filename);
extern "C" NUMAHK_API int* NDArray_Max_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Max(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Mean_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Mean(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Min_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Min(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Multiply(int* NDArray1, int* NDArray2, int type1, int type2, int length, int new_type);
extern "C" NUMAHK_API int* NDArray_Partition(int* NDArray, __int64* shape, int shape_length, int jump_step, int kth, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Prod_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Prod(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API void NDArray_Print(int* NDArray, __int64* shape, int shape_length, int jump_step, int length, int type, const char* DIMS_INTERVAL, const char* IN_DIMS_INTERVAL);
extern "C" NUMAHK_API int NDArray_Searchsorted(int* NDArray, double value, int return_type, int length, int type);
extern "C" NUMAHK_API int* NDArray_Std_(int* NDArray, __int64* shape, int shape_length, int ddof, int type);
extern "C" NUMAHK_API int* NDArray_Std(int* NDArray, __int64* shape, int shape_length, int ddof, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Subtract(int* NDArray1, int* NDArray2, int type1, int type2, int length, int new_type);
extern "C" NUMAHK_API int* NDArray_Sum_(int* NDArray, __int64* shape, int shape_length, int type);
extern "C" NUMAHK_API int* NDArray_Sum(int* NDArray, __int64* shape, int shape_length, int jump_step, int axis, int type);
extern "C" NUMAHK_API int* NDArray_Transpose(int* NDArray, __int64* shape, int shape_length, int jump_step, int type);
extern "C" NUMAHK_API int* NDArray_Var_(int* NDArray, __int64* shape, int shape_length, int ddof, int type);
extern "C" NUMAHK_API int* NDArray_Var(int* NDArray, __int64* shape, int shape_length, int ddof, int jump_step, int axis, int type);
// Global
extern "C" NUMAHK_API int* NUMAHK_BROADCAST(int* NDArray, __int64* shape, __int64* new_shape, __int64* strides, int shape_length, int type, int clean);
extern "C" NUMAHK_API void NUMAHK_FLAT(int* NDArray, __int64* arr, int arr_length, int length, int type);
extern "C" NUMAHK_API bool NUMAHK_NEWSHAPE(__int64* shape1, __int64* shape2, __int64* new_shape, int shape1_length, int shape2_length);
extern "C" NUMAHK_API int* NUMAHK_NUMS(int number, int length, int type);
extern "C" NUMAHK_API int NUMAHK_POS_MACHINE(int* now_pos, int* max_pos, int length);
extern "C" NUMAHK_API int* NUMAHK_RANGE(double start, double end, double step, int type);
extern "C" NUMAHK_API int* NUMAHK_RESHAPE(int* NDArray, int length, int jump_step, int type);
// Random
extern "C" NUMAHK_API int* Random_Choice(int* NDArray, int arr_length, int length, int type);
extern "C" NUMAHK_API double* Random_Normal(double loc, double scale, int length);
extern "C" NUMAHK_API double* Random_Rand(int length);
extern "C" NUMAHK_API int* Random_Randint(int start, int end, int length);
extern "C" NUMAHK_API double* Random_Randn(int length);
extern "C" NUMAHK_API void Random_Seed(double seed);
// Extra
extern "C" NUMAHK_API void swap(__int64* index, int* arr, int a, int b, int type);
extern "C" NUMAHK_API int partition(int* arr, __int64* index, int low, int high, int type);
extern "C" NUMAHK_API void partitionSort(int* arr, __int64* index, int low, int high, int type);
extern "C" NUMAHK_API int searchInsert(double* nums, int target, int length, int return_type);
