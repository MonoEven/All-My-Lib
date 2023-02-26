; Author: Mono
; Version: v1.1.0
; Time: 2023.02.26

cv2_file_path(filename)
{
    if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename))
        return format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename)
    else if fileexist(format("{}\lib\{}", A_ScriptDir, filename))
        return format("{}\lib\{}", A_ScriptDir, filename)
    else
        return false
}
IniDir := cv2_file_path("cv2\OpenCV.ini")
InstallDir := SubStr(IniDir, 1, StrLen(IniDir) - 10)
; Load Dll
DirPath := IniRead(IniDir, "WorkDir", "Dir")

Dllcall("SetDllDirectory", "Str", InstallDir DirPath)
hOpencv := DllCall("LoadLibrary", "Str", "openworld455.dll", "Ptr")
hOpencvCom := DllCall("LoadLibrary", "Str", "autoit_opencv_com455.dll", "Ptr")
hOpencvffmCom := DllCall("LoadLibrary", "Str", "openvideoio_ffmpeg455_64.dll", "Ptr")

Try
    ComObject("OpenCV.CV")

Catch
    DllCall("autoit_opencv_com455.dll\DllInstall", "Int", 1, "WStr", A_IsAdmin = 0 ? "user" : "", "cdecl")

Dllcall("SetDllDirectory", "Str", A_ScriptDir)

Class OpenCV
{    
    Static True := ComValue(0xB, -1)
    Static False := ComValue(0xB, 0)
	Static CV_PI := 3.1415926535897932384626433832795
	Static CV_2PI := 6.283185307179586476925286766559
	Static LOG2 := 0.69314718055994530941723212145818

	Static HAL_ERROR_OK := 0
	Static HAL_ERROR_NOT_IMPLEMENTED := 1
	Static HAL_ERROR_UNKNOWN := -1
	Static CN_MAX := 512
	Static CN_SHIFT := 3
	Static DEPTH_MAX := 1 << OpenCV.CN_SHIFT

	Static CV_8U := 0
	Static CV_8S := 1
	Static CV_16U := 2
	Static CV_16S := 3
	Static CV_32S := 4
	Static CV_32F := 5
	Static CV_64F := 6
	Static CV_16F := 7
	Static MAT_DEPTH_MASK := OpenCV.DEPTH_MAX - 1

	Static CV_8UC1 := OpenCV.MAKETYPE(OpenCV.CV_8U, 1)
	Static CV_8UC2 := OpenCV.MAKETYPE(OpenCV.CV_8U, 2)
	Static CV_8UC3 := OpenCV.MAKETYPE(OpenCV.CV_8U, 3)
	Static CV_8UC4 := OpenCV.MAKETYPE(OpenCV.CV_8U, 4)

	Static CV_8SC1 := OpenCV.MAKETYPE(OpenCV.CV_8S, 1)
	Static CV_8SC2 := OpenCV.MAKETYPE(OpenCV.CV_8S, 2)
	Static CV_8SC3 := OpenCV.MAKETYPE(OpenCV.CV_8S, 3)
	Static CV_8SC4 := OpenCV.MAKETYPE(OpenCV.CV_8S, 4)

	Static CV_16UC1 := OpenCV.MAKETYPE(OpenCV.CV_16U, 1)
	Static CV_16UC2 := OpenCV.MAKETYPE(OpenCV.CV_16U, 2)
	Static CV_16UC3 := OpenCV.MAKETYPE(OpenCV.CV_16U, 3)
	Static CV_16UC4 := OpenCV.MAKETYPE(OpenCV.CV_16U, 4)

	Static CV_16SC1 := OpenCV.MAKETYPE(OpenCV.CV_16S, 1)
	Static CV_16SC2 := OpenCV.MAKETYPE(OpenCV.CV_16S, 2)
	Static CV_16SC3 := OpenCV.MAKETYPE(OpenCV.CV_16S, 3)
	Static CV_16SC4 := OpenCV.MAKETYPE(OpenCV.CV_16S, 4)

	Static CV_32SC1 := OpenCV.MAKETYPE(OpenCV.CV_32S, 1)
	Static CV_32SC2 := OpenCV.MAKETYPE(OpenCV.CV_32S, 2)
	Static CV_32SC3 := OpenCV.MAKETYPE(OpenCV.CV_32S, 3)
	Static CV_32SC4 := OpenCV.MAKETYPE(OpenCV.CV_32S, 4)

	Static CV_32FC1 := OpenCV.MAKETYPE(OpenCV.CV_32F, 1)
	Static CV_32FC2 := OpenCV.MAKETYPE(OpenCV.CV_32F, 2)
	Static CV_32FC3 := OpenCV.MAKETYPE(OpenCV.CV_32F, 3)
	Static CV_32FC4 := OpenCV.MAKETYPE(OpenCV.CV_32F, 4)


	Static CV_64FC1 := OpenCV.MAKETYPE(OpenCV.CV_64F, 1)
	Static CV_64FC2 := OpenCV.MAKETYPE(OpenCV.CV_64F, 2)
	Static CV_64FC3 := OpenCV.MAKETYPE(OpenCV.CV_64F, 3)
	Static CV_64FC4 := OpenCV.MAKETYPE(OpenCV.CV_64F, 4)

	Static CV_16FC1 := OpenCV.MAKETYPE(OpenCV.CV_16F, 1)
	Static CV_16FC2 := OpenCV.MAKETYPE(OpenCV.CV_16F, 2)
	Static CV_16FC3 := OpenCV.MAKETYPE(OpenCV.CV_16F, 3)
	Static CV_16FC4 := OpenCV.MAKETYPE(OpenCV.CV_16F, 4)

	Static HAL_CMP_EQ := 0
	Static HAL_CMP_GT := 1
	Static HAL_CMP_GE := 2
	Static HAL_CMP_LT := 3
	Static HAL_CMP_LE := 4
	Static HAL_CMP_NE := 5

	Static HAL_BORDER_CONSTANT := 0
	Static HAL_BORDER_REPLICATE := 1
	Static HAL_BORDER_REFLECT := 2
	Static HAL_BORDER_WRAP := 3
	Static HAL_BORDER_REFLECT_101 := 4
	Static HAL_BORDER_TRANSPARENT := 5
	Static HAL_BORDER_ISOLATED := 16

	Static HAL_DFT_INVERSE := 1
	Static HAL_DFT_SCALE := 2
	Static HAL_DFT_ROWS := 4
	Static HAL_DFT_COMPLEX_OUTPUT := 16
	Static HAL_DFT_REAL_OUTPUT := 32
	Static HAL_DFT_TWO_STAGE := 64
	Static HAL_DFT_STAGE_COLS := 128
	Static HAL_DFT_IS_CONTINUOUS := 512
	Static HAL_DFT_IS_INPLACE := 1024
	
	Static HAL_SVD_NO_UV := 1
	Static HAL_SVD_SHORT_UV := 2
	Static HAL_SVD_MODIFY_A := 4
	Static HAL_SVD_FULL_UV := 8

	Static HAL_GEMM_1_T := 1
	Static HAL_GEMM_2_T := 2
	Static HAL_GEMM_3_T := 4

	Static MAT_CN_MASK := ((OpenCV.CN_MAX - 1) << OpenCV.CN_SHIFT)

	Static MAT_TYPE_MASK := OpenCV.DEPTH_MAX * OpenCV.CN_MAX - 1

	Static MAT_CONT_FLAG_SHIFT := 14
	Static MAT_CONT_FLAG := (1 << OpenCV.MAT_CONT_FLAG_SHIFT)

	Static SUBMAT_FLAG_SHIFT := 15
	Static SUBMAT_FLAG := (1 << OpenCV.SUBMAT_FLAG_SHIFT)

	Static MAT_DEPTH(flags)
	{
		Return flags & OpenCV.MAT_DEPTH_MASK
	}

	Static MAKETYPE(depth, cn)
	{
		Return OpenCV.MAT_DEPTH(depth) + (((cn)-1) << OpenCV.CN_SHIFT)
	}

	Static CV_8UC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_8U, Number)
	}

	Static CV_8SC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_8S, Number)
	}

	Static CV_16UC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_16U, Number)
	}

	Static CV_16SC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_16S, Number)
	}

	Static CV_32SC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_32S, Number)
	}

	Static CV_32FC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_32F, Number)
	}

	Static CV_64FC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_64F, Number)
	}

	Static CV_16FC(Number)
	{
		Return OpenCV.MAKETYPE(OpenCV.CV_16F, Number)
	}

	Static MAT_CN(flags)
	{
		Return ((((flags) & OpenCV.MAT_CN_MASK) >> OpenCV.CN_SHIFT) + 1)
	}

	Static MAT_TYPE(flags)
	{
		Return flags & OpenCV.MAT_TYPE_MASK
	}

	Static IS_MAT_CONT(flags)
	{
		Return flags & OpenCV.MAT_CONT_FLAG
	}

	Static IS_SUBMAT(flags)
	{
		Return flags & OpenCV.SUBMAT_FLAG
	}
    
	Static SORT_EVERY_ROW := 0
	Static SORT_EVERY_COLUMN := 1
	Static SORT_ASCENDING := 0
	Static SORT_DESCENDING := 16

	; CovarFlags
	Static COVAR_SCRAMBLED := 0
	Static COVAR_NORMAL := 1
	Static COVAR_USE_AVG := 2
	Static COVAR_SCALE := 4
	Static COVAR_ROWS := 8
	Static COVAR_COLS := 16
	
	; KmeansFlags
	Static KMEANS_RANDOM_CENTERS := 0
	Static KMEANS_PP_CENTERS := 2
	Static KMEANS_USE_INITIAL_LABELS := 1

	; ReduceTypes
	Static REDUCE_SUM := 0
	Static REDUCE_AVG := 1
	Static REDUCE_MAX := 2
	Static REDUCE_MIN := 3

	; RotateFlags
	Static ROTATE_90_CLOCKWISE := 0
	Static ROTATE_180 := 1
	Static ROTATE_90_COUNTERCLOCKWISE := 2

	; Flags
	Static PCA_DATA_AS_ROW := 0
	Static PCA_DATA_AS_COL := 1
	Static PCA_USE_AVG := 2

	; Flags
	Static SVD_MODIFY_A := 1
	Static SVD_NO_UV := 2
	Static SVD_FULL_UV := 4

	; anonymous
	Static RNG_UNIFORM := 0
	Static RNG_NORMAL := 1

	; FormatType
	Static FORMATTER_FMT_DEFAULT := 0
	Static FORMATTER_FMT_MATLAB := 1
	Static FORMATTER_FMT_CSV := 2
	Static FORMATTER_FMT_PYTHON := 3
	Static FORMATTER_FMT_NUMPY := 4
	Static FORMATTER_FMT_C := 5

	; Param
	Static PARAM_INT := 0
	Static PARAM_BOOLEAN := 1
	Static PARAM_REAL := 2
	Static PARAM_STRING := 3
	Static PARAM_MAT := 4
	Static PARAM_MAT_VECTOR := 5
	Static PARAM_ALGORITHM := 6
	Static PARAM_FLOAT := 7
	Static PARAM_UNSIGNED_INT := 8
	Static PARAM_UINT64 := 9
	Static PARAM_UCHAR := 11
	Static PARAM_SCALAR := 12

	; Code
	Static ERROR_StsOk := 0
	Static ERROR_StsBackTrace := -1
	Static ERROR_StsError := -2
	Static ERROR_StsInternal := -3
	Static ERROR_StsNoMem := -4
	Static ERROR_StsBadArg := -5
	Static ERROR_StsBadFunc := -6
	Static ERROR_StsNoConv := -7
	Static ERROR_StsAutoTrace := -8
	Static ERROR_HeaderIsNull := -9
	Static ERROR_BadImageSize := -10
	Static ERROR_BadOffset := -11
	Static ERROR_BadDataPtr := -12
	Static ERROR_BadStep := -13
	Static ERROR_BadModelOrChSeq := -14
	Static ERROR_BadNumChannels := -15
	Static ERROR_BadNumChannel1U := -16
	Static ERROR_BadDepth := -17
	Static ERROR_BadAlphaChannel := -18
	Static ERROR_BadOrder := -19
	Static ERROR_BadOrigin := -20
	Static ERROR_BadAlign := -21
	Static ERROR_BadCallBack := -22
	Static ERROR_BadTileSize := -23
	Static ERROR_BadCOI := -24
	Static ERROR_BadROISize := -25
	Static ERROR_MaskIsTiled := -26
	Static ERROR_StsNullPtr := -27
	Static ERROR_StsVecLengthErr := -28
	Static ERROR_StsFilterStructContentErr := -29
	Static ERROR_StsKernelStructContentErr := -30
	Static ERROR_StsFilterOffsetErr := -31
	Static ERROR_StsBadSize := -201
	Static ERROR_StsDivByZero := -202
	Static ERROR_StsInplaceNotSupported := -203
	Static ERROR_StsObjectNotFound := -204
	Static ERROR_StsUnmatchedFormats := -205
	Static ERROR_StsBadFlag := -206
	Static ERROR_StsBadPoint := -207
	Static ERROR_StsBadMask := -208
	Static ERROR_StsUnmatchedSizes := -209
	Static ERROR_StsUnsupportedFormat := -210
	Static ERROR_StsOutOfRange := -211
	Static ERROR_StsParseError := -212
	Static ERROR_StsNotImplemented := -213
	Static ERROR_StsBadMemBlock := -214
	Static ERROR_StsAssert := -215
	Static ERROR_GpuNotSupported := -216
	Static ERROR_GpuApiCallError := -217
	Static ERROR_OpenGlNotSupported := -218
	Static ERROR_OpenGlApiCallError := -219
	Static ERROR_OpenCLApiCallError := -220
	Static ERROR_OpenCLDoubleNotSupported := -221
	Static ERROR_OpenCLInitError := -222
	Static ERROR_OpenCLNoAMDBlasFft := -223

	; DecompTypes
	Static DECOMP_LU := 0
	Static DECOMP_SVD := 1
	Static DECOMP_EIG := 2
	Static DECOMP_CHOLESKY := 3
	Static DECOMP_QR := 4
	Static DECOMP_NORMAL := 16

	; NormTypes
	Static NORM_INF := 1
	Static NORM_L1 := 2
	Static NORM_L2 := 4
	Static NORM_L2SQR := 5
	Static NORM_HAMMING := 6
	Static NORM_HAMMING2 := 7
	Static NORM_TYPE_MASK := 7
	Static NORM_RELATIVE := 8
	Static NORM_MINMAX := 32

	; CmpTypes
	Static CMP_EQ := 0
	Static CMP_GT := 1
	Static CMP_GE := 2
	Static CMP_LT := 3
	Static CMP_LE := 4
	Static CMP_NE := 5

	; GemmFlags
	Static GEMM_1_T := 1
	Static GEMM_2_T := 2
	Static GEMM_3_T := 4

	; DftFlags
	Static DFT_INVERSE := 1
	Static DFT_SCALE := 2
	Static DFT_ROWS := 4
	Static DFT_COMPLEX_OUTPUT := 16
	Static DFT_REAL_OUTPUT := 32
	Static DFT_COMPLEX_INPUT := 64
	Static DCT_INVERSE := OpenCV.DFT_INVERSE
	Static DCT_ROWS := OpenCV.DFT_ROWS

	; BorderTypes
	Static BORDER_CONSTANT := 0
	Static BORDER_REPLICATE := 1
	Static BORDER_REFLECT := 2
	Static BORDER_WRAP := 3
	Static BORDER_REFLECT_101 := 4
	Static BORDER_TRANSPARENT := 5
	Static BORDER_REFLECT101 := OpenCV.BORDER_REFLECT_101
	Static BORDER_DEFAULT := OpenCV.BORDER_REFLECT_101
	Static BORDER_ISOLATED := 16

	; TestOp
	Static DETAIL_TEST_CUSTOM := 0
	Static DETAIL_TEST_EQ := 1
	Static DETAIL_TEST_NE := 2
	Static DETAIL_TEST_LE := 3
	Static DETAIL_TEST_LT := 4
	Static DETAIL_TEST_GE := 5
	Static DETAIL_TEST_GT := 6

	; AllocType
	Static CUDA_HOST_MEM_PAGE_LOCKED := 1
	Static CUDA_HOST_MEM_SHARED := 2
	Static CUDA_HOST_MEM_WRITE_COMBINED := 4

	; CreateFlags
	Static CUDA_EVENT_DEFAULT := 0x00
	Static CUDA_EVENT_BLOCKING_SYNC := 0x01
	Static CUDA_EVENT_DISABLE_TIMING := 0x02
	Static CUDA_EVENT_INTERPROCESS := 0x04

	; FeatureSet
	Static CUDA_FEATURE_SET_COMPUTE_10 := 10
	Static CUDA_FEATURE_SET_COMPUTE_11 := 11
	Static CUDA_FEATURE_SET_COMPUTE_12 := 12
	Static CUDA_FEATURE_SET_COMPUTE_13 := 13
	Static CUDA_FEATURE_SET_COMPUTE_20 := 20
	Static CUDA_FEATURE_SET_COMPUTE_21 := 21
	Static CUDA_FEATURE_SET_COMPUTE_30 := 30
	Static CUDA_FEATURE_SET_COMPUTE_32 := 32
	Static CUDA_FEATURE_SET_COMPUTE_35 := 35
	Static CUDA_FEATURE_SET_COMPUTE_50 := 50
	Static CUDA_GLOBAL_ATOMICS := OpenCV.CUDA_FEATURE_SET_COMPUTE_11
	Static CUDA_SHARED_ATOMICS := OpenCV.CUDA_FEATURE_SET_COMPUTE_12
	Static CUDA_NATIVE_DOUBLE := OpenCV.CUDA_FEATURE_SET_COMPUTE_13
	Static CUDA_WARP_SHUFFLE_FUNCTIONS := OpenCV.CUDA_FEATURE_SET_COMPUTE_30
	Static CUDA_DYNAMIC_PARALLELISM := OpenCV.CUDA_FEATURE_SET_COMPUTE_35

	; ComputeMode
	Static CUDA_DEVICE_INFO_ComputeModeDefault := 0
	Static CUDA_DEVICE_INFO_ComputeModeExclusive := 1
	Static CUDA_DEVICE_INFO_ComputeModeProhibited := 2
	Static CUDA_DEVICE_INFO_ComputeModeExclusiveProcess := 3

	; AccessFlag
	Static ACCESS_READ := BitShift(1, -24)
	Static ACCESS_WRITE := BitShift(1, -25)
	Static ACCESS_RW := BitShift(3, -24)
	Static ACCESS_MASK := OpenCV.ACCESS_RW
	Static ACCESS_FAST := BitShift(1, -26)

	; KindFlag
	Static _INPUT_ARRAY_KIND_SHIFT := 16
	Static _INPUT_ARRAY_FIXED_TYPE := BitShift(0x8000, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_FIXED_SIZE := BitShift(0x4000, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_KIND_MASK := BitShift(31, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_NONE := BitShift(0, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_MAT := BitShift(1, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_MATX := BitShift(2, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_VECTOR := BitShift(3, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_VECTOR_VECTOR := BitShift(4, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_VECTOR_MAT := BitShift(5, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_EXPR := BitShift(6, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_OPENGL_BUFFER := BitShift(7, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_CUDA_HOST_MEM := BitShift(8, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_CUDA_GPU_MAT := BitShift(9, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_UMAT := BitShift(10, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_VECTOR_UMAT := BitShift(11, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_BOOL_VECTOR := BitShift(12, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_VECTOR_CUDA_GPU_MAT := BitShift(13, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_ARRAY := BitShift(14, -OpenCV._INPUT_ARRAY_KIND_SHIFT)
	Static _INPUT_ARRAY_STD_ARRAY_MAT := BitShift(15, -OpenCV._INPUT_ARRAY_KIND_SHIFT)

	; DepthMask
	Static _OUTPUT_ARRAY_DEPTH_MASK_8U := BitShift(1, -OpenCV.CV_8U)
	Static _OUTPUT_ARRAY_DEPTH_MASK_8S := BitShift(1, -OpenCV.CV_8S)
	Static _OUTPUT_ARRAY_DEPTH_MASK_16U := BitShift(1, -OpenCV.CV_16U)
	Static _OUTPUT_ARRAY_DEPTH_MASK_16S := BitShift(1, -OpenCV.CV_16S)
	Static _OUTPUT_ARRAY_DEPTH_MASK_32S := BitShift(1, -OpenCV.CV_32S)
	Static _OUTPUT_ARRAY_DEPTH_MASK_32F := BitShift(1, -OpenCV.CV_32F)
	Static _OUTPUT_ARRAY_DEPTH_MASK_64F := BitShift(1, -OpenCV.CV_64F)
	Static _OUTPUT_ARRAY_DEPTH_MASK_16F := BitShift(1, -OpenCV.CV_16F)
	Static _OUTPUT_ARRAY_DEPTH_MASK_ALL := (BitShift(OpenCV._OUTPUT_ARRAY_DEPTH_MASK_64F, -1)) - 1
	Static _OUTPUT_ARRAY_DEPTH_MASK_ALL_BUT_8S := BitAND(OpenCV._OUTPUT_ARRAY_DEPTH_MASK_ALL, BitNOT(OpenCV._OUTPUT_ARRAY_DEPTH_MASK_8S))
	Static _OUTPUT_ARRAY_DEPTH_MASK_ALL_16F := (BitShift(OpenCV._OUTPUT_ARRAY_DEPTH_MASK_16F, -1)) - 1
	Static _OUTPUT_ARRAY_DEPTH_MASK_FLT := OpenCV._OUTPUT_ARRAY_DEPTH_MASK_32F + OpenCV._OUTPUT_ARRAY_DEPTH_MASK_64F

	; UMatUsageFlags
	Static USAGE_DEFAULT := 0
	Static USAGE_ALLOCATE_HOST_MEMORY := BitShift(1, -0)
	Static USAGE_ALLOCATE_DEVICE_MEMORY := BitShift(1, -1)
	Static USAGE_ALLOCATE_SHARED_MEMORY := BitShift(1, -2)
	Static __UMAT_USAGE_FLAGS_32BIT := 0x7fffffff

	; MemoryFlag
	Static UMAT_DATA_COPY_ON_MAP := 1
	Static UMAT_DATA_HOST_COPY_OBSOLETE := 2
	Static UMAT_DATA_DEVICE_COPY_OBSOLETE := 4
	Static UMAT_DATA_TEMP_UMAT := 8
	Static UMAT_DATA_TEMP_COPIED_UMAT := 24
	Static UMAT_DATA_USER_ALLOCATED := 32
	Static UMAT_DATA_DEVICE_MEM_MAPPED := 64
	Static UMAT_DATA_ASYNC_CLEANUP := 128

	; anonymous
	Static MAT_MAGIC_VAL := 0x42FF0000
	Static MAT_AUTO_STEP := 0
	Static MAT_CONTINUOUS_FLAG := OpenCV.MAT_CONT_FLAG
	Static MAT_SUBMATRIX_FLAG := OpenCV.SUBMAT_FLAG
	Static MAT_MAGIC_MASK := 0xFFFF0000



	; anonymous
	Static UMAT_MAGIC_VAL := 0x42FF0000
	Static UMAT_AUTO_STEP := 0
	Static UMAT_CONTINUOUS_FLAG := OpenCV.MAT_CONT_FLAG
	Static UMAT_SUBMATRIX_FLAG := OpenCV.SUBMAT_FLAG
	Static UMAT_MAGIC_MASK := 0xFFFF0000
	Static UMAT_TYPE_MASK := 0x00000FFF
	Static UMAT_DEPTH_MASK := 7

	; anonymous
	Static SPARSE_MAT_MAGIC_VAL := 0x42FD0000
	Static SPARSE_MAT_MAX_DIM := 32
	Static SPARSE_MAT_HASH_SCALE := 0x5bd1e995
	Static SPARSE_MAT_HASH_BIT := 0x80000000

	; anonymous
	Static OCL_DEVICE_TYPE_DEFAULT := (BitShift(1, -0))
	Static OCL_DEVICE_TYPE_CPU := (BitShift(1, -1))
	Static OCL_DEVICE_TYPE_GPU := (BitShift(1, -2))
	Static OCL_DEVICE_TYPE_ACCELERATOR := (BitShift(1, -3))
	Static OCL_DEVICE_TYPE_DGPU := OpenCV.OCL_DEVICE_TYPE_GPU + (BitShift(1, -16))
	Static OCL_DEVICE_TYPE_IGPU := OpenCV.OCL_DEVICE_TYPE_GPU + (BitShift(1, -17))
	Static OCL_DEVICE_TYPE_ALL := 0xFFFFFFFF
	Static OCL_DEVICE_FP_DENORM := (BitShift(1, -0))
	Static OCL_DEVICE_FP_INF_NAN := (BitShift(1, -1))
	Static OCL_DEVICE_FP_ROUND_TO_NEAREST := (BitShift(1, -2))
	Static OCL_DEVICE_FP_ROUND_TO_ZERO := (BitShift(1, -3))
	Static OCL_DEVICE_FP_ROUND_TO_INF := (BitShift(1, -4))
	Static OCL_DEVICE_FP_FMA := (BitShift(1, -5))
	Static OCL_DEVICE_FP_SOFT_FLOAT := (BitShift(1, -6))
	Static OCL_DEVICE_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT := (BitShift(1, -7))
	Static OCL_DEVICE_EXEC_KERNEL := (BitShift(1, -0))
	Static OCL_DEVICE_EXEC_NATIVE_KERNEL := (BitShift(1, -1))
	Static OCL_DEVICE_NO_CACHE := 0
	Static OCL_DEVICE_READ_ONLY_CACHE := 1
	Static OCL_DEVICE_READ_WRITE_CACHE := 2
	Static OCL_DEVICE_NO_LOCAL_MEM := 0
	Static OCL_DEVICE_LOCAL_IS_LOCAL := 1
	Static OCL_DEVICE_LOCAL_IS_GLOBAL := 2
	Static OCL_DEVICE_UNKNOWN_VENDOR := 0
	Static OCL_DEVICE_VENDOR_AMD := 1
	Static OCL_DEVICE_VENDOR_INTEL := 2
	Static OCL_DEVICE_VENDOR_NVIDIA := 3

	; anonymous
	Static OCL_KERNEL_ARG_LOCAL := 1
	Static OCL_KERNEL_ARG_READ_ONLY := 2
	Static OCL_KERNEL_ARG_WRITE_ONLY := 4
	Static OCL_KERNEL_ARG_READ_WRITE := 6
	Static OCL_KERNEL_ARG_CONSTANT := 8
	Static OCL_KERNEL_ARG_PTR_ONLY := 16
	Static OCL_KERNEL_ARG_NO_SIZE := 256

	; OclVectorStrategy
	Static OCL_OCL_VECTOR_OWN := 0
	Static OCL_OCL_VECTOR_MAX := 1
	Static OCL_OCL_VECTOR_DEFAULT := OpenCV.OCL_OCL_VECTOR_OWN

	; Target
	Static OGL_BUFFER_ARRAY_BUFFER := 0x8892
	Static OGL_BUFFER_ELEMENT_ARRAY_BUFFER := 0x8893
	Static OGL_BUFFER_PIXEL_PACK_BUFFER := 0x88EB
	Static OGL_BUFFER_PIXEL_UNPACK_BUFFER := 0x88EC

	; Access
	Static OGL_BUFFER_READ_ONLY := 0x88B8
	Static OGL_BUFFER_WRITE_ONLY := 0x88B9
	Static OGL_BUFFER_READ_WRITE := 0x88BA

	; Format
	Static OGL_TEXTURE2D_NONE := 0
	Static OGL_TEXTURE2D_DEPTH_COMPONENT := 0x1902
	Static OGL_TEXTURE2D_RGB := 0x1907
	Static OGL_TEXTURE2D_RGBA := 0x1908

	; RenderModes
	Static OGL_POINTS := 0x0000
	Static OGL_LINES := 0x0001
	Static OGL_LINE_LOOP := 0x0002
	Static OGL_LINE_STRIP := 0x0003
	Static OGL_TRIANGLES := 0x0004
	Static OGL_TRIANGLE_STRIP := 0x0005
	Static OGL_TRIANGLE_FAN := 0x0006
	Static OGL_QUADS := 0x0007
	Static OGL_QUAD_STRIP := 0x0008
	Static OGL_POLYGON := 0x0009

	; SolveLPResult
	Static SOLVELP_UNBOUNDED := -2
	Static SOLVELP_UNFEASIBLE := -1
	Static SOLVELP_SINGLE := 0
	Static SOLVELP_MULTI := 1

	; Mode
	Static FILE_STORAGE_READ := 0
	Static FILE_STORAGE_WRITE := 1
	Static FILE_STORAGE_APPEND := 2
	Static FILE_STORAGE_MEMORY := 4
	Static FILE_STORAGE_FORMAT_MASK := (BitShift(7, -3))
	Static FILE_STORAGE_FORMAT_AUTO := 0
	Static FILE_STORAGE_FORMAT_XML := (BitShift(1, -3))
	Static FILE_STORAGE_FORMAT_YAML := (BitShift(2, -3))
	Static FILE_STORAGE_FORMAT_JSON := (BitShift(3, -3))
	Static FILE_STORAGE_BASE64 := 64
	Static FILE_STORAGE_WRITE_BASE64 := BitOR(OpenCV.FILE_STORAGE_BASE64, OpenCV.FILE_STORAGE_WRITE)

	; State
	Static FILE_STORAGE_UNDEFINED := 0
	Static FILE_STORAGE_VALUE_EXPECTED := 1
	Static FILE_STORAGE_NAME_EXPECTED := 2
	Static FILE_STORAGE_INSIDE_MAP := 4

	; anonymous
	Static FILE_NODE_NONE := 0
	Static FILE_NODE_INT := 1
	Static FILE_NODE_REAL := 2
	Static FILE_NODE_FLOAT := OpenCV.FILE_NODE_REAL
	Static FILE_NODE_STR := 3
	Static FILE_NODE_STRING := OpenCV.FILE_NODE_STR
	Static FILE_NODE_SEQ := 4
	Static FILE_NODE_MAP := 5
	Static FILE_NODE_TYPE_MASK := 7
	Static FILE_NODE_FLOW := 8
	Static FILE_NODE_UNIFORM := 8
	Static FILE_NODE_EMPTY := 16
	Static FILE_NODE_NAMED := 32

	; QuatAssumeType
	Static QUAT_ASSUME_NOT_UNIT := 0
	Static QUAT_ASSUME_UNIT := 1

	; EulerAnglesType
	Static QUAT_ENUM_INT_XYZ := 0
	Static QUAT_ENUM_INT_XZY := 1
	Static QUAT_ENUM_INT_YXZ := 2
	Static QUAT_ENUM_INT_YZX := 3
	Static QUAT_ENUM_INT_ZXY := 4
	Static QUAT_ENUM_INT_ZYX := 5
	Static QUAT_ENUM_INT_XYX := 6
	Static QUAT_ENUM_INT_XZX := 7
	Static QUAT_ENUM_INT_YXY := 8
	Static QUAT_ENUM_INT_YZY := 9
	Static QUAT_ENUM_INT_ZXZ := 10
	Static QUAT_ENUM_INT_ZYZ := 11
	Static QUAT_ENUM_EXT_XYZ := 12
	Static QUAT_ENUM_EXT_XZY := 13
	Static QUAT_ENUM_EXT_YXZ := 14
	Static QUAT_ENUM_EXT_YZX := 15
	Static QUAT_ENUM_EXT_ZXY := 16
	Static QUAT_ENUM_EXT_ZYX := 17
	Static QUAT_ENUM_EXT_XYX := 18
	Static QUAT_ENUM_EXT_XZX := 19
	Static QUAT_ENUM_EXT_YXY := 20
	Static QUAT_ENUM_EXT_YZY := 21
	Static QUAT_ENUM_EXT_ZXZ := 22
	Static QUAT_ENUM_EXT_ZYZ := 23
	Static QUAT_ENUM_EULER_ANGLES_MAX_VALUE := 24

	; Type
	Static TERM_CRITERIA_COUNT := 1
	Static TERM_CRITERIA_MAX_ITER := OpenCV.TERM_CRITERIA_COUNT
	Static TERM_CRITERIA_EPS := 2

	; FlannIndexType
	Static FLANN_FLANN_INDEX_TYPE_8U := OpenCV.CV_8U
	Static FLANN_FLANN_INDEX_TYPE_8S := OpenCV.CV_8S
	Static FLANN_FLANN_INDEX_TYPE_16U := OpenCV.CV_16U
	Static FLANN_FLANN_INDEX_TYPE_16S := OpenCV.CV_16S
	Static FLANN_FLANN_INDEX_TYPE_32S := OpenCV.CV_32S
	Static FLANN_FLANN_INDEX_TYPE_32F := OpenCV.CV_32F
	Static FLANN_FLANN_INDEX_TYPE_64F := OpenCV.CV_64F
	Static FLANN_FLANN_INDEX_TYPE_STRING := OpenCV.CV_64F + 1
	Static FLANN_FLANN_INDEX_TYPE_BOOL := OpenCV.CV_64F + 2
	Static FLANN_FLANN_INDEX_TYPE_ALGORITHM := OpenCV.CV_64F + 3
	Static FLANN_LAST_VALUE_FLANN_INDEX_TYPE := OpenCV.FLANN_FLANN_INDEX_TYPE_ALGORITHM

	; SpecialFilter
	Static FILTER_SCHARR := -1

	; MorphTypes
	Static MORPH_ERODE := 0
	Static MORPH_DILATE := 1
	Static MORPH_OPEN := 2
	Static MORPH_CLOSE := 3
	Static MORPH_GRADIENT := 4
	Static MORPH_TOPHAT := 5
	Static MORPH_BLACKHAT := 6
	Static MORPH_HITMISS := 7

	; MorphShapes
	Static MORPH_RECT := 0
	Static MORPH_CROSS := 1
	Static MORPH_ELLIPSE := 2

	; InterpolationFlags
	Static INTER_NEAREST := 0
	Static INTER_LINEAR := 1
	Static INTER_CUBIC := 2
	Static INTER_AREA := 3
	Static INTER_LANCZOS4 := 4
	Static INTER_LINEAR_EXACT := 5
	Static INTER_NEAREST_EXACT := 6
	Static INTER_MAX := 7
	Static WARP_FILL_OUTLIERS := 8
	Static WARP_INVERSE_MAP := 16

	; WarpPolarMode
	Static WARP_POLAR_LINEAR := 0
	Static WARP_POLAR_LOG := 256

	; InterpolationMasks
	Static INTER_BITS := 5
	Static INTER_BITS2 := OpenCV.INTER_BITS * 2
	Static INTER_TAB_SIZE := BitShift(1, -OpenCV.INTER_BITS)
	Static INTER_TAB_SIZE2 := OpenCV.INTER_TAB_SIZE * OpenCV.INTER_TAB_SIZE

	; DistanceTypes
	Static DIST_USER := -1
	Static DIST_L1 := 1
	Static DIST_L2 := 2
	Static DIST_C := 3
	Static DIST_L12 := 4
	Static DIST_FAIR := 5
	Static DIST_WELSCH := 6
	Static DIST_HUBER := 7

	; DistanceTransformMasks
	Static DIST_MASK_3 := 3
	Static DIST_MASK_5 := 5
	Static DIST_MASK_PRECISE := 0

	; ThresholdTypes
	Static THRESH_BINARY := 0
	Static THRESH_BINARY_INV := 1
	Static THRESH_TRUNC := 2
	Static THRESH_TOZERO := 3
	Static THRESH_TOZERO_INV := 4
	Static THRESH_MASK := 7
	Static THRESH_OTSU := 8
	Static THRESH_TRIANGLE := 16

	; AdaptiveThresholdTypes
	Static ADAPTIVE_THRESH_MEAN_C := 0
	Static ADAPTIVE_THRESH_GAUSSIAN_C := 1

	; GrabCutClasses
	Static GC_BGD := 0
	Static GC_FGD := 1
	Static GC_PR_BGD := 2
	Static GC_PR_FGD := 3

	; GrabCutModes
	Static GC_INIT_WITH_RECT := 0
	Static GC_INIT_WITH_MASK := 1
	Static GC_EVAL := 2
	Static GC_EVAL_FREEZE_MODEL := 3

	; DistanceTransformLabelTypes
	Static DIST_LABEL_CCOMP := 0
	Static DIST_LABEL_PIXEL := 1

	; FloodFillFlags
	Static FLOODFILL_FIXED_RANGE := BitShift(1, -16)
	Static FLOODFILL_MASK_ONLY := BitShift(1, -17)

	; ConnectedComponentsTypes
	Static CC_STAT_LEFT := 0
	Static CC_STAT_TOP := 1
	Static CC_STAT_WIDTH := 2
	Static CC_STAT_HEIGHT := 3
	Static CC_STAT_AREA := 4
	Static CC_STAT_MAX := 5

	; ConnectedComponentsAlgorithmsTypes
	Static CCL_DEFAULT := -1
	Static CCL_WU := 0
	Static CCL_GRANA := 1
	Static CCL_BOLELLI := 2
	Static CCL_SAUF := 3
	Static CCL_BBDT := 4
	Static CCL_SPAGHETTI := 5

	; RetrievalModes
	Static RETR_EXTERNAL := 0
	Static RETR_LIST := 1
	Static RETR_CCOMP := 2
	Static RETR_TREE := 3
	Static RETR_FLOODFILL := 4

	; ContourApproximationModes
	Static CHAIN_APPROX_NONE := 1
	Static CHAIN_APPROX_SIMPLE := 2
	Static CHAIN_APPROX_TC89_L1 := 3
	Static CHAIN_APPROX_TC89_KCOS := 4

	; ShapeMatchModes
	Static CONTOURS_MATCH_I1 := 1
	Static CONTOURS_MATCH_I2 := 2
	Static CONTOURS_MATCH_I3 := 3

	; HoughModes
	Static HOUGH_STANDARD := 0
	Static HOUGH_PROBABILISTIC := 1
	Static HOUGH_MULTI_SCALE := 2
	Static HOUGH_GRADIENT := 3
	Static HOUGH_GRADIENT_ALT := 4

	; LineSegmentDetectorModes
	Static LSD_REFINE_NONE := 0
	Static LSD_REFINE_STD := 1
	Static LSD_REFINE_ADV := 2

	; HistCompMethods
	Static HISTCMP_CORREL := 0
	Static HISTCMP_CHISQR := 1
	Static HISTCMP_INTERSECT := 2
	Static HISTCMP_BHATTACHARYYA := 3
	Static HISTCMP_HELLINGER := OpenCV.HISTCMP_BHATTACHARYYA
	Static HISTCMP_CHISQR_ALT := 4
	Static HISTCMP_KL_DIV := 5

	; ColorConversionCodes
	Static COLOR_BGR2BGRA := 0
	Static COLOR_RGB2RGBA := OpenCV.COLOR_BGR2BGRA
	Static COLOR_BGRA2BGR := 1
	Static COLOR_RGBA2RGB := OpenCV.COLOR_BGRA2BGR
	Static COLOR_BGR2RGBA := 2
	Static COLOR_RGB2BGRA := OpenCV.COLOR_BGR2RGBA
	Static COLOR_RGBA2BGR := 3
	Static COLOR_BGRA2RGB := OpenCV.COLOR_RGBA2BGR
	Static COLOR_BGR2RGB := 4
	Static COLOR_RGB2BGR := OpenCV.COLOR_BGR2RGB
	Static COLOR_BGRA2RGBA := 5
	Static COLOR_RGBA2BGRA := OpenCV.COLOR_BGRA2RGBA
	Static COLOR_BGR2GRAY := 6
	Static COLOR_RGB2GRAY := 7
	Static COLOR_GRAY2BGR := 8
	Static COLOR_GRAY2RGB := OpenCV.COLOR_GRAY2BGR
	Static COLOR_GRAY2BGRA := 9
	Static COLOR_GRAY2RGBA := OpenCV.COLOR_GRAY2BGRA
	Static COLOR_BGRA2GRAY := 10
	Static COLOR_RGBA2GRAY := 11
	Static COLOR_BGR2BGR565 := 12
	Static COLOR_RGB2BGR565 := 13
	Static COLOR_BGR5652BGR := 14
	Static COLOR_BGR5652RGB := 15
	Static COLOR_BGRA2BGR565 := 16
	Static COLOR_RGBA2BGR565 := 17
	Static COLOR_BGR5652BGRA := 18
	Static COLOR_BGR5652RGBA := 19
	Static COLOR_GRAY2BGR565 := 20
	Static COLOR_BGR5652GRAY := 21
	Static COLOR_BGR2BGR555 := 22
	Static COLOR_RGB2BGR555 := 23
	Static COLOR_BGR5552BGR := 24
	Static COLOR_BGR5552RGB := 25
	Static COLOR_BGRA2BGR555 := 26
	Static COLOR_RGBA2BGR555 := 27
	Static COLOR_BGR5552BGRA := 28
	Static COLOR_BGR5552RGBA := 29
	Static COLOR_GRAY2BGR555 := 30
	Static COLOR_BGR5552GRAY := 31
	Static COLOR_BGR2XYZ := 32
	Static COLOR_RGB2XYZ := 33
	Static COLOR_XYZ2BGR := 34
	Static COLOR_XYZ2RGB := 35
	Static COLOR_BGR2YCrCb := 36
	Static COLOR_RGB2YCrCb := 37
	Static COLOR_YCrCb2BGR := 38
	Static COLOR_YCrCb2RGB := 39
	Static COLOR_BGR2HSV := 40
	Static COLOR_RGB2HSV := 41
	Static COLOR_BGR2Lab := 44
	Static COLOR_RGB2Lab := 45
	Static COLOR_BGR2Luv := 50
	Static COLOR_RGB2Luv := 51
	Static COLOR_BGR2HLS := 52
	Static COLOR_RGB2HLS := 53
	Static COLOR_HSV2BGR := 54
	Static COLOR_HSV2RGB := 55
	Static COLOR_Lab2BGR := 56
	Static COLOR_Lab2RGB := 57
	Static COLOR_Luv2BGR := 58
	Static COLOR_Luv2RGB := 59
	Static COLOR_HLS2BGR := 60
	Static COLOR_HLS2RGB := 61
	Static COLOR_BGR2HSV_FULL := 66
	Static COLOR_RGB2HSV_FULL := 67
	Static COLOR_BGR2HLS_FULL := 68
	Static COLOR_RGB2HLS_FULL := 69
	Static COLOR_HSV2BGR_FULL := 70
	Static COLOR_HSV2RGB_FULL := 71
	Static COLOR_HLS2BGR_FULL := 72
	Static COLOR_HLS2RGB_FULL := 73
	Static COLOR_LBGR2Lab := 74
	Static COLOR_LRGB2Lab := 75
	Static COLOR_LBGR2Luv := 76
	Static COLOR_LRGB2Luv := 77
	Static COLOR_Lab2LBGR := 78
	Static COLOR_Lab2LRGB := 79
	Static COLOR_Luv2LBGR := 80
	Static COLOR_Luv2LRGB := 81
	Static COLOR_BGR2YUV := 82
	Static COLOR_RGB2YUV := 83
	Static COLOR_YUV2BGR := 84
	Static COLOR_YUV2RGB := 85
	Static COLOR_YUV2RGB_NV12 := 90
	Static COLOR_YUV2BGR_NV12 := 91
	Static COLOR_YUV2RGB_NV21 := 92
	Static COLOR_YUV2BGR_NV21 := 93
	Static COLOR_YUV420sp2RGB := OpenCV.COLOR_YUV2RGB_NV21
	Static COLOR_YUV420sp2BGR := OpenCV.COLOR_YUV2BGR_NV21
	Static COLOR_YUV2RGBA_NV12 := 94
	Static COLOR_YUV2BGRA_NV12 := 95
	Static COLOR_YUV2RGBA_NV21 := 96
	Static COLOR_YUV2BGRA_NV21 := 97
	Static COLOR_YUV420sp2RGBA := OpenCV.COLOR_YUV2RGBA_NV21
	Static COLOR_YUV420sp2BGRA := OpenCV.COLOR_YUV2BGRA_NV21
	Static COLOR_YUV2RGB_YV12 := 98
	Static COLOR_YUV2BGR_YV12 := 99
	Static COLOR_YUV2RGB_IYUV := 100
	Static COLOR_YUV2BGR_IYUV := 101
	Static COLOR_YUV2RGB_I420 := OpenCV.COLOR_YUV2RGB_IYUV
	Static COLOR_YUV2BGR_I420 := OpenCV.COLOR_YUV2BGR_IYUV
	Static COLOR_YUV420p2RGB := OpenCV.COLOR_YUV2RGB_YV12
	Static COLOR_YUV420p2BGR := OpenCV.COLOR_YUV2BGR_YV12
	Static COLOR_YUV2RGBA_YV12 := 102
	Static COLOR_YUV2BGRA_YV12 := 103
	Static COLOR_YUV2RGBA_IYUV := 104
	Static COLOR_YUV2BGRA_IYUV := 105
	Static COLOR_YUV2RGBA_I420 := OpenCV.COLOR_YUV2RGBA_IYUV
	Static COLOR_YUV2BGRA_I420 := OpenCV.COLOR_YUV2BGRA_IYUV
	Static COLOR_YUV420p2RGBA := OpenCV.COLOR_YUV2RGBA_YV12
	Static COLOR_YUV420p2BGRA := OpenCV.COLOR_YUV2BGRA_YV12
	Static COLOR_YUV2GRAY_420 := 106
	Static COLOR_YUV2GRAY_NV21 := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV2GRAY_NV12 := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV2GRAY_YV12 := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV2GRAY_IYUV := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV2GRAY_I420 := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV420sp2GRAY := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV420p2GRAY := OpenCV.COLOR_YUV2GRAY_420
	Static COLOR_YUV2RGB_UYVY := 107
	Static COLOR_YUV2BGR_UYVY := 108
	Static COLOR_YUV2RGB_Y422 := OpenCV.COLOR_YUV2RGB_UYVY
	Static COLOR_YUV2BGR_Y422 := OpenCV.COLOR_YUV2BGR_UYVY
	Static COLOR_YUV2RGB_UYNV := OpenCV.COLOR_YUV2RGB_UYVY
	Static COLOR_YUV2BGR_UYNV := OpenCV.COLOR_YUV2BGR_UYVY
	Static COLOR_YUV2RGBA_UYVY := 111
	Static COLOR_YUV2BGRA_UYVY := 112
	Static COLOR_YUV2RGBA_Y422 := OpenCV.COLOR_YUV2RGBA_UYVY
	Static COLOR_YUV2BGRA_Y422 := OpenCV.COLOR_YUV2BGRA_UYVY
	Static COLOR_YUV2RGBA_UYNV := OpenCV.COLOR_YUV2RGBA_UYVY
	Static COLOR_YUV2BGRA_UYNV := OpenCV.COLOR_YUV2BGRA_UYVY
	Static COLOR_YUV2RGB_YUY2 := 115
	Static COLOR_YUV2BGR_YUY2 := 116
	Static COLOR_YUV2RGB_YVYU := 117
	Static COLOR_YUV2BGR_YVYU := 118
	Static COLOR_YUV2RGB_YUYV := OpenCV.COLOR_YUV2RGB_YUY2
	Static COLOR_YUV2BGR_YUYV := OpenCV.COLOR_YUV2BGR_YUY2
	Static COLOR_YUV2RGB_YUNV := OpenCV.COLOR_YUV2RGB_YUY2
	Static COLOR_YUV2BGR_YUNV := OpenCV.COLOR_YUV2BGR_YUY2
	Static COLOR_YUV2RGBA_YUY2 := 119
	Static COLOR_YUV2BGRA_YUY2 := 120
	Static COLOR_YUV2RGBA_YVYU := 121
	Static COLOR_YUV2BGRA_YVYU := 122
	Static COLOR_YUV2RGBA_YUYV := OpenCV.COLOR_YUV2RGBA_YUY2
	Static COLOR_YUV2BGRA_YUYV := OpenCV.COLOR_YUV2BGRA_YUY2
	Static COLOR_YUV2RGBA_YUNV := OpenCV.COLOR_YUV2RGBA_YUY2
	Static COLOR_YUV2BGRA_YUNV := OpenCV.COLOR_YUV2BGRA_YUY2
	Static COLOR_YUV2GRAY_UYVY := 123
	Static COLOR_YUV2GRAY_YUY2 := 124
	Static COLOR_YUV2GRAY_Y422 := OpenCV.COLOR_YUV2GRAY_UYVY
	Static COLOR_YUV2GRAY_UYNV := OpenCV.COLOR_YUV2GRAY_UYVY
	Static COLOR_YUV2GRAY_YVYU := OpenCV.COLOR_YUV2GRAY_YUY2
	Static COLOR_YUV2GRAY_YUYV := OpenCV.COLOR_YUV2GRAY_YUY2
	Static COLOR_YUV2GRAY_YUNV := OpenCV.COLOR_YUV2GRAY_YUY2
	Static COLOR_RGBA2mRGBA := 125
	Static COLOR_mRGBA2RGBA := 126
	Static COLOR_RGB2YUV_I420 := 127
	Static COLOR_BGR2YUV_I420 := 128
	Static COLOR_RGB2YUV_IYUV := OpenCV.COLOR_RGB2YUV_I420
	Static COLOR_BGR2YUV_IYUV := OpenCV.COLOR_BGR2YUV_I420
	Static COLOR_RGBA2YUV_I420 := 129
	Static COLOR_BGRA2YUV_I420 := 130
	Static COLOR_RGBA2YUV_IYUV := OpenCV.COLOR_RGBA2YUV_I420
	Static COLOR_BGRA2YUV_IYUV := OpenCV.COLOR_BGRA2YUV_I420
	Static COLOR_RGB2YUV_YV12 := 131
	Static COLOR_BGR2YUV_YV12 := 132
	Static COLOR_RGBA2YUV_YV12 := 133
	Static COLOR_BGRA2YUV_YV12 := 134
	Static COLOR_BayerBG2BGR := 46
	Static COLOR_BayerGB2BGR := 47
	Static COLOR_BayerRG2BGR := 48
	Static COLOR_BayerGR2BGR := 49
	Static COLOR_BayerRGGB2BGR := OpenCV.COLOR_BayerBG2BGR
	Static COLOR_BayerGRBG2BGR := OpenCV.COLOR_BayerGB2BGR
	Static COLOR_BayerBGGR2BGR := OpenCV.COLOR_BayerRG2BGR
	Static COLOR_BayerGBRG2BGR := OpenCV.COLOR_BayerGR2BGR
	Static COLOR_BayerRGGB2RGB := OpenCV.COLOR_BayerBGGR2BGR
	Static COLOR_BayerGRBG2RGB := OpenCV.COLOR_BayerGBRG2BGR
	Static COLOR_BayerBGGR2RGB := OpenCV.COLOR_BayerRGGB2BGR
	Static COLOR_BayerGBRG2RGB := OpenCV.COLOR_BayerGRBG2BGR
	Static COLOR_BayerBG2RGB := OpenCV.COLOR_BayerRG2BGR
	Static COLOR_BayerGB2RGB := OpenCV.COLOR_BayerGR2BGR
	Static COLOR_BayerRG2RGB := OpenCV.COLOR_BayerBG2BGR
	Static COLOR_BayerGR2RGB := OpenCV.COLOR_BayerGB2BGR
	Static COLOR_BayerBG2GRAY := 86
	Static COLOR_BayerGB2GRAY := 87
	Static COLOR_BayerRG2GRAY := 88
	Static COLOR_BayerGR2GRAY := 89
	Static COLOR_BayerRGGB2GRAY := OpenCV.COLOR_BayerBG2GRAY
	Static COLOR_BayerGRBG2GRAY := OpenCV.COLOR_BayerGB2GRAY
	Static COLOR_BayerBGGR2GRAY := OpenCV.COLOR_BayerRG2GRAY
	Static COLOR_BayerGBRG2GRAY := OpenCV.COLOR_BayerGR2GRAY
	Static COLOR_BayerBG2BGR_VNG := 62
	Static COLOR_BayerGB2BGR_VNG := 63
	Static COLOR_BayerRG2BGR_VNG := 64
	Static COLOR_BayerGR2BGR_VNG := 65
	Static COLOR_BayerRGGB2BGR_VNG := OpenCV.COLOR_BayerBG2BGR_VNG
	Static COLOR_BayerGRBG2BGR_VNG := OpenCV.COLOR_BayerGB2BGR_VNG
	Static COLOR_BayerBGGR2BGR_VNG := OpenCV.COLOR_BayerRG2BGR_VNG
	Static COLOR_BayerGBRG2BGR_VNG := OpenCV.COLOR_BayerGR2BGR_VNG
	Static COLOR_BayerRGGB2RGB_VNG := OpenCV.COLOR_BayerBGGR2BGR_VNG
	Static COLOR_BayerGRBG2RGB_VNG := OpenCV.COLOR_BayerGBRG2BGR_VNG
	Static COLOR_BayerBGGR2RGB_VNG := OpenCV.COLOR_BayerRGGB2BGR_VNG
	Static COLOR_BayerGBRG2RGB_VNG := OpenCV.COLOR_BayerGRBG2BGR_VNG
	Static COLOR_BayerBG2RGB_VNG := OpenCV.COLOR_BayerRG2BGR_VNG
	Static COLOR_BayerGB2RGB_VNG := OpenCV.COLOR_BayerGR2BGR_VNG
	Static COLOR_BayerRG2RGB_VNG := OpenCV.COLOR_BayerBG2BGR_VNG
	Static COLOR_BayerGR2RGB_VNG := OpenCV.COLOR_BayerGB2BGR_VNG
	Static COLOR_BayerBG2BGR_EA := 135
	Static COLOR_BayerGB2BGR_EA := 136
	Static COLOR_BayerRG2BGR_EA := 137
	Static COLOR_BayerGR2BGR_EA := 138
	Static COLOR_BayerRGGB2BGR_EA := OpenCV.COLOR_BayerBG2BGR_EA
	Static COLOR_BayerGRBG2BGR_EA := OpenCV.COLOR_BayerGB2BGR_EA
	Static COLOR_BayerBGGR2BGR_EA := OpenCV.COLOR_BayerRG2BGR_EA
	Static COLOR_BayerGBRG2BGR_EA := OpenCV.COLOR_BayerGR2BGR_EA
	Static COLOR_BayerRGGB2RGB_EA := OpenCV.COLOR_BayerBGGR2BGR_EA
	Static COLOR_BayerGRBG2RGB_EA := OpenCV.COLOR_BayerGBRG2BGR_EA
	Static COLOR_BayerBGGR2RGB_EA := OpenCV.COLOR_BayerRGGB2BGR_EA
	Static COLOR_BayerGBRG2RGB_EA := OpenCV.COLOR_BayerGRBG2BGR_EA
	Static COLOR_BayerBG2RGB_EA := OpenCV.COLOR_BayerRG2BGR_EA
	Static COLOR_BayerGB2RGB_EA := OpenCV.COLOR_BayerGR2BGR_EA
	Static COLOR_BayerRG2RGB_EA := OpenCV.COLOR_BayerBG2BGR_EA
	Static COLOR_BayerGR2RGB_EA := OpenCV.COLOR_BayerGB2BGR_EA
	Static COLOR_BayerBG2BGRA := 139
	Static COLOR_BayerGB2BGRA := 140
	Static COLOR_BayerRG2BGRA := 141
	Static COLOR_BayerGR2BGRA := 142
	Static COLOR_BayerRGGB2BGRA := OpenCV.COLOR_BayerBG2BGRA
	Static COLOR_BayerGRBG2BGRA := OpenCV.COLOR_BayerGB2BGRA
	Static COLOR_BayerBGGR2BGRA := OpenCV.COLOR_BayerRG2BGRA
	Static COLOR_BayerGBRG2BGRA := OpenCV.COLOR_BayerGR2BGRA
	Static COLOR_BayerRGGB2RGBA := OpenCV.COLOR_BayerBGGR2BGRA
	Static COLOR_BayerGRBG2RGBA := OpenCV.COLOR_BayerGBRG2BGRA
	Static COLOR_BayerBGGR2RGBA := OpenCV.COLOR_BayerRGGB2BGRA
	Static COLOR_BayerGBRG2RGBA := OpenCV.COLOR_BayerGRBG2BGRA
	Static COLOR_BayerBG2RGBA := OpenCV.COLOR_BayerRG2BGRA
	Static COLOR_BayerGB2RGBA := OpenCV.COLOR_BayerGR2BGRA
	Static COLOR_BayerRG2RGBA := OpenCV.COLOR_BayerBG2BGRA
	Static COLOR_BayerGR2RGBA := OpenCV.COLOR_BayerGB2BGRA
	Static COLOR_COLORCVT_MAX := 143

	; RectanglesIntersectTypes
	Static INTERSECT_NONE := 0
	Static INTERSECT_PARTIAL := 1
	Static INTERSECT_FULL := 2

	; LineTypes
	Static FILLED := -1
	Static LINE_4 := 4
	Static LINE_8 := 8
	Static LINE_AA := 16

	; HersheyFonts
	Static FONT_HERSHEY_SIMPLEX := 0
	Static FONT_HERSHEY_PLAIN := 1
	Static FONT_HERSHEY_DUPLEX := 2
	Static FONT_HERSHEY_COMPLEX := 3
	Static FONT_HERSHEY_TRIPLEX := 4
	Static FONT_HERSHEY_COMPLEX_SMALL := 5
	Static FONT_HERSHEY_SCRIPT_SIMPLEX := 6
	Static FONT_HERSHEY_SCRIPT_COMPLEX := 7
	Static FONT_ITALIC := 16

	; MarkerTypes
	Static MARKER_CROSS := 0
	Static MARKER_TILTED_CROSS := 1
	Static MARKER_STAR := 2
	Static MARKER_DIAMOND := 3
	Static MARKER_SQUARE := 4
	Static MARKER_TRIANGLE_UP := 5
	Static MARKER_TRIANGLE_DOWN := 6

	; anonymous
	Static SUBDIV2D_PTLOC_ERROR := -2
	Static SUBDIV2D_PTLOC_OUTSIDE_RECT := -1
	Static SUBDIV2D_PTLOC_INSIDE := 0
	Static SUBDIV2D_PTLOC_VERTEX := 1
	Static SUBDIV2D_PTLOC_ON_EDGE := 2
	Static SUBDIV2D_NEXT_AROUND_ORG := 0x00
	Static SUBDIV2D_NEXT_AROUND_DST := 0x22
	Static SUBDIV2D_PREV_AROUND_ORG := 0x11
	Static SUBDIV2D_PREV_AROUND_DST := 0x33
	Static SUBDIV2D_NEXT_AROUND_LEFT := 0x13
	Static SUBDIV2D_NEXT_AROUND_RIGHT := 0x31
	Static SUBDIV2D_PREV_AROUND_LEFT := 0x20
	Static SUBDIV2D_PREV_AROUND_RIGHT := 0x02

	; TemplateMatchModes
	Static TM_SQDIFF := 0
	Static TM_SQDIFF_NORMED := 1
	Static TM_CCORR := 2
	Static TM_CCORR_NORMED := 3
	Static TM_CCOEFF := 4
	Static TM_CCOEFF_NORMED := 5

	; ColormapTypes
	Static COLORMAP_AUTUMN := 0
	Static COLORMAP_BONE := 1
	Static COLORMAP_JET := 2
	Static COLORMAP_WINTER := 3
	Static COLORMAP_RAINBOW := 4
	Static COLORMAP_OCEAN := 5
	Static COLORMAP_SUMMER := 6
	Static COLORMAP_SPRING := 7
	Static COLORMAP_COOL := 8
	Static COLORMAP_HSV := 9
	Static COLORMAP_PINK := 10
	Static COLORMAP_HOT := 11
	Static COLORMAP_PARULA := 12
	Static COLORMAP_MAGMA := 13
	Static COLORMAP_INFERNO := 14
	Static COLORMAP_PLASMA := 15
	Static COLORMAP_VIRIDIS := 16
	Static COLORMAP_CIVIDIS := 17
	Static COLORMAP_TWILIGHT := 18
	Static COLORMAP_TWILIGHT_SHIFTED := 19
	Static COLORMAP_TURBO := 20
	Static COLORMAP_DEEPGREEN := 21

	; VariableTypes
	Static ML_VAR_NUMERICAL := 0
	Static ML_VAR_ORDERED := 0
	Static ML_VAR_CATEGORICAL := 1

	; ErrorTypes
	Static ML_TEST_ERROR := 0
	Static ML_TRAIN_ERROR := 1

	; SampleTypes
	Static ML_ROW_SAMPLE := 0
	Static ML_COL_SAMPLE := 1

	; Flags
	Static ML_STAT_MODEL_UPDATE_MODEL := 1
	Static ML_STAT_MODEL_RAW_OUTPUT := 1
	Static ML_STAT_MODEL_COMPRESSED_INPUT := 2
	Static ML_STAT_MODEL_PREPROCESSED_INPUT := 4

	; Types
	Static ML_KNEAREST_BRUTE_FORCE := 1
	Static ML_KNEAREST_KDTREE := 2

	; Types
	Static ML_SVM_C_SVC := 100
	Static ML_SVM_NU_SVC := 101
	Static ML_SVM_ONE_CLASS := 102
	Static ML_SVM_EPS_SVR := 103
	Static ML_SVM_NU_SVR := 104

	; KernelTypes
	Static ML_SVM_CUSTOM := -1
	Static ML_SVM_LINEAR := 0
	Static ML_SVM_POLY := 1
	Static ML_SVM_RBF := 2
	Static ML_SVM_SIGMOID := 3
	Static ML_SVM_CHI2 := 4
	Static ML_SVM_INTER := 5

	; ParamTypes
	Static ML_SVM_C := 0
	Static ML_SVM_GAMMA := 1
	Static ML_SVM_P := 2
	Static ML_SVM_NU := 3
	Static ML_SVM_COEF := 4
	Static ML_SVM_DEGREE := 5

	; Types
	Static ML_EM_COV_MAT_SPHERICAL := 0
	Static ML_EM_COV_MAT_DIAGONAL := 1
	Static ML_EM_COV_MAT_GENERIC := 2
	Static ML_EM_COV_MAT_DEFAULT := OpenCV.ML_EM_COV_MAT_DIAGONAL

	; anonymous
	Static ML_EM_DEFAULT_NCLUSTERS := 5
	Static ML_EM_DEFAULT_MAX_ITERS := 100
	Static ML_EM_START_E_STEP := 1
	Static ML_EM_START_M_STEP := 2
	Static ML_EM_START_AUTO_STEP := 0

	; Flags
	Static ML_DTREES_PREDICT_AUTO := 0
	Static ML_DTREES_PREDICT_SUM := (BitShift(1, -8))
	Static ML_DTREES_PREDICT_MAX_VOTE := (BitShift(2, -8))
	Static ML_DTREES_PREDICT_MASK := (BitShift(3, -8))

	; Types
	Static ML_BOOST_DISCRETE := 0
	Static ML_BOOST_REAL := 1
	Static ML_BOOST_LOGIT := 2
	Static ML_BOOST_GENTLE := 3

	; TrainingMethods
	Static ML_ANN_MLP_BACKPROP := 0
	Static ML_ANN_MLP_RPROP := 1
	Static ML_ANN_MLP_ANNEAL := 2

	; ActivationFunctions
	Static ML_ANN_MLP_IDENTITY := 0
	Static ML_ANN_MLP_SIGMOID_SYM := 1
	Static ML_ANN_MLP_GAUSSIAN := 2
	Static ML_ANN_MLP_RELU := 3
	Static ML_ANN_MLP_LEAKYRELU := 4

	; TrainFlags
	Static ML_ANN_MLP_UPDATE_WEIGHTS := 1
	Static ML_ANN_MLP_NO_INPUT_SCALE := 2
	Static ML_ANN_MLP_NO_OUTPUT_SCALE := 4

	; RegKinds
	Static ML_LOGISTIC_REGRESSION_REG_DISABLE := -1
	Static ML_LOGISTIC_REGRESSION_REG_L1 := 0
	Static ML_LOGISTIC_REGRESSION_REG_L2 := 1

	; Methods
	Static ML_LOGISTIC_REGRESSION_BATCH := 0
	Static ML_LOGISTIC_REGRESSION_MINI_BATCH := 1

	; SvmsgdType
	Static ML_SVMSGD_SGD := 0
	Static ML_SVMSGD_ASGD := 1

	; MarginType
	Static ML_SVMSGD_SOFT_MARGIN := 0
	Static ML_SVMSGD_HARD_MARGIN := 1

	; anonymous
	Static INPAINT_NS := 0
	Static INPAINT_TELEA := 1
	Static LDR_SIZE := 256
	Static NORMAL_CLONE := 1
	Static MIXED_CLONE := 2
	Static MONOCHROME_TRANSFER := 3
	Static RECURS_FILTER := 1
	Static NORMCONV_FILTER := 2
	Static CAP_PROP_DC1394_OFF := -4
	Static CAP_PROP_DC1394_MODE_MANUAL := -3
	Static CAP_PROP_DC1394_MODE_AUTO := -2
	Static CAP_PROP_DC1394_MODE_ONE_PUSH_AUTO := -1
	Static CAP_PROP_DC1394_MAX := 31
	Static CAP_OPENNI_DEPTH_GENERATOR := BitShift(1, -31)
	Static CAP_OPENNI_IMAGE_GENERATOR := BitShift(1, -30)
	Static CAP_OPENNI_IR_GENERATOR := BitShift(1, -29)
	Static CAP_OPENNI_GENERATORS_MASK := OpenCV.CAP_OPENNI_DEPTH_GENERATOR + OpenCV.CAP_OPENNI_IMAGE_GENERATOR + OpenCV.CAP_OPENNI_IR_GENERATOR
	Static CAP_PROP_OPENNI_OUTPUT_MODE := 100
	Static CAP_PROP_OPENNI_FRAME_MAX_DEPTH := 101
	Static CAP_PROP_OPENNI_BASELINE := 102
	Static CAP_PROP_OPENNI_FOCAL_LENGTH := 103
	Static CAP_PROP_OPENNI_REGISTRATION := 104
	Static CAP_PROP_OPENNI_REGISTRATION_ON := OpenCV.CAP_PROP_OPENNI_REGISTRATION
	Static CAP_PROP_OPENNI_APPROX_FRAME_SYNC := 105
	Static CAP_PROP_OPENNI_MAX_BUFFER_SIZE := 106
	Static CAP_PROP_OPENNI_CIRCLE_BUFFER := 107
	Static CAP_PROP_OPENNI_MAX_TIME_DURATION := 108
	Static CAP_PROP_OPENNI_GENERATOR_PRESENT := 109
	Static CAP_PROP_OPENNI2_SYNC := 110
	Static CAP_PROP_OPENNI2_MIRROR := 111
	Static CAP_OPENNI_IMAGE_GENERATOR_PRESENT := OpenCV.CAP_OPENNI_IMAGE_GENERATOR + OpenCV.CAP_PROP_OPENNI_GENERATOR_PRESENT
	Static CAP_OPENNI_IMAGE_GENERATOR_OUTPUT_MODE := OpenCV.CAP_OPENNI_IMAGE_GENERATOR + OpenCV.CAP_PROP_OPENNI_OUTPUT_MODE
	Static CAP_OPENNI_DEPTH_GENERATOR_PRESENT := OpenCV.CAP_OPENNI_DEPTH_GENERATOR + OpenCV.CAP_PROP_OPENNI_GENERATOR_PRESENT
	Static CAP_OPENNI_DEPTH_GENERATOR_BASELINE := OpenCV.CAP_OPENNI_DEPTH_GENERATOR + OpenCV.CAP_PROP_OPENNI_BASELINE
	Static CAP_OPENNI_DEPTH_GENERATOR_FOCAL_LENGTH := OpenCV.CAP_OPENNI_DEPTH_GENERATOR + OpenCV.CAP_PROP_OPENNI_FOCAL_LENGTH
	Static CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION := OpenCV.CAP_OPENNI_DEPTH_GENERATOR + OpenCV.CAP_PROP_OPENNI_REGISTRATION
	Static CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION_ON := OpenCV.CAP_OPENNI_DEPTH_GENERATOR_REGISTRATION
	Static CAP_OPENNI_IR_GENERATOR_PRESENT := OpenCV.CAP_OPENNI_IR_GENERATOR + OpenCV.CAP_PROP_OPENNI_GENERATOR_PRESENT
	Static CAP_OPENNI_DEPTH_MAP := 0
	Static CAP_OPENNI_POINT_CLOUD_MAP := 1
	Static CAP_OPENNI_DISPARITY_MAP := 2
	Static CAP_OPENNI_DISPARITY_MAP_32F := 3
	Static CAP_OPENNI_VALID_DEPTH_MASK := 4
	Static CAP_OPENNI_BGR_IMAGE := 5
	Static CAP_OPENNI_GRAY_IMAGE := 6
	Static CAP_OPENNI_IR_IMAGE := 7
	Static CAP_OPENNI_VGA_30HZ := 0
	Static CAP_OPENNI_SXGA_15HZ := 1
	Static CAP_OPENNI_SXGA_30HZ := 2
	Static CAP_OPENNI_QVGA_30HZ := 3
	Static CAP_OPENNI_QVGA_60HZ := 4
	Static CAP_PROP_GSTREAMER_QUEUE_LENGTH := 200
	Static CAP_PROP_PVAPI_MULTICASTIP := 300
	Static CAP_PROP_PVAPI_FRAMESTARTTRIGGERMODE := 301
	Static CAP_PROP_PVAPI_DECIMATIONHORIZONTAL := 302
	Static CAP_PROP_PVAPI_DECIMATIONVERTICAL := 303
	Static CAP_PROP_PVAPI_BINNINGX := 304
	Static CAP_PROP_PVAPI_BINNINGY := 305
	Static CAP_PROP_PVAPI_PIXELFORMAT := 306
	Static CAP_PVAPI_FSTRIGMODE_FREERUN := 0
	Static CAP_PVAPI_FSTRIGMODE_SYNCIN1 := 1
	Static CAP_PVAPI_FSTRIGMODE_SYNCIN2 := 2
	Static CAP_PVAPI_FSTRIGMODE_FIXEDRATE := 3
	Static CAP_PVAPI_FSTRIGMODE_SOFTWARE := 4
	Static CAP_PVAPI_DECIMATION_OFF := 1
	Static CAP_PVAPI_DECIMATION_2OUTOF4 := 2
	Static CAP_PVAPI_DECIMATION_2OUTOF8 := 4
	Static CAP_PVAPI_DECIMATION_2OUTOF16 := 8
	Static CAP_PVAPI_PIXELFORMAT_MONO8 := 1
	Static CAP_PVAPI_PIXELFORMAT_MONO16 := 2
	Static CAP_PVAPI_PIXELFORMAT_BAYER8 := 3
	Static CAP_PVAPI_PIXELFORMAT_BAYER16 := 4
	Static CAP_PVAPI_PIXELFORMAT_RGB24 := 5
	Static CAP_PVAPI_PIXELFORMAT_BGR24 := 6
	Static CAP_PVAPI_PIXELFORMAT_RGBA32 := 7
	Static CAP_PVAPI_PIXELFORMAT_BGRA32 := 8
	Static CAP_PROP_XI_DOWNSAMPLING := 400
	Static CAP_PROP_XI_DATA_FORMAT := 401
	Static CAP_PROP_XI_OFFSET_X := 402
	Static CAP_PROP_XI_OFFSET_Y := 403
	Static CAP_PROP_XI_TRG_SOURCE := 404
	Static CAP_PROP_XI_TRG_SOFTWARE := 405
	Static CAP_PROP_XI_GPI_SELECTOR := 406
	Static CAP_PROP_XI_GPI_MODE := 407
	Static CAP_PROP_XI_GPI_LEVEL := 408
	Static CAP_PROP_XI_GPO_SELECTOR := 409
	Static CAP_PROP_XI_GPO_MODE := 410
	Static CAP_PROP_XI_LED_SELECTOR := 411
	Static CAP_PROP_XI_LED_MODE := 412
	Static CAP_PROP_XI_MANUAL_WB := 413
	Static CAP_PROP_XI_AUTO_WB := 414
	Static CAP_PROP_XI_AEAG := 415
	Static CAP_PROP_XI_EXP_PRIORITY := 416
	Static CAP_PROP_XI_AE_MAX_LIMIT := 417
	Static CAP_PROP_XI_AG_MAX_LIMIT := 418
	Static CAP_PROP_XI_AEAG_LEVEL := 419
	Static CAP_PROP_XI_TIMEOUT := 420
	Static CAP_PROP_XI_EXPOSURE := 421
	Static CAP_PROP_XI_EXPOSURE_BURST_COUNT := 422
	Static CAP_PROP_XI_GAIN_SELECTOR := 423
	Static CAP_PROP_XI_GAIN := 424
	Static CAP_PROP_XI_DOWNSAMPLING_TYPE := 426
	Static CAP_PROP_XI_BINNING_SELECTOR := 427
	Static CAP_PROP_XI_BINNING_VERTICAL := 428
	Static CAP_PROP_XI_BINNING_HORIZONTAL := 429
	Static CAP_PROP_XI_BINNING_PATTERN := 430
	Static CAP_PROP_XI_DECIMATION_SELECTOR := 431
	Static CAP_PROP_XI_DECIMATION_VERTICAL := 432
	Static CAP_PROP_XI_DECIMATION_HORIZONTAL := 433
	Static CAP_PROP_XI_DECIMATION_PATTERN := 434
	Static CAP_PROP_XI_TEST_PATTERN_GENERATOR_SELECTOR := 587
	Static CAP_PROP_XI_TEST_PATTERN := 588
	Static CAP_PROP_XI_IMAGE_DATA_FORMAT := 435
	Static CAP_PROP_XI_SHUTTER_TYPE := 436
	Static CAP_PROP_XI_SENSOR_TAPS := 437
	Static CAP_PROP_XI_AEAG_ROI_OFFSET_X := 439
	Static CAP_PROP_XI_AEAG_ROI_OFFSET_Y := 440
	Static CAP_PROP_XI_AEAG_ROI_WIDTH := 441
	Static CAP_PROP_XI_AEAG_ROI_HEIGHT := 442
	Static CAP_PROP_XI_BPC := 445
	Static CAP_PROP_XI_WB_KR := 448
	Static CAP_PROP_XI_WB_KG := 449
	Static CAP_PROP_XI_WB_KB := 450
	Static CAP_PROP_XI_WIDTH := 451
	Static CAP_PROP_XI_HEIGHT := 452
	Static CAP_PROP_XI_REGION_SELECTOR := 589
	Static CAP_PROP_XI_REGION_MODE := 595
	Static CAP_PROP_XI_LIMIT_BANDWIDTH := 459
	Static CAP_PROP_XI_SENSOR_DATA_BIT_DEPTH := 460
	Static CAP_PROP_XI_OUTPUT_DATA_BIT_DEPTH := 461
	Static CAP_PROP_XI_IMAGE_DATA_BIT_DEPTH := 462
	Static CAP_PROP_XI_OUTPUT_DATA_PACKING := 463
	Static CAP_PROP_XI_OUTPUT_DATA_PACKING_TYPE := 464
	Static CAP_PROP_XI_IS_COOLED := 465
	Static CAP_PROP_XI_COOLING := 466
	Static CAP_PROP_XI_TARGET_TEMP := 467
	Static CAP_PROP_XI_CHIP_TEMP := 468
	Static CAP_PROP_XI_HOUS_TEMP := 469
	Static CAP_PROP_XI_HOUS_BACK_SIDE_TEMP := 590
	Static CAP_PROP_XI_SENSOR_BOARD_TEMP := 596
	Static CAP_PROP_XI_CMS := 470
	Static CAP_PROP_XI_APPLY_CMS := 471
	Static CAP_PROP_XI_IMAGE_IS_COLOR := 474
	Static CAP_PROP_XI_COLOR_FILTER_ARRAY := 475
	Static CAP_PROP_XI_GAMMAY := 476
	Static CAP_PROP_XI_GAMMAC := 477
	Static CAP_PROP_XI_SHARPNESS := 478
	Static CAP_PROP_XI_CC_MATRIX_00 := 479
	Static CAP_PROP_XI_CC_MATRIX_01 := 480
	Static CAP_PROP_XI_CC_MATRIX_02 := 481
	Static CAP_PROP_XI_CC_MATRIX_03 := 482
	Static CAP_PROP_XI_CC_MATRIX_10 := 483
	Static CAP_PROP_XI_CC_MATRIX_11 := 484
	Static CAP_PROP_XI_CC_MATRIX_12 := 485
	Static CAP_PROP_XI_CC_MATRIX_13 := 486
	Static CAP_PROP_XI_CC_MATRIX_20 := 487
	Static CAP_PROP_XI_CC_MATRIX_21 := 488
	Static CAP_PROP_XI_CC_MATRIX_22 := 489
	Static CAP_PROP_XI_CC_MATRIX_23 := 490
	Static CAP_PROP_XI_CC_MATRIX_30 := 491
	Static CAP_PROP_XI_CC_MATRIX_31 := 492
	Static CAP_PROP_XI_CC_MATRIX_32 := 493
	Static CAP_PROP_XI_CC_MATRIX_33 := 494
	Static CAP_PROP_XI_DEFAULT_CC_MATRIX := 495
	Static CAP_PROP_XI_TRG_SELECTOR := 498
	Static CAP_PROP_XI_ACQ_FRAME_BURST_COUNT := 499
	Static CAP_PROP_XI_DEBOUNCE_EN := 507
	Static CAP_PROP_XI_DEBOUNCE_T0 := 508
	Static CAP_PROP_XI_DEBOUNCE_T1 := 509
	Static CAP_PROP_XI_DEBOUNCE_POL := 510
	Static CAP_PROP_XI_LENS_MODE := 511
	Static CAP_PROP_XI_LENS_APERTURE_VALUE := 512
	Static CAP_PROP_XI_LENS_FOCUS_MOVEMENT_VALUE := 513
	Static CAP_PROP_XI_LENS_FOCUS_MOVE := 514
	Static CAP_PROP_XI_LENS_FOCUS_DISTANCE := 515
	Static CAP_PROP_XI_LENS_FOCAL_LENGTH := 516
	Static CAP_PROP_XI_LENS_FEATURE_SELECTOR := 517
	Static CAP_PROP_XI_LENS_FEATURE := 518
	Static CAP_PROP_XI_DEVICE_MODEL_ID := 521
	Static CAP_PROP_XI_DEVICE_SN := 522
	Static CAP_PROP_XI_IMAGE_DATA_FORMAT_RGB32_ALPHA := 529
	Static CAP_PROP_XI_IMAGE_PAYLOAD_SIZE := 530
	Static CAP_PROP_XI_TRANSPORT_PIXEL_FORMAT := 531
	Static CAP_PROP_XI_SENSOR_CLOCK_FREQ_HZ := 532
	Static CAP_PROP_XI_SENSOR_CLOCK_FREQ_INDEX := 533
	Static CAP_PROP_XI_SENSOR_OUTPUT_CHANNEL_COUNT := 534
	Static CAP_PROP_XI_FRAMERATE := 535
	Static CAP_PROP_XI_COUNTER_SELECTOR := 536
	Static CAP_PROP_XI_COUNTER_VALUE := 537
	Static CAP_PROP_XI_ACQ_TIMING_MODE := 538
	Static CAP_PROP_XI_AVAILABLE_BANDWIDTH := 539
	Static CAP_PROP_XI_BUFFER_POLICY := 540
	Static CAP_PROP_XI_LUT_EN := 541
	Static CAP_PROP_XI_LUT_INDEX := 542
	Static CAP_PROP_XI_LUT_VALUE := 543
	Static CAP_PROP_XI_TRG_DELAY := 544
	Static CAP_PROP_XI_TS_RST_MODE := 545
	Static CAP_PROP_XI_TS_RST_SOURCE := 546
	Static CAP_PROP_XI_IS_DEVICE_EXIST := 547
	Static CAP_PROP_XI_ACQ_BUFFER_SIZE := 548
	Static CAP_PROP_XI_ACQ_BUFFER_SIZE_UNIT := 549
	Static CAP_PROP_XI_ACQ_TRANSPORT_BUFFER_SIZE := 550
	Static CAP_PROP_XI_BUFFERS_QUEUE_SIZE := 551
	Static CAP_PROP_XI_ACQ_TRANSPORT_BUFFER_COMMIT := 552
	Static CAP_PROP_XI_RECENT_FRAME := 553
	Static CAP_PROP_XI_DEVICE_RESET := 554
	Static CAP_PROP_XI_COLUMN_FPN_CORRECTION := 555
	Static CAP_PROP_XI_ROW_FPN_CORRECTION := 591
	Static CAP_PROP_XI_SENSOR_MODE := 558
	Static CAP_PROP_XI_HDR := 559
	Static CAP_PROP_XI_HDR_KNEEPOINT_COUNT := 560
	Static CAP_PROP_XI_HDR_T1 := 561
	Static CAP_PROP_XI_HDR_T2 := 562
	Static CAP_PROP_XI_KNEEPOINT1 := 563
	Static CAP_PROP_XI_KNEEPOINT2 := 564
	Static CAP_PROP_XI_IMAGE_BLACK_LEVEL := 565
	Static CAP_PROP_XI_HW_REVISION := 571
	Static CAP_PROP_XI_DEBUG_LEVEL := 572
	Static CAP_PROP_XI_AUTO_BANDWIDTH_CALCULATION := 573
	Static CAP_PROP_XI_FFS_FILE_ID := 594
	Static CAP_PROP_XI_FFS_FILE_SIZE := 580
	Static CAP_PROP_XI_FREE_FFS_SIZE := 581
	Static CAP_PROP_XI_USED_FFS_SIZE := 582
	Static CAP_PROP_XI_FFS_ACCESS_KEY := 583
	Static CAP_PROP_XI_SENSOR_FEATURE_SELECTOR := 585
	Static CAP_PROP_XI_SENSOR_FEATURE_VALUE := 586
	Static CAP_PROP_ARAVIS_AUTOTRIGGER := 600
	Static CAP_PROP_IOS_DEVICE_FOCUS := 9001
	Static CAP_PROP_IOS_DEVICE_EXPOSURE := 9002
	Static CAP_PROP_IOS_DEVICE_FLASH := 9003
	Static CAP_PROP_IOS_DEVICE_WHITEBALANCE := 9004
	Static CAP_PROP_IOS_DEVICE_TORCH := 9005
	Static CAP_PROP_GIGA_FRAME_OFFSET_X := 10001
	Static CAP_PROP_GIGA_FRAME_OFFSET_Y := 10002
	Static CAP_PROP_GIGA_FRAME_WIDTH_MAX := 10003
	Static CAP_PROP_GIGA_FRAME_HEIGH_MAX := 10004
	Static CAP_PROP_GIGA_FRAME_SENS_WIDTH := 10005
	Static CAP_PROP_GIGA_FRAME_SENS_HEIGH := 10006
	Static CAP_PROP_INTELPERC_PROFILE_COUNT := 11001
	Static CAP_PROP_INTELPERC_PROFILE_IDX := 11002
	Static CAP_PROP_INTELPERC_DEPTH_LOW_CONFIDENCE_VALUE := 11003
	Static CAP_PROP_INTELPERC_DEPTH_SATURATION_VALUE := 11004
	Static CAP_PROP_INTELPERC_DEPTH_CONFIDENCE_THRESHOLD := 11005
	Static CAP_PROP_INTELPERC_DEPTH_FOCAL_LENGTH_HORZ := 11006
	Static CAP_PROP_INTELPERC_DEPTH_FOCAL_LENGTH_VERT := 11007
	Static CAP_INTELPERC_DEPTH_GENERATOR := BitShift(1, -29)
	Static CAP_INTELPERC_IMAGE_GENERATOR := BitShift(1, -28)
	Static CAP_INTELPERC_IR_GENERATOR := BitShift(1, -27)
	Static CAP_INTELPERC_GENERATORS_MASK := OpenCV.CAP_INTELPERC_DEPTH_GENERATOR + OpenCV.CAP_INTELPERC_IMAGE_GENERATOR + OpenCV.CAP_INTELPERC_IR_GENERATOR
	Static CAP_INTELPERC_DEPTH_MAP := 0
	Static CAP_INTELPERC_UVDEPTH_MAP := 1
	Static CAP_INTELPERC_IR_MAP := 2
	Static CAP_INTELPERC_IMAGE := 3
	Static CAP_PROP_GPHOTO2_PREVIEW := 17001
	Static CAP_PROP_GPHOTO2_WIDGET_ENUMERATE := 17002
	Static CAP_PROP_GPHOTO2_RELOAD_CONFIG := 17003
	Static CAP_PROP_GPHOTO2_RELOAD_ON_CHANGE := 17004
	Static CAP_PROP_GPHOTO2_COLLECT_MSGS := 17005
	Static CAP_PROP_GPHOTO2_FLUSH_MSGS := 17006
	Static CAP_PROP_SPEED := 17007
	Static CAP_PROP_APERTURE := 17008
	Static CAP_PROP_EXPOSUREPROGRAM := 17009
	Static CAP_PROP_VIEWFINDER := 17010
	Static CAP_PROP_IMAGES_BASE := 18000
	Static CAP_PROP_IMAGES_LAST := 19000
	Static LMEDS := 4
	Static RANSAC := 8
	Static RHO := 16
	Static USAC_DEFAULT := 32
	Static USAC_PARALLEL := 33
	Static USAC_FM_8PTS := 34
	Static USAC_FAST := 35
	Static USAC_ACCURATE := 36
	Static USAC_PROSAC := 37
	Static USAC_MAGSAC := 38
	Static CALIB_CB_ADAPTIVE_THRESH := 1
	Static CALIB_CB_NORMALIZE_IMAGE := 2
	Static CALIB_CB_FILTER_QUADS := 4
	Static CALIB_CB_FAST_CHECK := 8
	Static CALIB_CB_EXHAUSTIVE := 16
	Static CALIB_CB_ACCURACY := 32
	Static CALIB_CB_LARGER := 64
	Static CALIB_CB_MARKER := 128
	Static CALIB_CB_SYMMETRIC_GRID := 1
	Static CALIB_CB_ASYMMETRIC_GRID := 2
	Static CALIB_CB_CLUSTERING := 4
	Static CALIB_NINTRINSIC := 18
	Static CALIB_USE_INTRINSIC_GUESS := 0x00001
	Static CALIB_FIX_ASPECT_RATIO := 0x00002
	Static CALIB_FIX_PRINCIPAL_POINT := 0x00004
	Static CALIB_ZERO_TANGENT_DIST := 0x00008
	Static CALIB_FIX_FOCAL_LENGTH := 0x00010
	Static CALIB_FIX_K1 := 0x00020
	Static CALIB_FIX_K2 := 0x00040
	Static CALIB_FIX_K3 := 0x00080
	Static CALIB_FIX_K4 := 0x00800
	Static CALIB_FIX_K5 := 0x01000
	Static CALIB_FIX_K6 := 0x02000
	Static CALIB_RATIONAL_MODEL := 0x04000
	Static CALIB_THIN_PRISM_MODEL := 0x08000
	Static CALIB_FIX_S1_S2_S3_S4 := 0x10000
	Static CALIB_TILTED_MODEL := 0x40000
	Static CALIB_FIX_TAUX_TAUY := 0x80000
	Static CALIB_USE_QR := 0x100000
	Static CALIB_FIX_TANGENT_DIST := 0x200000
	Static CALIB_FIX_INTRINSIC := 0x00100
	Static CALIB_SAME_FOCAL_LENGTH := 0x00200
	Static CALIB_ZERO_DISPARITY := 0x00400
	Static CALIB_USE_LU := (BitShift(1, -17))
	Static CALIB_USE_EXTRINSIC_GUESS := (BitShift(1, -22))
	Static FM_7POINT := 1
	Static FM_8POINT := 2
	Static FM_LMEDS := 4
	Static FM_RANSAC := 8
	Static CASCADE_DO_CANNY_PRUNING := 1
	Static CASCADE_SCALE_IMAGE := 2
	Static CASCADE_FIND_BIGGEST_OBJECT := 4
	Static CASCADE_DO_ROUGH_SEARCH := 8
	Static OPTFLOW_USE_INITIAL_FLOW := 4
	Static OPTFLOW_LK_GET_MIN_EIGENVALS := 8
	Static OPTFLOW_FARNEBACK_GAUSSIAN := 256
	Static MOTION_TRANSLATION := 0
	Static MOTION_EUCLIDEAN := 1
	Static MOTION_AFFINE := 2
	Static MOTION_HOMOGRAPHY := 3

	; Backend
	Static DNN_DNN_BACKEND_DEFAULT := 0
	Static DNN_DNN_BACKEND_HALIDE := 0 + 1
	Static DNN_DNN_BACKEND_INFERENCE_ENGINE := 0 + 2
	Static DNN_DNN_BACKEND_OPENCV := 0 + 3
	Static DNN_DNN_BACKEND_VKCOM := 0 + 4
	Static DNN_DNN_BACKEND_CUDA := 0 + 5
	Static DNN_DNN_BACKEND_WEBNN := 0 + 6

	; Target
	Static DNN_DNN_TARGET_CPU := 0
	Static DNN_DNN_TARGET_OPENCL := 0 + 1
	Static DNN_DNN_TARGET_OPENCL_FP16 := 0 + 2
	Static DNN_DNN_TARGET_MYRIAD := 0 + 3
	Static DNN_DNN_TARGET_VULKAN := 0 + 4
	Static DNN_DNN_TARGET_FPGA := 0 + 5
	Static DNN_DNN_TARGET_CUDA := 0 + 6
	Static DNN_DNN_TARGET_CUDA_FP16 := 0 + 7
	Static DNN_DNN_TARGET_HDDL := 0 + 8

	; SoftNMSMethod
	Static DNN_SOFT_NMSMETHOD_SOFTNMS_LINEAR := 1
	Static DNN_SOFT_NMSMETHOD_SOFTNMS_GAUSSIAN := 2

	; ScoreType
	Static ORB_HARRIS_SCORE := 0
	Static ORB_FAST_SCORE := 1

	; DetectorType
	Static FAST_FEATURE_DETECTOR_TYPE_5_8 := 0
	Static FAST_FEATURE_DETECTOR_TYPE_7_12 := 1
	Static FAST_FEATURE_DETECTOR_TYPE_9_16 := 2

	; anonymous
	Static FAST_FEATURE_DETECTOR_THRESHOLD := 10000
	Static FAST_FEATURE_DETECTOR_NONMAX_SUPPRESSION := 10001
	Static FAST_FEATURE_DETECTOR_FAST_N := 10002

	; DetectorType
	Static AGAST_FEATURE_DETECTOR_AGAST_5_8 := 0
	Static AGAST_FEATURE_DETECTOR_AGAST_7_12d := 1
	Static AGAST_FEATURE_DETECTOR_AGAST_7_12s := 2
	Static AGAST_FEATURE_DETECTOR_OAST_9_16 := 3

	; anonymous
	Static AGAST_FEATURE_DETECTOR_THRESHOLD := 10000
	Static AGAST_FEATURE_DETECTOR_NONMAX_SUPPRESSION := 10001

	; DiffusivityType
	Static KAZE_DIFF_PM_G1 := 0
	Static KAZE_DIFF_PM_G2 := 1
	Static KAZE_DIFF_WEICKERT := 2
	Static KAZE_DIFF_CHARBONNIER := 3

	; DescriptorType
	Static AKAZE_DESCRIPTOR_KAZE_UPRIGHT := 2
	Static AKAZE_DESCRIPTOR_KAZE := 3
	Static AKAZE_DESCRIPTOR_MLDB_UPRIGHT := 4
	Static AKAZE_DESCRIPTOR_MLDB := 5

	; MatcherType
	Static DESCRIPTOR_MATCHER_FLANNBASED := 1
	Static DESCRIPTOR_MATCHER_BRUTEFORCE := 2
	Static DESCRIPTOR_MATCHER_BRUTEFORCE_L1 := 3
	Static DESCRIPTOR_MATCHER_BRUTEFORCE_HAMMING := 4
	Static DESCRIPTOR_MATCHER_BRUTEFORCE_HAMMINGLUT := 5
	Static DESCRIPTOR_MATCHER_BRUTEFORCE_SL2 := 6

	; DrawMatchesFlags
	Static DRAW_MATCHES_FLAGS_DEFAULT := 0
	Static DRAW_MATCHES_FLAGS_DRAW_OVER_OUTIMG := 1
	Static DRAW_MATCHES_FLAGS_NOT_DRAW_SINGLE_POINTS := 2
	Static DRAW_MATCHES_FLAGS_DRAW_RICH_KEYPOINTS := 4

	; ImreadModes
	Static IMREAD_UNCHANGED := -1
	Static IMREAD_GRAYSCALE := 0
	Static IMREAD_COLOR := 1
	Static IMREAD_ANYDEPTH := 2
	Static IMREAD_ANYCOLOR := 4
	Static IMREAD_LOAD_GDAL := 8
	Static IMREAD_REDUCED_GRAYSCALE_2 := 16
	Static IMREAD_REDUCED_COLOR_2 := 17
	Static IMREAD_REDUCED_GRAYSCALE_4 := 32
	Static IMREAD_REDUCED_COLOR_4 := 33
	Static IMREAD_REDUCED_GRAYSCALE_8 := 64
	Static IMREAD_REDUCED_COLOR_8 := 65
	Static IMREAD_IGNORE_ORIENTATION := 128

	; ImwriteFlags
	Static IMWRITE_JPEG_QUALITY := 1
	Static IMWRITE_JPEG_PROGRESSIVE := 2
	Static IMWRITE_JPEG_OPTIMIZE := 3
	Static IMWRITE_JPEG_RST_INTERVAL := 4
	Static IMWRITE_JPEG_LUMA_QUALITY := 5
	Static IMWRITE_JPEG_CHROMA_QUALITY := 6
	Static IMWRITE_PNG_COMPRESSION := 16
	Static IMWRITE_PNG_STRATEGY := 17
	Static IMWRITE_PNG_BILEVEL := 18
	Static IMWRITE_PXM_BINARY := 32
	Static IMWRITE_EXR_TYPE := (BitShift(3, -4)) + 0
	Static IMWRITE_EXR_COMPRESSION := (BitShift(3, -4)) + 1
	Static IMWRITE_WEBP_QUALITY := 64
	Static IMWRITE_PAM_TUPLETYPE := 128
	Static IMWRITE_TIFF_RESUNIT := 256
	Static IMWRITE_TIFF_XDPI := 257
	Static IMWRITE_TIFF_YDPI := 258
	Static IMWRITE_TIFF_COMPRESSION := 259
	Static IMWRITE_JPEG2000_COMPRESSION_X1000 := 272

	; ImwriteEXRTypeFlags
	Static IMWRITE_EXR_TYPE_HALF := 1
	Static IMWRITE_EXR_TYPE_FLOAT := 2

	; ImwriteEXRCompressionFlags
	Static IMWRITE_EXR_COMPRESSION_NO := 0
	Static IMWRITE_EXR_COMPRESSION_RLE := 1
	Static IMWRITE_EXR_COMPRESSION_ZIPS := 2
	Static IMWRITE_EXR_COMPRESSION_ZIP := 3
	Static IMWRITE_EXR_COMPRESSION_PIZ := 4
	Static IMWRITE_EXR_COMPRESSION_PXR24 := 5
	Static IMWRITE_EXR_COMPRESSION_B44 := 6
	Static IMWRITE_EXR_COMPRESSION_B44A := 7
	Static IMWRITE_EXR_COMPRESSION_DWAA := 8
	Static IMWRITE_EXR_COMPRESSION_DWAB := 9

	; ImwritePNGFlags
	Static IMWRITE_PNG_STRATEGY_DEFAULT := 0
	Static IMWRITE_PNG_STRATEGY_FILTERED := 1
	Static IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY := 2
	Static IMWRITE_PNG_STRATEGY_RLE := 3
	Static IMWRITE_PNG_STRATEGY_FIXED := 4

	; ImwritePAMFlags
	Static IMWRITE_PAM_FORMAT_NULL := 0
	Static IMWRITE_PAM_FORMAT_BLACKANDWHITE := 1
	Static IMWRITE_PAM_FORMAT_GRAYSCALE := 2
	Static IMWRITE_PAM_FORMAT_GRAYSCALE_ALPHA := 3
	Static IMWRITE_PAM_FORMAT_RGB := 4
	Static IMWRITE_PAM_FORMAT_RGB_ALPHA := 5

	; VideoCaptureAPIs
	Static CAP_ANY := 0
	Static CAP_VFW := 200
	Static CAP_V4L := 200
	Static CAP_V4L2 := OpenCV.CAP_V4L
	Static CAP_FIREWIRE := 300
	Static CAP_FIREWARE := OpenCV.CAP_FIREWIRE
	Static CAP_IEEE1394 := OpenCV.CAP_FIREWIRE
	Static CAP_DC1394 := OpenCV.CAP_FIREWIRE
	Static CAP_CMU1394 := OpenCV.CAP_FIREWIRE
	Static CAP_QT := 500
	Static CAP_UNICAP := 600
	Static CAP_DSHOW := 700
	Static CAP_PVAPI := 800
	Static CAP_OPENNI := 900
	Static CAP_OPENNI_ASUS := 910
	Static CAP_ANDROID := 1000
	Static CAP_XIAPI := 1100
	Static CAP_AVFOUNDATION := 1200
	Static CAP_GIGANETIX := 1300
	Static CAP_MSMF := 1400
	Static CAP_WINRT := 1410
	Static CAP_INTELPERC := 1500
	Static CAP_REALSENSE := 1500
	Static CAP_OPENNI2 := 1600
	Static CAP_OPENNI2_ASUS := 1610
	Static CAP_OPENNI2_ASTRA := 1620
	Static CAP_GPHOTO2 := 1700
	Static CAP_GSTREAMER := 1800
	Static CAP_FFMPEG := 1900
	Static CAP_IMAGES := 2000
	Static CAP_ARAVIS := 2100
	Static CAP_OPENMJPEG := 2200
	Static CAP_INTEL_MFX := 2300
	Static CAP_XINE := 2400
	Static CAP_UEYE := 2500

	; VideoCaptureProperties
	Static CAP_PROP_POS_MSEC := 0
	Static CAP_PROP_POS_FRAMES := 1
	Static CAP_PROP_POS_AVI_RATIO := 2
	Static CAP_PROP_FRAME_WIDTH := 3
	Static CAP_PROP_FRAME_HEIGHT := 4
	Static CAP_PROP_FPS := 5
	Static CAP_PROP_FOURCC := 6
	Static CAP_PROP_FRAME_COUNT := 7
	Static CAP_PROP_FORMAT := 8
	Static CAP_PROP_MODE := 9
	Static CAP_PROP_BRIGHTNESS := 10
	Static CAP_PROP_CONTRAST := 11
	Static CAP_PROP_SATURATION := 12
	Static CAP_PROP_HUE := 13
	Static CAP_PROP_GAIN := 14
	Static CAP_PROP_EXPOSURE := 15
	Static CAP_PROP_CONVERT_RGB := 16
	Static CAP_PROP_WHITE_BALANCE_BLUE_U := 17
	Static CAP_PROP_RECTIFICATION := 18
	Static CAP_PROP_MONOCHROME := 19
	Static CAP_PROP_SHARPNESS := 20
	Static CAP_PROP_AUTO_EXPOSURE := 21
	Static CAP_PROP_GAMMA := 22
	Static CAP_PROP_TEMPERATURE := 23
	Static CAP_PROP_TRIGGER := 24
	Static CAP_PROP_TRIGGER_DELAY := 25
	Static CAP_PROP_WHITE_BALANCE_RED_V := 26
	Static CAP_PROP_ZOOM := 27
	Static CAP_PROP_FOCUS := 28
	Static CAP_PROP_GUID := 29
	Static CAP_PROP_ISO_SPEED := 30
	Static CAP_PROP_BACKLIGHT := 32
	Static CAP_PROP_PAN := 33
	Static CAP_PROP_TILT := 34
	Static CAP_PROP_ROLL := 35
	Static CAP_PROP_IRIS := 36
	Static CAP_PROP_SETTINGS := 37
	Static CAP_PROP_BUFFERSIZE := 38
	Static CAP_PROP_AUTOFOCUS := 39
	Static CAP_PROP_SAR_NUM := 40
	Static CAP_PROP_SAR_DEN := 41
	Static CAP_PROP_BACKEND := 42
	Static CAP_PROP_CHANNEL := 43
	Static CAP_PROP_AUTO_WB := 44
	Static CAP_PROP_WB_TEMPERATURE := 45
	Static CAP_PROP_CODEC_PIXEL_FORMAT := 46
	Static CAP_PROP_BITRATE := 47
	Static CAP_PROP_ORIENTATION_META := 48
	Static CAP_PROP_ORIENTATION_AUTO := 49
	Static CAP_PROP_HW_ACCELERATION := 50
	Static CAP_PROP_HW_DEVICE := 51
	Static CAP_PROP_HW_ACCELERATION_USE_OPENCL := 52
	Static CAP_PROP_OPEN_TIMEOUT_MSEC := 53
	Static CAP_PROP_READ_TIMEOUT_MSEC := 54
	Static CAP_PROP_STREAM_OPEN_TIME_USEC := 55
	Static CAP_PROP_VIDEO_TOTAL_CHANNELS := 56
	Static CAP_PROP_VIDEO_STREAM := 57
	Static CAP_PROP_AUDIO_STREAM := 58
	Static CAP_PROP_AUDIO_POS := 59
	Static CAP_PROP_AUDIO_SHIFT_NSEC := 60
	Static CAP_PROP_AUDIO_DATA_DEPTH := 61
	Static CAP_PROP_AUDIO_SAMPLES_PER_SECOND := 62
	Static CAP_PROP_AUDIO_BASE_INDEX := 63
	Static CAP_PROP_AUDIO_TOTAL_CHANNELS := 64
	Static CAP_PROP_AUDIO_TOTAL_STREAMS := 65
	Static CAP_PROP_AUDIO_SYNCHRONIZE := 66
	Static CAP_PROP_LRF_HAS_KEY_FRAME := 67
	Static CAP_PROP_CODEC_EXTRADATA_INDEX := 68

	; VideoWriterProperties
	Static VIDEOWRITER_PROP_QUALITY := 1
	Static VIDEOWRITER_PROP_FRAMEBYTES := 2
	Static VIDEOWRITER_PROP_NSTRIPES := 3
	Static VIDEOWRITER_PROP_IS_COLOR := 4
	Static VIDEOWRITER_PROP_DEPTH := 5
	Static VIDEOWRITER_PROP_HW_ACCELERATION := 6
	Static VIDEOWRITER_PROP_HW_DEVICE := 7
	Static VIDEOWRITER_PROP_HW_ACCELERATION_USE_OPENCL := 8

	; VideoAccelerationType
	Static VIDEO_ACCELERATION_NONE := 0
	Static VIDEO_ACCELERATION_ANY := 1
	Static VIDEO_ACCELERATION_D3D11 := 2
	Static VIDEO_ACCELERATION_VAAPI := 3
	Static VIDEO_ACCELERATION_MFX := 4

	; SolvePnPMethod
	Static SOLVEPNP_ITERATIVE := 0
	Static SOLVEPNP_EPNP := 1
	Static SOLVEPNP_P3P := 2
	Static SOLVEPNP_DLS := 3
	Static SOLVEPNP_UPNP := 4
	Static SOLVEPNP_AP3P := 5
	Static SOLVEPNP_IPPE := 6
	Static SOLVEPNP_IPPE_SQUARE := 7
	Static SOLVEPNP_SQPNP := 8
	Static SOLVEPNP_MAX_COUNT := 8 + 1

	; HandEyeCalibrationMethod
	Static CALIB_HAND_EYE_TSAI := 0
	Static CALIB_HAND_EYE_PARK := 1
	Static CALIB_HAND_EYE_HORAUD := 2
	Static CALIB_HAND_EYE_ANDREFF := 3
	Static CALIB_HAND_EYE_DANIILIDIS := 4

	; RobotWorldHandEyeCalibrationMethod
	Static CALIB_ROBOT_WORLD_HAND_EYE_SHAH := 0
	Static CALIB_ROBOT_WORLD_HAND_EYE_LI := 1

	; SamplingMethod
	Static SAMPLING_UNIFORM := 0
	Static SAMPLING_PROGRESSIVE_NAPSAC := 1
	Static SAMPLING_NAPSAC := 2
	Static SAMPLING_PROSAC := 3

	; LocalOptimMethod
	Static LOCAL_OPTIM_NULL := 0
	Static LOCAL_OPTIM_INNER_LO := 1
	Static LOCAL_OPTIM_INNER_AND_ITER_LO := 2
	Static LOCAL_OPTIM_GC := 3
	Static LOCAL_OPTIM_SIGMA := 4

	; ScoreMethod
	Static SCORE_METHOD_RANSAC := 0
	Static SCORE_METHOD_MSAC := 1
	Static SCORE_METHOD_MAGSAC := 2
	Static SCORE_METHOD_LMEDS := 3

	; NeighborSearchMethod
	Static NEIGH_FLANN_KNN := 0
	Static NEIGH_GRID := 1
	Static NEIGH_FLANN_RADIUS := 2

	; GridType
	Static CIRCLES_GRID_FINDER_PARAMETERS_SYMMETRIC_GRID := 0
	Static CIRCLES_GRID_FINDER_PARAMETERS_ASYMMETRIC_GRID := 1

	; anonymous
	Static STEREO_MATCHER_DISP_SHIFT := 4
	Static STEREO_MATCHER_DISP_SCALE := (BitShift(1, -OpenCV.STEREO_MATCHER_DISP_SHIFT))

	; anonymous
	Static STEREO_BM_PREFILTER_NORMALIZED_RESPONSE := 0
	Static STEREO_BM_PREFILTER_XSOBEL := 1

	; anonymous
	Static STEREO_SGBM_MODE_SGBM := 0
	Static STEREO_SGBM_MODE_HH := 1
	Static STEREO_SGBM_MODE_SGBM_3WAY := 2
	Static STEREO_SGBM_MODE_HH4 := 3

	; UndistortTypes
	Static PROJ_SPHERICAL_ORTHO := 0
	Static PROJ_SPHERICAL_EQRECT := 1

	; anonymous
	Static FISHEYE_CALIB_USE_INTRINSIC_GUESS := BitShift(1, -0)
	Static FISHEYE_CALIB_RECOMPUTE_EXTRINSIC := BitShift(1, -1)
	Static FISHEYE_CALIB_CHECK_COND := BitShift(1, -2)
	Static FISHEYE_CALIB_FIX_SKEW := BitShift(1, -3)
	Static FISHEYE_CALIB_FIX_K1 := BitShift(1, -4)
	Static FISHEYE_CALIB_FIX_K2 := BitShift(1, -5)
	Static FISHEYE_CALIB_FIX_K3 := BitShift(1, -6)
	Static FISHEYE_CALIB_FIX_K4 := BitShift(1, -7)
	Static FISHEYE_CALIB_FIX_INTRINSIC := BitShift(1, -8)
	Static FISHEYE_CALIB_FIX_PRINCIPAL_POINT := BitShift(1, -9)
	Static FISHEYE_CALIB_ZERO_DISPARITY := BitShift(1, -10)
	Static FISHEYE_CALIB_FIX_FOCAL_LENGTH := BitShift(1, -11)

	; WindowFlags
	Static WINDOW_NORMAL := 0x00000000
	Static WINDOW_AUTOSIZE := 0x00000001
	Static WINDOW_OPENGL := 0x00001000
	Static WINDOW_FULLSCREEN := 1
	Static WINDOW_FREERATIO := 0x00000100
	Static WINDOW_KEEPRATIO := 0x00000000
	Static WINDOW_GUI_EXPANDED := 0x00000000
	Static WINDOW_GUI_NORMAL := 0x00000010

	; WindowPropertyFlags
	Static WND_PROP_FULLSCREEN := 0
	Static WND_PROP_AUTOSIZE := 1
	Static WND_PROP_ASPECT_RATIO := 2
	Static WND_PROP_OPENGL := 3
	Static WND_PROP_VISIBLE := 4
	Static WND_PROP_TOPMOST := 5
	Static WND_PROP_VSYNC := 6

	; MouseEventTypes
	Static EVENT_MOUSEMOVE := 0
	Static EVENT_LBUTTONDOWN := 1
	Static EVENT_RBUTTONDOWN := 2
	Static EVENT_MBUTTONDOWN := 3
	Static EVENT_LBUTTONUP := 4
	Static EVENT_RBUTTONUP := 5
	Static EVENT_MBUTTONUP := 6
	Static EVENT_LBUTTONDBLCLK := 7
	Static EVENT_RBUTTONDBLCLK := 8
	Static EVENT_MBUTTONDBLCLK := 9
	Static EVENT_MOUSEWHEEL := 10
	Static EVENT_MOUSEHWHEEL := 11

	; MouseEventFlags
	Static EVENT_FLAG_LBUTTON := 1
	Static EVENT_FLAG_RBUTTON := 2
	Static EVENT_FLAG_MBUTTON := 4
	Static EVENT_FLAG_CTRLKEY := 8
	Static EVENT_FLAG_SHIFTKEY := 16
	Static EVENT_FLAG_ALTKEY := 32

	; QtFontWeights
	Static QT_FONT_LIGHT := 25
	Static QT_FONT_NORMAL := 50
	Static QT_FONT_DEMIBOLD := 63
	Static QT_FONT_BOLD := 75
	Static QT_FONT_BLACK := 87

	; QtFontStyles
	Static QT_STYLE_NORMAL := 0
	Static QT_STYLE_ITALIC := 1
	Static QT_STYLE_OBLIQUE := 2

	; QtButtonTypes
	Static QT_PUSH_BUTTON := 0
	Static QT_CHECKBOX := 1
	Static QT_RADIOBOX := 2
	Static QT_NEW_BUTTONBAR := 1024

	; HistogramNormType
	Static HOGDESCRIPTOR_L2Hys := 0

	; anonymous
	Static HOGDESCRIPTOR_DEFAULT_NLEVELS := 64

	; DescriptorStorageFormat
	Static HOGDESCRIPTOR_DESCR_FORMAT_COL_BY_COL := 0
	Static HOGDESCRIPTOR_DESCR_FORMAT_ROW_BY_ROW := 1

	; EncodeMode
	Static QRCODE_ENCODER_MODE_AUTO := -1
	Static QRCODE_ENCODER_MODE_NUMERIC := 1
	Static QRCODE_ENCODER_MODE_ALPHANUMERIC := 2
	Static QRCODE_ENCODER_MODE_BYTE := 4
	Static QRCODE_ENCODER_MODE_ECI := 7
	Static QRCODE_ENCODER_MODE_KANJI := 8
	Static QRCODE_ENCODER_MODE_STRUCTURED_APPEND := 3

	; CorrectionLevel
	Static QRCODE_ENCODER_CORRECT_LEVEL_L := 0
	Static QRCODE_ENCODER_CORRECT_LEVEL_M := 1
	Static QRCODE_ENCODER_CORRECT_LEVEL_Q := 2
	Static QRCODE_ENCODER_CORRECT_LEVEL_H := 3

	; ECIEncodings
	Static QRCODE_ENCODER_ECI_UTF8 := 26

	; DisType
	Static FACE_RECOGNIZER_SF_FR_COSINE := 0
	Static FACE_RECOGNIZER_SF_FR_NORM_L2 := 1

	; Status
	Static STITCHER_OK := 0
	Static STITCHER_ERR_NEED_MORE_IMGS := 1
	Static STITCHER_ERR_HOMOGRAPHY_EST_FAIL := 2
	Static STITCHER_ERR_CAMERA_PARAMS_ADJUST_FAIL := 3

	; Mode
	Static STITCHER_PANORAMA := 0
	Static STITCHER_SCANS := 1

	; anonymous
	Static DETAIL_BLENDER_NO := 0
	Static DETAIL_BLENDER_FEATHER := 1
	Static DETAIL_BLENDER_MULTI_BAND := 2

	; anonymous
	Static DETAIL_EXPOSURE_COMPENSATOR_NO := 0
	Static DETAIL_EXPOSURE_COMPENSATOR_GAIN := 1
	Static DETAIL_EXPOSURE_COMPENSATOR_GAIN_BLOCKS := 2
	Static DETAIL_EXPOSURE_COMPENSATOR_CHANNELS := 3
	Static DETAIL_EXPOSURE_COMPENSATOR_CHANNELS_BLOCKS := 4

	; WaveCorrectKind
	Static DETAIL_WAVE_CORRECT_HORIZ := 0
	Static DETAIL_WAVE_CORRECT_VERT := 1
	Static DETAIL_WAVE_CORRECT_AUTO := 2

	; anonymous
	Static DETAIL_SEAM_FINDER_NO := 0
	Static DETAIL_SEAM_FINDER_VORONOI_SEAM := 1
	Static DETAIL_SEAM_FINDER_DP_SEAM := 2

	; CostFunction
	Static DETAIL_DP_SEAM_FINDER_COLOR := 0
	Static DETAIL_DP_SEAM_FINDER_COLOR_GRAD := 1

	; CostType
	Static DETAIL_GRAPH_CUT_SEAM_FINDER_BASE_COST_COLOR := 0
	Static DETAIL_GRAPH_CUT_SEAM_FINDER_BASE_COST_COLOR_GRAD := 1

	; anonymous
	Static DETAIL_TIMELAPSER_AS_IS := 0
	Static DETAIL_TIMELAPSER_CROP := 1

	; anonymous
	Static DISOPTICAL_FLOW_PRESET_ULTRAFAST := 0
	Static DISOPTICAL_FLOW_PRESET_FAST := 1
	Static DISOPTICAL_FLOW_PRESET_MEDIUM := 2

	; MODE
	Static DETAIL_TRACKER_SAMPLER_CSC_MODE_INIT_POS := 1
	Static DETAIL_TRACKER_SAMPLER_CSC_MODE_INIT_NEG := 2
	Static DETAIL_TRACKER_SAMPLER_CSC_MODE_TRACK_POS := 3
	Static DETAIL_TRACKER_SAMPLER_CSC_MODE_TRACK_NEG := 4
	Static DETAIL_TRACKER_SAMPLER_CSC_MODE_DETECT := 5

	; Kind
	Static GFLUID_KERNEL_KIND_Filter := 0
	Static GFLUID_KERNEL_KIND_Resize := 1
	Static GFLUID_KERNEL_KIND_YUV420toRGB := 2

	; OpaqueKind
	Static DETAIL_OPAQUE_KIND_UNKNOWN := 0
	Static DETAIL_OPAQUE_KIND_BOOL := 1
	Static DETAIL_OPAQUE_KIND_INT := 2
	Static DETAIL_OPAQUE_KIND_INT64 := 3
	Static DETAIL_OPAQUE_KIND_DOUBLE := 4
	Static DETAIL_OPAQUE_KIND_FLOAT := 5
	Static DETAIL_OPAQUE_KIND_UINT64 := 6
	Static DETAIL_OPAQUE_KIND_STRING := 7
	Static DETAIL_OPAQUE_KIND_POINT := 8
	Static DETAIL_OPAQUE_KIND_POINT2F := 9
	Static DETAIL_OPAQUE_KIND_SIZE := 10
	Static DETAIL_OPAQUE_KIND_RECT := 11
	Static DETAIL_OPAQUE_KIND_SCALAR := 12
	Static DETAIL_OPAQUE_KIND_MAT := 13
	Static DETAIL_OPAQUE_KIND_DRAW_PRIM := 14

	; GShape
	Static GSHAPE_GMAT := 0
	Static GSHAPE_GSCALAR := 1
	Static GSHAPE_GARRAY := 2
	Static GSHAPE_GOPAQUE := 3
	Static GSHAPE_GFRAME := 4

	; MediaFormat
	Static MEDIA_FORMAT_BGR := 0
	Static MEDIA_FORMAT_NV12 := 0 + 1

	; ArgKind
	Static DETAIL_ARG_KIND_OPAQUE_VAL := 0
	Static DETAIL_ARG_KIND_OPAQUE := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL
	Static DETAIL_ARG_KIND_GOBJREF := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 1
	Static DETAIL_ARG_KIND_GMAT := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 2
	Static DETAIL_ARG_KIND_GMATP := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 3
	Static DETAIL_ARG_KIND_GFRAME := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 4
	Static DETAIL_ARG_KIND_GSCALAR := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 5
	Static DETAIL_ARG_KIND_GARRAY := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 6
	Static DETAIL_ARG_KIND_GOPAQUE := OpenCV.DETAIL_ARG_KIND_OPAQUE_VAL + 7

	; TraitAs
	Static GAPI_IE_TRAIT_AS_TENSOR := 0
	Static GAPI_IE_TRAIT_AS_IMAGE := 1

	; Kind
	Static GAPI_IE_DETAIL_PARAM_DESC_KIND_Load := 0
	Static GAPI_IE_DETAIL_PARAM_DESC_KIND_Import := 1

	; TraitAs
	Static GAPI_ONNX_TRAIT_AS_TENSOR := 0
	Static GAPI_ONNX_TRAIT_AS_IMAGE := 1

	; Access
	Static MEDIA_FRAME_ACCESS_R := 0
	Static MEDIA_FRAME_ACCESS_W := 1

	; anonymous
	Static GAPI_OWN_DETAIL_MAT_HEADER_AUTO_STEP := 0
	Static GAPI_OWN_DETAIL_MAT_HEADER_TYPE_MASK := 0x00000FFF

	; Access
	Static RMAT_ACCESS_R := 0
	Static RMAT_ACCESS_W := 1

	; StereoOutputFormat
	Static GAPI_STEREO_OUTPUT_FORMAT_DEPTH_FLOAT16 := 0
	Static GAPI_STEREO_OUTPUT_FORMAT_DEPTH_FLOAT32 := 1
	Static GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_FIXED16_11_5 := 2
	Static GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_FIXED16_12_4 := 3
	Static GAPI_STEREO_OUTPUT_FORMAT_DEPTH_16F := OpenCV.GAPI_STEREO_OUTPUT_FORMAT_DEPTH_FLOAT16
	Static GAPI_STEREO_OUTPUT_FORMAT_DEPTH_32F := OpenCV.GAPI_STEREO_OUTPUT_FORMAT_DEPTH_FLOAT32
	Static GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_16Q_10_5 := OpenCV.GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_FIXED16_11_5
	Static GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_16Q_11_4 := OpenCV.GAPI_STEREO_OUTPUT_FORMAT_DISPARITY_FIXED16_12_4

	; OutputType
	Static GAPI_WIP_GST_GSTREAMER_SOURCE_OUTPUT_TYPE_FRAME := 0
	Static GAPI_WIP_GST_GSTREAMER_SOURCE_OUTPUT_TYPE_MAT := 1

	; AccelType
	Static GAPI_WIP_ONEVPL_ACCEL_TYPE_HOST := 0
	Static GAPI_WIP_ONEVPL_ACCEL_TYPE_DX11 := 1
	Static GAPI_WIP_ONEVPL_ACCEL_TYPE_LAST_VALUE := 0xFF

	; sync_policy
	Static GAPI_STREAMING_SYNC_POLICY_dont_sync := 0
	Static GAPI_STREAMING_SYNC_POLICY_drop := 1

	; BackgroundSubtractorType
	Static GAPI_VIDEO_TYPE_BS_MOG2 := 0
	Static GAPI_VIDEO_TYPE_BS_KNN := 1

	; flann_algorithm_t
	Static FLANN_FLANN_INDEX_LINEAR := 0
	Static FLANN_FLANN_INDEX_KDTREE := 1
	Static FLANN_FLANN_INDEX_KMEANS := 2
	Static FLANN_FLANN_INDEX_COMPOSITE := 3
	Static FLANN_FLANN_INDEX_KDTREE_SINGLE := 4
	Static FLANN_FLANN_INDEX_HIERARCHICAL := 5
	Static FLANN_FLANN_INDEX_LSH := 6
	Static FLANN_FLANN_INDEX_SAVED := 254
	Static FLANN_FLANN_INDEX_AUTOTUNED := 255
	Static FLANN_LINEAR := 0
	Static FLANN_KDTREE := 1
	Static FLANN_KMEANS := 2
	Static FLANN_COMPOSITE := 3
	Static FLANN_KDTREE_SINGLE := 4
	Static FLANN_SAVED := 254
	Static FLANN_AUTOTUNED := 255

	; flann_centers_Init_t
	Static FLANN_FLANN_CENTERS_RANDOM := 0
	Static FLANN_FLANN_CENTERS_GONZALES := 1
	Static FLANN_FLANN_CENTERS_KMEANSPP := 2
	Static FLANN_FLANN_CENTERS_GROUPWISE := 3
	Static FLANN_CENTERS_RANDOM := 0
	Static FLANN_CENTERS_GONZALES := 1
	Static FLANN_CENTERS_KMEANSPP := 2

	; flann_log_level_t
	Static FLANN_FLANN_LOG_NONE := 0
	Static FLANN_FLANN_LOG_FATAL := 1
	Static FLANN_FLANN_LOG_ERROR := 2
	Static FLANN_FLANN_LOG_WARN := 3
	Static FLANN_FLANN_LOG_INFO := 4

	; flann_distance_t
	Static FLANN_FLANN_DIST_EUCLIDEAN := 1
	Static FLANN_FLANN_DIST_L2 := 1
	Static FLANN_FLANN_DIST_MANHATTAN := 2
	Static FLANN_FLANN_DIST_L1 := 2
	Static FLANN_FLANN_DIST_MINKOWSKI := 3
	Static FLANN_FLANN_DIST_MAX := 4
	Static FLANN_FLANN_DIST_HIST_INTERSECT := 5
	Static FLANN_FLANN_DIST_HELLINGER := 6
	Static FLANN_FLANN_DIST_CHI_SQUARE := 7
	Static FLANN_FLANN_DIST_CS := 7
	Static FLANN_FLANN_DIST_KULLBACK_LEIBLER := 8
	Static FLANN_FLANN_DIST_KL := 8
	Static FLANN_FLANN_DIST_HAMMING := 9
	Static FLANN_FLANN_DIST_DNAMMING := 10
	Static FLANN_EUCLIDEAN := 1
	Static FLANN_MANHATTAN := 2
	Static FLANN_MINKOWSKI := 3
	Static FLANN_MAX_DIST := 4
	Static FLANN_HIST_INTERSECT := 5
	Static FLANN_HELLINGER := 6
	Static FLANN_CS := 7
	Static FLANN_KL := 8
	Static FLANN_KULLBACK_LEIBLER := 8

	; flann_datatype_t
	Static FLANN_FLANN_INT8 := 0
	Static FLANN_FLANN_INT16 := 1
	Static FLANN_FLANN_INT32 := 2
	Static FLANN_FLANN_INT64 := 3
	Static FLANN_FLANN_UINT8 := 4
	Static FLANN_FLANN_UINT16 := 5
	Static FLANN_FLANN_UINT32 := 6
	Static FLANN_FLANN_UINT64 := 7
	Static FLANN_FLANN_FLOAT32 := 8
	Static FLANN_FLANN_FLOAT64 := 9

	; anonymous
	Static FLANN_FLANN_CHECKS_UNLIMITED := -1
	Static FLANN_FLANN_CHECKS_AUTOTUNED := -2
    
    Static AFFINEFEATURE_Init()
    {
        AffineFeature := ComObject("OpenCV.CV.AFFINEFEATURE")
        
        Return AffineFeature
    }
    
    Static AGASTFEATUREDETECTOR_Init()
    {
        AgastFeatureDetector := ComObject("OpenCV.CV.AGASTFEATUREDETECTOR")
        
        Return AgastFeatureDetector
    }
    
    Static ALGORITHM_Init()
    {
        Algorithm := ComObject("OpenCV.CV.ALGORITHM")
        
        Return Algorithm
    }
    
    Static BFMATCHER_Init()
    {
        BFMatcher := ComObject("OpenCV.CV.BFMATCHER")
        
        Return BFMatcher
    }
    
    Static BOWIMGDESCRIPTOREXTRACTOR_Init()
    {
        BOWImgDescriptorExtractor := ComObject("OpenCV.CV.BOWIMGDESCRIPTOREXTRACTOR")
        
        Return BOWImgDescriptorExtractor
    }
    
    Static BRISK_Init()
    {
        Brisk := ComObject("OpenCV.CV.BRISK")
        
        Return Brisk
    }
    
    Static CASCADECLASSIFIER_Init()
    {
        CascadeClassifier := ComObject("OpenCV.CV.CASCADECLASSIFIER")
        
        Return CascadeClassifier
    }
    
    Static Crop(Img, Pos)
    {
        CV := OpenCV.CV_Init()
        Mat := OpenCV.MAT_Init()
        
        Img := Mat.Create(Img, Pos)
        
        Return Img
    }
    
    Static CUDA_Init()
    {
        Cuda := ComObject("OpenCV.CV.CUDA")
        
        Return Cuda
    }
    
    Static CUDABUFFERPOOL_Init()
    {
        CudaBufferPool := ComObject("OpenCV.CV.CUDA.BUFFERPOOL")
        
        Return CudaBufferPool
    }
    
    Static CUDAGPUMAT_Init()
    {
        CudaGpuMat := ComObject("OpenCV.CV.CUDA.GPUMAT")
        
        Return CudaGpuMat
    }
    
    Static CUDAGPUMATND_Init()
    {
        CudaGpuMatND := ComObject("OpenCV.CV.CUDA.GPUMATND")
        
        Return CudaGpuMatND
    }
    
    Static CUDAHOSTMEM_Init()
    {
        CudaHostMem := ComObject("OpenCV.CV.CUDA.CUDAHOSTMEM")
        
        Return CudaHostMem
    }
    
    Static CUDATARGETARCHS_Init()
    {
        CudaTargetArchs := ComObject("OpenCV.CV.CUDA.TARGETARCHS")
        
        Return CudaTargetArchs
    }
    
    Static CV_Init()
    {
        CV := ComObject("OpenCV.CV")
        
        Return CV
    }
    
    Static DESCRIPTORMATCHER_Init()
    {
        Matcher := ComObject("OpenCV.CV.DESCRIPTORMATCHER")
        
        Return Matcher
    }
    
    Static DMATCH_Init()
    {
        DMatch := ComObject("OpenCV.CV.DMATCH")
        
        Return DMatch
    }
    
    Static DNN_Init()
    {
        Dnn := ComObject("OpenCV.CV.DNN")
        
        Return Dnn
    }
    
    Static FASTFEATUREDETECTOR_Init()
    {
        Fast := ComObject("OpenCV.CV.FASTFEATUREDETECTOR")
        
        Return Fast
    }
    
    Static FILESTORAGE_Init()
    {
        FS := ComObject("OpenCV.CV.FILESTORAGE")
        
        Return FS
    }
    
    Static FLANN_Init()
    {
        Flann := ComObject("OpenCV.CV.FLANN")
        
        Return Flann
    }
    
    Static FLANNBASEDMATCHER_Init()
    {
        FlannBasedMatcher := ComObject("OpenCV.CV.FLANNBASEDMATCHER")
        
        Return FlannBasedMatcher
    }
    
    Static FORMATTER_Init()
    {
        Formatter := ComObject("OpenCV.CV.FORMATTER")
        
        Return Formatter
    }
    
    Static GENERALIZEDHOUGHGUIL_Init()
    {
        GeneralizedHoughGuil := ComObject("OpenCV.CV.GENERALIZEDHOUGHGUIL")
        
        Return GeneralizedHoughGuil
    }
    
    Static GFTTDETECTOR_Init()
    {
        GFTTDetector := ComObject("OpenCV.CV.GFTTDETECTOR")
        
        Return GFTTDetector
    }
    
    Static LINESEGMENTDETECTOR_Init()
    {
        LineSegmentDetector := ComObject("OpenCV.CV.LINESEGMENTDETECTOR")
        
        Return LineSegmentDetector
    }
    
    Static KAZE_Init()
    {
        Kaze := ComObject("OpenCV.CV.KAZE")
        
        Return Kaze
    }
    
    Static KEYPOINT_Init()
    {
        KeyPoint := ComObject("OpenCV.CV.KEYPOINT")
        
        Return KeyPoint
    }
    
    Static MAT_Init()
    {
        Frame := ComObject("OpenCV.CV.MAT")
        
        Return Frame
    }
    
    Static ML_Init()
    {
        Ml := ComObject("OpenCV.CV.ML")
        
        Return Ml
    }
    
    Static MLKNEAREST_Init()
    {
        Knn := ComObject("OpenCV.CV.ML.KNEAREST")
        
        Return Knn
    }
    
    Static MLTRAINDATA_Init()
    {
        TrainData := ComObject("OpenCV.CV.ML.TrainData")
        
        Return TrainData
    }
    
    Static OCL_Init()
    {
        Ocl := ComObject("OpenCV.CV.OCL")
        
        Return Ocl
    }
    
    Static OCLDEVICE_Init()
    {
        OclDevice := ComObject("OpenCV.CV.OCL.DEVICE")
        
        Return OclDevice
    }
    
    Static OCLKERNELARG_Init()
    {
        OclKernelArg := ComObject("OpenCV.CV.OCL.KERNELARG")
        
        Return OclKernelArg
    }
    
    Static OCLOPENCLEXECUTIONCONTEXT_Init()
    {
        OCLOpenCLExecutionContext := ComObject("OpenCV.CV.OCL.OPENCLEXECUTIONCONTEXT")
        
        Return OCLOpenCLExecutionContext
    }
    
    Static ORB_Init()
    {
        Orb := ComObject("OpenCV.CV.ORB")
        
        Return Orb
    }
    
    Static PCA_Init()
    {
        Pca := ComObject("OpenCV.CV.PCA")
        
        Return Pca
    }
    
    Static QRCODEDETECTOR_Init()
    {
        QRCodeDetector := ComObject("OpenCV.CV.QRCODEDETECTOR")
        
        Return QRCodeDetector
    }
    
    Static RANGE_Init()
    {
        Range := ComObject("OpenCV.CV.RANGE")
        
        Return Range
    }
    
    Static Resize(Img, Width := -1, Height := -1)
    {
        OpenCV.init()
        CV := OpenCV.init()
        
        if Width == -1
            Sizew := 1
        
        else
            Sizew := Width / Img.Cols()
        
        if Height == -1
            Sizeh := 1
        
        else
            Sizeh := Height / Img.Rows()
        
        Resized := CV.resize(Img, ComArrayMake([]), Sizew, Sizeh)
        
        Return Resized
    }
    
    Static RNG_Init()
    {
        Rng := ComObject("OpenCV.CV.RNG")
        
        Return Rng
    }
    
    Static ROTATEDRECT_Init()
    {
        RotatedRect := ComObject("OpenCV.CV.ROTATEDRECT")
        
        Return RotatedRect
    }
    
    Static SIFT_Init()
    {
        Sift := ComObject("OpenCV.CV.SIFT")
        
        Return Sift
    }
    
    Static SIMPLEBLOBDETECTOR_Init()
    {
        SimpleBlobDetector := ComObject("OpenCV.CV.SIMPLEBLOBDETECTOR")
        
        Return SimpleBlobDetector
    }
    
    Static SIMPLEBLOBDETECTOR_PARAMS_Init()
    {
        SimpleBlobDetector_Params := ComObject("OpenCV.CV.SIMPLEBLOBDETECTOR.PARAMS")
        
        Return SimpleBlobDetector_Params
    }
    
    Static SPARSEMAT_Init()
    {
        SparseMat := ComObject("OpenCV.CV.SPARSEMAT")
        
        Return SparseMat
    }
    
    Static STATMODEL_Init()
    {
        StatModel := ComObject("OpenCV.CV.ML.STATMODEL")
        
        Return StatModel
    }
    
    Static STEREOBM_Init()
    {
        StereoBM := ComObject("OpenCV.CV.STEREOBM")
        
        Return StereoBM
    }
    
    Static SUBDIV2D_Init()
    {
        Subdiv2D := ComObject("OpenCV.CV.SUBDIV2D")
        
        Return Subdiv2D
    }
    
    Static SVD_Init()
    {
        Svd := ComObject("OpenCV.CV.ML.SVD")
        
        Return Svd
    }
    
    Static SVM_Init()
    {
        Svm := ComObject("OpenCV.CV.ML.SVM")
        
        Return Svm
    }
    
    Static TermCriteria(type, maxCount, epsilon)
    {
        criteria := ComObject("OpenCV.CV.TERMCRITERIA")
        criteria.type := type
        criteria.maxCount := maxCount
        criteria.epsilon := epsilon
        
        Return criteria
    }
    
    Static TERMCRITERIA_Init()
    {
        criteria := ComObject("OpenCV.CV.TERMCRITERIA")
        
        Return criteria
    }
    
    Static TICKMETER_Init()
    {
        TickMeter := ComObject("OpenCV.CV.TICKMETER")
        
        Return TickMeter
    }
    
    Static UMAT_Init()
    {
        UMat := ComObject("OpenCV.CV.UMAT")
        
        Return UMat
    }
    
    Static UMATDATA_Init()
    {
        UMatData := ComObject("OpenCV.CV.UMATDATA")
        
        Return UMatData
    }
    
    Static VECTOROFPOINT_Init()
    {
        pts := ComObject("OpenCV.VECTOROFPOINT")
        
        Return pts
    }
    
    Static VIDEOCAPTURE_Init()
    {
        Cap := ComObject("OpenCV.CV.VIDEOCAPTURE")
        
        Return Cap
    }
    
    Static VIDEOWRITER_Init()
    {
        Out := ComObject("OpenCV.CV.VIDEOWRITER")
        
        Return Out
    }
    
    Static VIDEOWRITER_Fourcc_Init(Lst_Codec*)
    {
        Out := ComObject("OpenCV.CV.VIDEOWRITER")
        
        if Lst_Codec.Length !== 4
            Return 0
            
        else
        {
            Codec := Out.fourcc(Ord(Lst_Codec[1]), Ord(Lst_Codec[2]), Ord(Lst_Codec[3]), Ord(Lst_Codec[4]))
            
            Return Codec
        }
    }
}

BitAND(value1, value2)
{
    Return value1 & value2
}

BitNOT(Value)
{
	Return ~Value
}

BitOR(Value1, Value2)
{
    Return Value1 | Value2
}

BitShift(Value, Shift)
{
    Return Shift < 0 ? Value << -Shift : Value >> Shift
}

BitXOR(Value1, Value2)
{
    Return Value1 ^ Value2
}

ComArrayMake(InputArray)
{
    if Type(InputArray) == "ComObjArray"
        Return InputArray
    
    if Type(InputArray) == "Array"
    {
        Arr := ComObjArray(VT_VARIANT := 12, InputArray.Length)
        
        Loop InputArray.Length
        {
            if Type(InputArray[A_Index]) == "Array"
                Arr[A_Index - 1] := ComArrayMake(InputArray[A_Index])
                
            else
                Arr[A_Index - 1] := InputArray[A_Index]
        }
    }
    else
        Arr := InputArray
    
    Return Arr
}

OpencvAHK_Char(Char)
{
   Return Ord(Char)
}

OpencvAHK_Bool(InputBool)
{
    ComValue(0XB, InputBool == True ? -1 : 0)
}

OpencvAHK_ConstPointConst(InputArray)
{
    pts := CV2.VectorOfpoint_Init()
    
    Loop InputArray.Length()
    {
        pts.Push_Back(ComArrayMake(InputArray[A_Index]))
    }
    
    Return pts
}

OpencvAHK_ConstScalar(InputArray)
{
    Return ComArrayMake(InputArray) 
}

OpencvAHK_Double(Number)
{
    NumPut("Double", fps := Number, Temp := Buffer(8))
    Return fps := NumGet(Temp, "Double")
}

OpencvAHK_Point(InputArray)
{
    Return ComArrayMake(InputArray) 
}

OpencvAHK_OutputArray()
{
    Return CV2.MAT_Init()
}

OpencvAHK_Size(InputArray)
{
    Return ComArrayMake(InputArray) 
}

Class CV2 Extends OpenCV
{
    Static CV := OpenCV.CV_Init()
    
    Static None := None()
    
    Static Absdiff(src1, src2)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Absdiff(src1.MAT, src2.MAT))
        
        Return dst
    }
    
    Static AdaptiveThreshold(src, maxValue, adaptiveMethod := CV2.CV_ADAPTIVE_THRESH_MEAN_C, thresholdType := CV2.CV_THRESH_BINARY, blockSize := 3, param1 := 5)
    {
        dst := this.MAT()
        
        if Mod(blockSize, 2) == 0
            blockSize += 1
            
        if (src.channels() == 3)
            src := cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
        
        tomat(dst, this.CV.AdaptiveThreshold(src.MAT, maxValue, adaptiveMethod, thresholdType, blockSize, param1))
        
        Return dst
    }
    
    Static Add(src1, src2)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Add(src1.MAT, src2.MAT))
        
        Return dst
    }
    
    Static AddWeighted(src1, alpha, src2, beta, gamma)
    {
        dst := this.MAT()
        tomat(dst, this.CV.AddWeighted(src1.MAT, alpha, src2.MAT, beta, gamma))
        
        Return dst
    }
    
    Static AdjustGamma(src, gamma := 1)
    {
        invGamma := 1 / gamma
        table := CV2.MAT(1, 256, CV2.CV_8U)
        
        Loop 256
        {
            table.At[0, A_Index - 1] := (((A_Index - 1) / 255.0) ** invGamma) * 255
        }
        
        Return CV2.LUT(src, table)
    }
    
    Static ApplyColorMap(src, colormap)
    {
        dst := this.MAT()
        tomat(dst, this.CV.ApplyColorMap(src.MAT, colormap))
        
        Return dst
    }
    
    Static BilateralFilter(src, d, sigmaColor, sigmaSpace, borderType := CV2.BORDER_DEFAULT)
    {
        dst := this.MAT()
        tomat(dst, this.CV.BilateralFilter(src.MAT, d, sigmaColor, sigmaSpace, borderType))
        
        Return dst
    }
    
    Static Bitwise_And(src1, src2, dst, mask := noArray())
    {
        this.CV.Bitwise_And(src1.MAT, src2.MAT, mask.MAT, dst.MAT)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Bitwise_Not(src, dst, mask := noArray())
    {
        this.CV.Bitwise_Not(src.MAT, mask.MAT, dst.MAT)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Bitwise_Or(src1, src2, dst, mask := noArray())
    {
        this.CV.Bitwise_Or(src1.MAT, src2.MAT, mask.MAT, dst.MAT)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Bitwise_Xor(src1, src2, dst, mask := noArray())
    {
        this.CV.Bitwise_Xor(src1.MAT, src2.MAT, mask.MAT, dst.MAT)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Blur(src, ksize, anchor := [-1, -1], borderType := CV2.BORDER_DEFAULT)
    {
        ksize := ComArrayMake(ksize)
        anchor := ComArrayMake(anchor)
        dst := this.MAT()
        tomat(dst, this.CV.Blur(src.MAT, ksize, anchor, borderType))
        
        Return dst
    }
    
    Static CascadeClassifier(addr := "")
    {
        faceCascade := this.Classifier()
        
        if !addr
            faceCascade.Classifier := CV2.CascadeClassifier_Init()
        
        else
        {
            faceCascade.Classifier := CV2.CascadeClassifier_Init()
            faceCascade.Classifier.load(addr)
        }
        
        Return faceCascade
    }
    
    Static Canny(image, threshold1, threshold2, apertureSize := 3, L2gradient := False)
    {
        threshold1 := (threshold1 is Array) ? threshold1[1] : threshold1
        threshold2 := (threshold2 is Array) ? threshold2[1] : threshold2
        
        L2gradient := OpencvAHK_Bool(L2gradient)
        edges := noArray()
        this.CV.Canny(image.MAT, threshold1, threshold2, edges.MAT, apertureSize)
        tomat(edges, edges.MAT)
        
        Return edges
    }
    
    Static Circle(img, center, radius, color, thickness := 1, lineType := CV2.LINE_8, shift := 0)
    {
        center := ComArrayMake(center)
        color := ComArrayMake(color)
        this.CV.Circle(img.MAT, center, radius, color, thickness, lineType, shift)
        
        Return img
    }
    
    Static Close(binaryImage, ksize, kernelMode)
    {
        element := cv2.getStructuringElement(kernelMode, [ksize, ksize])
        dst := cv2.morphologyEx(binaryImage, 3, element)
        
        Return dst
    }
    
    Static ContourArea(contour, oriented := False)
    {
        oriented := OpencvAHK_Bool(oriented)
        
        Return this.CV.ContourArea(contour, oriented)
    }
    
    Static CopyMakeBorder(src, top, bottom, left, right, borderType, value := [])
    {
        value := ComArrayMake(value)
        dst := this.MAT()
        tomat(dst, this.CV.CopyMakeBorder(src.MAT, top, bottom, left, right, borderType, value))
        
        Return dst
    }
    
    Static CreateTrackbar(trackbarname, winname, value, count, onChange := 0)
    {
        if !onChange
            onChange := temp
        
        tmp := Buffer(8)
        tmpChange := CallbackCreate(onChange, "CDecl")
        DllCall("opencv_world455.dll\cvCreateTrackbar", "Astr", trackbarname, "Astr", winname, "ptr", tmp, "int", count, "ptr", tmpChange)
        
        temp(*)
        {
            Return
        }
    }
    
    Static CvtColor(src, code, dstCn := noArray())
    {
        dst := this.MAT()
        tomat(dst, this.CV.CvtColor(src.MAT, code, dstCn.MAT))
        
        Return dst
    }
    
    Static DestroyAllWindows()
    {
        this.CV.DestroyAllWindows()
    }
    
    Static DestroyWindow(wname)
    {
        if WinExist(wname)
            this.CV.DestroyWindow(wname)
    }
    
    Static Dft(src, flage := 0, nonzeroRow := 0)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Dft(src.MAT, flage, nonzeroRow))
        
        Return dst
    }
    
    Static Dilate(src, kernel, anchor := [-1, -1], iterations := 0, BorderTypes := CV2.BORDER_CONSTANT)
    {
        anchor := ComArrayMake(anchor)
        dst := this.MAT()
        tomat(dst, this.CV.Dilate(src.MAT, kernel.MAT, anchor, iterations, BorderTypes))
        
        Return dst
    }
    
    Static DistanceTransform(src, distanceType, maskSize, dstType := CV2.CV_32F)
    {
        dst := this.MAT()
        tomat(dst, this.CV.DistanceTransform(src.MAT, distanceType, maskSize, dstType))
        
        Return dst
    }
    
    Static Divide(src1, src2)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Divide(src1.MAT, src2.MAT))
        
        Return dst
    }
    
    Static DrawContours(image, contours, contourIdx, color, thickness := 1, lineType := 8, hierarchy := CV2.MAT())
    {
        contours := ComArrayMake(contours)
        color := ComArrayMake(color)
        this.CV.DrawContours(image.MAT, contours, contourIdx, color, thickness, lineType, hierarchy.MAT)
        
        Return image
    }
    
    Static DrawKeypoints(image, keypoints, outImage, color := [-1, -1, -1], flags := CV2.DRAW_MATCHES_FLAGS_DEFAULT)
    {
        color := ComArrayMake(color)
        this.CV.DrawKeypoints(image.MAT, keypoints, outImage.MAT, color, flags)
        tomat(outImage, outImage.MAT)
        
        Return outImage
    }
    
    Static Ellipse(img, center, axes, angle, startAngle, endAngle, color, thickness := 1, lineType := CV2.LINE_8, shift := 0)
    {
        center := ComArrayMake(center)
        axes := ComArrayMake(axes)
        color := ComArrayMake(color)
        this.CV.Ellipse(img.MAT, center, axes, angle, startAngle, endAngle, color, thickness, lineType, shift)
        
        Return img
    }
    
    Static EqualizeHist(src)
    {
        dst := this.MAT()
        tomat(dst, this.CV.EqualizeHist(src.MAT))
        
        Return dst
    }
    
    Static Erode(src, kernel, anchor := [-1, -1], iterations := 0, BorderTypes := CV2.BORDER_CONSTANT)
    {
        anchor := ComArrayMake(anchor)
        dst := this.MAT()
        tomat(dst, this.CV.Erode(src.MAT, kernel.MAT, anchor, iterations, BorderTypes))
        
        Return dst
    }
    
    Static FastNlMeansDenoisingColored(src, h := 3, hColor := 3, templateWindowSize := 7, searchWindowSize := 21)
    {
        dst := noArray()
        this.CV.FastNlMeansDenoisingColored(src.MAT, dst.MAT, h, hColor, templateWindowSize, searchWindowSize)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static FillPoly(img, pts, color, lineType := CV2.LINE_8, shift := 0, offset := [])
    {
        pts := ComArrayMake([pts.MAT])
        color := ComArrayMake(color)
        offset := ComArrayMake(offset)
        dst := this.MAT()
        tomat(dst, this.CV.FillPoly(img.MAT, pts, color, lineType, shift, offset))
        
        Return dst
    }
    
    Static Filter2D(src, ddepth, kernel, anchor := [-1, -1], delta := 0, BorderTypes := CV2.BORDER_DEFAULT)
    {
        anchor := ComArrayMake(anchor)
        dst := this.MAT()
        tomat(dst, this.CV.Filter2D(src.MAT, ddepth, kernel.MAT, anchor, delta, BorderTypes))
        
        Return dst
    }
    
    Static FindContours(image, mode, method)
    {
        contours := this.CV.FindContours(image.MAT, mode, method)
        hierarchy := this.MAT()
        tomat(hierarchy, this.CV.extended()[1])
        
        Return [contours, hierarchy]
    }
    
    Static Flip(img, flipcode)
    {
        imgflip := this.MAT()
        tomat(imgflip, this.CV.Flip(img.MAT, flipcode))
        
        Return imgflip
    }
    
    Static GaussianBlur(src, ksize, sigmaX, sigmaY := 0, borderType := CV2.BORDER_DEFAULT)
    {
        ksize := ComArrayMake(ksize)
        dst := this.MAT()
        tomat(dst, this.CV.GaussianBlur(src.MAT, ksize, sigmaX, sigmaY, borderType))
        
        Return dst
    }
    
    Static GetNumThreads()
    {
        Return this.CV.GetNumThreads()
    }
    
    Static GetOptimalDFTSize(vecsize)
    {
        Return this.CV.GetOptimalDFTSize(vecsize)
    }
    
    Static GetRotationMatrix2D(center, angle, scale)
    {
        center := ComArrayMake(center)
        dst := this.MAT()
        tomat(dst, this.CV.GetRotationMatrix2D(center, angle, scale))
        
        Return dst
    }
    
    Static GetStructuringElement(shape, ksize, anchor := [-1, -1])
    {
        ksize := ComArrayMake(ksize)
        anchor := ComArrayMake(anchor)
        kernel := this.MAT()
        tomat(kernel, this.CV.GetStructuringElement(shape, ksize, anchor))
        
        Return kernel
    }
    
    Static GetTextSize(text, fontFace, fontScale, thickness)
    {
        retval := CV2.CV.GetTextSize(text, fontFace, fontScale, thickness)
        baseLine := CV2.CV.extended()[1]
        
        Return [retval, baseLine]
    }
    
    Static GetTickCount()
    {
        Return this.CV.GetTickCount()
    }
    
    Static GetTickFrequency()
    {
        Return this.CV.GetTickFrequency()
    }
    
    Static GetTrackbarPos(trackbarname, winname)
    {
        Return this.CV.GetTrackbarPos(trackbarname, winname)
    }
    
    Static GetWindowProperty(winname, prop_id)
    {
        Return WinExist(winname) ? this.CV.GetWindowProperty(winname, prop_id) : -1
    }
    
    Static HConcat(arr)
    {
        Loop arr.Length
            arr[A_Index] := arr[A_Index].MAT
        
        dst := this.MAT()
        tomat(dst, this.CV.HConcat(ComArrayMake(arr)))
        
        Return dst
    }
    
    Static HoughLines(image, rho, theta, threshold, srn := 0, stn := 0)
    {
        lines := this.MAT()
        tomat(lines, this.CV.HoughLines(image.MAT, rho, theta, threshold, srn, stn))
        
        Return lines
    }
    
    Static HoughLinesP(image, rho, theta, threshold, minLineLegth := 0, maxLineGap := 0)
    {
        lines := this.MAT()
        tomat(lines, this.CV.HoughLinesP(image.MAT, rho, theta, threshold, minLineLegth, maxLineGap))
        
        Return lines
    }
    
    Static Imdecode(buf, flags)
    {
        retval := this.MAT()
        tomat(retval, this.CV.Imdecode(buf, flags))
        
        Return retval
    }
    
    Static Imdelete(img)
    {
        img.MAT := ""
        
        Return img
    }
    
    Static Imencode(ext, img, params := [])
    {
        params := ComArrayMake(params)
        retval := this.CV.Imencode(ext, img.MAT, params)
        buf := this.CV.extended()[1]
        
        Return [retval, buf]
    }
    
    Static Imread(filepath, flags := CV2.IMREAD_COLOR)
    {
        img := this.MAT()
        tomat(img, this.CV.Imread(filepath, flags))
        
        Return img
    }
    
    Static Imshow(wname, img := "")
    {
        if !img
        {
            img := wname
            wname := "Default"
        }
        
        this.CV.Imshow(wname, img.MAT)
    }
    
    Static Imwrite(file, img, num := -1)
    {
        if !InStr(file, ":")
            file := A_ScriptDir "/" file
        
        this.CV.Imwrite(file, img.MAT)
    }
    
    Static Inpaint(src, inpaintMask, inpaintRadius, flags)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Inpaint(src.MAT, inpaintMask.MAT, inpaintRadius, flags))
        
        Return dst
    }
    
    Static InRange(src, lowerb, upperb)
    {
        lowerb := ComArrayMake(lowerb)
        upperb := ComArrayMake(upperb)
        dst := this.MAT()
        tomat(dst, this.CV.InRange(src.MAT, lowerb, upperb))
        
        Return dst
    }
    
    Static Invert(src, flags := CV2.DECOMP_LU)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Invert(src.MAT, flags))
        
        Return dst
    }
    
    Static Laplacian(src, ddepth, ksize := 1, scale := 1, delta := 0, borderType := CV2.BORDER_DEFAULT)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Laplacian(src.MAT, ddepth, ksize, scale, delta, borderType))
        
        Return dst
    }
    
    Static Line(img, pt1, pt2, color, thickness := 1, lineType := CV2.LINE_8, shift := 0)
    {
        pt1 := ComArrayMake(pt1)
        pt2 := ComArrayMake(pt2)
        color := ComArrayMake(color)
        this.CV.Line(img.MAT, pt1, pt2, color, thickness, lineType, shift)
        
        Return img
    }
    
    Static LoadFromCSV(filename, headerLineCount, responseStartIdx := -1, responseEndIdx := -1, varTypeSpec := "", delimiter := ',', missch := '?')
    {
        traindata := CV2.MLTRAINDATA_Init()
        dstdata := this.ML.TrainData()
        dstdata.traindata := traindata.LoadFromCSV(filename, headerLineCount, responseStartIdx, responseEndIdx, varTypeSpec, delimiter, missch)
        
        Return dstdata
    }
    
    Static Log(src)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Log(src.MAT))
        
        Return dst
    }
    
    Static LUT(src, lut)
    {
        dst := this.MAT()
        tomat(dst, this.CV.LUT(src.MAT, lut.MAT))
        
        Return dst
    }
    
    Static Magnitude(x, y)
    {
        magnitude := this.MAT()
        tomat(magnitude, this.CV.Magnitude(x.MAT, y.MAT))
        
        Return magnitude
    }
    
    Static MAT_(param*)
    {
        if !param.Length
        {
            MAT_ := CV2.MAT()
            MAT_.MAT := CV2.MAT_Init()
            
            Return MAT_
        }
        
        else
        {
            x := 0
            y := 0
            flag := (param[1] * param[2] == param.Length - 2) || (param[3] is Array)
            index := flag ? 2 : 3
            cvtype := (index == 2) ? CV2.CV_8UC1 : param[3]
            MAT_ := CV2.MAT()
            MAT_.MAT := CV2.MAT_Init().Create(param[1], param[2], cvtype)
            MAT_.Shape := [MAT_.MAT.Rows, MAT_.MAT.Cols, MAT_.MAT.Channels]
            MAT_.At := CV2.MAT.At(MAT_)
            if param.length = index
            {
                tomat(MAT_, MAT_.MAT)
                return MAT_
            }
            if param[index + 1] is Array
            {
                Loop param[index + 1].Length
                {
                    if y == param[2]
                    {
                        y := 0
                        x++
                    }
                    
                    MAT_.At[x, y++] := param[index + 1][A_Index]
                }
            }
            
            else
            {
                Loop param.Length - index
                {
                    if y == param[2]
                    {
                        y := 0
                        x++
                    }
                    
                    MAT_.At[x, y++] := param[A_Index + index]
                }
            }
            
            tomat(MAT_, MAT_.MAT)
            
            Return MAT_
        }
    }
    
    Static MatchTemplate(image, templ, method)
    {
        result := this.MAT()
        tomat(result, this.CV.MatchTemplate(image.MAT, templ.MAT, method))
        
        Return result
    }
    
    Static MeanStdDev(src, mask := noArray())
    {
        mean := this.MAT()
        stddev := this.MAT()
        this.CV.MeanStdDev(src.MAT, mask.MAT)
        tomat(mean, this.CV.extended()[0])
        tomat(stddev, this.CV.extended()[1])
        
        Return [mean, stddev]
    }
    
    Static MedianBlur(src, ksize)
    {
        dst := this.MAT()
        tomat(dst, this.CV.MedianBlur(src.MAT, ksize))
        
        Return dst
    }
    
    Static Merge(mv)
    {
        Loop mv.Length
            mv[A_Index] := mv[A_Index].MAT
        
        dst := this.MAT()
        tomat(dst, this.CV.Merge(ComArrayMake(mv)))
        
        Return dst
    }
    
    Static MinMaxLoc(src, mask := noArray())
    {
        this.CV.MinMaxLoc(src.MAT, mask.MAT)
        min_val := this.CV.extended()[0]
        max_val := this.CV.extended()[1]
        min_loc := this.CV.extended()[2]
        max_loc := this.CV.extended()[3]
        
        Return [min_val, max_val, min_loc, max_loc]
    }
    
    Static MorphologyEx(src, op, kernel, anchor := [-1, -1], iterations := 1, borderType := cv2.BORDER_CONSTANT, borderValue := [])
    {
        anchor := ComArrayMake(anchor)
        borderValue := ComArrayMake(borderValue)
        dst := this.MAT()
        this.CV.MorphologyEx(src.MAT, op, kernel.MAT, dst.MAT, anchor, iterations, borderType, borderValue)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Multiply(src1, src2)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Multiply(src1.MAT, src2.MAT))
        
        Return dst
    }
    
    Static MoveWindow(winname, x, y)
    {
        this.CV.MoveWindow(winname, x, y)
    }
    
    Static NamedWindow(name, flags := 0)
    {
        this.CV.NamedWindow(name, flags)
    }
    
    Static Normalize(src, dst, alpha := 1, beta := 0, norm_type := CV2.NORM_L2, dtype := -1)
    {
        this.CV.Normalize(src.MAT, dst.MAT, alpha, beta, norm_type, dtype)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Static Open(binaryImage, ksize, kernelMode)
    {
        element := cv2.getStructuringElement(kernelMode, [ksize, ksize])
        dst := cv2.morphologyEx(binaryImage, 2, element)
        
        Return dst
    }
    
    Static Otsu(src)
    {
        gray := cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
        tmp := cv2.threshold(gray, 0, 255, cv2.THRESH_BINARY | cv2.THRESH_OTSU)
        
        Return tmp
    }
    
    Static Point(args*)
    {
        Return ComArrayMake(args)
    }
    
    Static Polylines(img, pts, flags, color, lineType := CV2.LINE_8, shift := 0, offset := [])
    {
        pts := ComArrayMake([pts.MAT])
        flags := OpencvAHK_Bool(flags)
        color := ComArrayMake(color)
        dst := this.MAT()
        tomat(dst, this.CV.Polylines(img.MAT, pts, flags, color, lineType, shift, offset))
        
        Return dst
    }
    
    Static PutText(image, text, org, font, fontScale, color, thickness := 1, lineType := CV2.LINE_8)
    {
        org := ComArrayMake(org)
        color := ComArrayMake(color)
        
        this.CV.PutText(image.MAT, text, org, font, fontScale, color, thickness, lineType)
        tomat(image, image.MAT)
        
        Return image
    }
    
    Static QRCodeDetector()
    {
        qrcode := this.Detector.QRCode()
        qrcode.qrcode := CV2.QRCodeDetector_Init()
        
        Return qrcode
    }
    
    Static Randu(src, low, high)
    {
        if low is Integer || low is Float
            low := ComArrayMake([low])
        
        else
            low := ComArrayMake(low)
        
        if high is Integer || high is Float
            high := ComArrayMake([high])
        
        else
            high := ComArrayMake(high)
        
        dst := this.MAT()
        tomat(dst, this.CV.Randu(src.MAT, low, high))
        
        Return dst
    }
    
    Static Rect(args*)
    {
        Return ComArrayMake(args)
    }
    
    Static Rectangle(img, pt1, pt2, color, thickness := 1, lineType := 8, shift := 0)
    {
        pt1 := ComArrayMake(pt1)
        pt2 := ComArrayMake(pt2)
        color := ComArrayMake(color)
        this.CV.Rectangle(img.MAT, pt1, pt2, color, thickness, lineType, shift)
        
        Return img
    }
    
    Static Resize(src, dsize, fx := 0, fy := 0, interpolation := CV2.INTER_LINEAR)
    {
        if InStr(fx, "interpolation")
        {
            interpolation := Integer(Trim(StrSplit(fx, "=")[2]))
            fx := 0
        }
        
        dsize := ComArrayMake(dsize)
        dst := this.MAT()
        tomat(dst, this.CV.Resize(src.MAT, dsize))
        
        Return dst
    }
    
    Static ResizeWindow(name, width, height)
    {
        this.CV.ResizeWindow(name, width, height)
    }
    
    Static SelectROI(windowName, img := noArray(), showCrosshair := cv2.True, fromCenter := cv2.False)
    {
        if windowName is String
            Return this.CV.SelectROI(windowName, img.MAT, showCrosshair, fromCenter)
        else
        {
            showCrosshair := img is ComValue ? showCrosshair : cv2.False
            
            Return this.CV.SelectROI(windowName.MAT, img := img is ComValue ? img : cv2.True, showCrosshair)
        }
    }
    
    Static SetMouseCallback(winname, onMouse, userdata := 0)
    {
        if !onMouse
            onMouse := temp
        
        ;if userdata
            ;tmpdata := ObjPtrAddRef(userdata)
        
        tmpMouse := CallbackCreate(onMouse)
        DllCall("opencv_world455.dll\cvSetMouseCallback", "Astr", winname, "ptr", tmpMouse, "ptr", 0)
        
        temp(*)
        {
            Return
        }
    }
    
    Static SetNumThreads(nthreads)
    {
        this.CV.SetNumThreads(nthreads)
    }
    
    Static SetTrackbarPos(trackbarname, winname, pos)
    {
        this.CV.SetTrackbarPos(trackbarname, winname, pos)
    }
    
    Static SetUseOptimized(bool)
    {
        this.CV.SetUseOptimized(OpencvAHK_Bool(bool))
    }
    
    Static SetWindowProperty(winname, prop_id, prop_value)
    {
        this.CV.SetWindowProperty(winname, prop_id, prop_value)
    }
    
    Static Size(args*)
    {
        Return ComArrayMake(args)
    }
    
    Static Sobel(src, ddepth, dx, dy, ksize := 3, scale := 1, delta := 0, borderType := CV2.BORDER_DEFAULT)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Sobel(src.MAT, ddepth, dx, dy, ksize, scale, delta, borderType))
        
        Return dst
    }
    
    Static Sobel_X(src, ksize := 3)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Sobel(src.MAT, cv2.CV_64F, 1, 0, ksize))
        
        Return dst
    }
    
    Static Sobel_Y(src, ksize := 3)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Sobel(src.MAT, cv2.CV_64F, 0, 1, ksize))
        
        Return dst
    }
    
    Static Sobel_XY(src, ksize := 3)
    {
        sobel_x := cv2.Sobel_X(src, ksize)
        sobel_y := cv2.Sobel_Y(src, ksize)
        dst := this.MAT()
        tomat(dst, cv2.addWeighted(sobel_x, 0.5, sobel_y, 0.5, 0))
        
        Return dst
    }
    
    Static Split(m)
    {
        mv := this.CV.Split(m.MAT)
        mvl := []
        
        Loop mv.MaxIndex() + 1
        {
            tmp := this.MAT()
            tomat(tmp, mv[A_Index - 1])
            mvl.Push(tmp)
        }
        
        Return mvl
    }
    
    Static StartWindowThread()
    {
        Return this.CV.StartWindowThread()
    }
    
    Static Subtract(src1, src2)
    {
        dst := this.MAT()
        tomat(dst, this.CV.Subtract(src1.MAT, src2.MAT))
        
        Return dst
    }
    
    Static Threshold(src, thresh, maxval, type)
    {
        dst := this.MAT()
        ret := this.CV.Threshold(src.MAT, thresh, maxval, type)
        tomat(dst, this.CV.extended()[1])
        
        Return [ret, dst]
    }
    
    Static UseOptimized()
    {
        Return this.CV.UseOptimized()
    }
    
    Static VConcat(arr)
    {
        Loop arr.Length
            arr[A_Index] := arr[A_Index].MAT
        
        dst := this.MAT()
        tomat(dst, this.CV.VConcat(ComArrayMake(arr)))
        
        Return dst
    }
    
    Static VideoCapture(video := "")
    {
        Cap := this.Video()
        Cap.Video := CV2.VideoCapture_Init()
        
        if video !== ""
            Cap.Video.Open(video)
        
        Return Cap
    }
    
    Static VideoWriter(filename, fourcc, fps, frame_size)
    {
        video := this.Video()
        video.Video := CV2.VideoWriter_Init()
        frame_size := ComArrayMake(frame_size)
        video.Video.Open(filename, fourcc, fps, frame_size)
        
        Return video
    }
    
    Static VideoWriter_fourcc(Lst_Codec*)
    {
        Return CV2.VideoWriter_Fourcc_Init(Lst_Codec*)
    }
    
    Static WaitKey(num := 0)
    {
        Return CV2.CV.WaitKey(num)
    }
    
    Static WarpAffine(src, M, dsize, flags := CV2.INTER_LINEAR, borderMode := CV2.BORDER_CONSTANT, borderValue := [])
    {
        dsize := ComArrayMake(dsize)
        borderValue := ComArrayMake(borderValue)
        dst := this.MAT()
        this.CV.WarpAffine(src.MAT, M.MAT, dsize, dst.MAT, flags, borderMode, borderValue)
        tomat(dst, dst.MAT)
        
        Return dst
    }
    
    Class Classifier
    {
        detectMultiScale(image, scaleFactor := 1.1, minNeighbors := 3, flags := 0, minSize := [], maxSize := [])
        {
            minSize := ComArrayMake(minSize)
            maxSize := ComArrayMake(maxSize)
            
            Return this.Classifier.detectMultiScale(image.MAT, scaleFactor, minNeighbors, flags, minSize, maxSize)
        }
    }
    
    Class Detector
    {
        Class QRCode
        {
            detectAndDecode(img)
            {
                this.qrcode.detectAndDecode(img.MAT)
                Ret := []
                
                Loop 3
                    Ret.Push(CV2.CV.extended()[A_Index - 1])
                
                Return Ret
            }

        }
    }
    
    Class MAT
    {
        __New(param*)
        {
            if !param.Length
            {
                this.MAT := CV2.MAT_Init()
                
                Return this
            }
            
            else if Type(param[1]) == "CV2.MAT"
            {
                this.MAT := param[1].MAT
                
                Return this
            }
            
            else
            {
                While param.Length < 4
                    param.Push(0)
                
                if Type(param[-1]) == "Array"
                    param[-1] := ComArrayMake(param[-1])
                
                else
                    param[-1] := ComArrayMake([param[-1]])
                
                tomat(this, CV2.MAT_Init().Create(param[1], param[2], param[3], param[-1]))
                
                Return this
            }
        }
        
        __Delete()
        {
            this.MAT := ""
        }
    
        __Item[size*]
        {
            Get => this.GetMethod(this, size)
            Set => ROIMethod(this, size, value)
        }
        
        Clone()
        {
            imgclone := CV2.MAT()
            tomat(imgclone, this.MAT.Clone())
            
            Return imgclone
        }
        
        Col(column)
        {
            imgcol := CV2.MAT()
            tomat(imgcol, this.MAT.Col(column))
            
            Return imgcol
        }
        
        Copy()
        {
            imgcopy := CV2.MAT()
            tomat(imgcopy, this.MAT.Copy())
            
            Return imgcopy
        }
        
        Copyto(dst, mask := 0)
        {
            if !HasProp(dst, "MAT")
                dst.MAT := CV2.MAT_Init()
            
            if !mask
                this.MAT.Copyto(dst.MAT)
            
            else
                this.MAT.Copyto(dst.MAT, mask.MAT)
            
            tomat(dst, dst.MAT)
            
            Return dst
        }
        
        ConvertTo(rtype, alpha := 1, beta := 0)
        {
            dst := noArray()
            this.MAT.ConvertTo(rtype, dst.MAT, alpha, beta)
            tomat(dst, dst.MAT)
            
            Return dst
        }
        
        Empty()
        {
            Return this.MAT.Empty()
        }
        
        GetMethod(src, size)
        {
            size := ComArrayMake(size)
            dst := CV2.MAT()
            dst.MAT := (src.Cols == size[2] && src.Rows == size[3]) ? src.MAT : CV2.Crop(src.MAT, size)
            tomat(dst, dst.MAT)
        
            Return dst
        }
        
        isContinuous()
        {
            Return this.MAT.isContinuous()
        }
        
        Release()
        {
            matRelease(this)
        }
        
        Reshape(cn, rows := 0)
        {
            dst := CV2.MAT()
            tomat(dst, this.MAT.Reshape(cn, rows))
            
            Return dst
        }
        
        Row(rowing)
        {
            imgrow := CV2.MAT()
            tomat(imgrow, this.MAT.Row(rowing))
            
            Return imgrow
        }
        
        SetMethod(src, size, value)
        {
            NewCols := Array()
            
            x := size[1]
            y := size[2]
            Width := size[3]
            Height := size[4]
            
            cropw := (value.Cols > src.Cols - x) ? src.Cols - x : value.Cols
            croph := (value.Rows > src.Rows - y) ? src.Rows - y : value.Rows
            
            value := value[0, 0, cropw, croph]
            
            Loop src.Cols
            {
                index := A_Index - 1
                if A_Index - 1 < x || A_Index > width + x
                    NewCols.Push(src.Col(A_Index - 1).MAT)
                
                else
                {
                    tmpRows := Array()
                    
                    Loop src.Rows
                    {
                        if A_Index - 1 < y || A_Index > height + y
                            tmpRows.Push(src.Col(index).MAT.Row(A_Index - 1))
                        
                        else
                            tmpRows.Push(value.Col(index - x).MAT.Row(A_Index - 1 - y))
                    }
                    
                    NewCols.Push(CV2.CV.vconcat(ComArrayMake(tmpRows)))
                }
            }
            
            src.MAT := CV2.CV.hconcat(ComArrayMake(NewCols))
        }
        
        SetTo(value, mask := 0)
        {
            value := ComArrayMake(value)
            
            if !mask
                this.MAT.SetTo(value)
            
            else
                this.MAT.SetTo(value, mask.MAT)
        }
        
        T()
        {
            dst := CV2.MAT()
            tomat(dst, this.MAT.T())
            
            Return dst
        }
        
        toNumahk()
        {
            if isset(numahk)
            {
                Switch this.Type
                {
                    Case cv2.CV_8SC1, cv2.CV_8SC2, cv2.CV_8SC3, cv2.CV_8SC4:
                        dtype := numahk.int8
                    Case cv2.CV_8UC1, cv2.CV_8UC2, cv2.CV_8UC3, cv2.CV_8UC4:
                        dtype := numahk.uint8
                    Case cv2.CV_16SC1, cv2.CV_16SC2, cv2.CV_16SC3, cv2.CV_16SC4:
                        dtype := numahk.int16
                    Case cv2.CV_16UC1, cv2.CV_16UC2, cv2.CV_16UC3, cv2.CV_16UC4:
                        dtype := numahk.uint16
                    Case cv2.CV_32SC1, cv2.CV_32SC2, cv2.CV_32SC3, cv2.CV_32SC4:
                        dtype := numahk.int32
                    Case cv2.CV_32UC1, cv2.CV_32UC2, cv2.CV_32UC3, cv2.CV_32UC4:
                        dtype := numahk.uint32
                    Case cv2.CV_32FC1, cv2.CV_32FC2, cv2.CV_32FC3, cv2.CV_32FC4:
                        dtype := numahk.float32
                    Case cv2.CV_64FC1, cv2.CV_64FC2, cv2.CV_64FC3, cv2.CV_64FC4:
                        dtype := numahk.float64
                }
                ndarray := numahk.zeros(this.Total * this.Channels, dtype)
                memcpy(ndarray.data, this.Data, this.Total * this.Channels * numahk.type_dict[ndarray.dtype])
                return ndarray.resize(this.Shape)
            }
        }
        
        Static Zeros(rows, cols, type := -1)
        {
            src := CV2.MAT()
            
            if type !== -1
                src.MAT := CV2.MAT_Init().Zeros(rows, cols, type)
            
            else
                src.MAT := CV2.MAT_Init().Zeros(ComArrayMake(rows), cols)
            
            tomat(src, src.MAT)
            
            Return src
        }
        
        Static Eye(rows, cols, type := -1)
        {
            src := CV2.MAT()
            
            if type !== -1
                src.MAT := CV2.MAT_Init().Eye(rows, cols, type)
            
            else
                src.MAT := CV2.MAT_Init().Eye(ComArrayMake(rows), cols)
            
            tomat(src, src.MAT)
            
            Return src
        }
        
        Static Ones(rows, cols, type := -1)
        {
            src := CV2.MAT()
            
            if type !== -1
                src.MAT := CV2.MAT_Init().Ones(rows, cols, type)
            
            else
                src.MAT := CV2.MAT_Init().Ones(ComArrayMake(rows), cols)
            
            tomat(src, src.MAT)
            
            Return src
        }
        
        Class At
        {
            __New(MAT)
            {
                this.At := MAT
            }
        
            __Item[x, y]
            {
                Get => this.GetMethod(x, y)
                Set => this.SetMethod(x, y, value)
            }
            
            GetMethod(x, y)
            {
                flag := (this.At.Type // 8) + 1
                arr := []
                loop flag
                    arr.push(NumGet(this.At.Data, x * this.At.Width * flag + y * flag + A_Index - 1, "UChar"))
                
                Return (arr.Length = 1) ? arr[1] : arr
            }
            
            SetMethod(x, y, value)
            {
                flag := (this.At.Type // 8) + 1
                value := (value is Number) ? [value] : value
                loop flag
                    NumPut("UChar", value[A_Index], this.At.Data, x * this.At.Width * flag + y * flag + A_Index - 1)
            }
        }
        
        ToString()
        {
            return format("
            (
                CV2.MAT
                Channels: {}
                Data: {}
                Depth: {}
                Height: {}
                Shape: [{}, {}, {}]
                Size: [{}, {}]
                Step1: {}
                Total: {}
                Type: {}
                Width: {}
                Cols: {}
                Dims: {}
                Rows: {}
            )", this.Channels, this.Data, this.Depth, this.Height, this.Rows, this.Cols, this.Channels, this.Rows, this.Cols, this.Step1, this.Total, this.Type, this.Width, this.Cols, this.Dims, this.Rows)
        }
    }
    
    Class ML
    {
        Class SVM
        {
            GetUncompressedSupportVectors()
            {
                Return this.svm.GetUncompressedSupportVectors()
            }
            
            Predict(samples, flags := 0)
            {
                dst := noArray()
                this.svm.Predict(samples.MAT, dst.MAT, flags)
                tomat(dst, dst.MAT)
                
                Return dst
            }
            
            SetC(val)
            {
                this.svm.SetC(val)
            }
            
            SetGamma(val)
            {
                this.svm.SetGamma(val)
            }
            
            SetKernel(kernelType)
            {
                this.svm.SetKernel(kernelType)
            }
            
            SetTermCriteria(val*)
            {
                if val.Length == 3
                    this.svm.SetTermCriteria(CV2.TermCriteria(val*))
                
                else
                    this.svm.SetTermCriteria(val[1])
            }
            
            SetType(val)
            {
                this.svm.SetType(val)
            }
            
            Train(trainingDataMat, ROW_SAMPLE, labelsMat)
            {
                Return this.svm.Train(trainingDataMat.MAT, ROW_SAMPLE, labelsMat.MAT)
            }
            
            TrainAuto(samples, layout, responses, kFold, Cgrid, gammaGrid, pGrid, nuGrid, coeffGrid, degreeGrid, balanced)
            {
                
            }
            
            Static Create()
            {
                svm := CV2.ML.SVM()
                svm.svm := CV2.SVM_Init().Create()
                
                Return svm
            }
            
            Static Load(svm_file)
            {
                svm := CV2.ML.SVM()
                svm.svm := CV2.SVM_Init().Load(svm_file)
                
                Return svm
            }
        }
        
        Class TrainData
        {
            getTrainSamples()
            {
                dst := CV2.MAT()
                tomat(dst, this.traindata.getTrainSamples())
                
                Return dst
            }
        }
    }
    
    Class UMAT
    {
        GetMAT(flags)
        {
            dst := CV2.MAT()
            tomat(dst, this.MAT.GetMAT(flags))
            
            Return dst
        }
    }
    
    Class Video
    {
        Get(propId := "")
        {
            if !propId
                this.Video.Get()
            
            Return this.Video.Get(propId)
        }
        
        Grab()
        {
            Return this.Video.Grab()
        }
        
        Open(video)
        {
            this.Video.Open(video)
        }
        
        Read()
        {
            Frame := CV2.MAT()
            Frame.MAT := CV2.MAT_Init()
            Ret := this.Video.Read(Frame.MAT)
            tomat(Frame, Frame.MAT)
            
            Return [Ret, Frame]
        }
        
        Release()
        {
            Try
                this.Video.Release()
        }
        
        Retrieve()
        {
            Frame := CV2.MAT()
            Retval := this.Video.Retrieve()
            tomat(Frame, CV2.CV.extended()[1])
            
            Return [Retval, Frame]
        }
        
        Set(propId, value)
        {
            Return this.Video.Set(propId, value)
        }
        
        Write(frame)
        {
            this.Video.Write(frame.MAT)
        }
    }
}

Class None
{
    
}

DllCall("QueryPerformanceFrequency", "Int64*", &CLOCKS_PER_SEC := 0)

clock()
{
    DllCall("QueryPerformanceCounter", "Int64*", &Time := 0)
    
    Return Time
}

getCurrentDirectory()
{
    Return A_ScriptDir
}

int(num)
{
    Return Integer(num)
}

input(Prompt := "")
{
    InputObj := InputBox(Prompt)
    
    if InputObj.Result == "Cancel" || InputObj.Result == "Timeout"
        Return -1
    
    else
        Return InputObj.Value
}

isinstance(object, classinfo)
{
    if Type(object) == "CV2.MAT"
        object := object.MAT
    
    Return object is classinfo
}

lpcstr(pszSound)
{
    Return FileRead(pszSound, "RAW")
}

lstClone(Lst)
{
    tmp := []
    
    if !(Lst is Array)
        Return Lst
    
    For i in Lst
    {
        if i is Array
            tmp.Push(lstclone(i))
        
        else
            tmp.Push(i)
    }
    
    Return tmp
}

matRelease(src)
{
    if Type(src.MAT) == "Cv_Mat_Object"
    {
        Try
        {
            src.At.At.MAT := ""
            src.At.At := ""
            src.At := ""
        }
        src.Channels := ""
        src.Data := ""
        src.Depth := ""
        src.Shape := ""
        src.Size := ""
        src.Step1 := ""
        src.Total := ""
        src.Type := ""
    }
    
    src.Cols := ""
    src.Dims := ""
    src.Rows := ""
    
    Return src
}

matToBitmap(img)
{
    if img.MAT.depth !== cv2.CV_8U
        MsgBox "Unable to Change"

    if img.MAT.channels == 1
        img := cv2.cvtcolor(img, cv2.COLOR_GRAY2BGRA)
    
    else if img.MAT.channels == 3
        img := cv2.cvtcolor(img, cv2.COLOR_BGR2BGRA)
    
    si := Buffer(A_PtrSize = 8 ? 24 : 16, 0)
    NumPut("UInt", 1, si, 0)
    DllCall("gdiplus\GdiplusStartup", "Ptr*", &pToken := 0, "Ptr", si, "Ptr", 0)
    DllCall("gdiplus\GdipCreateBitmapFromScan0", "Int", img.Cols, "Int", img.Rows, "Int", img.Step1, "Int", 2498570, "Ptr", img.data, "Ptr*", &pBitmap := 0)
    
    Return pBitmap
}

multiple(Lst, Number)
{
    tmp := lstclone(Lst)
    
    Loop Number - 1
    {
        For i in tmp
            Lst.Push(lstclone(i))
    }
    
    Return Lst
}

noArray(uflag := 0)
{
    
    if uflag
    {
        dst := cv2.UMAT()
        dst.MAT := cv2.UMAT_Init()
    }
    
    else
    {
        dst := cv2.MAT()
        dst.MAT := cv2.MAT_Init()
    }
    
    Return dst
}

; fdwSound
NULL := 0x00
SND_ASYNC := 0x01
SND_LOOP := 0x08
SND_MEMORY := 0x04
SND_NODEFAULT := 0x02
SND_NOSTOP := 0x10
SND_SYNC := 0x00
SND_NOWAIT := 0x002000
SND_ALIAS := 0x010000
SND_ALIAS_ID := 0x110000
SND_FILENAME := 0x020000
SND_RESOURCE := 0x040004
SND_PURGE := 0x40
SND_APPLICATION := 0x80

playSound(pszSound, hmod, fdwSound)
{
    if pszSound is String
        pszSound := FileRead(pszSound, "RAW")
    
    DllCall("winmm.dll\PlaySound","Ptr", pszSound, "UInt", hmod, "UInt", fdwSound)
}

point(args*)
{
    Return ComArrayMake(args)
}

printc(args*)
{
    str := ""
    
    For i in args
        str .= i
    
    MsgBox str
}

printf(fs, args*)
{
    MsgBox sprintf(fs, args*)
}

rand()
{
    Return Random(0, 32767)
}

roiMethod(src, size, value)
{
    NewCols := ComObjArray(VT_VARIANT := 12, src.Cols)
    
    x := size[1]
    y := size[2]
    Width := size[3]
    Height := size[4]
    
    cropw := (value.Cols > src.Cols - x) ? src.Cols - x : value.Cols
    croph := (value.Rows > src.Rows - y) ? src.Rows - y : value.Rows
    
    value.MAT := value[0, 0, cropw, croph].MAT
    
    Loop src.Cols
    {
        index := A_Index - 1
        if A_Index - 1 < x || A_Index > width + x
            NewCols[A_Index - 1] := src.Col(A_Index - 1).MAT
        
        else
        {
            tmpRows := ComObjArray(VT_VARIANT := 12, src.Rows)
            
            Loop src.Rows
            {
                if A_Index - 1 < y || A_Index > height + y
                    tmpRows[A_Index - 1] := src.Col(index).MAT.Row(A_Index - 1)
                
                else
                    tmpRows[A_Index - 1] := value.Col(index - x).MAT.Row(A_Index - 1 - y)
            }
            
            NewCols[A_Index - 1] := CV2.CV.vconcat(tmpRows)
        }
    }
    
    src.MAT := CV2.CV.hconcat(NewCols)
}

scalar(args*)
{
    Return ComArrayMake(args)
}

GWL_EXSTYLE := -20
GWL_HINSTANCE := -6
GWL_HWNDPARENT := -8
GWL_ID := -12
GWL_STYLE := -16
GWL_USERDATA := -21
GWL_WNDPROC := -4
DWL_DLGPROC := 4
DWL_MSGRESULT := 0
DWL_USER := 8
WS_EX_ACCEPTFILES := 0x00000010
WS_EX_APPWINDOW := 0x00040000
WS_EX_CLIENTEDGE := 0x00000200
WS_EX_COMPOSITED := 0x02000000
WS_EX_CONTEXTHELP := 0x00000400
WS_EX_CONTROLPARENT := 0x00010000
WS_EX_DLGMODALFRAME := 0x00000001
WS_EX_LAYERED := 0x00080000
WS_EX_LAYOUTRTL := 0x00400000
WS_EX_LEFT := 0x00000000
WS_EX_LEFTSCROLLBAR := 0x00004000
WS_EX_LTRREADING := 0x00000000
WS_EX_MDICHILD := 0x00000040
WS_EX_NOACTIVATE := 0x08000000
WS_EX_NOINHERITLAYOUT := 0x00100000
WS_EX_NOPARENTNOTIFY := 0x00000004
WS_EX_TOOLWINDOW := 0x00000080
WS_EX_TOPMOST := 0x00000008
WS_EX_WINDOWEDGE := 0x00000100
WS_EX_OVERLAPPEDWINDOW := (WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE)
WS_EX_PALETTEWINDOW := (WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST)
WS_EX_RIGHT := 0x00001000
WS_EX_RIGHTSCROLLBAR := 0x00000000
WS_EX_RTLREADING := 0x00002000
WS_EX_STATICEDGE := 0x00020000
WS_EX_TRANSPARENT := 0x00000020
SW_HIDE := 0
SW_SHOWNORMAL := 1
SW_NORMAL := 1
SW_SHOWMINIMIZED := 2
SW_SHOWMAXIMIZED := 3
SW_MAXIMIZE := 3
SW_SHOWNOACTIVATE := 4
SW_SHOW := 5
SW_MINIMIZE := 6
SW_SHOWMINNOACTIVE := 7
SW_SHOWNA := 8
SW_RESTORE := 9
SW_SHOWDEFAULT := 10
SW_FORCEMINIMIZE := 11
SW_MAX := 11
WM_NULL := 0x0000
WM_CREATE := 0x0001
WM_DESTROY := 0x0002
WM_MOVE := 0x0003
WM_SIZE := 0x0005
WS_OVERLAPPED := 0x00000000
WS_POPUP := 0x80000000
WS_CHILD := 0x40000000
WS_MINIMIZE := 0x20000000
WS_VISIBLE := 0x10000000
WS_DISABLED := 0x08000000
WS_CLIPSIBLINGS := 0x04000000
WS_CLIPCHILDREN := 0x02000000
WS_MAXIMIZE := 0x01000000
WS_BORDER := 0x00800000
WS_DLGFRAME := 0x00400000
WS_CAPTION := WS_BORDER | WS_DLGFRAME
WS_VSCROLL := 0x00200000
WS_HSCROLL := 0x00100000
WS_SYSMENU := 0x00080000
WS_THICKFRAME := 0x00040000
WS_GROUP := 0x00020000
WS_TABSTOP := 0x00010000
setBorderless(Winhwnd)
{
    dwNewLong := DllCall("GetWindowLong", "UInt", Winhwnd, "Int", GWL_EXSTYLE) | WS_EX_TOPMOST
    DllCall("SetWindowLong", "UInt", Winhwnd, "Int", GWL_STYLE, "UInt", dwNewLong)
    DllCall("ShowWindow", "UInt", Winhwnd, "UInt", SW_SHOW)
}

showBitmap(pBitmap, ShowCase := 1, img := "", title := "Default", show := 1, delete := 1)
{
    if ShowCase == 1
    {
        DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "Ptr*", &hbm := 0, "Int", Background := 0xffffffff)
        MyGui := Gui()
        MyGui.Title := title
        MyGui.Add("Picture", "", "HBITMAP:" hbm)
        
        if show
            MyGui.Show()
        
        if delete
        {
            DllCall("DeleteObject", "Ptr", hbm)
            DllCall("gdiplus\GdipDisposeImage", "Ptr", pBitmap)
        }
        
        Return MyGui
    }
    
    ; Need to Include CGdip.ahk
    else if ShowCase == 2
    {
        if isSet(CreateCompatibleDC) && isSet(CreateDIBSection) && isSet(SelectObject) && isSet(CGdip) && isSet(UpdateLayeredWindow)
        {
            hdc := CreateCompatibleDC()
            hbm := CreateDIBSection(img.Cols, img.Rows)
            obm := SelectObject(hdc, hbm)
            canvas := CGdip.Graphics.FromHDC(hdc)
            canvas.SetSmoothingMode(4)
            canvas.DrawImage(pBitmap, 0, 0, img.Cols, img.Rows, 0, 0, img.Cols, img.Rows)
            
            AHKGui := Gui()
            AHKGui.Title := title
            AHKGui.Opt("-Caption +E0x80000")
            
            if show
            {
                AHKGui.Show("NA")
                UpdateLayeredWindow(AHKGui.hwnd, hdc, 0, 0, img.Cols, img.Rows)
            }
            
            if delete
            {
                DllCall("DeleteDC", "Ptr", hdc)
                DllCall("DeleteObject", "Ptr", hbm)
                DllCall("DeleteObject", "Ptr", obm)
                DllCall("gdiplus\GdipDeleteGraphics", "Ptr", canvas)
                DllCall("gdiplus\GdipDisposeImage", "Ptr", pBitmap)
            }
            
            Return AHKGui
        }
    }
}

size(args*)
{
    Return ComArrayMake(args)
}

sprintf(fs, args*)
{
    if args.Length && args[1] is Array
        args := args[1]
    
    if RegExMatch(fs, "i)%\.(.*)LF", &Num := 0)
        Return Round(args[-1], Num[1])
    
    if RegExMatch(fs, "i)%\.(.*)F", &Num := 0)
        Return Round(args[-1], Num[1])
    
    fs := StrReplace(fs, "\t", "`t")
    fs := StrReplace(fs, "\n", "`n")
    fs := StrReplace(fs, "%d", "{:d}")
    fs := StrReplace(fs, "%i", "{:i}")
    fs := StrReplace(fs, "%x", "{:x}")
    fs := StrReplace(fs, "%o", "{:o}")
    fs := StrReplace(fs, "%f", "{:f}")
    fs := StrReplace(fs, "%e", "{:e}")
    fs := StrReplace(fs, "%E", "{:E}")
    fs := StrReplace(fs, "%g", "{:g}")
    fs := StrReplace(fs, "%G", "{:G}")
    fs := StrReplace(fs, "%a", "{:a}")
    fs := StrReplace(fs, "%A", "{:A}")
    fs := StrReplace(fs, "%p", "{:p}")
    fs := StrReplace(fs, "%s", "{:s}")
    fs := StrReplace(fs, "%c", "{:c}")
    s := Format(fs, args*)
    
    Return s
}

memcpy(target, source, bytes)
{
    DllCall("Ntdll\memcpy", "ptr", target, "ptr", source, "uint", bytes)
}

toMat(src, img)
{
    src.MAT := img
    
    if Type(src.MAT) == "Cv_Mat_Object"
    {
        src.At := CV2.MAT.At(src)
        src.Channels := src.MAT.Channels
        src.Data := src.MAT.Data
        src.Depth := src.MAT.Depth
        src.Height := src.MAT.Height
        src.Shape := [src.MAT.Rows, src.MAT.Cols, src.MAT.Channels]
        src.Size := src.MAT.Size
        src.Step1 := src.MAT.Step1
        src.Total := src.MAT.Total
        src.Type := src.MAT.Type
        src.Width := src.MAT.Width
    }
    
    src.Cols := src.MAT.Cols
    src.Dims := src.MAT.Dims
    src.Rows := src.MAT.Rows
    
    Return src
}
