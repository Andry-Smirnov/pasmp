(******************************************************************************
 *                                   PasMP                                    *
 ******************************************************************************
 *                        Version 2025-04-24-18-11-0000                       *
 ******************************************************************************
 *                                zlib license                                *
 *============================================================================*
 *                                                                            *
 * Copyright (C) 2016-2025, Benjamin Rosseaux (benjamin@rosseaux.de)          *
 *                                                                            *
 * This software is provided 'as-is', without any express or implied          *
 * warranty. In no event will the authors be held liable for any damages      *
 * arising from the use of this software.                                     *
 *                                                                            *
 * Permission is granted to anyone to use this software for any purpose,      *
 * including commercial applications, and to alter it and redistribute it     *
 * freely, subject to the following restrictions:                             *
 *                                                                            *
 * 1. The origin of this software must not be misrepresented; you must not    *
 *    claim that you wrote the original software. If you use this software    *
 *    in a product, an acknowledgement in the product documentation would be  *
 *    appreciated but is not required.                                        *
 * 2. Altered source versions must be plainly marked as such, and must not be *
 *    misrepresented as being the original software.                          *
 * 3. This notice may not be removed or altered from any source distribution. *
 *                                                                            *
 ******************************************************************************
 *                  General guidelines for code contributors                  *
 *============================================================================*
 *                                                                            *
 * 1. Make sure you are legally allowed to make a contribution under the zlib *
 *    license.                                                                *
 * 2. The zlib license header goes at the top of each source file, with       *
 *    appropriate copyright notice.                                           *
 * 3. After a pull request, check the status of your pull request on          *
      http://github.com/BeRo1985/pasmp                                        *
 * 4. Write code, which is compatible with Delphi 7-XE7 and FreePascal >= 2.6 *
 *    so don't use generics/templates, operator overloading and another newer *
 *    syntax features than Delphi 7 has support for that, but if needed, make *
 *    it out-ifdef-able.                                                      *
 * 5. Don't use Delphi-only, FreePascal-only or Lazarus-only libraries/units, *
 *    but if needed, make it out-ifdef-able.                                  *
 * 6. No use of third-party libraries/units as possible, but if needed, make  *
 *    it out-ifdef-able.                                                      *
 * 7. Try to use const when possible.                                         *
 * 8. Make sure to comment out writeln, used while debugging.                 *
 * 9. Make sure the code compiles on 32-bit and 64-bit platforms (x86-32,     *
 *    x86-64, ARM, ARM64, etc.).                                              *
 * 10. Make sure the code runs on platforms with weak and strong memory       *
 *     models without any issues.                                             *
 *                                                                            *
 ******************************************************************************)
unit PasMP;

{$IFDEF fpc}
  {$mode delphi}
  {$IFDEF CPUi386}
    {$DEFINE CPU386}
  {$ENDIF}
  {$IFDEF CPUAMD64}
    {$DEFINE CPUx86_64}
  {$ENDIF}
  {$IFDEF CPU386}
    {$DEFINE CPUx86}
    {$DEFINE CPU32}
    {$asmmode intel}
    {$DEFINE PasMPHaveFPUControls}
  {$ENDIF}
  {$IFDEF CPUx86_64}
    {$DEFINE CPUx64}
    {$DEFINE CPU64}
    {$asmmode intel}
    {$DEFINE PasMPHaveFPUControls}
  {$ENDIF}
  {$IFDEF FPC_LITTLE_ENDIAN}
    {$DEFINE LITTLE_ENDIAN}
  {$ELSE}
    {$IFDEF FPC_BIG_ENDIAN}
      {$DEFINE BIG_ENDIAN}
    {$ENDIF}
  {$ENDIF}
  {-$pic off}
  {$DEFINE HAS_ADVANCED_RECORDS}
  {$DEFINE CAN_INLINE}
  {$IFDEF FPC_HAS_TYPE_EXTENDED}
    {$DEFINE HAS_TYPE_EXTENDED}
  {$ELSE}
    {$UNDEF HAS_TYPE_EXTENDED}
  {$ENDIF}
  {$IFDEF FPC_HAS_TYPE_DOUBLE}
    {$DEFINE HAS_TYPE_DOUBLE}
  {$ELSE}
    {$UNDEF HAS_TYPE_DOUBLE}
  {$ENDIF}
  {$IFDEF FPC_HAS_TYPE_SINGLE}
    {$DEFINE HAS_TYPE_SINGLE}
    {}
  {$ELSE}
    {$UNDEF HAS_TYPE_SINGLE}
  {$ENDIF}
  {$IF DEFINED(FPC_FULLVERSION) and (FPC_FULLVERSION>=30301) and not DEFINED(PASMP_NO_ANONYMOUS_METHODS)}
    {$modeswitch functionreferences}
    {$modeswitch anonymousfunctions}
    {$warn 5036 off}
    {$DEFINE HAS_ANONYMOUS_METHODS}
  {$ELSE}
    {$UNDEF HAS_ANONYMOUS_METHODS}
  {$IFEND}
  {$IF DECLARED(RawByteString)}
    {$DEFINE HAS_TYPE_RAWBYTESTRING}
  {$ELSE}
    {$UNDEF HAS_TYPE_RAWBYTESTRING}
  {$IFEND}
  {$IF DECLARED(UTF8String)}
    {$DEFINE HAS_TYPE_UTF8STRING}
  {$ELSE}
    {$UNDEF HAS_TYPE_UTF8STRING}
  {$IFEND}
  {$DEFINE HAS_GENERICS}
  {$DEFINE HAS_STATIC}
  {$IF DEFINED(FPC_VERSION) and (FPC_VERSION>=3)}
    {$DEFINE HAS_NAMETHREADFORDEBUGGING}
  {$IFEND}
{$ELSE}
  {$realcompatibility off}
  {$localsymbols on}
  {$DEFINE LITTLE_ENDIAN}
  {$IFNDEF CPU64}
    {$DEFINE CPU32}
  {$ENDIF}
  {$IFDEF CPUx64}
    {$DEFINE CPUx86_64}
    {$DEFINE CPU64}
    {$DEFINE PasMPHaveFPUControls}
  {$ELSE}
    {$IFDEF CPU386}
      {$DEFINE CPUx86}
      {$DEFINE CPU32}
      {$DEFINE PasMPHaveFPUControls}
    {$ENDIF}
  {$ENDIF}
  {$DEFINE HAS_TYPE_EXTENDED}
  {$DEFINE HAS_TYPE_DOUBLE}
  {$DEFINE HAS_TYPE_SINGLE}
  {$UNDEF HAS_TYPE_RAWBYTESTRING}
  {$UNDEF HAS_TYPE_UTF8STRING}
  {$realcompatibility off}
  {$localsymbols on}
  {$DEFINE LITTLE_ENDIAN}
  {$IFNDEF cpu64}
    {$DEFINE cpu32}
  {$ENDIF}
  {$IFNDEF BCB}
    {$IFDEF ver120}
      {$DEFINE Delphi4or5}
    {$ENDIF}
    {$IFDEF ver130}
      {$DEFINE Delphi4or5}
    {$ENDIF}
    {$IFDEF ver140}
      {$DEFINE Delphi6}
    {$ENDIF}
    {$IFDEF ver150}
      {$DEFINE Delphi7}
    {$ENDIF}
    {$IFDEF ver170}
      {$DEFINE Delphi2005}
    {$ENDIF}
  {$ELSE}
    {$IFDEF ver120}
      {$DEFINE Delphi4or5}
      {$DEFINE BCB4}
    {$ENDIF}
    {$IFDEF ver130}
      {$DEFINE Delphi4or5}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF conditionalexpressions}
    {$IF CompilerVersion>=24.0}
      {$legacyifend on}
    {$IFEND}
  {$IF DECLARED(RawByteString)}
   {$DEFINE HAS_TYPE_RAWBYTESTRING}
  {$ELSE}
   {$UNDEF HAS_TYPE_RAWBYTESTRING}
  {$IFEND}
  {$IF DECLARED(UTF8String)}
   {$DEFINE HAS_TYPE_UTF8STRING}
  {$ELSE}
   {$UNDEF HAS_TYPE_UTF8STRING}
  {$IFEND}
  {$IF CompilerVersion >= 14.0}
   {$IF CompilerVersion=14.0}
    {$DEFINE Delphi6}
   {$IFEND}
   {$DEFINE Delphi6AndUp}
  {$IFEND}
  {$IF CompilerVersion >= 15.0}
   {$IF CompilerVersion=15.0}
    {$DEFINE Delphi7}
   {$IFEND}
   {$DEFINE Delphi7AndUp}
  {$IFEND}
  {$IF CompilerVersion >= 17.0}
   {$IF CompilerVersion=17.0}
    {$DEFINE Delphi2005}
   {$IFEND}
   {$DEFINE Delphi2005AndUp}
  {$IFEND}
  {$IF CompilerVersion >= 18.0}
   {$IF CompilerVersion=18.0}
    {$DEFINE BDS2006}
    {$DEFINE Delphi2006}
   {$IFEND}
   {$DEFINE Delphi2006AndUp}
   {$DEFINE CAN_INLINE}
   {$DEFINE HAS_ADVANCED_RECORDS}
  {$IFEND}
  {$IF CompilerVersion >= 18.5}
   {$IF CompilerVersion=18.5}
    {$DEFINE Delphi2007}
   {$IFEND}
   {$DEFINE Delphi2007AndUp}
  {$IFEND}
  {$IF CompilerVersion=19.0}
   {$DEFINE Delphi2007Net}
  {$IFEND}
  {$IF CompilerVersion>=20.0}
   {$IF CompilerVersion=20.0}
    {$DEFINE Delphi2009}
   {$IFEND}
   {$DEFINE Delphi2009AndUp}
   {$IFNDEF PASMP_NO_ANONYMOUS_METHODS}
    {$DEFINE HAS_ANONYMOUS_METHODS}
   {$ENDIF}
   {$DEFINE HAS_GENERICS}
   {$DEFINE HAS_STATIC}
  {$IFEND}
  {$IF CompilerVersion>=21.0}
   {$IF CompilerVersion=21.0}
    {$DEFINE Delphi2010}
   {$IFEND}
   {$DEFINE Delphi2010AndUp}
  {$IFEND}
  {$IF CompilerVersion>=22.0}
   {$IF CompilerVersion=22.0}
    {$DEFINE DelphiXE}
   {$IFEND}
   {$DEFINE DelphiXEAndUp}
  {$IFEND}
  {$IF CompilerVersion>=23.0}
   {$IF CompilerVersion=23.0}
    {$DEFINE DelphiXE2}
   {$IFEND}
   {$DEFINE DelphiXE2AndUp}
  {$IFEND}
  {$IF CompilerVersion>=24.0}
   {$IF CompilerVersion=24.0}
    {$DEFINE DelphiXE3}
   {$IFEND}
   {$DEFINE DelphiXE3AndUp}
   {$DEFINE HAS_ATOMICS}
  {$IFEND}
  {$IF CompilerVersion>=25.0}
   {$IF CompilerVersion=25.0}
    {$DEFINE DelphiXE4}
   {$IFEND}
   {$DEFINE DelphiXE4AndUp}
   {$DEFINE HAS_WEAK}
   {$DEFINE HAS_VOLATILE}
   {$DEFINE HAS_REF}
  {$IFEND}
  {$IF CompilerVersion>=26.0}
    {$IF CompilerVersion=26.0}
      {$DEFINE DelphiXE5}
    {$IFEND}
    {$DEFINE DelphiXE5AndUp}
    {$IFEND}
    {$IF CompilerVersion>=27.0}
      {$IF CompilerVersion=27.0}
        {$DEFINE DelphiXE6}
      {$IFEND}
      {$DEFINE DelphiXE6AndUp}
    {$IFEND}
    {$IF CompilerVersion>=28.0}
      {$IF CompilerVersion=28.0}
        {$DEFINE DelphiXE7}
      {$IFEND}
      {$DEFINE DelphiXE7AndUp}
    {$IFEND}
    {$IF CompilerVersion>=29.0}
      {$IF CompilerVersion=29.0}
        {$DEFINE DelphiXE8}
      {$IFEND}
      {$DEFINE DelphiXE8AndUp}
    {$IFEND}
    {$IF CompilerVersion>=30.0}
      {$IF CompilerVersion=30.0}
        {$DEFINE Delphi10Seattle}
      {$IFEND}
      {$DEFINE Delphi10SeattleAndUp}
    {$IFEND}
    {$IF CompilerVersion>=31.0}
      {$IF CompilerVersion=31.0}
        {$DEFINE Delphi10Berlin}
      {$IFEND}
      {$DEFINE Delphi10BerlinAndUp}
    {$IFEND}
    {$IF CompilerVersion>=31.0}
      {$DEFINE HAS_NAMETHREADFORDEBUGGING}
    {$IFEND}
  {$ENDIF}
  {$IFNDEF Delphi4or5}
    {$IFNDEF BCB}
      {$DEFINE Delphi6AndUp}
    {$ENDIF}
    {$IFNDEF Delphi6}
      {$DEFINE BCB6OrDelphi7AndUp}
      {$IFNDEF BCB}
        {$DEFINE Delphi7AndUp}
      {$ENDIF}
      {$IFNDEF BCB}
        {$IFNDEF Delphi7}
          {$IFNDEF Delphi2005}
            {$DEFINE BDS2006AndUp}
          {$ENDIF}
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
  {$IFDEF Delphi6AndUp}
    {$warn symbol_platform off}
    {$warn symbol_deprecated off}
  {$ENDIF}
  {$IFDEF Posix}
    {$DEFINE Unix}
  {$ENDIF}
{$ENDIF}
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64) or (DEFINED(FPC) and DEFINED(CPUAARCH64))}
  {$DEFINE PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
{$ELSEIF DEFINED(CPUARM)}
  {$IF DEFINED(CPUARMV6K)}
    // = CPUARMV6K
    {$IFDEF PASMP_FORCE_ARM_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
       {$DEFINE PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
    {$ENDIF}
  {$ELSEIF DEFINED(CPUARM_HAS_DMB) and DEFINED(CPUARM_HAS_LDREX)}
    // >= CPUARMV7A
    {$IFDEF PASMP_FORCE_ARM_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
      {$DEFINE PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
    {$ENDIF}
  {$IFEND}
{$IFEND}
{$IF DEFINED(Win32) or DEFINED(Win64) or DEFINED(WinCE)}
  {$DEFINE Windows}
{$IFEND}
{$rangechecks off}
{$extendedsyntax on}
{$writeableconst on}
{$hints off}
{$booleval off}
{$typedaddress off}
{$stackframes off}
{$varstringchecks on}
{$typeinfo on}
{$overflowchecks off}
{$longstrings on}
{$openstrings on}

{$UNDEF UseThreadLocalStorage}
{$UNDEF UseThreadLocalStorageX8632}

{$IF DEFINED(LINUX) OR DEFINED(ANDROID)}
  {$IFDEF fpc}
    {$DEFINE PasMPPThreadSpinLock}
    {$DEFINE PasMPPThreadBarrier}
  {$ELSE}
    {$UNDEF PasMPPThreadSpinLock}
    {$UNDEF PasMPPThreadBarrier}
  {$ENDIF}
{$ELSE}
  {$UNDEF PasMPPThreadSpinLock}
  {$UNDEF PasMPPThreadBarrier}
{$IFEND}

{$IFDEF PasMPUseAsStrictSingletonInstance}
{$IF DEFINED(Windows) and (DEFINED(CPU386) or DEFINED(CPUx86_64)) and not (DEFINED(FPC) or DEFINED(UseMultiplePasMPInstanceInstances))}
 // Delphi (under x86 Windows) has fast thread local storage handling (per nearly direct TEB access by reading fs:[0x18])
  {$DEFINE UseThreadLocalStorage}
  {$IFDEF cpu386}
    {$DEFINE UseThreadLocalStorageX8632}
  {$ENDIF}
  {$IFDEF cpux86_64}
    {$DEFINE UseThreadLocalStorageX8664}
  {$ENDIF}
{$ELSE}
 // FreePascal has portable but unfortunately slow thread local storage handling (for example under Windows, over TLSGetIndex
 // calls etc. in FPC_THREADVAR_RELOCATE), so use here the bit faster thread ID hash table approach with less total CPU-cycle
 // count and less OS-API calls than with the FPC_THREADVAR_RELOCATE variant
{$IFEND}
{$ENDIF}

{$DEFINE PasMPUseWakeUpConditionVariable}
{$WARN 6058 off : Call to subroutine "$1" marked as inline is not inlined}
interface

uses
{$IFDEF Windows}
  Windows,
  MMSystem,
{$ELSE}
  {$IFDEF fpc}
    {$IFDEF Unix}
      {$IFDEF usecthreads}
        cthreads,
      {$ENDIF}
      BaseUnix,
      Unix,
      UnixType,
      {$IFNDEF AndroidOld}PThreads,{$ENDIF}
      {$IF DEFINED(Linux) or DEFINED(Android)}
        Linux,
      {$ELSE}
        ctypes, Sysctl,
      {$IFEND}
    {$ENDIF}
  {$ELSE}
    {$IF DEFINED(DelphiXE2AndUp) and DEFINED(Posix)}
      Posix.Base,
      Posix.StdDef,
      Posix.SysTypes,
      Posix.SysTime,
      Posix.Time,
      Posix.Sched,
      Posix.Semaphore,
      Posix.Pthread,
      Posix.Errno,
    {$IFEND}
  {$ENDIF}
{$ENDIF}
{$IFDEF HAS_GENERICS}
  {$IF DEFINED(fpc)}
    {$IF DEFINED(FreePascalGenericsCollectionsLibrary) or (DEFINED(fpc) and (((fpc_version=3.0) and (fpc_release >= 1.0)) or (fpc_version>3.0)))}
      Generics.Defaults,
      {$DEFINE HasGenericsCollections}
    {$IFEND}
  {$ELSE}
     System.Generics.Defaults,
     {$DEFINE HasGenericsCollections}
  {$IFEND}
{$ENDIF}
  SysUtils,
  Classes,
  Math,
  LCLIntf,
  SyncObjs
  ;

type
  TPasMPInt8 = {$IF DECLARED(Int8)}Int8{$ELSE}shortint{$IFEND};
  PPasMPInt8 = ^TPasMPInt8;

  TPasMPUInt8 = {$IF DECLARED(UInt8)}UInt8{$ELSE}byte{$IFEND};
  PPasMPUInt8 = ^TPasMPUInt8;

  TPasMPInt16 = {$IF DECLARED(Int16)}Int16{$ELSE}smallint{$IFEND};
  PPasMPInt16 = ^TPasMPInt16;

  TPasMPUInt16 = {$IF DECLARED(UInt16)}UInt16{$ELSE}word{$IFEND};
  PPasMPUInt16 = ^TPasMPUInt16;

  TPasMPInt32 = {$IF DECLARED(Int32)}Int32{$ELSE}longint{$IFEND};
  PPasMPInt32 = ^TPasMPInt32;

  TPasMPUInt32 = {$IF DECLARED(UInt32)}UInt32{$ELSE}longword{$IFEND};
  PPasMPUInt32 = ^TPasMPUInt32;

  TPasMPInt64 = int64;
  PPasMPInt64 = ^TPasMPInt64;

{$IFDEF fpc}
  {$UNDEF OldDelphi}
  TPasMPUInt64 = uint64;
  TPasMPPtrUInt = PtrUInt;
  TPasMPPtrInt = PtrInt;
{$ELSE}
  {$IFDEF conditionalexpressions}
    {$IF CompilerVersion>=23.0}
      {$UNDEF OldDelphi}
  TPasMPUInt64 = uint64;
  TPasMPPtrUInt = NativeUInt;
  TPasMPPtrInt = NativeInt;
    {$ELSE}
      {$DEFINE OldDelphi}
    {$IFEND}
  {$ELSE}
    {$DEFINE OldDelphi}
  {$ENDIF}
{$ENDIF}
{$IFDEF OldDelphi}
  {$IF CompilerVersion >= 15.0}
  TPasMPUInt64 = UInt64;
  {$ELSE}
  TPasMPUInt64 = TPasMPInt64;
  {$IFEND}
  {$IFDEF CPU64}
  TPasMPPtrUInt = qword;
  TPasMPPtrInt = TPasMPInt64;
  {$ELSE}
  TPasMPPtrUInt = TPasMPUInt32;
  TPasMPPtrInt = TPasMPInt32;
  {$ENDIF}
{$ENDIF}

  PPasMPUInt64 = ^TPasMPUInt64;

  TPasMPUInt64DynamicArray = array of TPasMPUInt64;

  PPasMPPtrUInt = ^TPasMPPtrUInt;
  PPasMPPtrInt = ^TPasMPPtrInt;

  TPasMPNativeUInt = TPasMPPtrUInt;
  PPasMPNativeUInt = ^TPasMPNativeUInt;

  TPasMPNativeInt = TPasMPPtrInt;
  PPasMPNativeInt = ^TPasMPNativeInt;

  TPasMPSizeUInt = TPasMPPtrUInt;
  PPasMPSizeUInt = ^TPasMPSizeUInt;

  TPasMPSizeInt = TPasMPPtrInt;
  PPasMPSizeInt = ^TPasMPSizeInt;

  TPasMPSizeIntEx = {$IFDEF cpu64}TPasMPInt64{$ELSE}TPasMPInt32{$ENDIF};
  PPasMPSizeIntEx = ^TPasMPSizeIntEx;

  TPasMPSizeUIntEx = {$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF};
  PPasMPSizeUIntEx = ^TPasMPSizeUIntEx;

  TPasMPBoolean = Boolean;
  PPasMPBoolean = ^TPasMPBoolean;

  TPasMPBool8 = bytebool;
  PPasMPBool8 = ^TPasMPBool8;

  TPasMPBool16 = wordbool;
  PPasMPBool16 = ^TPasMPBool16;

  TPasMPBool32 = longbool;
  PPasMPBool32 = ^TPasMPBool32;

const
  PasMPAllocatorPoolBucketBits=12;
  PasMPAllocatorPoolBucketSize=1 shl PasMPAllocatorPoolBucketBits;
  PasMPAllocatorPoolBucketMask=PasMPAllocatorPoolBucketSize - 1;

  PasMPJobQueueStartSize=4096; // must be power of two

  PasMPJobWorkerThreadHashTableSize=4096;
  PasMPJobWorkerThreadHashTableMask=PasMPJobWorkerThreadHashTableSize - 1;

  PasMPDefaultDepth=16;

  PasMPJobThreadIndexBits=12; // 4096 worker threads should be enough for the first time
  PasMPJobThreadIndexSize = TPasMPUInt32(TPasMPUInt32(1) shl PasMPJobThreadIndexBits);
  PasMPJobThreadIndexMask=PasMPJobThreadIndexSize - 1;
  PasMPJobThreadIndexShift=0;
  PasMPJobThreadIndexShiftedMask=PasMPJobThreadIndexMask shl PasMPJobThreadIndexShift;

  PasMPJobPriorityBits=2; // 4 priorities (inherited, low, normal, high)
  PasMPJobPrioritySize = TPasMPUInt32(TPasMPUInt32(1) shl PasMPJobPriorityBits);
  PasMPJobPriorityMask=PasMPJobPrioritySize - 1;
  PasMPJobPriorityShift=PasMPJobThreadIndexBits;
  PasMPJobPriorityShiftedMask=PasMPJobPriorityMask shl PasMPJobPriorityShift;

  PasMPJobTagBits=12; // 4096 task tags should be enough for the first time
  PasMPJobTagSize = TPasMPUInt32(TPasMPUInt32(1) shl PasMPJobTagBits);
  PasMPJobTagMask=PasMPJobTagSize - 1;
  PasMPJobTagShift=PasMPJobThreadIndexBits+PasMPJobPriorityBits;
  PasMPJobTagShiftedMask=PasMPJobTagMask shl PasMPJobTagShift;

  PasMPJobPriorityInherited=(TPasMPUInt32(0) shl PasMPJobPriorityShift) and PasMPJobPriorityShiftedMask;
  PasMPJobPriorityLow=(TPasMPUInt32(1) shl PasMPJobPriorityShift) and PasMPJobPriorityShiftedMask;
  PasMPJobPriorityNormal=(TPasMPUInt32(2) shl PasMPJobPriorityShift) and PasMPJobPriorityShiftedMask;
  PasMPJobPriorityHigh=(TPasMPUInt32(3) shl PasMPJobPriorityShift) and PasMPJobPriorityShiftedMask;

  PasMPJobFlagRequeue = TPasMPUInt32(TPasMPUInt32(1) shl 28);
  PasMPJobFlagRequeueAndNotMask = TPasMPUInt32(not PasMPJobFlagRequeue);

  PasMPJobFlagHasOwnerWorkerThread = TPasMPUInt32(TPasMPUInt32(1) shl 29);
  PasMPJobFlagReleaseOnFinish = TPasMPUInt32(TPasMPUInt32(1) shl 30);

  PasMPJobFlagActive = TPasMPUInt32(TPasMPUInt32(1) shl 31);
  PasMPJobFlagActiveAndNotMask = TPasMPUInt32(not PasMPJobFlagActive);

  PasMPCPUCacheLineSize=64;

  PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment=SizeOf(TPasMPPtrUInt) shl 1;

  PasMPProfilerHistoryRingBufferSizeBits=16;
  PasMPProfilerHistoryRingBufferSize = TPasMPUInt32(1) shl PasMPProfilerHistoryRingBufferSizeBits;
  PasMPProfilerHistoryRingBufferSizeMask = TPasMPUInt32(PasMPProfilerHistoryRingBufferSize-1);

  PasMPOnceInit={$IFDEF Linux}PTHREAD_ONCE_INIT{$ELSE}0{$ENDIF};

  PasMPJobQueuePriorityLow=2;
  PasMPJobQueuePriorityNormal=1;
  PasMPJobQueuePriorityHigh=0;

  PasMPJobQueuePriorityFirst=PasMPJobQueuePriorityHigh;
  PasMPJobQueuePriorityLast=PasMPJobQueuePriorityLow;

  PasMPVersionMajor=1000000;
  PasMPVersionMinor=1000;
  PasMPVersionRelease=1;

{$IFNDEF FPC}
  // Delphi evaluates every $IF-directive even if it is disabled by a surrounding, so it's then a error in Delphi, and for to avoid it, we define dummys here.
  FPC_VERSION = 0;
  FPC_RELEASE = 0;
  FPC_PATCH = 0;
  FPC_FULLVERSION = (FPC_VERSION*10000) + (FPC_RELEASE*100) + (FPC_PATCH*1);
{$ENDIF}

//    FPC_VERSION_PASMP=(FPC_VERSION*PasMPVersionMajor) + (FPC_RELEASE*PasMPVersionMinor) + (FPC_PATCH*PasMPVersionRelease);

{$IFNDEF Windows}
{$IFNDEF fpc}
  INFINITE = TPasMPUInt32(-1);
{$ENDIF}
{$ENDIF}

  PasMPThreadSafeDynamicArrayFirstBucketBits=3;
  PasMPThreadSafeDynamicArrayFirstBucketSize=1 shl PasMPThreadSafeDynamicArrayFirstBucketBits;
  PasMPThreadSafeDynamicArrayNumberOfBuckets=30;
  PasMPThreadSafeDynamicArrayMarkFirstBit = TPasMPUInt32($80000000);

  PasMPCLZDebruijn32Multiplicator = TPasMPUInt32($07c4acdd);
  PasMPCLZDebruijn32Shift=27;
  PasMPCLZDebruijn32Mask=31;
  PasMPCLZDebruijn32Table: array [0..31] of TPasMPInt32=(31,22,30,21,18,10,29,2,20,17,15,13,9,6,28,1,23,19,11,3,16,14,7,24,12,4,8,25,5,26,27, 0);

  PasMPCLZDebruijn64Multiplicator: TPasMPUInt64=TPasMPUInt64($03f79d71b4cb0a89);
  PasMPCLZDebruijn64Shift=58;
  PasMPCLZDebruijn64Mask=63;
  PasMPCLZDebruijn64Table: array [0..63] of TPasMPInt32=(63,16,62,7,15,36,61,3,6,14,22,26,35,47,60,2,9,5,28,11,13,21,42,19,25,31,34,40,46,52,59,1,
                                                       17,8,37,4,23,27,48,10,29,12,43,20,32,41,53,18,38,24,49,30,44,33,54,39,50,45,55,51,56,57,58, 0);

  PasMPCTZDebruijn32Multiplicator = TPasMPUInt32($077cb531);
  PasMPCTZDebruijn32Shift=27;
  PasMPCTZDebruijn32Mask=31;
  PasMPCTZDebruijn32Table: array [0..31] of TPasMPInt32=(0,1,28,2,29,14,24,3,30,22,20,15,25,17,4,8,31,27,13,23,21,19,16,7,26,12,18,6,11,5,10,9);

  PasMPCTZDebruijn64Multiplicator: TPasMPUInt64=TPasMPUInt64($07edd5e59a4e28c2);
  PasMPCTZDebruijn64Shift=58;
  PasMPCTZDebruijn64Mask=63;
  PasMPCTZDebruijn64Table: array [0..63] of TPasMPInt32=(63, 0,58,1,59,47,53,2,60,39,48,27,54,33,42,3,61,51,37,40,49,18,28,20,55,30,34,11,43,14,22,4,
                                                       62,57,46,52,38,26,32,41,50,36,17,19,29,10,13,21,56,45,25,31,35,16,9,12,44,24,15,8,23,7,6,5);

  PasMPBSFDebruijn32Multiplicator = TPasMPUInt32($077cb531);
  PasMPBSFDebruijn32Shift=27;
  PasMPBSFDebruijn32Mask=31;
  PasMPBSFDebruijn32Table: array [0..31] of TPasMPInt32=(0,1,28,2,29,14,24,3,30,22,20,15,25,17,4,8,31,27,13,23,21,19,16,7,26,12,18,6,11,5,10,9);

  PasMPBSFDebruijn64Multiplicator: TPasMPUInt64=TPasMPUInt64($03f79d71b4cb0a89);
  PasMPBSFDebruijn64Shift=58;
  PasMPBSFDebruijn64Mask=63;
  PasMPBSFDebruijn64Table: array [0..63] of TPasMPInt32=(0,1,48,2,57,49,28,3,61,58,50,42,38,29,17,4,62,55,59,36,53,51,43,22,45,39,33,30,24,18,12,5,
                                                      63,47,56,27,60,41,37,16,54,35,52,21,44,32,23,11,46,26,40,15,34,20,31,10,25,14,19,9,13,8,7,6);

  PasMPBSRDebruijn32Multiplicator = TPasMPUInt32($07c4acdd);
  PasMPBSRDebruijn32Shift=27;
  PasMPBSRDebruijn32Mask=31;
  PasMPBSRDebruijn32Table: array [0..31] of TPasMPInt32=(0,9,1,10,13,21,2,29,11,14,16,18,22,25,3,30,8,12,20,28,15,17,24,7,19,27,23,6,26,5,4,31);

  PasMPBSRDebruijn64Multiplicator: TPasMPUInt64=TPasMPUInt64($03f79d71b4cb0a89);
  PasMPBSRDebruijn64Shift=58;
  PasMPBSRDebruijn64Mask=63;
  PasMPBSRDebruijn64Table: array [0..63] of TPasMPInt32=(0,47,1,56,48,27,2,60,57,49,41,37,28,16,3,61,54,58,35,52,50,42,21,44,38,32,29,23,17,11,4,62,
                                                       46,55,26,59,40,36,15,53,34,51,20,43,31,22,10,45,25,39,14,33,19,30,9,24,13,18,8,12,7,6,5,63);

type
  TPasMPAvailableCPUCores = array of TPasMPInt32;

  PPasMPInt128Record = ^TPasMPInt128Record;
  TPasMPInt128Record=record
{$IFDEF BIG_ENDIAN}
    Hi: TPasMPUInt64;
    Lo: TPasMPUInt64;
{$ELSE}
    Lo: TPasMPUInt64;
    Hi: TPasMPUInt64;
{$ENDIF}
  end;

  PPasMPInt64Record = ^TPasMPInt64Record;
  TPasMPInt64Record = record
    case Boolean of
      False: (
{$IFDEF BIG_ENDIAN}
        Hi: TPasMPUInt32;
        Lo: TPasMPUInt32;
{$ELSE}
        Lo: TPasMPUInt32;
        Hi: TPasMPUInt32;
{$ENDIF}
      );
      True: (
        Value: TPasMPInt64;
      );
    end;

  PPasMPTaggedPointer = ^TPasMPTaggedPointer;
  TPasMPTaggedPointer = record
    case TPasMPInt32 of
      0: (
           PointerValue: Pointer;
           TagValue: TPasMPPtrUInt;
         );
      1: (
           Value:{$IFDEF CPU64}TPasMPInt128Record{$ELSE}TPasMPInt64Record{$ENDIF};
         );
    end;

{$IFDEF Unix}
  PPasMPTimeSpec = ^TPasMPTimeSpec;
  TPasMPTimeSpec = {$IF DEFINED(fpc)}TTimeSpec{$ELSEIF DECLARED(timespec)}timespec{$ELSE}record
    tv_sec: time_t;
    tv_nsec: suseconds_t;
  end{$IFEND};

  PPasMPTimeZone = ^TPasMPTimeZone;
  TPasMPTimeZone = {$IFDEF fpc}timezone{$ELSE}record
    tz_minuteswest: TPasMPInt32;
    tz_dsttime: TPasMPInt32;
  end{$ENDIF};
{$ENDIF}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMath = class
  public
    class function PopulationCount32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function PopulationCount64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function PopulationCount(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanForward32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanForward64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanForward(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanReverse32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanReverse64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function BitScanReverse(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountLeadingZeros32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountLeadingZeros64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountLeadingZeros(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountTrailingZeros32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountTrailingZeros64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function CountTrailingZeros(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function FindFirstSetBit32(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function FindFirstSetBit64(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function FindFirstSetBit(Value: TPasMPPtrUInt): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToPowerOfTwo32(Value: TPasMPUInt32): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToPowerOfTwo64(Value: TPasMPUInt64): TPasMPUInt64; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToPowerOfTwo(Value: TPasMPPtrUInt): TPasMPPtrUInt; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToMask32(Value, Mask: TPasMPUInt32): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToMask64(Value, Mask: TPasMPUInt64): TPasMPUInt64; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function RoundUpToMask(Value, Mask: TPasMPPtrUInt): TPasMPPtrUInt; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPInterlocked = class
  public
    class function Increment(var Destination: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Increment(var Destination: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function Increment(var Destination: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Increment(var Destination: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function Decrement(var Destination: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Decrement(var Destination: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function Decrement(var Destination: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Decrement(var Destination: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function Add(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Add(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function Add(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Add(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function Sub(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Sub(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function Sub(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Sub(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class procedure BitwiseAnd(var Destination: TPasMPInt32; const Value: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseAnd(var Destination: TPasMPUInt32; const Value: TPasMPUInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$IFDEF CPU64}
    class procedure BitwiseAnd(var Destination: TPasMPInt64; const Value: TPasMPInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseAnd(var Destination: TPasMPUInt64; const Value: TPasMPUInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$ENDIF}
    class procedure BitwiseOr(var Destination: TPasMPInt32; const Value: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseOr(var Destination: TPasMPUInt32; const Value: TPasMPUInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$IFDEF CPU64}
    class procedure BitwiseOr(var Destination: TPasMPInt64; const Value: TPasMPInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseOr(var Destination: TPasMPUInt64; const Value: TPasMPUInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$ENDIF}
    class procedure BitwiseXor(var Destination: TPasMPInt32; const Value: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseXor(var Destination: TPasMPUInt32; const Value: TPasMPUInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$IFDEF CPU64}
    class procedure BitwiseXor(var Destination: TPasMPInt64; const Value: TPasMPInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
    class procedure BitwiseXor(var Destination: TPasMPUInt64; const Value: TPasMPUInt64); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(cpux86_64)}register;{$ELSE}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}{$IFEND}
{$ENDIF}
    class function ExchangeBitwiseAnd(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseAnd(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function ExchangeBitwiseAnd(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseAnd(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function ExchangeBitwiseOr(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseOr(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function ExchangeBitwiseOr(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseOr(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function ExchangeBitwiseAndOr(var Destination: TPasMPInt32; const AndValue,OrValue: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseAndOr(var Destination: TPasMPUInt32; const AndValue,OrValue: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function ExchangeBitwiseAndOr(var Destination: TPasMPInt64; const AndValue,OrValue: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseAndOr(var Destination: TPasMPUInt64; const AndValue,OrValue: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function ExchangeBitwiseXor(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseXor(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function ExchangeBitwiseXor(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function ExchangeBitwiseXor(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function Exchange(var Destination: TPasMPInt32; const Source: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Exchange(var Destination: TPasMPUInt32; const Source: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFDEF CPU64}
    class function Exchange(var Destination: TPasMPInt64; const Source: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Exchange(var Destination: TPasMPUInt64; const Source: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$ENDIF}
    class function Exchange(var Destination: Pointer; const Source: Pointer): Pointer; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Exchange(var Destination: TObject; const Source: TObject): TObject; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Exchange(var Destination: TPasMPBool32; const Source: TPasMPBool32): TPasMPBool32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TPasMPInt32; const NewValue, Comperand: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TPasMPUInt32; const NewValue, Comperand: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
    class function CompareExchange(var Destination: TPasMPInt64; const NewValue, Comperand: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TPasMPInt64Record; const NewValue, Comperand: TPasMPInt64Record): TPasMPInt64Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TPasMPUInt64; const NewValue, Comperand: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IFEND}
{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
    class function CompareExchange(var Destination: TPasMPInt128Record; const NewValue, Comperand: TPasMPInt128Record): TPasMPInt128Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(fpc)}inline;{$IFEND}
{$IFEND}
    class function CompareExchange(var Destination: Pointer; const NewValue, Comperand: Pointer): Pointer; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TObject; const NewValue, Comperand: TObject): TObject; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function CompareExchange(var Destination: TPasMPBool32; const NewValue, Comperand: TPasMPBool32): TPasMPBool32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
    class function Read(var Source: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TPasMPInt64Record): TPasMPInt64Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
    class function Read(var Source: TPasMPInt128Record): TPasMPInt128Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(fpc)}inline;{$IFEND}
{$IFEND}
{$IFEND}
    class function Read(var Source: Pointer): Pointer; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TObject): TObject; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Read(var Source: TPasMPBool32): TPasMPBool32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TPasMPInt32; const Source: TPasMPInt32): TPasMPInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TPasMPUInt32; const Source: TPasMPUInt32): TPasMPUInt32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
    class function Write(var Destination: TPasMPInt64; const Source: TPasMPInt64): TPasMPInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TPasMPInt64Record; const Source: TPasMPInt64Record): TPasMPInt64Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TPasMPUInt64; const Source: TPasMPUInt64): TPasMPUInt64; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
    class function Write(var Destination: TPasMPInt128Record; const Source: TPasMPInt128Record): TPasMPInt128Record; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(fpc)}inline;{$IFEND}
{$IFEND}
{$IFEND}
    class function Write(var Destination: Pointer; const Source: Pointer): Pointer; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TObject; const Source: TObject): TObject; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
    class function Write(var Destination: TPasMPBool32; const Source: TPasMPBool32): TPasMPBool32; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPAtomic = class(TPasMPInterlocked);
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

  {$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMemoryBarrier = class
  public
    class procedure Read; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class procedure ReadDependency; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class procedure ReadWrite; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class procedure Write; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class procedure Sync; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMemory = class
  public
    class procedure AllocateAlignedMemory(var p; Size: TPasMPInt32; Align: TPasMPInt32 = PasMPCPUCacheLineSize); {$IFDEF HAS_STATIC}static;{$ENDIF}
    class procedure FreeAlignedMemory(const p); {$IFDEF HAS_STATIC}static;{$ENDIF}
    class procedure Barrier; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

  PPPasMPHighResolutionTime = ^PPasMPHighResolutionTime;
  PPasMPHighResolutionTime = ^TPasMPHighResolutionTime;
  TPasMPHighResolutionTime = TPasMPInt64;

  TPasMPHighResolutionTimer = class
  private
    fFrequency: TPasMPInt64;
    fFrequencyShift: TPasMPInt32;
    fMillisecondInterval: TPasMPHighResolutionTime;
    fTwoMillisecondsInterval: TPasMPHighResolutionTime;
    fFourMillisecondsInterval: TPasMPHighResolutionTime;
    fQuarterSecondInterval: TPasMPHighResolutionTime;
    fMinuteInterval: TPasMPHighResolutionTime;
    fHourInterval: TPasMPHighResolutionTime;
  public
    constructor Create;
    destructor Destroy; override;
    function GetTime: TPasMPInt64;
    procedure Sleep(const pDelay: TPasMPHighResolutionTime);
    function ToFloatSeconds(const pTime: TPasMPHighResolutionTime):double;
    function FromFloatSeconds(const pTime:double): TPasMPHighResolutionTime;
    function ToMilliseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
    function FromMilliseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
    function ToMicroseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
    function FromMicroseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
    function ToNanoseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
    function FromNanoseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
    property Frequency: TPasMPInt64 read fFrequency;
    property MillisecondInterval: TPasMPHighResolutionTime read fMillisecondInterval;
    property TwoMillisecondsInterval: TPasMPHighResolutionTime read fTwoMillisecondsInterval;
    property FourMillisecondsInterval: TPasMPHighResolutionTime read fFourMillisecondsInterval;
    property QuarterSecondInterval: TPasMPHighResolutionTime read fQuarterSecondInterval;
    property SecondInterval: TPasMPHighResolutionTime read fFrequency;
    property MinuteInterval: TPasMPHighResolutionTime read fMinuteInterval;
    property HourInterval: TPasMPHighResolutionTime read fHourInterval;
  end;

  TPasMP = class;

  PPasMPOnce = ^TPasMPOnce;
  TPasMPOnce = {$IFDEF Linux}pthread_once_t{$ELSE}TPasMPInt32{$ENDIF};

  TPasMPOnceInitRoutine={$IFDEF fpc}TProcedure{$ELSE}procedure{$ENDIF};

  TPasMPEvent = class(TEvent);

  TPasMPSimpleEvent = class(TPasMPEvent)
  public
    constructor Create;
  end;


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
{$IF DEFINED(fpc)}
  TPasMPCriticalSectionInstance = TRTLCriticalSection;
{$ELSEIF DEFINED(POSIX)}
  TPasMPCriticalSectionInstance = TObject;
{$ELSE}
  TPasMPCriticalSectionInstance = TRTLCriticalSection;
{$IFEND}

  TPasMPCriticalSection = class(TCriticalSection)
  protected
{$IF not DEFINED(Darwin)}
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPCriticalSectionInstance))-1] of TPasMPUInt8;
{$IFEND}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMutex = class(TSynchroObject)
{$IF DEFINED(Windows)}
  private
    fMutex:THandle;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPCriticalSectionInstance))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
  private
    fMutex:pthread_mutex_t;
  protected
{$IF not DEFINED(Darwin)}
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(pthread_mutex_t))-1] of TPasMPUInt8;
{$IFEND}
{$ELSE}
  private
    fCriticalSection: TPasMPCriticalSection;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPCriticalSection))-1] of TPasMPUInt8;
{$IFEND}
  public
    constructor Create; overload;
{$IF DEFINED(Unix)}
    constructor Create(const lpMutexAttributes: Pointer); overload;
{$ELSEIF DEFINED(Windows)}
    constructor Create(const lpMutexAttributes: Pointer; const bInitialOwner: Boolean; const lpName: string); overload;
    constructor Create(const DesiredAccess: TPasMPUInt32; const bInitialOwner: Boolean; const lpName: string); overload;
{$IFEND}
    destructor Destroy; override;
    procedure Acquire; override;
    procedure Release; override;
{$IF DEFINED(Windows)}
    property Mutex:THandle read fMutex;
{$ELSEIF DEFINED(Unix)}
    property Mutex:pthread_mutex_t read fMutex;
{$ELSE}
    property CriticalSection: TPasMPCriticalSection read fCriticalSection;
{$IFEND}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)} {$pop} {$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)} {$push} {$optimization noorderfields}{$IFEND}
  TPasMPConditionVariableLock = class(TSynchroObject)
{$IF DEFINED(Windows)}
  private
  {$IFDEF FPC}
    FCriticalSection: TCriticalSection;
  {$ELSE}
    FCriticalSection: TRTLCriticalSection;
  {$ENDIF}
  protected
    fCacheLineFillUp: array[0..(PasMPCPUCacheLineSize-SizeOf(TRTLCriticalSection))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
  private
    fMutex: pthread_mutex_t;
  protected
{$IF not DEFINED(Darwin)}
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(pthread_mutex_t))-1] of TPasMPUInt8;
{$IFEND}
{$ELSE}
  private
    fCriticalSection: TPasMPCriticalSection;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPCriticalSection))-1] of TPasMPUInt8;
{$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Acquire; override;
    procedure Release; override;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF Windows}
  PPasMPConditionVariableData = ^TPasMPConditionVariableData;
  TPasMPConditionVariableData = Pointer;
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPConditionVariable = class
{$IF DEFINED(Windows)}
  private
    fConditionVariable: TPasMPConditionVariableData;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPConditionVariableData))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
  private
    fConditionVariable:pthread_cond_t;
    fConditionVariableAttributes:pthread_condattr_t;
    fHasConditionVariableAttributes: TPasMPBool32;
    fClockID: TPasMPInt32;
  protected
    fCacheLineFillUp: array [0..((PasMPCPUCacheLineSize*2) - (SizeOf(pthread_cond_t)+SizeOf(pthread_condattr_t)+SizeOf(TPasMPBool32)+SizeOf(TPasMPInt32)))-1] of TPasMPUInt8;
{$ELSE}
  private
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fWaitCounter: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fReleaseCounter: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fGenerationCounter: TPasMPInt32;
    fCriticalSection: TPasMPCriticalSection;
    fEvent: TPasMPEvent;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*3)+SizeOf(TPasMPCriticalSection)+SizeOf(TPasMPEvent)))-1] of TPasMPUInt8;
{$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure Signal; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure Broadcast; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    function Wait(const Lock: TPasMPConditionVariableLock; const dwMilliSeconds: TPasMPUInt32=INFINITE): TWaitResult; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPSemaphore = class(TSynchroObject)
  private
    fInitialCount: TPasMPInt32;
    fMaximumCount: TPasMPInt32;
{$IF DEFINED(Windows)}
    fHandle:THandle;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*2)+SizeOf(THandle)))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
    fHandle:{$IFDEF fpc}TPasMPInt32{$ELSE}sem_t{$ENDIF};
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*2)+SizeOf({$IFDEF fpc}TPasMPInt32{$ELSE}sem_t{$ENDIF})))-1] of TPasMPUInt8;
{$ELSE}
{$DEFINE PasMPSemaphoreUseConditionVariable}
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fCurrentCount: TPasMPInt32;
{$IFDEF PasMPSemaphoreUseConditionVariable}
    fConditionVariableLock: TPasMPConditionVariableLock;
    fConditionVariable: TPasMPConditionVariable;
{$ELSE}
    fCriticalSection: TPasMPCriticalSection;
    fEvent: TPasMPEvent;
{$ENDIF}
  protected
{$IFDEF PasMPSemaphoreUseConditionVariable}
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*3)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
{$ELSE}
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*3)+SizeOf(TPasMPCriticalSection)+SizeOf(TPasMPEvent)))-1] of TPasMPUInt8;
{$ENDIF}
{$IFEND}
  public
    constructor Create(const InitialCount, MaximumCount: TPasMPInt32);
    destructor Destroy; override;
    procedure Acquire; overload; override;
    procedure Release; overload; override;
    function Acquire(const AcquireCount: TPasMPInt32): TWaitResult; reintroduce; overload;
    function Release(const ReleaseCount: TPasMPInt32): TPasMPInt32; reintroduce; overload;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPInvertedSemaphore = class(TSynchroObject)
  private
    fInitialCount: TPasMPInt32;
    fMaximumCount: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fCurrentCount: TPasMPInt32;
    fConditionVariableLock: TPasMPConditionVariableLock;
    fConditionVariable: TPasMPConditionVariable;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*3)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
  public
    constructor Create(const InitialCount, MaximumCount: TPasMPInt32);
    destructor Destroy; override;
    procedure Acquire; overload; override; // Acquire a number of resource elements. It never blocks.
    procedure Release; overload; override; // Release a number of resource elements. It never blocks, but it may wake up waiting threads.
    function Acquire(const AcquireCount: TPasMPInt32; out Count: TPasMPInt32): TPasMPInt32; reintroduce; overload;
    function Release(const ReleaseCount: TPasMPInt32; out Count: TPasMPInt32): TPasMPInt32; reintroduce; overload;
    function Wait(const dwMilliSeconds: TPasMPUInt32=INFINITE): TWaitResult; // Block until the inverted semaphore reaches zero
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF Windows}
     PPasMPSRWLock = ^TPasMPSRWLock;
     TPasMPSRWLock=Pointer;
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMultipleReaderSingleWriterLock = class(TInterfacedObject, iReadWriteSync)
{$IF DEFINED(Windows)}
  private
    fSRWLock: TPasMPSRWLock;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSRWLock))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
  private
    fReadWriteLock:pthread_rwlock_t;
  protected
{$IF not (DEFINED(CPUAArch64) or DEFINED(Darwin))}
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(pthread_rwlock_t))-1] of TPasMPUInt8;
{$IFEND}
{$ELSE}
  private
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fReaders: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fWriters: TPasMPInt32;
    fConditionVariableLock: TPasMPConditionVariableLock;
    fConditionVariable: TPasMPConditionVariable;
  protected
    fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*2)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
{$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure AcquireRead; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    function TryAcquireRead: Boolean; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure ReleaseRead; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure AcquireWrite; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    function TryAcquireWrite: Boolean; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure ReleaseWrite; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure ReadToWrite; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure WriteToRead; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure BeginRead;
    procedure EndRead;
    function BeginWrite: Boolean;
    procedure EndWrite;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPMultipleReaderSingleWriterSpinLock = class(TInterfacedObject, iReadWriteSync)
      private
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fState: TPasMPInt32;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*2)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
      public
       constructor Create;
       destructor Destroy; override;
       procedure AcquireRead; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       function TryAcquireRead: Boolean; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure ReleaseRead; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure AcquireWrite; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       function TryAcquireWrite: Boolean; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure ReleaseWrite; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure ReadToWrite; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure WriteToRead; overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       procedure BeginRead;
       procedure EndRead;
       function BeginWrite: Boolean;
       procedure EndWrite;
       class procedure AcquireRead(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class function TryAcquireRead(var LockState: TPasMPInt32): Boolean; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class procedure ReleaseRead(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class procedure AcquireWrite(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class function TryAcquireWrite(var LockState: TPasMPInt32): Boolean; overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class procedure ReleaseWrite(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class procedure ReadToWrite(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
       class procedure WriteToRead(var LockState: TPasMPInt32); overload; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(HAS_ATOMICS) or DEFINED(fpc)}inline;{$IFEND}
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPSlimReaderWriterLock = class(TSynchroObject)
{$IF DEFINED(Windows)}
      private
       fSRWLock: TPasMPSRWLock;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSRWLock))-1] of TPasMPUInt8;
{$ELSEIF DEFINED(Unix)}
      private
       fReadWriteLock:pthread_rwlock_t;
      protected
{$IF not (DEFINED(CPUAArch64) or DEFINED(Darwin))}
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(pthread_rwlock_t))-1] of TPasMPUInt8;
{$IFEND}
{$ELSE}
      private
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fCount: TPasMPInt32;
       fConditionVariableLock: TPasMPConditionVariableLock;
       fConditionVariable: TPasMPConditionVariable;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - (SizeOf(TPasMPInt32)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
{$IFEND}
      public
       constructor Create;
       destructor Destroy; override;
       procedure Acquire; override;
       function TryAcquire: Boolean;
       procedure Release; override;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(PasMPPThreadSpinLock)}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     PPasMPSpinLockPThreadSpinLock = ^TPasMPSpinLockPThreadSpinLock;
{$IFDEF Android}
     TPasMPSpinLockPThreadSpinLock=TPasMPInt32;
{$ELSE}
     TPasMPSpinLockPThreadSpinLock=pthread_spinlock_t;
{$ENDIF}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPSpinLock = class(TSynchroObject)
{$IF DEFINED(PasMPPThreadSpinLock)}
      private
       fSpinLock: TPasMPSpinLockPThreadSpinLock;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSpinLockPThreadSpinLock))-1] of TPasMPUInt8;
{$ELSE}
      private
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fState: TPasMPInt32;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8;
{$IFEND}
      public
       constructor Create;
       destructor Destroy; override;
       procedure Acquire; override;
       function TryAcquire: longbool; {$IF not DEFINED(Unix)}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$IFEND}{$IFEND}
       procedure Release; override;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPBenaphore = class(TSynchroObject)
      private
       fSemaphore: TPasMPSemaphore;
       fLockCount: TPasMPUInt32;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - (SizeOf(TPasMPSemaphore)+SizeOf(TPasMPUInt32)))-1] of TPasMPUInt8;
      public
       constructor Create;
       destructor Destroy; override;
       procedure Acquire; override;
       function TryAcquire: longbool; {$IF not DEFINED(Unix)}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$IFEND}{$IFEND}
       procedure Release; override;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

     EPasMPRecursiveBenaphore = class(Exception);

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPRecursiveBenaphore = class(TSynchroObject)
      private
       fSemaphore: TPasMPSemaphore;
       fOwningThreadID:{$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF};
       fLockCount: TPasMPUInt32;
       fRecursionCount: TPasMPUInt32;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - (SizeOf(TPasMPSemaphore)+SizeOf({$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF}) + (SizeOf(TPasMPUInt32)*2)))-1] of TPasMPUInt8;
      public
       constructor Create;
       destructor Destroy; override;
       procedure Acquire; override;
       function TryAcquire: longbool; {$IF not DEFINED(Unix)}{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}register;{$ELSE}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$IFEND}{$IFEND}
       procedure Release; override;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(PasMPPThreadBarrier)}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     PPasMPSpinLockPThreadBarrier = ^TPasMPSpinLockPThreadBarrier;
{$IF DEFINED(Android)}
     PPasMPSpinLockPThreadFastLock = ^TPasMPSpinLockPThreadFastLock;
     TPasMPSpinLockPThreadFastLock={$IFDEF fpc}_pthread_fastlock{$ELSE}record
      __status: TPasMPInt32;
      __spinlock: TPasMPInt32;
     end{$ENDIF};
     TPasMPSpinLockPThreadBarrier=record
      __ba_lock: TPasMPSpinLockPThreadFastLock;
      __ba_required: TPasMPInt32;
      __ba_present: TPasMPInt32;
      __ba_waiting: Pointer{_pthread_descr};
     end;
{$ELSE}
     TPasMPSpinLockPThreadBarrier=pthread_barrier_t;
{$IFEND}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPBarrier=class
{$IF DEFINED(PasMPPThreadBarrier)}
      private
       fBarrier: TPasMPSpinLockPThreadBarrier;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSpinLockPThreadBarrier))-1] of TPasMPUInt8;
{$ELSE}
      private
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fCount: TPasMPInt32;
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fTotal: TPasMPInt32;
       fConditionVariableLock: TPasMPConditionVariableLock;
       fConditionVariable: TPasMPConditionVariable;
      protected
       fCacheLineFillUp: array [0..(PasMPCPUCacheLineSize - ((SizeOf(TPasMPInt32)*2)+SizeOf(TPasMPConditionVariableLock)+SizeOf(TPasMPConditionVariable)))-1] of TPasMPUInt8;
{$IFEND}
      public
       constructor Create(const Count: TPasMPInt32);
       destructor Destroy; override;
       function Wait: Boolean; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

     PPasMPThreadSafeStackEntry = ^TPasMPThreadSafeStackEntry;
     TPasMPThreadSafeStackEntry=Pointer;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     // The lock-free variant is based on the idea behind the concept of the internal workings of the "Interlocked Singly Linked Lists" Windows API, just stripped by the Depth stuff
     // The lock-based variant is based of my head
     TPasMPThreadSafeStack=class // only for PasMP internal usage
      private
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
       fHead:PPasMPTaggedPointer;
{$ELSE}
       fCriticalSection: TPasMPCriticalSection;
       fHead: Pointer;
{$ENDIF}
      public
       constructor Create;
       destructor Destroy; override;
       procedure Clear; {$IFDEF CAN_INLINE}inline;{$ENDIF}
       function IsEmpty: Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
       function Push(const Item: Pointer): Pointer; {$IFDEF CAN_INLINE}inline;{$ENDIF}
       function Pop: Pointer; {$IFDEF CAN_INLINE}inline;{$ENDIF}
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

     PPasMPThreadSafeQueueNode = ^TPasMPThreadSafeQueueNode;
     TPasMPThreadSafeQueueNode=record
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
      Previous: TPasMPTaggedPointer;
      Next: TPasMPTaggedPointer;
{$ELSE}
      Next: Pointer;
{$ENDIF}
      Data:record
       // Empty
      end;
     end;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
{$DEFINE PASMP_USE_OPTIMISTIC_FIFO_QUEUE}
{$IFDEF PASMP_USE_OPTIMISTIC_FIFO_QUEUE}
     // The lock-free variant is based on http://people.csail.mit.edu/edya/publications/OptimisticFIFOQueue-journal.pdf
{$ELSE}
     // The lock-free variant is based on M. M. Michael and M. L. Scott "Simple, fast, and practical non-blocking and blocking concurrent queue algorithms" together with tagged Pointer counters
{$ENDIF}
     // The lock-based variant is based on the two-lock concurrent queue
     TPasMPThreadSafeQueue=class // only for PasMP internal usage
      private
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
       fHead:PPasMPTaggedPointer;
       fTail:PPasMPTaggedPointer;
{$ELSE}
       fHeadCriticalSection: TPasMPCriticalSection;
       fTailCriticalSection: TPasMPCriticalSection;
       fHead: PPasMPThreadSafeQueueNode;
       fTail: PPasMPThreadSafeQueueNode;
{$ENDIF}
       fItemSize: TPasMPInt32;
       fInternalNodeSize: TPasMPInt32;
       fAddCPUCacheLinePaddingToInternalItemDataStructure: Boolean;
      protected
       procedure InitializeItem(const Data: Pointer); virtual;
       procedure FinalizeItem(const Data: Pointer); virtual;
       procedure CopyItem(const Source,Destination: Pointer); virtual;
      public
       constructor Create(ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
       destructor Destroy; override;
       procedure Clear; {$IFNDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       function IsEmpty: Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
       procedure Enqueue(const Item); {$IFNDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
       function Dequeue(out Item): Boolean; {$IFNDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

     PPasMPThreadSafeBoundedArrayBasedQueueItemNode = ^TPasMPThreadSafeBoundedArrayBasedQueueItemNode;
     TPasMPThreadSafeBoundedArrayBasedQueueItemNode=record
      Sequence: TPasMPUInt32;
      Data:record
       // Empty
      end;
     end;

     EPasMPThreadSafeBoundedArrayBasedQueue = class(Exception);

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPThreadSafeBoundedArrayBasedQueue=class // only for TPasMP internal usage
      private
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fData: Pointer;
       fMaximalCount: TPasMPUInt32;
       fMask: TPasMPUInt32;
       fItemSize: TPasMPUInt32;
       fInternalItemSize: TPasMPUInt32;
      protected
       fCacheLineFillUp0: array [0..(PasMPCPUCacheLineSize - (SizeOf(Pointer) + (SizeOf(TPasMPUInt32)*4)))-1] of TPasMPUInt8; // for to force fields to different CPU cache lines
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fHeadSequence: TPasMPUInt32;
       fCacheLineFillUp1: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPUInt32))-1] of TPasMPUInt8; // for to force fields to different CPU cache lines
       {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fTailSequence: TPasMPUInt32;
       fCacheLineFillUp2: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPUInt32))-1] of TPasMPUInt8; // for to force fields to different CPU cache lines
      protected
       procedure InitializeItem(const Data: Pointer); virtual;
       procedure FinalizeItem(const Data: Pointer); virtual;
       procedure CopyItem(const Source,Destination: Pointer); virtual;
      public
       constructor Create(const MaximalCount, itemSize: TPasMPUInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
       destructor Destroy; override;
       procedure Clear;
       function IsEmpty: Boolean;
       function IsFull: Boolean;
       function Enqueue(const Item): Boolean;
       function Dequeue(out Item): Boolean;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

  TPasMPThreadSafeHashTableHash = TPasMPUInt32;

  PPasMPThreadSafeHashTableItem = ^TPasMPThreadSafeHashTableItem;
  TPasMPThreadSafeHashTableItem = record
    case TPasMPInt32 of
      0: (
          Lock: TPasMPInt32;
          State: TPasMPInt32;
          Hash: TPasMPThreadSafeHashTableHash;
          Data: record
            // Empty
          end;
          );
      1: ( LockState: TPasMPInt64Record; );
    end;

  PPasMPThreadSafeHashTableState = ^TPasMPThreadSafeHashTableState;
  TPasMPThreadSafeHashTableState = record
    case TPasMPInt32 of
      0: (
          Previous: PPasMPThreadSafeHashTableState;
          Next: PPasMPThreadSafeHashTableState;
          ReferenceCounter: TPasMPInt32;
          Version: TPasMPInt32;
          Size: TPasMPInt32;
          Mask: TPasMPInt32;
          LogSize: TPasMPInt32;
          Count: TPasMPInt32;
          Items: Pointer;
          );
      1: ( FillUp: array [0..(PasMPCPUCacheLineSize*(SizeOf(TPasMPPtrUInt) div SizeOf(TPasMPUInt32)))-1] of TPasMPUInt8; );
    end;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     // A thread-safe hash table with open addressing and double-hashing-like probing (two values from one single hash value)
     // The read operation is almost lock-free until the read-acquisition of the multiple-reader-single-writer-lock of a hash item,
     // since a item value can larger than one and two native maschine words
     // The write operations are almost multiple-reader-single-writer-lock-based
     // Why not complete lock-free? => Because TPasMPThreadSafeHashTable should be universal usable independently by the key and
     // value data types and also key-and-value-object-reference-counting-free as much as possble.
  TPasMPThreadSafeHashTable = class // only for PasMP internal usage
  private
    fCriticalSection: TPasMPCriticalSection;
    fLock: TPasMPMultipleReaderSingleWriterSpinLock;
    fResizeLock: TPasMPMultipleReaderSingleWriterSpinLock;
    fItemSize: TPasMPInt32;
    fInternalItemSize: TPasMPInt32;
    fGrowLoadFactor: TPasMPInt32; // 24.7 bit fixed point
    fFirstState: PPasMPThreadSafeHashTableState;
    fLastState: PPasMPThreadSafeHashTableState;
    fVersion: TPasMPInt32;
    function GetGrowLoadFactor:single;
    procedure SetGrowLoadFactor(const NewGrowLoadFactor:single);
    function CreateState: PPasMPThreadSafeHashTableState;
    procedure FreeState(const State: PPasMPThreadSafeHashTableState);
    function AcquireState: PPasMPThreadSafeHashTableState; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure ReleaseState(const State: PPasMPThreadSafeHashTableState); {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Clear;
    function SetKeyValueOnState(const CurrentState: PPasMPThreadSafeHashTableState; const Key,Value: Pointer): Boolean;
    function UnderGrowLoadFactor(const CurrentState: PPasMPThreadSafeHashTableState): Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Grow;
  protected
    procedure InitializeItem(const Data: Pointer); virtual;
    procedure FinalizeItem(const Data: Pointer); virtual;
    procedure CopyItem(const Source,Destination: Pointer); virtual;
    procedure GetKey(const Data,Key: Pointer); virtual;
    procedure SetKey(const Data,Key: Pointer); virtual;
    procedure GetValue(const Data,Value: Pointer); virtual;
    procedure SetValue(const Data,Value: Pointer); virtual;
    function HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash; virtual;
    function CompareKey(const Data,Key: Pointer): Boolean; virtual;
    function GetKeyValue(const Key,Value: Pointer): Boolean;
    function SetKeyValue(const Key,Value: Pointer): Boolean;
    function DeleteKey(const Key: Pointer): Boolean;
  public
    constructor Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    property GrowLoadFactor:single read GetGrowLoadFactor write SetGrowLoadFactor;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  PPasMPThreadSafeDynamicArrayBuckets = ^TPasMPThreadSafeDynamicArrayBuckets;
  TPasMPThreadSafeDynamicArrayBuckets = array [0..PasMPThreadSafeDynamicArrayNumberOfBuckets-1] of Pointer;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPThreadSafeDynamicArray = class // only for PasMP internal usage
  private
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fSize: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fItemSize: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fItemLockOffset: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fInternalItemSize: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fAllocated: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fCountBuckets: TPasMPInt32;
    fLock: TPasMPMultipleReaderSingleWriterSpinLock;
    fBuckets: TPasMPThreadSafeDynamicArrayBuckets;
  protected
    procedure InitializeItem(const ItemData: Pointer); virtual;
    procedure FinalizeItem(const ItemData: Pointer); virtual;
    procedure CopyItem(const Source,Destination: Pointer); virtual;
    procedure SetSize(const NewSize: TPasMPInt32);
    function GetItem(const ItemIndex: TPasMPInt32; const ItemData: Pointer): Boolean;
    function SetItem(const ItemIndex: TPasMPInt32; const ItemData: Pointer): Boolean;
    function Push(const ItemData: Pointer): TPasMPInt32;
    function Pop(const ItemData: Pointer): Boolean;
  public
    constructor Create(const aItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    procedure Clear; virtual;
    property Size: TPasMPInt32 read fSize write SetSize;
    property ItemSize: TPasMPInt32 read fItemSize;
    property Allocated: TPasMPInt32 read fAllocated;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPSingleProducerSingleConsumerRingBuffer = class
  protected
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fReadIndex: TPasMPInt32;
    fCacheLineFillUp0: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fReadIndex and fWriteIndex to different CPU cache lines
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fWriteIndex: TPasMPInt32;
    fCacheLineFillUp1: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fWriteIndex and fData to different CPU cache lines
    fData: array of TPasMPUInt8;
    fSize: TPasMPInt32;
    fLockState: TPasMPInt32;
    fCacheLineFillUp2: array [0..(PasMPCPUCacheLineSize - (SizeOf(Pointer)+SizeOf(TPasMPInt32)+SizeOf(TPasMPInt32)))-1] of TPasMPUInt8; // as CPU cache line alignment
  public
    constructor Create(const Size: TPasMPInt32);
    destructor Destroy; override;
    procedure Clear;
    function Read(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function TryRead(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function ReadAsMuchAsPossible(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function Write(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function TryWrite(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function WriteAsMuchAsPossible(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
    function AvailableForRead: TPasMPInt32;
    function AvailableForWrite: TPasMPInt32;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPSingleProducerSingleConsumerBoundedQueue=class
  protected
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fReadIndex: TPasMPInt32;
    fCacheLineFillUp0: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fReadIndex and fWriteIndex to different CPU cache lines
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fWriteIndex: TPasMPInt32;
    fCacheLineFillUp1: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fWriteIndex and fData to different CPU cache lines
    fData: array of TPasMPUInt8;
    fMaximalCount: TPasMPInt32;
    fItemSize: TPasMPInt32;
    fCacheLineFillUp2: array [0..(PasMPCPUCacheLineSize - (SizeOf(Pointer)+SizeOf(TPasMPInt32)))-1] of TPasMPUInt8; // as CPU cache line alignment
  public
    constructor Create(const MaximalCount, itemSize: TPasMPInt32);
    destructor Destroy; override;
    function Enqueue(const Item): Boolean;
    function Dequeue(out Item): Boolean;
    function AvailableForEnqueue: TPasMPInt32;
    function AvailableForDequeue: TPasMPInt32;
    function IsFull: Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPSingleProducerSingleConsumerBoundedQueue<T>=class
  protected
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fReadIndex: TPasMPInt32;
    fCacheLineFillUp0: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fReadIndex and fWriteIndex to different CPU cache lines
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fWriteIndex: TPasMPInt32;
    fCacheLineFillUp1: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPInt32))-1] of TPasMPUInt8; // for to force fWriteIndex and fData to different CPU cache lines
    fData: array of T;
    fMaximalCount: TPasMPInt32;
    fCacheLineFillUp2: array [0..(PasMPCPUCacheLineSize - (SizeOf(Pointer)+SizeOf(TPasMPInt32)))-1] of TPasMPUInt8; // as CPU cache line alignment
  public
    constructor Create(const MaximalCount: TPasMPInt32);
    destructor Destroy; override;
    function Enqueue(const Item: T): Boolean;
    function Dequeue(out Item: T): Boolean;
    function AvailableForEnqueue: TPasMPInt32;
    function AvailableForDequeue: TPasMPInt32;
    function IsFull: Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


  PPasMPBoundedStackItem = ^TPasMPBoundedStackItem;
  TPasMPBoundedStackItem = record
    Next: TPasMPThreadSafeStackEntry;
    Data: record
      // Empty
    end;
  end;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedStack = class
  private
    fStack: TPasMPThreadSafeStack;
    fFree: TPasMPThreadSafeStack;
    fData: Pointer;
    fMaximalCount: TPasMPInt32;
    fItemSize: TPasMPInt32;
    fInternalItemSize: TPasMPInt32;
  public
    constructor Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsFull: Boolean;
    function Push(const Item): Boolean;
    function Pop(out Item): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedStack<T> = class
  private
    type
      PPasMPBoundedTypedStackItem = ^TPasMPBoundedTypedStackItem;
      TPasMPBoundedTypedStackItem = record
        Next: TPasMPThreadSafeStackEntry;
        Data: T;
      end;
  private
    fStack: TPasMPThreadSafeStack;
    fFree: TPasMPThreadSafeStack;
    fData: Pointer;
    fMaximalCount: TPasMPInt32;
    fInternalItemSize: TPasMPInt32;
  public
    constructor Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsFull: Boolean;
    function Push(const Item: T): Boolean;
    function Pop(out Item: T): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


  PPasMPUnboundedStackItem = ^TPasMPUnboundedStackItem;
  TPasMPUnboundedStackItem = record
    Next: TPasMPThreadSafeStackEntry;
    Data: record
      // Empty
    end;
  end;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPUnboundedStack = class
  private
    fStack: TPasMPThreadSafeStack;
    fItemSize: TPasMPInt32;
    fAddCPUCacheLinePaddingToInternalItemDataStructure: Boolean;
  public
    constructor Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function Push(const Item): Boolean;
    function Pop(out Item): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPUnboundedStack<T> = class
  private
    type
      PPasMPUnboundedTypedStackItem = ^TPasMPUnboundedTypedStackItem;
      TPasMPUnboundedTypedStackItem = record
        Next: TPasMPThreadSafeStackEntry;
        Data: T;
      end;
  private
    fStack: TPasMPThreadSafeStack;
    fItemSize: TPasMPInt32;
    fAddCPUCacheLinePaddingToInternalItemDataStructure: Boolean;
  public
    constructor Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function Push(const Item: T): Boolean;
    function Pop(out Item: T): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


  PPasMPBoundedQueueItem = ^TPasMPBoundedQueueItem;
  TPasMPBoundedQueueItem = record
    Next: TPasMPThreadSafeStackEntry;
    Data:record
      // Empty
    end;
  end;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedQueue = class
  private
    fQueue: TPasMPThreadSafeQueue;
    fFree: TPasMPThreadSafeStack;
    fData: Pointer;
    fMaximalCount: TPasMPInt32;
    fItemSize: TPasMPInt32;
    fInternalItemSize: TPasMPInt32;
  public
    constructor Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsFull: Boolean;
    function Enqueue(const Item): Boolean;
    function Dequeue(out Item): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedQueue<T>=class
  private
    type
      PPasMPBoundedTypedQueueItem = ^TPasMPBoundedTypedQueueItem;
      TPasMPBoundedTypedQueueItem = record
        Next: TPasMPThreadSafeStackEntry;
        Data: T;
      end;
  private
    fQueue: TPasMPThreadSafeQueue;
    fFree: TPasMPThreadSafeStack;
    fData: Pointer;
    fMaximalCount: TPasMPInt32;
    fInternalItemSize: TPasMPInt32;
  public
    constructor Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsFull: Boolean;
    function Enqueue(const Item: T): Boolean;
    function Dequeue(out Item: T): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedArrayBasedQueue = class(TPasMPThreadSafeBoundedArrayBasedQueue)
  public
    constructor Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True); reintroduce;
    destructor Destroy; override;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPBoundedArrayBasedQueue<T> = class(TPasMPThreadSafeBoundedArrayBasedQueue)
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
  public
    constructor Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True); reintroduce;
    destructor Destroy; override;
    function Enqueue(const Item: T): Boolean; reintroduce;
    function Dequeue(out Item: T): Boolean; reintroduce;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPUnboundedQueue = class(TPasMPThreadSafeQueue)
  public
    constructor Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True); reintroduce;
    destructor Destroy; override;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPUnboundedQueue<T> = class(TPasMPThreadSafeQueue)
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
  public
    constructor Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True); reintroduce;
    destructor Destroy; override;
    procedure Enqueue(const Item: T); reintroduce;
    function Dequeue(out Item: T): Boolean; reintroduce;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPMultipleProducerMultipleConsumerQueue<T> = class
  public
    type
      TSlot = record
      public
        fTurn: TPasMPSizeUIntEx;
        fPadding1: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSizeUIntEx))-1] of TPasMPUInt8;
        fData: T;
      end;
      PSlot = ^TSlot;
      TSlotDynamicArray = array of TSlot;
  private
    fCapacity: TPasMPSizeUIntEx;
    fSlots:TSlotDynamicArray;
    fHead: TPasMPSizeUIntEx;
    fPaddingHead: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSizeUIntEx))-1] of TPasMPUInt8;
    fTail: TPasMPSizeInt;
    fPaddingTail: array [0..(PasMPCPUCacheLineSize-SizeOf(TPasMPSizeUIntEx))-1] of TPasMPUInt8;

    function Idx(const aX: TPasMPSizeUIntEx): TPasMPSizeUIntEx; inline;
    function TurnOf(const aX: TPasMPSizeUIntEx): TPasMPSizeUIntEx; inline;
  public
    constructor Create(const aCapacity: TPasMPSizeInt);
    destructor Destroy; override;
    procedure Enqueue(const aValue: T);
    function TryEnqueue(const aValue: T): Boolean;
    procedure Dequeue(out AValue: T);
    function TryDequeue(out AValue: T): Boolean;
    function Size: TPasMPSizeUIntEx;
    function Empty: Boolean; inline;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPHashTable = class(TPasMPThreadSafeHashTable)
  private
    fKeySize: TPasMPInt32;
    fValueSize: TPasMPInt32;
    fItemSize: TPasMPInt32;
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source, Destination: Pointer); override;
    procedure GetKey(const Data, Key: Pointer); override;
    procedure SetKey(const Data, Key: Pointer); override;
    procedure GetValue(const Data, Value: Pointer); override;
    procedure SetValue(const Data, Value: Pointer); override;
    function HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash; override;
    function CompareKey(const Data, Key: Pointer): Boolean; override;
  public
    constructor Create(const KeySize, ValueSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetKeyValue(const Key; out Value): Boolean;
    function SetKeyValue(const Key,Value): Boolean;
    function DeleteKey(const Key): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPStringHashTable = class(TPasMPThreadSafeHashTable)
  private
    fKeySize: TPasMPInt32;
    fValueSize: TPasMPInt32;
    fItemSize: TPasMPInt32;
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
    procedure GetKey(const Data,Key: Pointer); override;
    procedure SetKey(const Data,Key: Pointer); override;
    procedure GetValue(const Data,Value: Pointer); override;
    procedure SetValue(const Data,Value: Pointer); override;
    function HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash; override;
    function CompareKey(const Data,Key: Pointer): Boolean; override;
  public
    constructor Create(const ValueSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetKeyValue(const Key: string; out Value): Boolean;
    function SetKeyValue(const Key: string; const Value): Boolean;
    function DeleteKey(const Key: string): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPStringStringHashTable = class(TPasMPThreadSafeHashTable)
  private
    fKeySize: TPasMPInt32;
    fValueSize: TPasMPInt32;
    fItemSize: TPasMPInt32;
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
    procedure GetKey(const Data,Key: Pointer); override;
    procedure SetKey(const Data,Key: Pointer); override;
    procedure GetValue(const Data,Value: Pointer); override;
    procedure SetValue(const Data,Value: Pointer); override;
    function HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash; override;
    function CompareKey(const Data,Key: Pointer): Boolean; override;
  public
    constructor Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetKeyValue(const Key: string; out Value: string): Boolean;
    function SetKeyValue(const Key,Value: string): Boolean;
    function DeleteKey(const Key: string): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IFDEF HasGenericsCollections}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPHashTable<KeyType,ValueType> = class(TPasMPThreadSafeHashTable)
  private
    fKeySize: TPasMPInt32;
    fValueSize: TPasMPInt32;
    fItemSize: TPasMPInt32;
    fComparer:IEqualityComparer<KeyType>;
{$IFDEF fpc}
    procedure Dummy(out Value:ValueType); inline;
{$ENDIF}
  protected
    procedure InitializeItem(const Data: Pointer); override;
    procedure FinalizeItem(const Data: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
    procedure GetKey(const Data,Key: Pointer); override;
    procedure SetKey(const Data,Key: Pointer); override;
    procedure GetValue(const Data,Value: Pointer); override;
    procedure SetValue(const Data,Value: Pointer); override;
    function HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash; override;
    function CompareKey(const Data,Key: Pointer): Boolean; override;
  public
    constructor Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetKeyValue(const Key:KeyType; out Value:ValueType): Boolean;
    function SetKeyValue(const Key:KeyType; const Value:ValueType): Boolean;
    function DeleteKey(const Key:KeyType): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  EPasMPDynamicArrayOutOfBounds = class(Exception);
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPDynamicArray = class(TPasMPThreadSafeDynamicArray)
  protected
    procedure InitializeItem(const ItemData: Pointer); override;
    procedure FinalizeItem(const ItemData: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
  public
    constructor Create(const aItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetItem(const ItemIndex: TPasMPInt32; out ItemData): Boolean;
    function SetItem(const ItemIndex: TPasMPInt32; const ItemData): Boolean;
    function Push(const ItemData): TPasMPInt32;
    function Pop(out ItemData): Boolean;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPDynamicArray<T> = class(TPasMPThreadSafeDynamicArray)
  private
    type
      PPasMPDynamicArrayDataType = ^TPasMPDynamicArrayDataType;
      TPasMPDynamicArrayDataType=T;
  protected
    procedure InitializeItem(const ItemData: Pointer); override;
    procedure FinalizeItem(const ItemData: Pointer); override;
    procedure CopyItem(const Source,Destination: Pointer); override;
    function GetPropertyItem(const ItemIndex: TPasMPInt32): T;
    procedure SetPropertyItem(const ItemIndex: TPasMPInt32; const ItemData: T);
  public
    constructor Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
    destructor Destroy; override;
    function GetItem(const ItemIndex: TPasMPInt32; out ItemData: T): Boolean;
    function SetItem(const ItemIndex: TPasMPInt32; const ItemData: T): Boolean;
    function Push(const ItemData: T): TPasMPInt32;
    function Pop(out ItemData: T): Boolean;
    property Items[const ItemIndex: TPasMPInt32]:T read GetPropertyItem write SetPropertyItem; default;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}
{$ENDIF}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPThread = class(TThread)
{$IF DEFINED(fpc) and (DEFINED(Linux) or DEFINED(Android)) and DECLARED(TThreadPriority)}
  private
    function GetPriority: TThreadPriority; reintroduce;
    procedure SetPriority(Value: TThreadPriority); reintroduce;
  public
    property Priority: TThreadPriority read GetPriority write SetPriority;
{$IFEND}
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  PPasMPJobPriority = ^TPasMPJobPriority;
  TPasMPJobPriority = (
    pmjpInherited,
    pmjpLow,
    pmjpNormal,
    pmjpHigh
  );

  PPasMPJob = ^TPasMPJob;

{$IFDEF HAS_ANONYMOUS_METHODS}
  TPasMPJobReferenceProcedure = reference to procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
{$ENDIF}

  TPasMPJobProcedure = procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);

  TPasMPJobMethod = procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32) of object;

{$IFDEF HAS_ANONYMOUS_METHODS}
  TPasMPParallelForReferenceProcedure = reference to procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32; const Data: Pointer; const FromIndex, ToIndex: TPasMPNativeInt);
{$ENDIF}

  TPasMPParallelForProcedure = procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32; const Data: Pointer; const FromIndex, ToIndex: TPasMPNativeInt);

  TPasMPParallelForMethod = procedure(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32; const Data: Pointer; const FromIndex, ToIndex: TPasMPNativeInt) of object;

  TPasMPParallelSortCompareFunction = function(const a, B: Pointer): TPasMPInt32;

  TPasMPJobWorkerThread = class;

  TPasMPJob = record
    case TPasMPInt32 of
      0: (                                          // 32 / 64 bit
          Method:TMethod;                             //  8 / 16 => 2x pointers
          ParentJob: PPasMPJob;                        //  4 /  8 => 1x Pointer
          ChildrenJobs: TPasMPUInt32;                  //  4 /  4 => 1x 32-bit unsigned integer (children jobs)
          InternalData: TPasMPUInt32;                  //  4 /  4 => 1x 32-bit unsigned integer (owner worker thread index, job priority, task tag, flags, etc. and last high bit = active bit)
          AreaMask: TPasMPUInt32;                      //  4 /  4 => 1x 32-bit unsigned integer (area mask)
          AvoidAreaMask: TPasMPUInt32;                 //  4 /  4 => 1x 32-bit unsigned integer (avoid area mask)
          Data: Pointer;                               // ------- => just a dummy variable as struct field offset anchor
          );                                           // 28 / 40
      1: ( Next: TPasMPThreadSafeStackEntry; );
      2: (
          // for 32-bit Destinations: use one whole cache line (1x 64 bytes = 16x 32-bit pointers/integers) to avoid false sharing (1 cache line => 64 bytes on the most CPUs) and also to have some free place for meta data
          // for 64-bit Destinations: use two whole cache lines (2x 64 bytes = 16x 64-bit pointers/integers) to avoid false sharing (1 cache line => 64 bytes on the most CPUs) and also to have some free place for meta data
          // and so on . . .
          FillUp: array [0..(PasMPCPUCacheLineSize*(SizeOf(TPasMPPtrUInt) div SizeOf(TPasMPUInt32)))-1] of TPasMPUInt8;
          );
    end;

  TPPasMPJobs = array of PPasMPJob;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPJobTask = class
  private
    fFreeOnRelease: Boolean;
    fJob: PPasMPJob;
    fThreadIndex: TPasMPInt32;
    fJobTag: TPasMPUInt32;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Run; virtual;
    function Split: TPasMPJobTask; virtual;
    function PartialPop: TPasMPJobTask; virtual;
    function Spread: Boolean; virtual;
    property FreeOnRelease: Boolean read fFreeOnRelease write fFreeOnRelease;
    property Job: PPasMPJob read fJob;
    property ThreadIndex: TPasMPInt32 read fThreadIndex;
    property JobTag: TPasMPUInt32 read fJobTag write fJobTag;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  PPasMPJobAllocatorMemoryPoolBucket = ^TPasMPJobAllocatorMemoryPoolBucket;
  TPasMPJobAllocatorMemoryPoolBucket = array [0..PasMPAllocatorPoolBucketSize-1] of TPasMPJob;

  PPPasMPJobAllocatorMemoryPoolBuckets = ^TPPasMPJobAllocatorMemoryPoolBuckets;
  TPPasMPJobAllocatorMemoryPoolBuckets = array of PPasMPJobAllocatorMemoryPoolBucket;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPJobAllocator=class
  private
    fJobWorkerThread: TPasMPJobWorkerThread;
    fFreeJobs: TPasMPThreadSafeStack;
    fMemoryPoolBuckets:TPPasMPJobAllocatorMemoryPoolBuckets;
    fCountMemoryPoolBuckets: TPasMPInt32;
    fCountAllocatedJobs: TPasMPInt32;
    procedure AllocateNewBuckets(const NewCountMemoryPoolBuckets: TPasMPInt32);
    function AllocateJob: PPasMPJob; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure FreeJobs; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure FreeJob(const Job: PPasMPJob);
  public
    constructor Create(const AJobWorkerThread: TPasMPJobWorkerThread);
    destructor Destroy; override;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
     TPasMPWorkerSystemThread = class(TPasMPThread)
      private
       fJobWorkerThread: TPasMPJobWorkerThread;
      protected
       procedure Execute; override;
      public
       constructor Create(const AJobWorkerThread: TPasMPJobWorkerThread);
       destructor Destroy; override;
     end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  TPasMPJobQueueJobs = array of PPasMPJob;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPJobQueue = class
  private
    fPasMPInstance: TPasMP;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueLockState: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueSize: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueMask: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueBottom: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueTop: TPasMPInt32;
    {$IFDEF HAS_VOLATILE}[volatile]{$ENDIF}fQueueJobs: TPasMPJobQueueJobs;
    function HasJobs: Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Resize(const QueueBottom, QueueTop: TPasMPInt32);
    procedure PushJob(const pJob: PPasMPJob);
    function PopJob: PPasMPJob;
    function StealJob: PPasMPJob;
  public
    constructor Create(const APasMPInstance: TPasMP);
    destructor Destroy; override;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  PPasMPJobQueues = ^TPasMPJobQueues;
  TPasMPJobQueues = array [PasMPJobQueuePriorityFirst..PasMPJobQueuePriorityLast] of TPasMPJobQueue;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPJobWorkerThread=class
  private
    fPasMPInstance: TPasMP;
    fNext: TPasMPJobWorkerThread;
    fThreadIndex: TPasMPInt32;
    fCurrentJobPriority: TPasMPUInt32;
    fDepth: TPasMPUInt32;
    fAreaMask: TPasMPUInt32;
{$IFNDEF UseThreadLocalStorage}
    fThreadID:{$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF};
{$ENDIF}
    fCPUAffinityMask: TPasMPUInt64; // 64-bit CPU affinity mask for maximum 64 CPU logical cores for now
    fSystemThread: TPasMPWorkerSystemThread;
    fIsReadyEvent: TPasMPEvent;
    fJobAllocator: TPasMPJobAllocator;
    fJobQueues: TPasMPJobQueues;
    fJobQueuesUsedBitmap: TPasMPUInt32;
    fMaxPriorityJobQueueIndex: TPasMPUInt32;
    fXorShift32: TPasMPUInt32;
    procedure ThreadInitialization;
    function GetJob: PPasMPJob;
    function HasJobs: Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure ThreadProc;
  public
    constructor Create(const APasMPInstance: TPasMP; const AThreadIndex: TPasMPInt32; const aCPUAffinityMask: TPasMPUInt64=0);
    destructor Destroy; override;
    property Depth: TPasMPUInt32 read fDepth;
    property AreaMask: TPasMPUInt32 read fAreaMask write fAreaMask;
    property ThreadIndex: TPasMPInt32 read fThreadIndex;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  TPasMPJobWorkerThreads = array of TPasMPJobWorkerThread;

  TPasMPJobWorkerThreadHashTable = array [0..PasMPJobWorkerThreadHashTableSize-1] of TPasMPJobWorkerThread;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPScope = class
  private
    fPasMPInstance: TPasMP;
    fWaitCalled: longbool;
    fJobs: TPPasMPJobs;
    fCountJobs: TPasMPInt32;
  public
    constructor Create(const APasMPInstance: TPasMP);
    destructor Destroy; override;
    procedure Run(const Job: PPasMPJob); overload;
    procedure Run(const Jobs: array of PPasMPJob); overload;
    procedure Run(const JobTask: TPasMPJobTask); overload;
    procedure Run(const JobTasks: array of TPasMPJobTask); overload;
    procedure Wait;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  PPasMPProfilerHistoryRingBufferItem = ^TPasMPProfilerHistoryRingBufferItem;
  TPasMPProfilerHistoryRingBufferItem = record
    case TPasMPUInt32 of
      0: (
          JobTag: TPasMPUInt32;
          ThreadIndexStackDepth: TPasMPUInt32;
          StartTime: TPasMPHighResolutionTime;
          EndTime: TPasMPHighResolutionTime;
          Dummy: Pointer;
          );
      1: ( CacheLineFillUp: array [0..PasMPCPUCacheLineSize-1] of TPasMPUInt8; );
    end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}


  PPasMPProfilerHistory = ^TPasMPProfilerHistory;
  TPasMPProfilerHistory = array [0..PasMPProfilerHistoryRingBufferSize-1] of TPasMPProfilerHistoryRingBufferItem;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMPProfiler = class
  private
    fHistory: TPasMPProfilerHistory;
    fPointerToHistory:PPasMPProfilerHistory;
    fPasMPInstance: TPasMP;
    fCount: TPasMPInt32;
    fHighResolutionTimer: TPasMPHighResolutionTimer;
    fStartTime: TPasMPHighResolutionTime;
    fLastTime: TPasMPHighResolutionTime;
    fOffsetTime: TPasMPHighResolutionTime;
    function GetHistoryRingBufferItem(const pIndex: TPasMPUInt32): PPasMPProfilerHistoryRingBufferItem; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure Sort;
  public
    constructor Create(const pPasMPInstance: TPasMP);
    destructor Destroy; override;
    procedure Reset;
    procedure Start(const SuppressGaps: Boolean = True);
    procedure Stop(const MaximalTimePeriodToKeep: TPasMPHighResolutionTime=-1);
    function Acquire: PPasMPProfilerHistoryRingBufferItem; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    property History: PPasMPProfilerHistory read fPointerToHistory;
    property HistoryRingBufferItems[const pIndex: TPasMPUInt32]: PPasMPProfilerHistoryRingBufferItem read GetHistoryRingBufferItem;
    property PasMPInstance: TPasMP read fPasMPInstance;
    property Count: TPasMPInt32 read fCount;
    property HighResolutionTimer: TPasMPHighResolutionTimer read fHighResolutionTimer;
    property StartTime: TPasMPHighResolutionTime read fStartTime;
    property LastTime: TPasMPHighResolutionTime read fLastTime;
    property OffsetTime: TPasMPHighResolutionTime read fOffsetTime;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

{$IF DECLARED(TThreadPriority)}
  {$DEFINE HasRealTThreadPriority}
{$ELSE}
  {$UNDEF HasRealTThreadPriority}
     // Workaround for Delphi mobile targets
  TThreadPriority = (
    tpIdle,
    tpLowest,
    tpLower,
    tpNormal,
    tpHigher,
    tpHighest,
    tpTimeCritical
  );
{$IFEND}

  TPasMPOnWorkerThreadException = function(const aException:Exception): Boolean of object;

  TPasMPOnCheckJobExecution = function(const aPasMPInstance: TPasMP; const aJob: PPasMPJob; const aJobWorkerThread: TPasMPJobWorkerThread): Boolean of object;

{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
  TPasMP = class
  private
    fAvailableCPUCores: TPasMPAvailableCPUCores;
    fDoCPUCorePinning: longbool;
    fSleepingOnIdle: longbool;
    fAllWorkerThreadsHaveOwnSystemThreads: longbool;
{$IFDEF PasMPHaveFPUControls}
    fFPUExceptionMask:TFPUExceptionMask;
    fFPUPrecisionMode:TFPUPrecisionMode;
    fFPURoundingMode: TFPURoundingMode;
{$ENDIF}
    fJobWorkerThreads: TPasMPJobWorkerThreads;
    fCountJobWorkerThreads: TPasMPInt32;
    fSleepingJobWorkerThreads: TPasMPInt32;
    fWorkingJobWorkerThreads: TPasMPInt32;
    fSystemIsReadyEvent: TPasMPEvent;
{$IFDEF PasMPUseWakeUpConditionVariable}
    fWakeUpCounter: TPasMPInt32;
    fWakeUpConditionVariableLock: TPasMPConditionVariableLock;
    fWakeUpConditionVariable: TPasMPConditionVariable;
{$ELSE}
    fWakeUpEvent: TPasMPEvent;
{$ENDIF}
    fCountCPUThreads: TPasMPInt32;
    fCriticalSection: TPasMPCriticalSection;
    fJobAllocatorCriticalSection: TPasMPCriticalSection;
    fJobAllocator: TPasMPJobAllocator;
    fJobQueues: TPasMPJobQueues;
    fJobQueuesUsedBitmap: TPasMPUInt32;
    fJobQueuesLock: TPasMPSlimReaderWriterLock;
    fGlobalJobQueuesUsedBitmap: TPasMPUInt32;
{$IFNDEF UseThreadLocalStorage}
    fJobWorkerThreadHashTableCriticalSection: TPasMPCriticalSection;
    fJobWorkerThreadHashTable: TPasMPJobWorkerThreadHashTable;
{$ENDIF}
    fProfiler: TPasMPProfiler;
    fWorkerThreadPriority: TThreadPriority;
    fWorkerThreadStackSize: TPasMPSizeUInt;
    fWorkerThreadMaxDepth: TPasMPUInt32;
    fOnWorkerThreadException: TPasMPOnWorkerThreadException;
    fOnCheckJobExecution: TPasMPOnCheckJobExecution;
    fRespectJobAvoidAreaMasks: TPasMPBool32;
    class function GetThreadIDHash(ThreadID:{$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF}): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    function GetJobWorkerThread: TPasMPJobWorkerThread; {$IFNDEF UseThreadLocalStorage}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$ENDIF}
    procedure WaitForWakeUp;
    procedure WakeUpAll;
    function CanSpread: Boolean;
    function IsFull: Boolean;
    function GlobalAllocateJob: PPasMPJob;
    procedure GlobalFreeJob(const Job: PPasMPJob);
    function AllocateJob(const MethodCode, MethodData,Data: Pointer; const ParentJob: PPasMPJob; const Flags, AreaMask, AvoidAreaMask: TPasMPUInt32): PPasMPJob; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure WaitOnChildrenJobs(const Job: PPasMPJob);
    procedure ExecuteJobTask(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread; const ThreadIndex: TPasMPInt32); {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    function CheckJobExecution(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread): Boolean;
    procedure ExecuteJob(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread); //{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure PushJob(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread); {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
{$IFDEF HAS_ANONYMOUS_METHODS}
    procedure JobReferenceProcedureJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelForJobReferenceProcedureProcess(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelForJobReferenceProcedureFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelForStartJobReferenceProcedureFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
{$ENDIF}
    procedure ParallelForJobFunctionProcess(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelForJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelForStartJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelDirectIntroSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelIndirectIntroSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelDirectMergeSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelDirectMergeSortRootJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelIndirectMergeSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
    procedure ParallelIndirectMergeSortRootJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
  public
    constructor Create(const CountThreads: TPasMPInt32 =  - 1; const MinimumCountThreads: TPasMPInt32 =  - 1; const MaximumCountThreads: TPasMPInt32= - 1; const ThreadHeadRoomForForeignTasks: TPasMPInt32=0; const DoCPUCorePinning: Boolean = True; const SleepingOnIdle: Boolean = True; const AllWorkerThreadsHaveOwnSystemThreads: Boolean = False; const Profiling: Boolean = False; const WorkerThreadPriority: TThreadPriority=TThreadPriority.tpNormal; const WorkerThreadStackSize: TPasMPSizeUInt=0; const WorkerThreadMaxDepth: TPasMPUInt32=0);
    destructor Destroy; override;
    class function CreateGlobalInstance: TPasMP;
    class procedure DestroyGlobalInstance;
    class function GetGlobalInstance: TPasMP; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    class function GetCountOfPhysicalCores(out AvailableCPUCores: TPasMPAvailableCPUCores): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}
    class function GetCountOfHardwareThreads(out AvailableCPUCores: TPasMPAvailableCPUCores): TPasMPInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}
    class procedure Relax; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}{$ELSEIF DEFINED(CAN_INLINE)}inline;{$IFEND}
    class procedure Yield; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    class function Once(var OnceControl: TPasMPOnce; const InitRoutine: TPasMPOnceInitRoutine): Boolean; {$IFDEF Linux}{$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$ENDIF}
    class function IsJobCompleted(const Job: PPasMPJob): Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function IsJobValid(const Job: PPasMPJob): Boolean; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function EncodeJobPriorityToJobFlags(const JobPriority: TPasMPJobPriority): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function DecodeJobPriorityFromJobFlags(const Flags: TPasMPUInt32): TPasMPJobPriority; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function EncodeJobTagToJobFlags(const JobTag: TPasMPUInt32): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    class function DecodeJobTagFromJobFlags(const Flags: TPasMPUInt32): TPasMPUInt32; {$IFDEF HAS_STATIC}static;{$ENDIF}{$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Reset;
    function CreateScope: TPasMPScope; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    function GetJobWorkerThreadIndex: TPasMPInt32;
{$IFDEF HAS_ANONYMOUS_METHODS}
    function Acquire(const JobReferenceProcedure: TPasMPJobReferenceProcedure; const Data: Pointer = nil; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob; overload;
{$ENDIF}
    function Acquire(const JobProcedure: TPasMPJobProcedure; const Data: Pointer = nil; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob; overload;
    function Acquire(const JobMethod: TPasMPJobMethod; const Data: Pointer = nil; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob; overload;
    function Acquire(const JobTask: TPasMPJobTask; const Data: Pointer = nil; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob; overload;
    procedure Release(const Job: PPasMPJob); overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure Release(const Jobs: array of PPasMPJob); overload;
    procedure Run(const Job: PPasMPJob; const GlobalQueue: Boolean = False); overload; {$IFDEF fpc}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
    procedure Run(const Jobs: array of PPasMPJob; const GlobalQueue: Boolean = False); overload;
    function StealAndExecuteJob: Boolean;
    procedure Wait(const Job: PPasMPJob); overload;
    procedure Wait(const Jobs: array of PPasMPJob); overload;
    procedure RunWait(const Job: PPasMPJob); overload; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure RunWait(const Jobs: array of PPasMPJob); overload;
    procedure WaitRelease(const Job: PPasMPJob); overload; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure WaitRelease(const Jobs: array of PPasMPJob); overload;
    procedure Invoke(const Job: PPasMPJob); overload; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Invoke(const Jobs: array of PPasMPJob); overload;
    procedure Invoke(const JobTask: TPasMPJobTask); overload; {$IFDEF CAN_INLINE}inline;{$ENDIF}
    procedure Invoke(const JobTasks: array of TPasMPJobTask); overload;
{$IFDEF HAS_ANONYMOUS_METHODS}
    function ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForReferenceProcedure: TPasMPParallelForReferenceProcedure; const Granularity: TPasMPInt32=1; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0; const RecursiveSplit: Boolean = True): PPasMPJob; overload;
{$ENDIF}
    function ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForProcedure: TPasMPParallelForProcedure; const Granularity: TPasMPInt32=1; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0; const RecursiveSplit: Boolean = True): PPasMPJob; overload;
    function ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForMethod: TPasMPParallelForMethod; const Granularity: TPasMPInt32=1; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0; const RecursiveSplit: Boolean = True): PPasMPJob; overload;
    function ParallelDirectIntroSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const ElementSize: TPasMPInt32; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32=16; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob;
    function ParallelIndirectIntroSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32=16; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob;
    function ParallelDirectMergeSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const ElementSize: TPasMPInt32; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32=16; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob;
    function ParallelIndirectMergeSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32=16; const Depth: TPasMPInt32=PasMPDefaultDepth; const ParentJob: PPasMPJob=nil; const Flags: TPasMPUInt32=0; const AreaMask: TPasMPUInt32=0; const AvoidAreaMask: TPasMPUInt32=0): PPasMPJob;
    property JobWorkerThread: TPasMPJobWorkerThread read GetJobWorkerThread;
    property JobWorkerThreads: TPasMPJobWorkerThreads read fJobWorkerThreads;
    property CountJobWorkerThreads: TPasMPInt32 read fCountJobWorkerThreads;
    property Profiler: TPasMPProfiler read fProfiler;
    property SleepingOnIdle: longbool read fSleepingOnIdle write fSleepingOnIdle;
    property OnWorkerThreadException: TPasMPOnWorkerThreadException read fOnWorkerThreadException write fOnWorkerThreadException;
    property OnCheckJobExecution: TPasMPOnCheckJobExecution read fOnCheckJobExecution write fOnCheckJobExecution;
    property RespectJobAvoidAreaMasks: TPasMPBool32 read fRespectJobAvoidAreaMasks write fRespectJobAvoidAreaMasks;
  end;
{$IF DEFINED(fpc) and (fpc_version>=3)}{$pop}{$IFEND}

var
  GlobalPasMP: TPasMP = nil; // "Optional" singleton-like global PasMP instance

  GlobalPasMPCountThreads: TPasMPInt32 =  - 1;
  GlobalPasMPMinimumCountThreads: TPasMPInt32 =  - 1;
  GlobalPasMPMaximumCountThreads: TPasMPInt32 =  - 1;
  GlobalPasMPThreadHeadRoomForForeignTasks: TPasMPInt32 = 0;
  GlobalPasMPDoCPUCorePinning: Boolean = True;
  GlobalPasMPSleepingOnIdle: Boolean = True;
  GlobalPasMPAllWorkerThreadsHaveOwnSystemThreads: Boolean = False;
  GlobalPasMPProfiling: Boolean = False;
  GlobalPasMPWorkerThreadPriority: TThreadPriority=TThreadPriority.tpNormal;
  GlobalPasMPOverrideThreadPriorityFunctions: Boolean = False;
  GlobalPasMPWorkerThreadStackSize: TPasMPSizeUInt=0;
  GlobalPasMPWorkerThreadMaxDepth: TPasMPUInt32=0;

  GPasMP: TPasMP absolute GlobalPasMP; // A shorter name for lazy peoples

{$IF DEFINED(fpc)}
{$ELSEIF CompilerVersion>=25}
{$ELSEIF DEFINED(fpc)}
procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
{$ELSEIF CompilerVersion>=25}
procedure FallbackReadBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
{$ELSEIF DEFINED(CPU386)}
procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
{$ELSEIF DEFINED(CPUx86)}
procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
{$ELSEIF DEFINED(CPUAARCH64)}
procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
{$ELSEIF DEFINED(CPUARM)}
procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
{$ELSE}
procedure FallbackReadBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackReadWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
{$IFEND}

{$IF DEFINED(cpu386)}
{$IFNDEF fpc}
function BSFDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
function BSRDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
function BSFQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
function BSRQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
function POPCNTDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
function POPCNTQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
{$ENDIF}
{$ELSEIF DEFINED(cpux86_64)}
{$IFNDEF fpc}
function BSFDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function BSRDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function BSFQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function BSRQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function POPCNTDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
function POPCNTQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
{$ENDIF}
{$ELSEIF not DEFINED(fpc)}
function UInt64Mul(a, B: TPasMPUInt64): TPasMPUInt64;{$IFDEF cpu386}assembler; stdcall;{$ELSE}{$IFDEF cpu64}{$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}{$ENDIF}
function BSFDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function BSFQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function BSRDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function BSRQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CLZDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CLZQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CTZDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CTZQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function POPCNTDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function POPCNTQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
{$IFEND}

{$IFDEF fpc}
function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
{$ENDIF}


implementation


const
  PasMPBarrierFlag = TPasMPInt32(1) shl 30;


{$IFDEF UseThreadLocalStorage}
{$IF DEFINED(UseThreadLocalStorageX8632) or DEFINED(UseThreadLocalStorageX8664)}
var
  CurrentJobWorkerThreadTLSIndex: TPasMPInt32;
  CurrentJobWorkerThreadTLSOffset: TPasMPInt32;
{$ELSE}
threadvar
  CurrentJobWorkerThread: TPasMPJobWorkerThread;
{$IFEND}
{$ENDIF}

var
  GlobalPasMPCriticalSection: TPasMPCriticalSection = nil;

{$IFDEF PasMPUseGlobalPasMPCountOfHardwareThreads}
  GlobalPasMPCountOfHardwareThreads: TPasMPInt32 =  - 1;

  GlobalPasMPAvailableCPUCores: TPasMPAvailableCPUCores;
{$ENDIF}

{$IFDEF fpc}
  {$UNDEF OldDelphi}
{$ELSE}
  {$IFDEF conditionalexpressions}
    {$IF CompilerVersion>=23.0}
      {$UNDEF OldDelphi}
type
  qword = UInt64;
  ptruint = NativeUInt;
  ptrint = NativeInt;
    {$ELSE}
      {$DEFINE OldDelphi}
    {$IFEND}
  {$ELSE}
    {$DEFINE OldDelphi}
  {$ENDIF}
{$ENDIF}

{$IFDEF OldDelphi}
type
  qword = TPasMPInt64;
  {$IFDEF CPU64}
  ptruint = qword;
  ptrint = TPasMPInt64;
  {$ELSE}
  ptruint = TPasMPUInt32;
  ptrint = TPasMPInt32;
  {$ENDIF}
{$ENDIF}


{$IF DEFINED(Windows)}
type
  Bool = Boolean;

function SwitchToThread: Bool; external 'kernel32.dll' name 'SwitchToThread';

function SetThreadIdealProcessor(hThread: THANDLE; dwIdealProcessor: TPasMPUInt32): TPasMPUInt32; stdcall; external 'kernel32.dll' name 'SetThreadIdealProcessor';

procedure InitializeConditionVariable(ConditionVariable: PPasMPConditionVariableData); stdcall; external 'kernel32.dll' name 'InitializeConditionVariable';
function SleepConditionVariableCS(ConditionVariable: PPasMPConditionVariableData; CriticalSection: PRTLCriticalSection;dwMilliSeconds: TPasMPUInt32): bool; stdcall; external 'kernel32.dll' name 'SleepConditionVariableCS';
procedure WakeConditionVariable(ConditionVariable: PPasMPConditionVariableData); stdcall; external 'kernel32.dll' name 'WakeConditionVariable';
procedure WakeAllConditionVariable(ConditionVariable: PPasMPConditionVariableData); stdcall; external 'kernel32.dll' name 'WakeAllConditionVariable';

procedure InitializeSRWLock(SRWLock: PPasMPSRWLock); stdcall; external 'kernel32.dll' name 'InitializeSRWLock';
procedure AcquireSRWLockShared(SRWLock: PPasMPSRWLock); stdcall; external 'kernel32.dll' name 'AcquireSRWLockShared';
function TryAcquireSRWLockShared(SRWLock: PPasMPSRWLock): bool; stdcall; external 'kernel32.dll' name 'TryAcquireSRWLockShared';
procedure ReleaseSRWLockShared(SRWLock: PPasMPSRWLock); stdcall; external 'kernel32.dll' name 'ReleaseSRWLockShared';
procedure AcquireSRWLockExclusive(SRWLock: PPasMPSRWLock); stdcall; external 'kernel32.dll' name 'AcquireSRWLockExclusive';
function TryAcquireSRWLockExclusive(SRWLock: PPasMPSRWLock): bool; stdcall; external 'kernel32.dll' name 'TryAcquireSRWLockExclusive';
procedure ReleaseSRWLockExclusive(SRWLock: PPasMPSRWLock); stdcall; external 'kernel32.dll' name 'ReleaseSRWLockExclusive';

{$ELSEIF DEFINED(Linux) or DEFINED(Android)}
{$IFDEF fpc}
const
  _SC_UIO_MAXIOV=60;
  _SC_NPROCESSORS_CONF = (_SC_UIO_MAXIOV)+23;

{$IF DEFINED(PasMPPThreadBarrier)}
  PTHREAD_BARRIER_SERIAL_THREAD =  - 1;
{$IFEND}

type
  cpu_set_p = ^cpu_set_t;
  cpu_set_t = TPasMPInt64;

{$IFDEF fpc}
{$linklib c}
{$ENDIF}

{$IF DEFINED(Android) or not DEFINED(fpc)}
type
  ppthread_mutex_t = ^pthread_mutex_t;
  ppthread_mutexattr_t = ^pthread_mutexattr_t;

  ppthread_cond_t = ^pthread_cond_t;
  ppthread_condattr_t = ^pthread_condattr_t;

  Ppthread_rwlock_t = ^pthread_rwlock_t;
  Ppthread_rwlockattr_t = ^pthread_rwlockattr_t;

  Psem_t = ^sem_t;

{$IF DEFINED(PasMPPThreadSpinLock)}
  pthread_spinlock_t = TPasMPSpinLockPThreadSpinLock;
  ppthread_spinlock_t = ^pthread_spinlock_t;
  TPthreadSpinlock = pthread_spinlock_t;
  PTPthreadSpinlock = ^TPthreadSpinlock;
{$IFEND}

{$IF DEFINED(PasMPPThreadBarrier)}
  Ppthread_barrier_t = ^pthread_barrier_t;
  pthread_barrier_t = TPasMPSpinLockPThreadBarrier;

  pthread_barrierattr_t = record
    __pshared: TPasMPInt32;
  end;
  ppthread_barrierattr_t = ^pthread_barrierattr_t;
  TPthreadBarrierAttribute = pthread_barrierattr_t;
  PPthreadBarrierAttribute = ^TPthreadBarrierAttribute;
{$IFEND}

{$IFEND}

function sysconf(__name: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'sysconf';

function sched_getaffinity(pid:ptruint;cpusetsize: TPasMPInt32;cpuset: Pointer): TPasMPInt32; cdecl; external 'c' name 'sched_getaffinity';
function sched_setaffinity(pid:ptruint;cpusetsize: TPasMPInt32;cpuset: Pointer): TPasMPInt32; cdecl; external 'c' name 'sched_setaffinity';

function pthread_setaffinity_np(pid:ptruint;cpusetsize: TPasMPInt32;cpuset: Pointer): TPasMPInt32; cdecl; external 'c' name 'pthread_setaffinity_np';
function pthread_getaffinity_np(pid:ptruint;cpusetsize: TPasMPInt32;cpuset: Pointer): TPasMPInt32; cdecl; external 'c' name 'pthread_getaffinity_np';

{$IF DEFINED(Android) or not DEFINED(fpc)}
function pthread_mutex_init(__mutex:ppthread_mutex_t;__mutex_attr:ppthread_mutexattr_t): TPasMPInt32; cdecl; external 'c' name 'pthread_mutex_init';
function pthread_mutex_destroy(__mutex:ppthread_mutex_t): TPasMPInt32; cdecl; external 'c' name 'pthread_mutex_destroy';
function pthread_mutex_trylock(__mutex:ppthread_mutex_t): TPasMPInt32; cdecl; external 'c' name 'pthread_mutex_trylock';
function pthread_mutex_lock(__mutex:ppthread_mutex_t): TPasMPInt32; cdecl; external 'c' name 'pthread_mutex_lock';
function pthread_mutex_unlock(__mutex:ppthread_mutex_t): TPasMPInt32; cdecl; external 'c' name 'pthread_mutex_unlock';

function pthread_cond_init(__cond:ppthread_cond_t;__cond_attr:ppthread_condattr_t): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_init';
function pthread_cond_destroy(__cond:ppthread_cond_t): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_destroy';
function pthread_cond_signal(__cond:ppthread_cond_t): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_signal';
function pthread_cond_broadcast(__cond:ppthread_cond_t): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_broadcast';
function pthread_cond_wait(__cond:ppthread_cond_t; __mutex:ppthread_mutex_t): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_wait';
function pthread_cond_timedwait(__cond:ppthread_cond_t;__mutex:ppthread_mutex_t;__abstime:PPasMPTimeSpec): TPasMPInt32; cdecl; external 'c' name 'pthread_cond_timedwait';

function pthread_rwlock_init(__rwlock:Ppthread_rwlock_t;__attr:Ppthread_rwlockattr_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_init';
function pthread_rwlock_destroy(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_destroy';
function pthread_rwlock_rdlock(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_rdlock';
function pthread_rwlock_tryrdlock(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_tryrdlock';
function pthread_rwlock_timedrdlock(__rwlock:Ppthread_rwlock_t;__abstime:PPasMPTimeSpec): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_timedrdlock';
function pthread_rwlock_wrlock(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_wrlock';
function pthread_rwlock_trywrlock(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_trywrlock';
function pthread_rwlock_timedwrlock(__rwlock:Ppthread_rwlock_t;__abstime:PPasMPTimeSpec): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_timedwrlock';
function pthread_rwlock_unlock(__rwlock:Ppthread_rwlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_rwlock_unlock';

{$IF DEFINED(PasMPPThreadSpinLock)}
function pthread_spin_init(__lock:Ppthread_spinlock_t;__pshared: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'pthread_spin_init';
function pthread_spin_destroy(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_spin_destroy';
function pthread_spin_lock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_spin_lock';
function pthread_spin_trylock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_spin_trylock';
function pthread_spin_unlock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external 'c' name 'pthread_spin_unlock';
{$IFEND}

{$IF DEFINED(PasMPPThreadBarrier)}
function pthread_barrier_init(__barrier:Ppthread_barrier_t;__attr:Ppthread_barrierattr_t;__count: TPasMPUInt32): TPasMPInt32; cdecl; external 'c' name 'pthread_barrier_init';
function pthread_barrier_destroy(__barrier:Ppthread_barrier_t): TPasMPInt32; cdecl; external 'c' name 'pthread_barrier_destroy';
function pthread_barrier_wait(__barrier:Ppthread_barrier_t): TPasMPInt32; cdecl; external 'c' name 'pthread_barrier_wait';
{$IFEND}

function sem_init(__sem:Psem_t;__pshared: TPasMPInt32;__value: TPasMPUInt32): TPasMPInt32; cdecl; external 'c' name 'sem_init';
function sem_destroy(__sem:Psem_t): TPasMPInt32; cdecl; external 'c' name 'sem_destroy';
function sem_close(__sem:Psem_t): TPasMPInt32; cdecl; external 'c' name 'sem_close';
function sem_unlink(__name:Pchar): TPasMPInt32; cdecl; external 'c' name 'sem_unlink';
function sem_wait(__sem:Psem_t): TPasMPInt32; cdecl; external 'c' name 'sem_wait';
function sem_trywait(__sem:Psem_t): TPasMPInt32; cdecl; external 'c' name 'sem_trywait';
function sem_post(__sem:Psem_t): TPasMPInt32; cdecl; external 'c' name 'sem_post';
function sem_getvalue(__sem:Psem_t;__sval: PPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'sem_getvalue';
function sem_timedwait(__sem:Psem_t;__abstime:PPasMPTimeSpec): TPasMPInt32; cdecl; external 'c' name 'sem_timedwait';
{$IFEND}

{$ELSE}

{$IF DEFINED(PasMPPThreadSpinLock)}
type pthread_spinlock_t=TPasMPSpinLockPThreadSpinLock;
     ppthread_spinlock_t = ^pthread_spinlock_t;
     TPthreadSpinlock=pthread_spinlock_t;
     PTPthreadSpinlock = ^TPthreadSpinlock;

function pthread_spin_init(__lock:Ppthread_spinlock_t;__pshared: TPasMPInt32): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_spin_init';
function pthread_spin_destroy(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_spin_destroy';
function pthread_spin_lock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_spin_lock';
function pthread_spin_trylock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_spin_trylock';
function pthread_spin_unlock(__lock:Ppthread_spinlock_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_spin_unlock';


{$IFEND}

{$IF DEFINED(PasMPPThreadBarrier)}
const
  PTHREAD_BARRIER_SERIAL_THREAD =  - 1;

type
  Ppthread_barrier_t = ^pthread_barrier_t;
  pthread_barrier_t = TPasMPSpinLockPThreadBarrier;

  pthread_barrierattr_t = record
    __pshared: TPasMPInt32;
  end;
  ppthread_barrierattr_t = ^pthread_barrierattr_t;
  TPthreadBarrierAttribute = pthread_barrierattr_t;
  PPthreadBarrierAttribute = ^TPthreadBarrierAttribute;

function pthread_barrier_init(__barrier:Ppthread_barrier_t;__attr:Ppthread_barrierattr_t;__count: TPasMPUInt32): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_barrier_init';
function pthread_barrier_destroy(__barrier:Ppthread_barrier_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_barrier_destroy';
function pthread_barrier_wait(__barrier:Ppthread_barrier_t): TPasMPInt32; cdecl; external libpthread name _PU+'pthread_barrier_wait';

{$IFEND}

{$ENDIF}

{$IFEND}

{$IFDEF fpc}
{$IF DEFINED(Linux) and not (DEFINED(Android) or DECLARED(pthread_condattr_setclock))}
function pthread_condattr_setclock(Attr:ppthread_condattr_t;clockid: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'pthread_condattr_setclock';
{$IFEND}
{$ELSE}
{$IF DEFINED(Linux) and not DEFINED(Android)}
function pthread_condattr_setclock(var Attr:pthread_condattr_t;clockid: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'pthread_condattr_setclock';
{$IFEND}
{$ENDIF}

{$IF DEFINED(cpu386)}
{$IFNDEF fpc}
function BSFDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsf eax, Eax
  jnz @Done
  mov eax,255
@Done:
end;

function BSRDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsr eax, Eax
  jnz @Done
  mov eax,255
@Done:
end;

function BSFQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsf eax,dword ptr [Value+0]
  jnz @Done
  bsf eax,dword ptr [Value+4]
  jz @Fail
  add eax,32
  jmp @Done
@Fail:
  mov eax,255
@Done:
end;

function BSRQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsr eax,dword ptr [Value+4]
  jz @LowPart
  add eax,32
  jmp @Done
@LowPart:
  xor ecx, Ecx
  bsr eax,dword ptr [Value+0]
  jnz @Done
  mov eax,255
@Done:
end;

function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsf eax, Eax
  jnz @Done
  mov eax,32
@Done:
end;

function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsr edx, Eax
  jnz @Done
  xor edx, Edx
  not edx
@Done:
  mov eax,31
  sub eax, Edx
end;

function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsf eax,dword ptr [Value+0]
  jnz @Done
  bsf eax,dword ptr [Value+4]
  jz @Fail
  add eax,32
  jmp @Done
@Fail:
  xor eax, Eax
  not eax
@Done:
end;

function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
  bsr edx,dword ptr [Value+4]
  jz @LowPart
  add edx,32
  jmp @Done
@LowPart:
  bsr edx,dword ptr [Value+0]
  jnz @Done
  xor edx, Edx
  not edx
@Done:
  mov eax,63
  sub eax, Edx
end;

function POPCNTDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register;
asm
  // Result := Value - ((Value shr 1) and $55555555);
  mov edx, Eax
  shr eax,1
  and eax,$55555555
  sub edx, Eax

  // Result := (result and $33333333) + ((result shr 2) and $33333333);
  mov eax, Edx
  shr edx,2
  and eax,$33333333
  and edx,$33333333
  add eax, Edx

  // Result := (result + (result shr 4)) and $0f0f0f0f;
  mov edx, Eax
  shr eax,4
  add eax, Edx
  and eax,$0f0f0f0f

  // Inc(result, Result shr 8);
  mov edx, Eax
  shr edx,8
  add eax, Edx

  // Inc(result, Result shr 16);
  mov edx, Eax
  shr edx,16
  add eax, Edx

  // Result := Result and $3f;
  and eax,$3f
end;

function POPCNTQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; stdcall;
asm
  mov eax,dword [Value+0]
  mov ecx,dword [Value+4]

  // Result := Value - ((Value shr 1) and $55555555);
  mov edx, Eax
  shr eax,1
  and eax,$55555555
  sub edx, Eax

  // Result := (result and $33333333) + ((result shr 2) and $33333333);
  mov eax, Edx
  shr edx,2
  and eax,$33333333
  and edx,$33333333
  add eax, Edx

  // Result := (result + (result shr 4)) and $0f0f0f0f;
  mov edx, Eax
  shr eax,4
  add eax, Edx
  and eax,$0f0f0f0f

  // Inc(result, Result shr 8);
  mov edx, Eax
  shr edx,8
  add eax, Edx

  // Inc(result, Result shr 16);
  mov edx, Eax
  shr edx,16
  add eax, Edx

  // Result := Result and $3f;
  and eax,$3f

  xchg ecx, Eax

  // Result := Value - ((Value shr 1) and $55555555);
  mov edx, Eax
  shr eax,1
  and eax,$55555555
  sub edx, Eax

  // Result := (result and $33333333) + ((result shr 2) and $33333333);
  mov eax, Edx
  shr edx,2
  and eax,$33333333
  and edx,$33333333
  add eax, Edx

  // Result := (result + (result shr 4)) and $0f0f0f0f;
  mov edx, Eax
  shr eax,4
  add eax, Edx
  and eax,$0f0f0f0f

  // Inc(result, Result shr 8);
  mov edx, Eax
  shr edx,8
  add eax, Edx

  // Inc(result, Result shr 16);
  mov edx, Eax
  shr edx,16
  add eax, Edx

  // Result := Result and $3f;
  and eax,$3f

  add eax, Ecx
end;
{$ENDIF}

{$ELSEIF DEFINED(cpux86_64)}

{$IFNDEF fpc}
function BSFDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
 .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsf eax, Ecx
{$ELSE}
  bsf eax, Edi
{$ENDIF}
  jnz @Done
  mov eax,255
@Done:
end;

function BSRDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsr eax, Ecx
{$ELSE}
  bsr eax, Edi
{$ENDIF}
  jnz @Done
  mov eax,255
@Done:
end;

function BSFQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsf rax, Rcx
{$ELSE}
  bsf rax, Rdi
{$ENDIF}
  jnz @Done
  mov eax,255
@Done:
end;

function BSRQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsr rax, Rcx
{$ELSE}
  bsr rax, Rdi
{$ENDIF}
  jnz @Done
  mov eax,255
@Done:
end;

function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsf eax, Ecx
{$ELSE}
  bsf eax, Edi
{$ENDIF}
  jnz @Done
  mov eax,32
@Done:
end;

function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsr ecx, Ecx
  jnz @Done
  xor ecx, Ecx
  not ecx
@Done:
  mov eax,31
  sub eax, Ecx
{$ELSE}
  bsr edi, Edi
  jnz @Done
  xor edi, Edi
  not edi
@Done:
  mov eax,31
  sub eax, Edi
{$ENDIF}
end;

function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsf rax, Rcx
{$ELSE}
  bsf rax, Rdi
{$ENDIF}
  jnz @Done
  mov eax,64
@Done:
end;

function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  bsr rcx, Rcx
  jnz @Done
  xor rcx, Rcx
  not rcx
@Done:
  mov rax,63
  sub rax, Rcx
{$ELSE}
  bsr rdi, Rdi
  jnz @Done
  xor rdi, Rdi
  not rdi
@Done:
  mov rax,63
  sub rax, Rdi
{$ENDIF}
end;

function POPCNTDWord(Value: TPasMPUInt32): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  mov eax, Ecx
{$ELSE}
  mov eax, Edi
{$ENDIF}

  // Result := Value - ((Value shr 1) and $55555555);
  mov edx, Eax
  shr eax,1
  and eax,$55555555
  sub edx, Eax

  // Result := (result and $33333333) + ((result shr 2) and $33333333);
  mov eax, Edx
  shr edx,2
  and eax,$33333333
  and edx,$33333333
  add eax, Edx

  // Result := (result + (result shr 4)) and $0f0f0f0f;
  mov edx, Eax
  shr eax,4
  add eax, Edx
  and eax,$0f0f0f0f

  // Inc(result, Result shr 8);
  mov edx, Eax
  shr edx,8
  add eax, Edx

  // Inc(result, Result shr 16);
  mov edx, Eax
  shr edx,16
  add eax, Edx

  // Result := Result and $3f;
  and eax,$3f
end;

function POPCNTQWord(Value: TPasMPUInt64): TPasMPUInt32; assembler; register; {$IFDEF fpc}nostackframe;{$ENDIF}
asm
{$IFNDEF fpc}
  .NOFRAME
{$ENDIF}
{$IFDEF Windows}
  mov rax, Rcx
{$ELSE}
  mov rax, Rdi
{$ENDIF}

  // Result := Value - ((Value shr 1) and $5555555555555555);
  mov rdx, Rax
  shr rax,1
  mov r8,$5555555555555555
  and rax, R8
  sub rdx, Rax

  // Result := (result and $3333333333333333) + ((result shr 2) and $3333333333333333);
  mov rax, Rdx
  shr rdx,2
  mov r8,$3333333333333333
  and rax, R8
  and rdx, R8
  add rax, Rdx

  // Result := (result + (result shr 4)) and $0f0f0f0f0f0f0f0f;
  mov rdx, Rax
  shr rax,4
  add rax, Rdx
  mov r8,$0f0f0f0f0f0f0f0f
  and rax, R8

  // Inc(result, Result shr 8);
  mov rdx, Rax
  shr rdx,8
  add rax, Rdx

  // Inc(result, Result shr 16);
  mov rdx, Rax
  shr rdx,16
  add rax, Rdx

  // Inc(result, Result shr 32);
  mov rdx, Rax
  shr rdx,32
  add rax, Rdx

  // Result := Result and $7f;
  and rax,$7f
end;
{$ENDIF}

{$ELSEIF not DEFINED(fpc)}

function UInt64Mul(a, B: TPasMPUInt64): TPasMPUInt64;{$IFDEF cpu386}assembler; stdcall;
asm
  push ebx
  push esi
  push edi
  mov ebx,dword ptr [b+0]
  mov ecx,dword ptr [b+4]
  mov esi,dword ptr [a+0]
  mov edi,dword ptr [a+4]
  mov eax, Edi
  mul ebx
  xchg eax, Ebx
  mul esi
  xchg esi, Eax
  add ebx, Edx
  mul ecx
  lea edx,[eax+ebx]
  mov eax, Esi
  pop edi
  pop esi
  pop ebx
end;
{$ELSE}
{$IFDEF cpu64}{$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  Result := a*b;
end;
{$ELSE}
var
  al: TPasMPUInt32;
  ah: TPasMPUInt32;
  bl: TPasMPUInt32;
  bh: TPasMPUInt32;
  zl: TPasMPUInt32;
  zh: TPasMPUInt32;
begin
  al := a and $ffffffff;
  ah := a shr 32;
  bl := b and $ffffffff;
  bh := b shr 32;
  zl := al*bl;
  zh := (al*bh) + (ah*bl) + (((al shr 1)*(bl shr 1)) shr 30);
  Result := (UInt64(zh) shl 32) or UInt64(zl);
end;
{$ENDIF}
{$ENDIF}

function BSFDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 255;
  end
  else
  begin
    Result := PasMPBSFDebruijn32Table[(((Value and not (Value-1))*PasMPBSFDebruijn32Multiplicator) shr PasMPBSFDebruijn32Shift) and PasMPBSFDebruijn32Mask];
  end;
end;

function BSFQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 255;
  end
  else
  begin
    Result := PasMPBSFDebruijn64Table[(((Value and not (Value-1))*PasMPBSFDebruijn64Multiplicator) shr PasMPBSFDebruijn64Shift) and PasMPBSFDebruijn64Mask];
  end;
end;

function BSRDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 255;
  end
  else
  begin
    Value := Value or (Value shr 1);
    Value := Value or (Value shr 2);
    Value := Value or (Value shr 4);
    Value := Value or (Value shr 8);
    Value := Value or (Value shr 16);
    Result := PasMPBSRDebruijn32Table[((Value*PasMPBSRDebruijn32Multiplicator) shr PasMPBSRDebruijn32Shift) and PasMPBSRDebruijn32Mask];
  end;
end;

function BSRQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 255;
  end
  else
  begin
    Value := Value or (Value shr 1);
    Value := Value or (Value shr 2);
    Value := Value or (Value shr 4);
    Value := Value or (Value shr 8);
    Value := Value or (Value shr 16);
    Value := Value or (Value shr 32);
    Result := PasMPBSRDebruijn64Table[((Value*PasMPBSRDebruijn64Multiplicator) shr PasMPBSRDebruijn64Shift) and PasMPBSRDebruijn64Mask];
  end;
end;

function CLZDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 32;
  end
  else
  begin
    Value := Value or (Value shr 1);
    Value := Value or (Value shr 2);
    Value := Value or (Value shr 4);
    Value := Value or (Value shr 8);
    Value := Value or (Value shr 16);
    Result := PasMPCLZDebruijn32Table[((longword(Value)*PasMPCLZDebruijn32Multiplicator) shr PasMPCLZDebruijn32Shift) and PasMPCLZDebruijn32Mask];
  end;
end;

function CLZQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 64;
  end
  else
  begin
    Value := Value or (Value shr 1);
    Value := Value or (Value shr 2);
    Value := Value or (Value shr 4);
    Value := Value or (Value shr 8);
    Value := Value or (Value shr 16);
    Value := Value or (Value shr 32);
    Result := PasMPCLZDebruijn64Table[((Value*PasMPCLZDebruijn64Multiplicator) shr PasMPCLZDebruijn64Shift) and PasMPCLZDebruijn64Mask];
  end;
end;

function CTZDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 32;
  end
  else
  begin
    Result := PasMPCTZDebruijn32Table[((longword(Value and (-Value))*PasMPCTZDebruijn32Multiplicator) shr PasMPCTZDebruijn32Shift) and PasMPCTZDebruijn32Mask];
  end;
end;

function CTZQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 64;
  end
  else
  begin
    Result := PasMPCTZDebruijn64Table[(((Value and (-Value))*PasMPCTZDebruijn64Multiplicator) shr PasMPCTZDebruijn64Shift) and PasMPCTZDebruijn64Mask];
  end;
end;

function POPCNTDWord(Value: TPasMPUInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  Value := Value - ((Value shr 1) and longword($55555555));
  Value := (Value and longword($33333333)) + ((Value shr 2) and longword($33333333));
  Value := (Value + (Value shr 4)) and longword($0f0f0f0f);
  Inc(Value,Value shr 8);
  Inc(Value,Value shr 16);
  Result := Value and $3f;
end;

function POPCNTQWord(Value: TPasMPUInt64): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  Value := Value - ((Value shr 1) and UInt64($5555555555555555));
  Value := (Value and UInt64($3333333333333333)) + ((Value shr 2) and UInt64($3333333333333333));
  Value := (Value + (Value shr 4)) and UInt64($0f0f0f0f0f0f0f0f);
  Inc(Value,Value shr 8);
  Inc(Value,Value shr 16);
  Inc(Value,Value shr 32);
  Result := Value and $7f;
end;
{$IFEND}

{$IFDEF fpc}
function CTZDWord(Value: TPasMPUInt32): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 32;
  end
  else
  begin
    Result := BSFDWord(Value);
  end;
end;

function CLZDWord(Value: TPasMPUInt32): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 0;
  end
  else
  begin
    Result := 31-BSRDWord(Value);
  end;
end;

function CTZQWord(Value: TPasMPUInt64): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 64;
  end
  else
  begin
    Result := BSFQWord(Value);
  end;
end;

function CLZQWord(Value: TPasMPUInt64): TPasMPUInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  if Value = 0 then
  begin
    Result := 0;
  end
  else
  begin
    Result := 63-BSRQWord(Value);
  end;
end;
{$ENDIF}

{$IF DEFINED(FPC) and DEFINED(CPUAArch64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
(*function IsCASPInstructionSupported: Boolean; assembler;
asm
  .pushnv
  .arch armv8-a

  mrs x0, ID_AA64PFR0_EL1 // Read ID_AA64PFR0_EL1 system register into x0
  and x0, x0, #(15 shl 16) // Extract bits [19:16] to check the architecture version
  cmp x0, #(1 shl 16) // Compare the extracted bits with ARMv8.1-A
  b.ge 1f // If the architecture is ARMv8.1-A or later, set the return value to True

  mov x0, #0 // Set the return value to False (casp is not supported)
  b 2f

  1:
  mov x0, #1 // Set the return value to True (casp is supported)

  2:
  .popnv
end;*)

{$IF DEFINED(Darwin)}
// Using casp instruction (recommended for ARMv8.1-A and later)
(*function _InterlockedCompareExchange128_(Dest:PPasMPInt64;XChgHigh,XChgLow: TPasMPInt64;Compare:PPasMPInt64): TPasMPUInt8; assembler; nostackframe;
asm
  sub sp, sp, #32
  str x0, [sp, #24]
  str x1, [sp, #16]
  str x2, [sp, #8]
  str x3, [sp]
  ldr x8, [sp, #24]
  ldr x9, [sp]
  ldr q0, [x9]
  ldr x9, [sp, #16]
  mov x11, xzr
  ldr x10, [sp, #8]
  orr x2, x11, x10
  // orr x9, x9, x10, asr #63
  .byte 0x29
  .byte 0xfd
  .byte 0x8a
  .byte 0xaa
  fmov d2, d0
  mov d1, v0.d[1]
  fmov x0, d2
  fmov x1, d1
  mov x3, x9
  // caspal x0, x1, x2, x3, [x8]
  .byte 0xe8
  .byte 0x03
  .byte 0x00
  .byte 0xaa
  mov x8, x0
  mov x9, x1
  fmov d1, d0
  mov d0, v0.d[1]
  fmov x10, d1
  eor x8, x8, x10
  fmov x10, d0
  eor x9, x9, x10
  orr x8, x8, x9
  subs x8, x8, #0
  cset w8, eq
  and w0, w8, #0x1
  add sp, sp, #32
end;*)

procedure _InterlockedCompareExchange128(Dest:PPasMPInt64;XChgHigh,XChgLow: TPasMPInt64;Compare, Result_:PPasMPInt64); assembler; nostackframe;
asm
  sub sp, sp, #48
  str x0, [sp, #40]
  str x1, [sp, #32]
  str x2, [sp, #24]
  str x3, [sp, #16]
  str x4, [sp, #8]
  ldr x8, [sp, #40]
  ldr x9, [sp, #16]
  ldr q0, [x9]
  ldr x9, [sp, #32]
  mov x11, xzr
  ldr x10, [sp, #24]
  orr x2, x11, x10
  //.dword 0xaa8afd29 // orr x9, x9, x10, asr #63
  .byte 0x29
  .byte 0xfd
  .byte 0x8a
  .byte 0xaa
  fmov d1, d0
  mov d0, v0.d[1]
  fmov x0, d1
  fmov x1, d0
  mov x3, x9
  // .dword 0x4860fd02 // caspal x0, x1, x2, x3, [x8]
  .byte 0x02
  .byte 0xfd
  .byte 0x60
  .byte 0x48
  mov x9, x0
  mov x8, x1
  mov v0.d[0], x9
  mov v0.d[1], x8
  ldr x8, [sp, #8]
  str q0, [x8]
  add sp, sp, #48
end;
{$ELSE}
// Using ldxp and stxp instructions (for broader compatibility, including ARMv8-A)
(*function _InterlockedCompareExchange128_(Dest:PPasMPInt64;XChgHigh,XChgLow: TPasMPInt64;Compare:PPasMPInt64): TPasMPUInt8; assembler; nostackframe;
label LBB0_1,LBB0_2,LBB0_3,LBB0_4;
asm
  sub sp, sp, #32
  str x0, [sp, #24]
  str x1, [sp, #16]
  str x2, [sp, #8]
  str x3, [sp]
  ldr x11, [sp, #24]
  ldr x8, [sp]
  ldr q0, [x8]
  ldr x8, [sp, #16]
  mov x10, xzr
  ldr x9, [sp, #8]
  orr x14, x10, x9
  // orr x15, x8, x9, asr #63
  .byte 0x0f
  .byte 0xfd
  .byte 0x89
  .byte 0xaa
  fmov d1, d0
  mov d2, v0.d[1]
  fmov x13, d2
  fmov x12, d1
LBB0_1: // =>This Inner Loop Header: Depth=1
  ldaxp x8, x9, [x11]
  cmp x8, x12
  cset w10, ne
  cmp x9, x13
  cinc w10, w10, ne
  cbnz w10, .LBB0_3
  stlxp w10, x14, x15, [x11]
  cbnz w10, LBB0_1
  b LBB0_4
LBB0_3: // in Loop: Header=BB0_1 Depth=1
  stlxp w10, x8, x9, [x11]
  cbnz w10, LBB0_1
LBB0_4:
  fmov d1, d0
  mov d0, v0.d[1]
  fmov x10, d1
  eor x8, x8, x10
  fmov x10, d0
  eor x9, x9, x10
  orr x8, x8, x9
  subs x8, x8, #0
  cset w8, eq
  and w0, w8, #0x1
  add sp, sp, #32
end;*)

procedure _InterlockedCompareExchange128(Dest:PPasMPInt64;XChgHigh,XChgLow: TPasMPInt64;Compare, Result_:PPasMPInt64); assembler; nostackframe;
label LBB1_1,LBB1_3,LBB1_4;
asm
  sub sp, sp, #48
  str x0, [sp, #40]
  str x1, [sp, #32]
  str x2, [sp, #24]
  str x3, [sp, #16]
  str x4, [sp, #8]
  ldr x11, [sp, #40]
  ldr x8, [sp, #16]
  ldr q1, [x8]
  ldr x8, [sp, #32]
  mov x10, xzr
  ldr x9, [sp, #24]
  orr x14, x10, x9
  // .dword 0xaa89fd0f // orr x15, x8, x9, asr #63
  .byte 0x0f
  .byte 0xfd
  .byte 0x89
  .byte 0xaa
  fmov d0, d1
  mov d1, v1.d[1]
  fmov x13, d1
  fmov x12, d0
LBB1_1: // =>This Inner Loop Header: Depth=1
  // .dword 0xc87fa169 // ldaxp x9, x8, [x11]
  .byte 0x69
  .byte 0xa1
  .byte 0x7f
  .byte 0xc8
  cmp x9, x12
  cset w10, ne
  cmp x8, x13
  cinc w10, w10, ne
  cbnz w10, LBB1_3
  stlxp w10, x14, x15, [x11]
  cbnz w10, LBB1_1
  b LBB1_4
LBB1_3: // in Loop: Header=BB1_1 Depth=1
  stlxp w10, x9, x8, [x11]
  cbnz w10, LBB1_1
LBB1_4:
  mov v0.d[0], x9
  mov v0.d[1], x8
  ldr x8, [sp, #8]
  str q0, [x8]
  add sp, sp, #48
end;
{$IFEND}

function InterlockedCompareExchange128(var Destination: TPasMPInt128Record; const NewValue, Comperand: TPasMPInt128Record): TPasMPInt128Record;
begin
  _InterlockedCompareExchange128(PPasMPInt64(@Destination), NewValue.Hi, NewValue.Lo, PPasMPInt64(@Comperand), PPasMPInt64(@Result));
end;

{$ELSEIF DEFINED(FPC) and DEFINED(CPUARM) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
{$IF DEFINED(CPUARM_HAS_LDREX)}
function InterlockedCompareExchange64(var Destination: TPasMPInt64;NewValue, Comperand: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
label Loop;
asm
  // LDREXD and STREXD were introduced in ARM 11, so the LDREXD and STREXD instructions in
  // ARM all v7 variants or above. In v6, only some variants support it (ARMv6k).
  // the LDREXD and STREXD instructions demands that Rm be an even numbered register
  // This routine is for non-thumb code
  // Input:
  // r0 = Pointer to Destination
  // r1 = NewValue.Lo
  // r2 = NewValue.Hi
  // r3 = Comperand.Lo
  // [sp] = Comperand.Hi
  stmfd sp!,{r4, R5, R6, R7}
  mov r4, R3 // r4 = Comperand.Lo (r3)
  ldr r5,[sp,#16] // r5 = Comperand.Hi ([sp+16])
  mov r6, R1 // r6 = NewValue.Lo (r1)
  mov r7, R2 // r7 = NewValue.Hi (r2)
  mov r2, R0 // r2 = Pointer to Destination (r0)
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05f // dmb sy
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  .long 0xee072fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
Loop:
  ldrexd	r0, R1,[r2] // loads r0 and r1 from Pointer to Destination (r2), so r0 = Destination.Lo, r1 = Destination.Hi
  eors r3, R0, R4 // compare Destination.Lo (r0) with Comperand.Lo (r4)
  eoreqs r3, R1, R5 // compare Destination.Hi (r1) with Comperand.Hi (r5)
  strexdeq r3, R6, R7,[r2]  // [r2]=r6 and [r2+4]=r7 and r3=result (0 for success or 1 for failure)
  teqeq r3,#1 // 1 for failure and 0 for success
  beq Loop // try again if failed
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05f // dmb sy
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  .long 0xee072fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
  // r0 and r1 should contain here now the old Lo and Hi values from Pointer to Destination (r2) as
  // Result value registers
  ldmfd sp!,{r4, R5, R6, R7}
end;
{$ELSEIF DEFINED(FPC) and DEFINED(CPUAARCH64)}
function InterlockedCompareExchange128(var Destination: TPasMPInt128Record; const NewValue, Comperand: TPasMPInt128Record): TPasMPInt128Record; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
label Loop, Fail;
asm
  // Input:
  // x0 = Pointer to Destination
  // x1 = NewValue.Lo
  // x2 = NewValue.Hi
  // x3 = Comperand.Lo
  // x4 = Comperand.Hi
  // x5 = Destination.Lo = [x0+0]
  // x6 = Destination.Hi = [x0+8]
  mov x6,x1
Loop:
  ldaxp x5,x1,[x0]
  cmp x5,x3
  bne Fail
  cmp x1,x4
  bne Fail
  stlxp w7,x6,x2,[x0]
  cbnz w7,Loop
Fail:
  mov x0,x5
  // x0 and x1 should contain here now the old Lo and Hi values from Pointer to Destination (x0) as
  // Result value registers
end;
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 3.1 respectively _kuser_helper_version >= 5
function InterlockedCompareExchange64(var Destination: TPasMPInt64;NewValue, Comperand: TPasMPInt64): TPasMPInt64;
type Tkuser__cmpxchg64 = function(Comperand, NewValue,Destination:PPasMPInt64): TPasMPInt32;
begin
  if PPasMPInt32(Pointer(PtrUInt($ffff0ffc{__kuser__helper_version})))^>=5 then
  begin
    // Warning:
    // This assumes that the InterlockedCompareExchange64 caller uses the Result only for
    // successful/failure checking, but not for other purposes
    Result := Destination;
    if Tkuser__cmxchg64(Pointer(PtrUInt($ffff0f60{__kuser__cmpxchg64})))(@Comperand, @NewValue, @Destination) = 0 then
    begin
      Result := Comperand;
    end
    else if Result = Comperand then
    begin
      Result := not Comperand;
    end;
  end
  else
  begin
    Assert(false,'Non-supported target platform configuration');
    Result := not Comperand;
  end;
end;
{$ELSE} // Otherwise give up
 {$error Non-supported target platform configuration}
{$IFEND}

{$ELSEIF DEFINED(CPU386)}

function InterlockedCompareExchange64(var Destination: TPasMPInt64;NewValue, Comperand: TPasMPInt64): TPasMPInt64; assembler;
asm
  push ebx
  push edi
  mov edi, Eax
  mov edx,dword ptr [Comperand+4]
  mov eax,dword ptr [Comperand+0]
  mov ecx,dword ptr [NewValue+4]
  mov ebx,dword ptr [NewValue+0]
  lock cmpxchg8b [edi]
  pop edi
  pop ebx
end;

{$ELSEIF DEFINED(CPUx86_64)}

function InterlockedCompareExchange128(var Destination: TPasMPInt128Record; const NewValue, Comperand: TPasMPInt128Record): TPasMPInt128Record; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  push rbx
{$IFDEF Windows}
  push rcx
  mov rbx, Qword ptr [r8]
  mov rcx, Qword ptr [r8+8]
  mov r8, Rdx
  mov rax, Qword ptr [r9]
  mov rdx, Qword ptr [r9+8]
  lock cmpxchg16b [r8]
  pop rcx
  mov qword ptr [rcx], Rax
  mov qword ptr [rcx+8], Rdx
{$ELSE}
  mov rbx, Rsi
  mov rax, Rcx
  mov rcx, Rdx
  mov rdx, R8
  lock cmpxchg16b [rdi]
{$ENDIF}
  pop rbx
end;

{$IFEND}

{$IFNDEF fpc}
{$IFDEF CPU386}
function InterlockedDecrement(var Destination: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  mov edx,$ffffffff
  xchg eax, Edx
  lock xadd dword ptr [edx], Eax
  dec eax
end;

function InterlockedIncrement(var Destination: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  mov edx,1
  xchg eax, Edx
  lock xadd dword ptr [edx], Eax
  inc eax
end;

function InterlockedExchange(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  lock xchg dword ptr [eax], Edx
  mov eax, Edx
end;

function InterlockedExchangePointer(var Destination: Pointer;Source: Pointer): Pointer; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  lock xchg dword ptr [eax], Edx
  mov eax, Edx
end;

function InterlockedExchangeAdd(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  xchg edx, Eax
  lock xadd dword ptr [edx], Eax
end;

function InterlockedCompareExchange(var Destination: TPasMPInt32;NewValue, Comperand: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
  xchg ecx, Eax
  lock cmpxchg dword ptr [ecx], Edx
end;
{$ELSE}
{$IFDEF CPUx86_64}
function InterlockedDecrement(var Destination: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov rax, Rcx
{$ELSE}
  mov rax, Rdi
{$ENDIF}
  mov edx,$ffffffff
  xchg rdx, Rax
  lock xadd dword ptr [rdx], Eax
  dec eax
end;

function InterlockedDecrement64(var Destination: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov rax, Rcx
{$ELSE}
  mov rax, Rdi
{$ENDIF}
  mov rdx,$ffffffffffffffff
  xchg rdx, Rax
  lock xadd qword ptr [rdx], Rax
  dec rax
end;

function InterlockedIncrement(var Destination: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov rax, Rcx
{$ELSE}
  mov rax, Rdi
{$ENDIF}
  mov edx,1
  xchg rdx, Rax
  lock xadd dword ptr [rdx], Eax
  inc eax
end;

function InterlockedIncrement64(var Destination: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov rax, Rcx
{$ELSE}
  mov rax, Rdi
{$ENDIF}
  mov rdx,1
  xchg rdx, Rax
  lock xadd qword ptr [rdx], Rax
  inc rax
end;

function InterlockedExchange(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  lock xchg dword ptr [rcx], Edx
  mov eax, Edx
{$ELSE}
  lock xchg dword ptr [rdi], Esi
  mov eax, Esi
{$ENDIF}
end;

function InterlockedExchange64(var Destination: TPasMPInt64;NewValue: TPasMPInt64;Comperand: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  lock xchg rdx, Qword ptr [rcx]
  mov rax, Rdx
{$ELSE}
  lock xchg rsi, Qword ptr [rdi]
  mov rax, Rsi
{$ENDIF}
end;

function InterlockedExchangePointer(var Destination: Pointer;Source: Pointer): Pointer; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  lock xchg rdx, Qword ptr [rcx]
  mov rax, Rdx
{$ELSE}
  lock xchg rsi, Qword ptr [rdi]
  mov rax, Rsi
{$ENDIF}
end;

function InterlockedExchangeAdd(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  xchg rdx, Rcx
  lock xadd dword ptr [rdx], Ecx
  mov eax, Ecx
{$ELSE}
  xchg rsi, Rdi
  lock xadd dword ptr [rsi], Edi
  mov eax, Edi
{$ENDIF}
end;

function InterlockedExchangeAdd64(var Destination: TPasMPInt64;NewValue: TPasMPInt64;Comperand: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  xchg rdx, Rcx
  lock xadd qword ptr [rdx], Rcx
  mov rax, Rcx
{$ELSE}
  xchg rsi, Rdi
  lock xadd qword ptr [rsi], Rdi
  mov rax, Rdi
{$ENDIF}
end;

function InterlockedCompareExchange(var Destination: TPasMPInt32;NewValue, Comperand: TPasMPInt32): TPasMPInt32; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov eax, R8d
  lock cmpxchg dword ptr [rcx], Edx
{$ELSE}
  mov eax, Edx
  lock cmpxchg dword ptr [rdi], Esi
{$ENDIF}
end;

function InterlockedCompareExchange64(var Destination: TPasMPInt64;NewValue, Comperand: TPasMPInt64): TPasMPInt64; assembler; {$IFDEF fpc}nostackframe;{$ELSE}register;{$ENDIF}
asm
{$IFDEF Windows}
  mov rax, R8
  lock cmpxchg qword ptr [rcx], Rdx
{$ELSE}
  mov rax, Rdx
  lock cmpxchg qword ptr [rdi], Rsi
{$ENDIF}
end;
{$ELSE}
{$IFNDEF HAS_ATOMICS}
function InterlockedDecrement(var Destination: TPasMPInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicDecrement(Destination);
{$ELSE}
  Result := Windows.InterlockedDecrement(Destination);
{$ENDIF}
end;

function InterlockedIncrement(var Destination: TPasMPInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination);
{$ELSE}
  Result := Windows.InterlockedIncrement(Destination);
{$ENDIF}
end;

function InterlockedExchange(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := Windows.InterlockedExchange(Destination, Source);
{$ENDIF}
end;

function InterlockedExchangePointer(var Destination: Pointer;Source: Pointer): Pointer; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := Windows.InterlockedExchangePointer(Destination, Source);
{$ENDIF}
end;

function InterlockedExchangeAdd(var Destination: TPasMPInt32;Source: TPasMPInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  repeat
    Result := Destination;
  until AtomicCmpExchange(Destination,Destination+Source,Destination) = result;
{$ELSE}
  Result := Windows.InterlockedExchangeAdd(Destination, Source);
{$ENDIF}
end;

function InterlockedCompareExchange(var Destination: TPasMPInt32;NewValue, Comperand: TPasMPInt32): TPasMPInt32; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := Windows.InterlockedCompareExchange(Destination, NewValue, Comperand);
{$ENDIF}
end;

function InterlockedCompareExchange64(var Destination: TPasMPInt64;NewValue, Comperand: TPasMPInt64): TPasMPInt64; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := Windows.InterlockedCompareExchange64(Destination, NewValue, Comperand);
{$ENDIF}
end;
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$IF DEFINED(fpc)}

procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  ReadWriteBarrier;
end;

{$ELSEIF CompilerVersion>=25}

procedure FallbackReadBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  MemoryBarrier;
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  MemoryBarrier;
end;

procedure FallbackWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  MemoryBarrier;
end;

procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  MemoryBarrier;
end;

{$ELSEIF DEFINED(CPU386)}

procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  lfence
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  mfence
end;

procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  sfence
end;

procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  mfence
end;

{$ELSEIF DEFINED(CPUx64)}

procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  lfence
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  mfence
end;

procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  sfence
end;

procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  mfence
end;

{$ELSEIF DEFINED(CPUAARCH64)}

procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  .long 0xd50339bf // dmb ishld (or #9)
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  .long 0xd5033bbf // dmb ish (or #11)
end;

procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  .long 0xd5033abf // dmb ishst or (#10)
end;

procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
  .long 0xd5033bbf // dmb ish (or #11)
end;

{$ELSEIF DEFINED(CPUARM)}

procedure FallbackReadBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05f // dmb sy
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  mov r0,#0
  .long 0xee070fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05f // dmb sy
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  mov r0,#0
  .long 0xee070fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
end;

procedure FallbackWriteBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05e // dmb st
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  mov r0,#0
  .long 0xee070fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
end;

procedure FallbackMemoryBarrier; assembler; {$IFDEF fpc}nostackframe; {$IFDEF CAN_INLINE}inline;{$ENDIF}{$ENDIF}
asm
{$IF DEFINED(CPUARM_HAS_DMB)} // >= CPUARMV7A
  .long 0xf57ff05f // dmb sy
{$ELSEIF DEFINED(CPUARMV6K)} // = CPUARMV6K
  mov r0,#0
  .long 0xee070fba // mcr p15, 0, R2, C7, C10,5
{$ELSEIF DEFINED(Linux) or DEFINED(Android)} // Linux and Android with a kernel version >= 2.6.15 respectively _kuser_helper_version >= 3
  // r0 = kuser_memory_barrier at 0xffff0fa0 (see https://www.kernel.org/doc/Documentation/arm/kernel_user_helpers.txt)
  stmfd r13!,{lr}
  mvn r0,#0x0000f000
  sub r0, R0,#0x5f
{$IF DEFINED(CPUARM_HAS_BLX)}
  blx r0
{$ELSEIF DEFINED(CPUARM_HAS_BLX)}
  mov lr, Pc
{$IF DEFINED(CPUARM_HAS_BX)}
  bx r0
{$ELSE}
  mov pc, R0
{$IFEND}
  ldmfd r13!,{pc}
{$IFEND}
{$ELSE} // Otherwise give up
  {$error Non-supported target platform configuration}
{$IFEND}
end;

{$ELSE}
procedure FallbackReadBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
end;

procedure FallbackReadDependencyBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
  // reads imply barrier on earlier reads depended on
end;

procedure FallbackReadWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
end;

procedure FallbackWriteBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
end;

procedure FallbackMemoryBarrier; {$IFDEF CAN_INLINE}inline;{$ENDIF}
begin
{$IFDEF fpc}
  ReadWriteBarrier;
{$ELSE}
  FallBackReadWriteBarrier;
{$ENDIF}
end;
{$IFEND}

procedure MemorySwap(a, B: Pointer;Size: TPasMPInt32);
var
  Temp: TPasMPUInt32;
begin
  while Size>=SizeOf(TPasMPUInt32) do
  begin
    Temp := TPasMPUInt32(a^);
    TPasMPUInt32(a^) := TPasMPUInt32(b^);
    TPasMPUInt32(b^) := Temp;
    Inc(TPasMPPtrUInt(a), SizeOf(TPasMPUInt32));
    Inc(TPasMPPtrUInt(b), SizeOf(TPasMPUInt32));
    Dec(Size, SizeOf(TPasMPUInt32));
  end;
  while Size>=SizeOf(TPasMPUInt8) do
  begin
    Temp := TPasMPUInt8(a^);
    TPasMPUInt8(a^) := TPasMPUInt8(b^);
    TPasMPUInt8(b^) := Temp;
    Inc(TPasMPPtrUInt(a), SizeOf(TPasMPUInt8));
    Inc(TPasMPPtrUInt(b), SizeOf(TPasMPUInt8));
    Dec(Size, SizeOf(TPasMPUInt8));
  end;
end;

class function TPasMPMath.PopulationCount32(Value: TPasMPUInt32): TPasMPInt32;
begin
{$IFDEF fpc}
  Result := PopCnt(Value);
{$ELSE}
  Result := POPCNTDWord(Value);
{$ENDIF}
end;

class function TPasMPMath.PopulationCount64(Value: TPasMPUInt64): TPasMPInt32;
begin
{$IFDEF fpc}
  Result := PopCnt(Value);
{$ELSE}
  Result := POPCNTQWord(Value);
{$ENDIF}
end;

class function TPasMPMath.PopulationCount(Value: TPasMPPtrUInt): TPasMPInt32;
begin
{$IFDEF fpc}
  Result := PopCnt(Value);
{$ELSE}
{$IFDEF CPU64}
  Result := POPCNTQWord(Value);
{$ELSE}
  Result := POPCNTDWord(Value);
{$ENDIF}
{$ENDIF}
end;

class function TPasMPMath.BitScanForward32(Value: TPasMPUInt32): TPasMPInt32;
begin
  Result := BSFDWord(Value);
end;

class function TPasMPMath.BitScanForward64(Value: TPasMPUInt64): TPasMPInt32;
begin
  Result := BSFQWord(Value);
end;

class function TPasMPMath.BitScanForward(Value: TPasMPPtrUInt): TPasMPInt32;
begin
{$IFDEF CPU64}
  Result := BSFQWord(Value);
{$ELSE}
  Result := BSFDWord(Value);
{$ENDIF}
end;

class function TPasMPMath.BitScanReverse32(Value: TPasMPUInt32): TPasMPInt32;
begin
  Result := BSRDWord(Value);
end;

class function TPasMPMath.BitScanReverse64(Value: TPasMPUInt64): TPasMPInt32;
begin
  Result := BSRQWord(Value);
end;

class function TPasMPMath.BitScanReverse(Value: TPasMPPtrUInt): TPasMPInt32;
begin
{$IFDEF CPU64}
  Result := BSRQWord(Value);
{$ELSE}
  Result := BSRDWord(Value);
{$ENDIF}
end;

class function TPasMPMath.CountLeadingZeros32(Value: TPasMPUInt32): TPasMPInt32;
begin
  Result := CLZDWord(Value);
end;

class function TPasMPMath.CountLeadingZeros64(Value: TPasMPUInt64): TPasMPInt32;
begin
  Result := CLZQWord(Value);
end;

class function TPasMPMath.CountLeadingZeros(Value: TPasMPPtrUInt): TPasMPInt32;
begin
{$IFDEF CPU64}
  Result := CLZQWord(Value);
{$ELSE}
  Result := CLZDWord(Value);
{$ENDIF}
end;

class function TPasMPMath.CountTrailingZeros32(Value: TPasMPUInt32): TPasMPInt32;
begin
  Result := CTZDWord(Value);
end;

class function TPasMPMath.CountTrailingZeros64(Value: TPasMPUInt64): TPasMPInt32;
begin
  Result := CTZQWord(Value);
end;

class function TPasMPMath.CountTrailingZeros(Value: TPasMPPtrUInt): TPasMPInt32;
begin
{$IFDEF CPU64}
  Result := CTZQWord(Value);
{$ELSE}
  Result := CTZDWord(Value);
{$ENDIF}
end;

class function TPasMPMath.FindFirstSetBit32(Value: TPasMPUInt32): TPasMPInt32;
begin
  if Value = 0 then
  begin
    Result :=  - 1;
  end
  else
  begin
    Result := BSFDWord(Value);
  end;
end;

class function TPasMPMath.FindFirstSetBit64(Value: TPasMPUInt64): TPasMPInt32;
begin
  if Value = 0 then
  begin
    Result :=  - 1;
  end
  else
  begin
    Result := BSFQWord(Value);
  end;
end;

class function TPasMPMath.FindFirstSetBit(Value: TPasMPPtrUInt): TPasMPInt32;
begin
  if Value = 0 then
  begin
    Result :=  - 1;
  end
  else
  begin
{$IFDEF CPU64}
    Result := BSFQWord(Value);
{$ELSE}
    Result := BSFDWord(Value);
{$ENDIF}
  end;
end;

class function TPasMPMath.RoundUpToPowerOfTwo32(Value: TPasMPUInt32): TPasMPUInt32;
begin
  Dec(Value);
  Value := Value or (Value shr 1);
  Value := Value or (Value shr 2);
  Value := Value or (Value shr 4);
  Value := Value or (Value shr 8);
  Value := Value or (Value shr 16);
  Result := Value + 1;
end;

class function TPasMPMath.RoundUpToPowerOfTwo64(Value: TPasMPUInt64): TPasMPUInt64;
begin
  Dec(Value);
  Value := Value or (Value shr 1);
  Value := Value or (Value shr 2);
  Value := Value or (Value shr 4);
  Value := Value or (Value shr 8);
  Value := Value or (Value shr 16);
  Value := Value or (Value shr 32);
  Result := Value + 1;
end;

class function TPasMPMath.RoundUpToPowerOfTwo(Value: TPasMPPtrUInt): TPasMPPtrUInt;
begin
  Dec(Value);
  Value := Value or (Value shr 1);
  Value := Value or (Value shr 2);
  Value := Value or (Value shr 4);
  Value := Value or (Value shr 8);
  Value := Value or (Value shr 16);
{$IFDEF CPU64}
  Value := Value or (Value shr 32);
{$ENDIF}
  Result := Value + 1;
end;

class function TPasMPMath.RoundUpToMask32(Value, Mask: TPasMPUInt32): TPasMPUInt32;
begin
  if (Value and (Mask-1)) <> 0 then
  begin
    Result := (Value+Mask) and not (Mask-1);
  end
  else
  begin
    Result := Value;
  end;
end;

class function TPasMPMath.RoundUpToMask64(Value, Mask: TPasMPUInt64): TPasMPUInt64;
begin
  if (Value and (Mask-1)) <> 0 then
  begin
    Result := (Value+Mask) and not (Mask-1);
  end
  else
  begin
    Result := Value;
  end;
end;

class function TPasMPMath.RoundUpToMask(Value, Mask: TPasMPPtrUInt): TPasMPPtrUInt;
begin
  if (Value and (Mask-1)) <> 0 then
  begin
    Result := (Value+Mask) and not (Mask-1);
  end
  else
  begin
    Result := Value;
  end;
end;

class function TPasMP.GetThreadIDHash(ThreadID:{$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF}): TPasMPUInt32;
{$IF DEFINED(Darwin)}
var
  ThreadIDCasted: TPasMPUInt32 absolute ThreadID;
{$IFEND}
begin
{$IF DEFINED(Darwin)}
  Result := (ThreadIDCasted*83492791) xor ((ThreadIDCasted shr 24)*19349669) xor ((ThreadIDCasted shr 16)*73856093) xor ((ThreadIDCasted shr 8)*50331653);
{$ELSE}
  Result := (ThreadID*83492791) xor ((ThreadID shr 24)*19349669) xor ((ThreadID shr 16)*73856093) xor ((ThreadID shr 8)*50331653);
{$IFEND}
end;

class function TPasMP.EncodeJobPriorityToJobFlags(const JobPriority: TPasMPJobPriority): TPasMPUInt32;
begin
  case JobPriority of
    pmjpLow:  begin
                Result := PasMPJobPriorityLow;
              end;
    pmjpNormal: begin
                  Result := PasMPJobPriorityNormal;
                end;
    pmjpHigh: begin
                Result := PasMPJobPriorityHigh;
              end;
    else
      begin
        Result := PasMPJobPriorityInherited;
      end;
  end;
end;

class function TPasMP.DecodeJobPriorityFromJobFlags(const Flags: TPasMPUInt32): TPasMPJobPriority;
begin
  case Flags and PasMPJobPriorityMask of
    PasMPJobPriorityLow:  begin
                            Result := pmjpLow;
                          end;
    PasMPJobPriorityNormal: begin
                              Result := pmjpNormal;
                            end;
    PasMPJobPriorityHigh: begin
                            Result := pmjpHigh;
                          end;
    else
      begin
        Result := pmjpInherited;
      end;
  end;
end;

class function TPasMP.EncodeJobTagToJobFlags(const JobTag: TPasMPUInt32): TPasMPUInt32;
begin
  Result := (JobTag and PasMPJobTagMask) shl PasMPJobTagShift;
end;

class function TPasMP.DecodeJobTagFromJobFlags(const Flags: TPasMPUInt32): TPasMPUInt32;
begin
  Result := (Flags shr PasMPJobTagShift) and PasMPJobTagMask;
end;

class procedure TPasMP.Relax;{$IF DEFINED(CPU386)}assembler;
asm
  db $f3,$90 // pause (rep nop)
end;
{$ELSEIF DEFINED(CPUx86_64)}assembler;
asm
  pause
end;
{$ELSE}
begin
{$IFDEF fpc}
  TPasMP.Yield;
{$ELSE}
  YieldProcessor;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMP.Yield;
{$IF DEFINED(Windows)}
begin
  SwitchToThread;
end;
{$ELSEIF DEFINED(Unix)}
{$IF DEFINED(fpc) and DEFINED(usecthreads)}
begin
  sched_yield;
end;
{$ELSEIF DEFINED(fpc)}
var
  timeout:timeval;
begin
  timeout.tv_sec := 0;
  timeout.tv_usec := 0;
  fpselect(0, nil, nil, nil, @timeout);
end;
{$ELSE}
begin
  TThread.Yield;
end;
{$IFEND}
{$ELSEIF DEFINED(fpc)}
begin
  ThreadSwitch;
end;
{$ELSE}
begin
  TThread.Yield;
end;
{$IFEND}

class function TPasMPInterlocked.Increment(var Destination: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination);
{$ELSE}
  Result := InterlockedIncrement(Destination);
{$ENDIF}
end;

class function TPasMPInterlocked.Increment(var Destination: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicIncrement(TPasMPInt32(Destination))));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedIncrement(TPasMPInt32(Destination))));
{$ENDIF}
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.Increment(var Destination: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination);
{$ELSE}
  Result := InterlockedIncrement64(Destination);
{$ENDIF}
end;

class function TPasMPInterlocked.Increment(var Destination: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt64(TPasMPInt64(AtomicIncrement(TPasMPInt64(Destination))));
{$ELSE}
  Result := TPasMPUInt64(TPasMPInt64(InterlockedIncrement64(TPasMPInt64(Destination))));
{$ENDIF}
end;
{$ENDIF}

class function TPasMPInterlocked.Decrement(var Destination: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicDecrement(Destination);
{$ELSE}
  Result := InterlockedDecrement(Destination);
{$ENDIF}
end;

class function TPasMPInterlocked.Decrement(var Destination: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicDecrement(TPasMPInt32(Destination))));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedDecrement(TPasMPInt32(Destination))));
{$ENDIF}
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.Decrement(var Destination: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicDecrement(Destination);
{$ELSE}
  Result := InterlockedDecrement64(Destination);
{$ENDIF}
end;

class function TPasMPInterlocked.Decrement(var Destination: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt64(TPasMPInt64(AtomicDecrement(TPasMPInt64(Destination))));
{$ELSE}
  Result := TPasMPUInt64(TPasMPInt64(InterlockedDecrement64(TPasMPInt64(Destination))));
{$ENDIF}
end;
{$ENDIF}

class function TPasMPInterlocked.Add(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination,Value)-Value;
{$ELSE}
  Result := InterlockedExchangeAdd(Destination,Value);
{$ENDIF}
end;

class function TPasMPInterlocked.Add(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicIncrement(TPasMPInt32(Destination), TPasMPInt32(Value))-TPasMPInt32(Value)));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedExchangeAdd(TPasMPInt32(Destination), TPasMPInt32(Value))));
{$ENDIF}
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.Add(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination,Value)-Value;
{$ELSE}
  Result := InterlockedExchangeAdd64(Destination,Value);
{$ENDIF}
end;

class function TPasMPInterlocked.Add(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt64(TPasMPInt64(AtomicIncrement(TPasMPInt64(Destination), TPasMPInt64(Value))-TPasMPInt64(Value)));
{$ELSE}
  Result := TPasMPUInt64(TPasMPInt64(InterlockedExchangeAdd64(TPasMPInt64(Destination), TPasMPInt64(Value))));
{$ENDIF}
end;
{$ENDIF}

class function TPasMPInterlocked.Sub(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination,-Value)+Value;
{$ELSE}
  Result := InterlockedExchangeAdd(Destination,-Value);
{$ENDIF}
end;

class function TPasMPInterlocked.Sub(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicIncrement(TPasMPInt32(Destination),-TPasMPInt32(Value))+TPasMPInt32(Value)));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedExchangeAdd(TPasMPInt32(Destination),-TPasMPInt32(Value))));
{$ENDIF}
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.Sub(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicIncrement(Destination,-Value)+Value;
{$ELSE}
  Result := InterlockedExchangeAdd64(Destination,-Value);
{$ENDIF}
end;

class function TPasMPInterlocked.Sub(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt64(TPasMPInt64(AtomicIncrement(TPasMPInt64(Destination),-TPasMPInt64(Value))+TPasMPInt64(Value)));
{$ELSE}
  Result := TPasMPUInt64(TPasMPInt64(InterlockedExchangeAdd64(TPasMPInt64(Destination),-TPasMPInt64(Value))));
{$ENDIF}
end;
{$ENDIF}

class procedure TPasMPInterlocked.BitwiseAnd(var Destination: TPasMPInt32; const Value: TPasMPInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock and dword ptr [eax], Edx
{$ELSE}
  lock and dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock and dword ptr [rcx], Edx
{$ELSE}
  lock and dword ptr [rdx], R8d
{$ENDIF}
  {$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock and dword ptr [rdi], Esi
{$ELSE}
  lock and dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue and Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange(Destination, OldValue and Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseAnd(var Destination: TPasMPUInt32; const Value: TPasMPUInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock and dword ptr [eax], Edx
{$ELSE}
  lock and dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock and dword ptr [rcx], Edx
{$ELSE}
  lock and dword ptr [rdx], R8d
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock and dword ptr [rdi], Esi
{$ELSE}
  lock and dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue and Value), TPasMPInt32(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue and Value), TPasMPInt32(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}

{$IFDEF CPU64}
class procedure TPasMPInterlocked.BitwiseAnd(var Destination: TPasMPInt64; const Value: TPasMPInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock and qword ptr [rcx], Rdx
{$ELSE}
  lock and qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock and qword ptr [rdi], Rsi
{$ELSE}
  lock and qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue and Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange64(Destination, OldValue and Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseAnd(var Destination: TPasMPUInt64; const Value: TPasMPUInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock and qword ptr [rcx], Rdx
{$ELSE}
  lock and qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock and qword ptr [rdi], Rsi
{$ELSE}
  lock and qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(OldValue and Value), TPasMPInt64(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(OldValue and Value), TPasMPInt64(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}
{$ENDIF}

class procedure TPasMPInterlocked.BitwiseOr(var Destination: TPasMPInt32; const Value: TPasMPInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock or dword ptr [eax], Edx
{$ELSE}
  lock or dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock or dword ptr [rcx], Edx
{$ELSE}
  lock or dword ptr [rdx], R8d
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock or dword ptr [rdi], Esi
{$ELSE}
  lock or dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue or Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange(Destination, OldValue or Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseOr(var Destination: TPasMPUInt32; const Value: TPasMPUInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock or dword ptr [eax], Edx
{$ELSE}
  lock or dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock or dword ptr [rcx], Edx
{$ELSE}
  lock or dword ptr [rdx], R8d
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock or dword ptr [rdi], Esi
{$ELSE}
  lock or dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue or Value), TPasMPInt32(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue or Value), TPasMPInt32(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}

{$IFDEF CPU64}
class procedure TPasMPInterlocked.BitwiseOr(var Destination: TPasMPInt64; const Value: TPasMPInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock or qword ptr [rcx], Rdx
{$ELSE}
  lock or qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock or qword ptr [rdi], Rsi
{$ELSE}
  lock or qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue or Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange64(Destination, OldValue or Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseOr(var Destination: TPasMPUInt64; const Value: TPasMPUInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock or qword ptr [rcx], Rdx
{$ELSE}
  lock or qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock or qword ptr [rdi], Rsi
{$ELSE}
  lock or qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(OldValue or Value), TPasMPInt64(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(OldValue or Value), TPasMPInt64(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}
{$ENDIF}

class procedure TPasMPInterlocked.BitwiseXor(var Destination: TPasMPInt32; const Value: TPasMPInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock xor dword ptr [eax], Edx
{$ELSE}
  lock xor dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock xor dword ptr [rcx], Edx
{$ELSE}
  lock xor dword ptr [rdx], R8d
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock xor dword ptr [rdi], Esi
{$ELSE}
  lock xor dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue xor Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange(Destination, OldValue xor Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseXor(var Destination: TPasMPUInt32; const Value: TPasMPUInt32);
{$IF DEFINED(cpu386)}
asm
{$IFDEF HAS_STATIC}
  lock xor dword ptr [eax], Edx
{$ELSE}
  lock xor dword ptr [edx], Ecx
{$ENDIF}
end;
{$ELSEIF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock xor dword ptr [rcx], Edx
{$ELSE}
  lock xor dword ptr [rdx], R8d
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock xor dword ptr [rdi], Esi
{$ELSE}
  lock xor dword ptr [rsi], Edx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue xor Value), TPasMPInt32(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(OldValue xor Value), TPasMPInt32(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}

{$IFDEF CPU64}
class procedure TPasMPInterlocked.BitwiseXor(var Destination: TPasMPInt64; const Value: TPasMPInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock xor qword ptr [rcx], Rdx
{$ELSE}
  lock xor qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock xor qword ptr [rdi], Rsi
{$ELSE}
  lock xor qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until AtomicCmpExchange(Destination, OldValue xor Value, OldValue) = OldValue;
{$ELSE}
  until InterlockedCompareExchange64(Destination, OldValue xor Value, OldValue) = OldValue;
{$ENDIF}
end;
{$IFEND}

class procedure TPasMPInterlocked.BitwiseXor(var Destination: TPasMPUInt64; const Value: TPasMPUInt64);
{$IF DEFINED(cpux86_64)}
asm
{$IFDEF Windows}
  // Win64 ABI
  // rcx = Parameter 1
  // rdx = Parameter 2
  // r8 = Parameter 3
{$IFDEF HAS_STATIC}
  lock xor qword ptr [rcx], Rdx
{$ELSE}
  lock xor qword ptr [rdx], R8
{$ENDIF}
{$ELSE}
  // System V ABI
  // rdi = self
  // rsi = Job
  // rdx = Temporary
{$IFDEF HAS_STATIC}
  lock xor qword ptr [rdi], Rsi
{$ELSE}
  lock xor qword ptr [rsi], Rdx
{$ENDIF}
{$ENDIF}
end;
{$ELSE}
var
  OldValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
{$IFDEF HAS_ATOMICS}
  until TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(OldValue xor Value), TPasMPInt64(OldValue)))) = OldValue;
{$ELSE}
  until TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(OldValue xor Value), TPasMPInt64(OldValue)))) = OldValue;
{$ENDIF}
end;
{$IFEND}
{$ENDIF}

class function TPasMPInterlocked.ExchangeBitwiseAnd(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32;
var
  OldValue: TPasMPInt32;
  NewValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue and Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseAnd(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32;
var
  OldValue: TPasMPUInt32;
  NewValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue and Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ELSE}
    Result := TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.ExchangeBitwiseAnd(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64;
var
  OldValue: TPasMPInt64;
  NewValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue and Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange64(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseAnd(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64;
var
  OldValue: TPasMPUInt64;
  NewValue: TPasMPUInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue and Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ELSE}
    Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;
{$ENDIF}

class function TPasMPInterlocked.ExchangeBitwiseOr(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32;
var
  OldValue: TPasMPInt32;
  NewValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue or Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseOr(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32;
var
  OldValue: TPasMPUInt32;
  NewValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue or Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ELSE}
    Result := TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.ExchangeBitwiseOr(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64;
var
  OldValue: TPasMPInt64;
  NewValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue or Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange64(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseOr(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64;
var
  OldValue: TPasMPUInt64;
  NewValue: TPasMPUInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue or Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ELSE}
    Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;
{$ENDIF}

class function TPasMPInterlocked.ExchangeBitwiseAndOr(var Destination: TPasMPInt32; const AndValue,OrValue: TPasMPInt32): TPasMPInt32;
var
  OldValue: TPasMPInt32;
  NewValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := (OldValue and AndValue) or OrValue;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseAndOr(var Destination: TPasMPUInt32; const AndValue,OrValue: TPasMPUInt32): TPasMPUInt32;
var
  OldValue: TPasMPUInt32;
  NewValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := (OldValue and AndValue) or OrValue;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ELSE}
    Result := TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.ExchangeBitwiseAndOr(var Destination: TPasMPInt64; const AndValue,OrValue: TPasMPInt64): TPasMPInt64;
var
  OldValue: TPasMPInt64;
  NewValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := (OldValue and AndValue) or OrValue;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange64(Destination, NewValue, OldValue);
{$ENDIF}
  until Result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseAndOr(var Destination: TPasMPUInt64; const AndValue,OrValue: TPasMPUInt64): TPasMPUInt64;
var
  OldValue: TPasMPUInt64;
  NewValue: TPasMPUInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := (OldValue and AndValue) or OrValue;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ELSE}
    Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;
{$ENDIF}

class function TPasMPInterlocked.ExchangeBitwiseXor(var Destination: TPasMPInt32; const Value: TPasMPInt32): TPasMPInt32;
var
  OldValue: TPasMPInt32;
  NewValue: TPasMPInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue xor Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange(Destination, NewValue, OldValue);
{$ENDIF}
  until result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseXor(var Destination: TPasMPUInt32; const Value: TPasMPUInt32): TPasMPUInt32;
var
  OldValue: TPasMPUInt32;
  NewValue: TPasMPUInt32;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue xor Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ELSE}
    Result := TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.ExchangeBitwiseXor(var Destination: TPasMPInt64; const Value: TPasMPInt64): TPasMPInt64;
var
  OldValue: TPasMPInt64;
  NewValue: TPasMPInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue xor Value;
{$IFDEF HAS_ATOMICS}
    Result := AtomicCmpExchange(Destination, NewValue, OldValue);
{$ELSE}
    Result := InterlockedCompareExchange64(Destination, NewValue, OldValue);
{$ENDIF}
  until result = OldValue;
end;

class function TPasMPInterlocked.ExchangeBitwiseXor(var Destination: TPasMPUInt64; const Value: TPasMPUInt64): TPasMPUInt64;
var
  OldValue: TPasMPUInt64;
  NewValue: TPasMPUInt64;
begin
  repeat
    OldValue := Destination;
    NewValue := OldValue xor Value;
{$IFDEF HAS_ATOMICS}
    Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ELSE}
    Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(OldValue))));
{$ENDIF}
  until Result = OldValue;
end;
{$ENDIF}

class function TPasMPInterlocked.Exchange(var Destination: TPasMPInt32; const Source: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := InterlockedExchange(Destination, Source);
{$ENDIF}
end;

class function TPasMPInterlocked.Exchange(var Destination: TPasMPUInt32; const Source: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := TPasMPUInt32(InterlockedExchange(TPasMPInt32(Destination), TPasMPInt32(Source)));
{$ENDIF}
end;

{$IFDEF CPU64}
class function TPasMPInterlocked.Exchange(var Destination: TPasMPInt64; const Source: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := InterlockedExchange64(Destination, Source);
{$ENDIF}
end;

class function TPasMPInterlocked.Exchange(var Destination: TPasMPUInt64; const Source: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := TPasMPUInt64(InterlockedExchange64(TPasMPInt64(Destination), TPasMPInt64(Source)));
{$ENDIF}
end;
{$ENDIF}

class function TPasMPInterlocked.Exchange(var Destination: Pointer; const Source: Pointer): Pointer;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(Source)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(Source)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Exchange(var Destination: TObject; const Source: TObject): TObject;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Pointer(Destination), Pointer(Source));
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(Source)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(Source)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Exchange(var Destination: TPasMPBool32; const Source: TPasMPBool32): TPasMPBool32;
begin
{$IFDEF HAS_ATOMICS}
{$IF DEFINED(cpu64bits) and DEFINED(nextgen)}
  Result := TPasMPBool32(TPasMPInt64(AtomicExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ELSE}
  Result := TPasMPBool32(TPasMPInt32(AtomicExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$IFEND}
{$ELSE}
  Result := TPasMPBool32(TPasMPInt32(InterlockedExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPInt32; const NewValue, Comperand: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := InterlockedCompareExchange(Destination, NewValue, Comperand);
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPUInt32; const NewValue, Comperand: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := TPasMPUInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(Comperand)));
{$ENDIF}
end;

{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPInt64; const NewValue, Comperand: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := InterlockedCompareExchange64(Destination, NewValue, Comperand);
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPInt64Record; const NewValue, Comperand: TPasMPInt64Record): TPasMPInt64Record;
begin
{$IFDEF HAS_ATOMICS}
  Result.Value := AtomicCmpExchange(Destination.Value, NewValue.Value, Comperand.Value);
{$ELSE}
  Result.Value := interlockedCompareExchange64(Destination.Value, NewValue.Value, Comperand.Value);
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPUInt64; const NewValue, Comperand: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
  Result := TPasMPUInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(NewValue), TPasMPInt64(Comperand)));
{$ENDIF}
end;
{$IFEND}

{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPInt128Record; const NewValue, Comperand: TPasMPInt128Record): TPasMPInt128Record;
begin
  Result := InterlockedCompareExchange128(Destination, NewValue, Comperand);
end;
{$IFEND}

class function TPasMPInterlocked.CompareExchange(var Destination: Pointer; const NewValue, Comperand: Pointer): Pointer;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Destination, NewValue, Comperand);
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(NewValue)), TPasMPInt64(TPasMPPtrInt(Comperand)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(NewValue)), TPasMPInt32(TPasMPPtrInt(Comperand)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TObject; const NewValue, Comperand: TObject): TObject;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Pointer(Destination), Pointer(NewValue), Pointer(Comperand));
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(NewValue)), TPasMPInt64(TPasMPPtrInt(Comperand)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(NewValue)), TPasMPInt32(TPasMPPtrInt(Comperand)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.CompareExchange(var Destination: TPasMPBool32; const NewValue, Comperand: TPasMPBool32): TPasMPBool32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPBool32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(Comperand))));
{$ELSE}
  Result := TPasMPBool32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Destination), TPasMPInt32(NewValue), TPasMPInt32(Comperand))));
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Source, 0, 0);
{$ELSE}
  Result := InterlockedCompareExchange(Source, 0, 0);
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Source), 0, 0)));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Source), 0, 0)));
{$ENDIF}
end;

{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
class function TPasMPInterlocked.Read(var Source: TPasMPInt64): TPasMPInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Source, 0, 0);
{$ELSE}
  Result := InterlockedCompareExchange64(Source, 0, 0);
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TPasMPInt64Record): TPasMPInt64Record;
begin
{$IFDEF HAS_ATOMICS}
  Result.Value := AtomicCmpExchange(Source.Value, 0, 0);
{$ELSE}
  Result.Value := interlockedCompareExchange64(Source.Value, 0, 0);
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TPasMPUInt64): TPasMPUInt64;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Source), 0, 0)));
{$ELSE}
  Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Source), 0, 0)));
{$ENDIF}
end;

{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
class function TPasMPInterlocked.Read(var Source: TPasMPInt128Record): TPasMPInt128Record;
var
  Temp: TPasMPInt128Record;
begin
  Temp.Lo := 0;
  Temp.Hi := 0;
  Result := InterlockedCompareExchange128(Source, Temp, Temp);
end;
{$IFEND}
{$IFEND}

class function TPasMPInterlocked.Read(var Source: Pointer): Pointer;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Source, nil, nil);
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange64(TPasMPInt64(TPasMPPtrInt(Source)), TPasMPInt64(TPasMPPtrInt(0)), TPasMPInt64(TPasMPPtrInt(0)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange(TPasMPInt32(TPasMPPtrInt(Source)), TPasMPInt32(TPasMPPtrInt(0)), TPasMPInt32(TPasMPPtrInt(0)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TObject): TObject;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicCmpExchange(Pointer(Source), nil, nil);
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange64(TPasMPInt64(TPasMPPtrInt(Source)), TPasMPInt64(TPasMPPtrInt(0)), TPasMPInt64(TPasMPPtrInt(0)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedCompareExchange(TPasMPInt32(TPasMPPtrInt(Source)), TPasMPInt32(TPasMPPtrInt(0)), TPasMPInt32(TPasMPPtrInt(0)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Read(var Source: TPasMPBool32): TPasMPBool32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPBool32(TPasMPInt32(AtomicCmpExchange(TPasMPInt32(Source), TPasMPInt32(0), TPasMPInt32(0))));
{$ELSE}
  Result := TPasMPBool32(TPasMPInt32(InterlockedCompareExchange(TPasMPInt32(Source), TPasMPInt32(0), TPasMPInt32(0))));
{$ENDIF}
end;

class function TPasMPInterlocked.Write(var Destination: TPasMPInt32; const Source: TPasMPInt32): TPasMPInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
  Result := InterlockedExchange(Destination, Source);
{$ENDIF}
end;

class function TPasMPInterlocked.Write(var Destination: TPasMPUInt32; const Source: TPasMPUInt32): TPasMPUInt32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPUInt32(TPasMPInt32(AtomicExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ELSE}
  Result := TPasMPUInt32(TPasMPInt32(InterlockedExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ENDIF}
end;

{$IF DEFINED(CPU64) or ((DEFINED(CPU386) or DEFINED(CPUARM)) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE))}
class function TPasMPInterlocked.Write(var Destination: TPasMPInt64; const Source: TPasMPInt64): TPasMPInt64;
{$IFDEF CPU64}
{$IFDEF HAS_ATOMICS}
begin
  Result := AtomicExchange(Destination, Source);
end;
{$ELSE}
begin
  Result := InterlockedExchange64(Destination, Source);
end;
{$ENDIF}
{$ELSE}
{$IFDEF HAS_ATOMICS}
var
  Old: TPasMPInt64;
begin
  repeat
    Old:=Destination;
    Result := AtomicCmpExchange(Destination, Source,Old);
  until Result = Old;
end;
{$ELSE}
var
  Old: TPasMPInt64;
begin
  repeat
    Old:=Destination;
    Result := InterlockedCompareExchange64(Destination, Source,Old);
  until Result = Old;
end;
{$ENDIF}
{$ENDIF}

class function TPasMPInterlocked.Write(var Destination: TPasMPInt64Record; const Source: TPasMPInt64Record): TPasMPInt64Record;
{$IFDEF CPU64}
{$IFDEF HAS_ATOMICS}
begin
  Result.Value := AtomicExchange(Destination.Value, Source.Value);
end;
{$ELSE}
begin
  Result.Value := interlockedExchange64(Destination.Value, Source.Value);
end;
{$ENDIF}
{$ELSE}
{$IFDEF HAS_ATOMICS}
var
  Old: TPasMPInt64;
begin
  repeat
    Old := Destination.Value;
    Result.Value := AtomicCmpExchange(Destination.Value, Source.Value, Old);
  until Result.Value = Old;
end;
{$ELSE}
var
  Old: TPasMPInt64;
begin
  repeat
    Old := Destination.Value;
    Result.Value := InterlockedCompareExchange64(Destination.Value, Source.Value,Old);
  until Result.Value = Old;
end;
{$ENDIF}
{$ENDIF}

{$IF DEFINED(CPU64) and DEFINED(PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE)}
class function TPasMPInterlocked.Write(var Destination: TPasMPInt128Record; const Source: TPasMPInt128Record): TPasMPInt128Record;
var
  Old: TPasMPInt128Record;
begin
  repeat
    Old := Destination;
    Result := InterlockedCompareExchange128(Destination, Source, Old);
  until (Result.Lo = Old.Lo) and (Result.Hi = Old.Hi);
end;
{$IFEND}

class function TPasMPInterlocked.Write(var Destination: TPasMPUInt64; const Source: TPasMPUInt64): TPasMPUInt64;
{$IFDEF CPU64}
{$IFDEF HAS_ATOMICS}
begin
  Result := TPasMPUInt64(TPasMPInt64(AtomicExchange(TPasMPInt64(Destination), TPasMPInt64(Source))));
end;
{$ELSE}
begin
  Result := TPasMPUInt64(TPasMPInt64(InterlockedExchange64(TPasMPInt64(Destination), TPasMPInt64(Source))));
end;
{$ENDIF}
{$ELSE}
{$IFDEF HAS_ATOMICS}
var
  Old: TPasMPUInt64;
begin
  repeat
    Old:=Destination;
    Result := TPasMPUInt64(TPasMPInt64(AtomicCmpExchange(TPasMPInt64(Destination), TPasMPInt64(Source), TPasMPInt64(Old))));
  until result = Old;
end;
{$ELSE}
var
  Old: TPasMPUInt64;
begin
  repeat
    Old := Destination;
    Result := TPasMPUInt64(TPasMPInt64(InterlockedCompareExchange64(TPasMPInt64(Destination), TPasMPInt64(Source), TPasMPInt64(Old))));
  until result = Old;
end;
{$ENDIF}
{$ENDIF}

{$IFEND}

class function TPasMPInterlocked.Write(var Destination: Pointer; const Source: Pointer): Pointer;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Destination, Source);
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(Source)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(Source)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Write(var Destination: TObject; const Source: TObject): TObject;
begin
{$IFDEF HAS_ATOMICS}
  Result := AtomicExchange(Pointer(Destination), Pointer(Source));
{$ELSE}
{$IFDEF CPU64}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange64(TPasMPInt64(TPasMPPtrInt(Destination)), TPasMPInt64(TPasMPPtrInt(Source)))));
{$ELSE}
  Result := Pointer(TPasMPPtrInt(InterlockedExchange(TPasMPInt32(TPasMPPtrInt(Destination)), TPasMPInt32(TPasMPPtrInt(Source)))));
{$ENDIF}
{$ENDIF}
end;

class function TPasMPInterlocked.Write(var Destination: TPasMPBool32; const Source: TPasMPBool32): TPasMPBool32;
begin
{$IFDEF HAS_ATOMICS}
  Result := TPasMPBool32(TPasMPInt32(AtomicExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ELSE}
  Result := TPasMPBool32(TPasMPInt32(InterlockedExchange(TPasMPInt32(Destination), TPasMPInt32(Source))));
{$ENDIF}
end;

class procedure TPasMPMemoryBarrier.Read;
begin
{$IF DEFINED(fpc)}
 ReadBarrier;
{$ELSEIF CompilerVersion>=25}
 MemoryBarrier;
{$ELSE}
 FallbackReadBarrier;
{$IFEND}
end;

class procedure TPasMPMemoryBarrier.ReadDependency;
begin
 // reads imply barrier on earlier reads depended on
end;

class procedure TPasMPMemoryBarrier.ReadWrite;
begin
{$IF DEFINED(fpc)}
  ReadWriteBarrier;
{$ELSEIF CompilerVersion>=25}
  MemoryBarrier;
{$ELSE}
  FallbackReadWriteBarrier;
{$IFEND}
end;

class procedure TPasMPMemoryBarrier.Write;
begin
{$IF DEFINED(fpc)}
  WriteBarrier;
{$ELSEIF CompilerVersion>=25}
  MemoryBarrier;
{$ELSE}
  FallbackWriteBarrier;
{$IFEND}
end;

class procedure TPasMPMemoryBarrier.Sync;
begin
{$IF DEFINED(fpc)}
  ReadWriteBarrier;
{$ELSEIF CompilerVersion>=25}
  MemoryBarrier;
{$ELSE}
  FallbackReadWriteBarrier;
{$IFEND}
end;

class procedure TPasMPMemory.AllocateAlignedMemory(var p;Size: TPasMPInt32;Align: TPasMPInt32=PasMPCPUCacheLineSize);
var
  Original,
  Aligned: Pointer;
  Mask:ptruint;
begin
 if (Align and (Align-1)) <> 0 then begin
  Align := TPasMPMath.RoundUpToPowerOfTwo(Align);
 end;
 Mask := Align - 1;
 Inc(Size, ((Align shl 1)+SizeOf(Pointer)));
 GetMem(Original, Size);
 FillChar(Original^, Size,#0);
 Aligned := Pointer(ptruint(ptruint(Original)+SizeOf(Pointer)));
 if (Align>1) and ((ptruint(Aligned) and Mask) <> 0) then begin
  Inc(ptruint(Aligned), Ptruint(ptruint(Align) - (ptruint(Aligned) and Mask)));
 end;
 Pointer(Pointer(ptruint(ptruint(Aligned)-SizeOf(Pointer)))^):=Original;
 Pointer(Pointer(@p)^):=Aligned;
end;

class procedure TPasMPMemory.FreeAlignedMemory(const p);
var pp: Pointer;
begin
 pp := Pointer(Pointer(@p)^);
 if Assigned(pp) then begin
  pp := Pointer(Pointer(ptruint(ptruint(pp)-SizeOf(Pointer)))^);
  FreeMem(pp);
 end;
end;

class procedure TPasMPMemory.Barrier;
begin
{$IFDEF fpc}
  ReadWriteBarrier;
{$ELSE}
  {$IF CompilerVersion>=25}
  MemoryBarrier;
  {$ELSE}
  FallbackReadWriteBarrier;
  {$IFEND}
{$ENDIF}
end;

constructor TPasMPHighResolutionTimer.Create;
begin
  inherited Create;
  fFrequencyShift := 0;
{$IF DEFINED(Windows)}
  if QueryPerformanceFrequency(fFrequency) then
  begin
    while (fFrequency and $ffffffffe0000000) <> 0 do
    begin
      fFrequency := fFrequency shr 1;
      Inc(fFrequencyShift);
    end;
  end
  else
  begin
    fFrequency := 1000;
  end;
{$ELSEIF DEFINED(Linux)}
  fFrequency := 1000000000;
{$ELSEIF DEFINED(Unix)}
  fFrequency := 1000000;
{$ELSE}
  fFrequency := 1000;
{$IFEND}
  fMillisecondInterval := (fFrequency+500) div 1000;
  fTwoMillisecondsInterval := (fFrequency+250) div 500;
  fFourMillisecondsInterval := (fFrequency+125) div 250;
  fQuarterSecondInterval := (fFrequency+2) div 4;
  fMinuteInterval := fFrequency*60;
  fHourInterval := fFrequency*3600;
end;

destructor TPasMPHighResolutionTimer.Destroy;
begin
 inherited Destroy;
end;

function TPasMPHighResolutionTimer.GetTime: TPasMPInt64;
{$IF DEFINED(Linux)}
var NowTimeSpec: TPasMPTimeSpec;
    tv:timeval;
    tz: TPasMPTimeZone;
    ia, ib: TPasMPInt64;
begin
  if clock_gettime(CLOCK_MONOTONIC, @NowTimeSpec) = 0 then
  begin
    ia := TPasMPInt64(NowTimeSpec.tv_sec)*TPasMPInt64(1000000000);
    ib:=NowTimeSpec.tv_nsec;
    Result := (ia+ib) shr fFrequencyShift;
  end
  else
  begin
    tz.tz_minuteswest := 0;
    tz.tz_dsttime := 0;
{$IFDEF fpc}
    fpgettimeofday(@tv, @tz);
{$ELSE}
    gettimeofday(tv, @tz);
{$ENDIF}
    ia := TPasMPInt64(tv.tv_sec)*TPasMPInt64(1000000);
    ib := Tv.tv_usec;
    Result := ((ia+ib)*1000) shr fFrequencyShift;
  end;
end;
{$ELSEIF DEFINED(unix)}
var
  tv:timeval;
  tz: TPasMPTimeZone;
  ia, ib: TPasMPInt64;
begin
  tz.tz_minuteswest := 0;
  tz.tz_dsttime := 0;
{$IFDEF fpc}
  fpgettimeofday(@tv, @tz);
{$ELSE}
  gettimeofday(tv, @tz);
{$ENDIF}
  ia := TPasMPInt64(tv.tv_sec)*TPasMPInt64(1000000);
  ib := Tv.tv_usec;
  Result := (ia+ib) shr fFrequencyShift;
end;
{$ELSEIF DEFINED(Windows)}
begin
  if not QueryPerformanceCounter(result) then
  begin
    Result := GetTickCount; { *Converted from TimeGetTime* }
  end;
  Result := Result shr fFrequencyShift;
end;
{$ELSE}
begin
  Result := trunc(Now*86400000.0) shr fFrequencyShift;
end;
{$IFEND}

procedure TPasMPHighResolutionTimer.Sleep(const pDelay: TPasMPInt64);
var EndTime,NowTime{$IFDEF unix}, SleepTime{$ENDIF}: TPasMPInt64;
{$IFDEF unix}
    req, Rem: TPasMPTimeSpec;
{$ENDIF}
begin
 if pDelay > 0 then begin
{$IF DEFINED(Windows)}
  NowTime := GetTime;
  EndTime:=NowTime+pDelay;
  while (NowTime+fTwoMillisecondsInterval)<EndTime do begin
   Windows.Sleep(1);
   NowTime := GetTime;
  end;
  while (NowTime+fMillisecondInterval)<EndTime do begin
   Windows.Sleep(0);
   NowTime := GetTime;
  end;
  while NowTime<EndTime do begin
   NowTime := GetTime;
  end;
{$ELSEIF DEFINED(Linux) or DEFINED(Android)}
  NowTime := GetTime;
  EndTime:=NowTime+pDelay;
  while (NowTime+fFourMillisecondsInterval)<EndTime do begin
   SleepTime:=((EndTime-NowTime)+2) shr 2;
   if SleepTime > 0 then begin
    req.tv_sec:=SleepTime div 1000000000;
    req.tv_nsec:=SleepTime mod 10000000000;
{$IFDEF fpc}
    fpNanoSleep(@req, @rem);
{$ELSE}
    NanoSleep(req, @rem);
{$ENDIF}
    NowTime := GetTime;
    Continue;
   end;
   Break;
  end;
  while (NowTime+fTwoMillisecondsInterval)<EndTime do begin
   TPasMP.Yield;
   NowTime := GetTime;
  end;
  while NowTime<EndTime do begin
   NowTime := GetTime;
  end;
{$ELSEIF DEFINED(Unix)}
  NowTime := GetTime;
  EndTime:=NowTime+pDelay;
  while (NowTime+fFourMillisecondsInterval)<EndTime do begin
   SleepTime:=((EndTime-NowTime)+2) shr 2;
   if SleepTime > 0 then begin
    req.tv_sec:=SleepTime div 1000000;
    req.tv_nsec:=(SleepTime mod 1000000)*1000;
{$IFDEF fpc}
    fpNanoSleep(@req, @rem);
{$ELSE}
    NanoSleep(req, @rem);
{$ENDIF}
    NowTime := GetTime;
    Continue;
   end;
   Break;
  end;
  while (NowTime+fTwoMillisecondsInterval)<EndTime do begin
   TPasMP.Yield;
   NowTime := GetTime;
  end;
  while NowTime<EndTime do begin
   NowTime := GetTime;
  end;
{$ELSE}
  NowTime := GetTime;
  EndTime:=NowTime+pDelay;
  while (NowTime+4)<EndTime do begin
   TPasMP.Yield;
   NowTime := GetTime;
  end;
  while (NowTime+2)<EndTime do begin
   TPasMP.Yield;
   NowTime := GetTime;
  end;
  while NowTime<EndTime do begin
   NowTime := GetTime;
  end;
{$IFEND}
 end;
end;

function TPasMPHighResolutionTimer.ToFloatSeconds(const pTime: TPasMPHighResolutionTime):double;
begin
  if fFrequency <> 0 then
  begin
    Result := pTime/fFrequency;
  end
  else
  begin
    Result := 0;
  end;
end;

function TPasMPHighResolutionTimer.FromFloatSeconds(const pTime:double): TPasMPHighResolutionTime;
begin
  if fFrequency <> 0 then
  begin
    Result := trunc(pTime*fFrequency);
  end
  else
  begin
    Result := 0;
  end;
end;

function TPasMPHighResolutionTimer.ToMilliseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
begin
  Result := pTime;
  if fFrequency <> 1000 then
  begin
    Result := ((pTime*1000) + ((fFrequency + 1) shr 1)) div fFrequency;
  end;
end;

function TPasMPHighResolutionTimer.FromMilliseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
begin
  Result := pTime;
  if fFrequency <> 1000 then
  begin
    Result := ((pTime*fFrequency)+500) div 1000;
  end;
end;

function TPasMPHighResolutionTimer.ToMicroseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
begin
  Result := pTime;
  if fFrequency <> 1000000 then
  begin
    Result := ((pTime*1000000) + ((fFrequency + 1) shr 1)) div fFrequency;
  end;
end;

function TPasMPHighResolutionTimer.FromMicroseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
begin
  Result := pTime;
  if fFrequency <> 1000000 then
  begin
    Result := ((pTime*fFrequency)+500000) div 1000000;
  end;
end;

function TPasMPHighResolutionTimer.ToNanoseconds(const pTime: TPasMPHighResolutionTime): TPasMPInt64;
begin
  Result := pTime;
  if fFrequency <> 1000000000 then
  begin
    Result := ((pTime*1000000000) + ((fFrequency + 1) shr 1)) div fFrequency;
  end;
end;

function TPasMPHighResolutionTimer.FromNanoseconds(const pTime: TPasMPInt64): TPasMPHighResolutionTime;
begin
  Result := pTime;
  if fFrequency <> 1000000000 then
  begin
    Result := ((pTime*fFrequency)+500000000) div 1000000000;
  end;
end;

constructor TPasMPSimpleEvent.Create;
begin
  inherited Create(nil, False, False,'');
end;

constructor TPasMPMutex.Create;
begin
  inherited Create;
{$IF DEFINED(Windows)}
  fMutex:=CreateMutex(nil, False, nil);
  if fMutex = 0 then
  begin
    RaiseLastOSError;
  end;
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_init(@fMutex, nil);
{$ELSE}
  pthread_mutex_init(fMutex, nil);
{$ENDIF}
{$ELSE}
  fCriticalSection := TPasMPCriticalSection.Create;
{$IFEND}
end;

{$IFDEF Unix}
constructor TPasMPMutex.Create(const lpMutexAttributes: Pointer);
begin
  inherited Create;
{$IF DEFINED(Windows)}
  fMutex:=CreateMutex(lpMutexAttributes, False,'');
  if fMutex=0 then
  begin
    RaiseLastOSError;
  end;
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_init(@fMutex,lpMutexAttributes);
{$ELSE}
  pthread_mutex_init(fMutex,lpMutexAttributes);
{$ENDIF}
{$ELSE}
  fCriticalSection := TCriticalSection.Create;
{$IFEND}
end;
{$ENDIF}

{$IFDEF Windows}
constructor TPasMPMutex.Create(const lpMutexAttributes: Pointer; const bInitialOwner: Boolean; const lpName: string);
begin
  inherited Create;
{$IF DEFINED(Windows)}
  fMutex:=CreateMutex(lpMutexAttributes, BInitialOwner, PChar(lpName));
  if fMutex=0 then
  begin
    RaiseLastOSError;
  end;
{$ELSEIF DEFINED(Unix)}
  pthread_mutex_init(@fMutex,lpMutexAttributes);
{$ELSE}
  fCriticalSection := TCriticalSection.Create;
{$IFEND}
end;

constructor TPasMPMutex.Create(const DesiredAccess: TPasMPUInt32; const bInitialOwner: Boolean; const lpName: string);
begin
 inherited Create;
{$IF DEFINED(Windows)}
  fMutex:=OpenMutex(DesiredAccess, BInitialOwner, PChar(lpName));
  if fMutex=0 then
  begin
    RaiseLastOSError;
  end;
{$ELSEIF DEFINED(Unix)}
  pthread_mutex_init(@fMutex, nil);
{$ELSE}
  fCriticalSection := TCriticalSection.Create;
{$IFEND}
end;
{$ENDIF}

destructor TPasMPMutex.Destroy;
begin
{$IF DEFINED(Windows)}
  FileClose(fMutex); { *Converted from CloseHandle* }
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_destroy(@fMutex);
{$ELSE}
  pthread_mutex_destroy(fMutex);
{$ENDIF}
{$ELSE}
  fCriticalSection.Free;
{$IFEND}
  inherited Destroy;
end;

procedure TPasMPMutex.Acquire;
begin
{$IF DEFINED(Windows)}
  case WaitForSingleObject(fMutex, INFINITE) of
    WAIT_OBJECT_0:  begin end;
    WAIT_TIMEOUT:   begin end;
    WAIT_ABANDONED: begin end;
    else
      begin
        RaiseLastOSError;
      end;
  end;
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_lock(@fMutex);
{$ELSE}
  pthread_mutex_lock(fMutex);
{$ENDIF}
{$ELSE}
  fCriticalSection.Acquire;
{$IFEND}
end;

procedure TPasMPMutex.Release;
begin
{$IF DEFINED(Windows)}
  if not ReleaseMutex(fMutex) then begin
    RaiseLastOSError;
  end;
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_unlock(@fMutex);
{$ELSE}
  pthread_mutex_unlock(fMutex);
{$ENDIF}
{$ELSE}
  fCriticalSection.Release;
{$IFEND}
end;

constructor TPasMPConditionVariableLock.Create;
begin
  inherited Create;
{$IF DEFINED(Windows)}
  {$IFDEF FPC}
  FCriticalSection := TCriticalSection.Create;
  {$ELSE}
  InitializeCriticalSection(FCriticalSection);
  {$ENDIF}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_init(@fMutex, nil);
{$ELSE}
  pthread_mutex_init(fMutex, nil);
{$ENDIF}
{$ELSE}
  fCriticalSection := TPasMPCriticalSection.Create;
{$IFEND}
end;

destructor TPasMPConditionVariableLock.Destroy;
begin
{$IF DEFINED(Windows)}
  {$IFDEF FPC}
  FCriticalSection.Destroy;
  {$ELSE}
  DeleteCriticalSection(FCriticalSection);
  {$ENDIF}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_destroy(@fMutex);
{$ELSE}
  pthread_mutex_destroy(fMutex);
{$ENDIF}
{$ELSE}
  fCriticalSection.Free;
{$IFEND}
  inherited Destroy;
end;

procedure TPasMPConditionVariableLock.Acquire;
begin
{$IF DEFINED(Windows)}
  {$IFDEF FPC}
  FCriticalSection.Enter;
  {$ELSE}
  EnterCriticalSection(FCriticalSection);
  {$ENDIF}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_mutex_lock(@fMutex);
{$ELSE}
  pthread_mutex_lock(fMutex);
{$ENDIF}
{$ELSE}
  fCriticalSection.Acquire;
{$IFEND}
end;

procedure TPasMPConditionVariableLock.Release;
begin
{$IF DEFINED(Windows)}
  {$IFDEF FPC}
  FCriticalSection.Leave;
  {$ELSE}
  LeaveCriticalSection(FCriticalSection);
  {$ENDIF}
{$ELSEIF DEFINED(Unix)}
  {$IFDEF fpc}
  pthread_mutex_unlock(@fMutex);
  {$ELSE}
  pthread_mutex_unlock(fMutex);
  {$ENDIF}
{$ELSE}
  fCriticalSection.Release;
{$IFEND}
end;

constructor TPasMPConditionVariable.Create;
{$IF DEFINED(Unix)}
const
  CLOCK_REALTIME = 0;
  CLOCK_MONOTONIC = 1;
  CLOCK_MONOTONIC_RAW = 4;
var
  r: TPasMPInt32;
  TimeSpec_: TPasMPTimeSpec;
{$IFEND}
begin
 inherited Create;
{$IF DEFINED(Windows)}
 InitializeConditionVariable(@fConditionVariable);
{$ELSEIF DEFINED(Unix)}
 fClockID:=CLOCK_REALTIME;
 fHasConditionVariableAttributes := False;
 // TODO: FIX-ME: Also use monotonic clock source for other *nix targets than just Linux, otherwise we
 // can have NTP-related deadlock fun on these Non-Linux *nix targets!
{$IF DEFINED(Linux) and not DEFINED(Android)}
 r := Pthread_condattr_init({$IFDEF fpc}@fConditionVariableAttributes{$ELSE}fConditionVariableAttributes{$ENDIF});
 if r=0 then begin
  try
   if clock_gettime(CLOCK_MONOTONIC_RAW, @TimeSpec_) = 0 then begin
    r := Pthread_condattr_setclock({$IFDEF fpc}@fConditionVariableAttributes{$ELSE}fConditionVariableAttributes{$ENDIF}, CLOCK_MONOTONIC_RAW);
   end else begin
    r:= - 1; // No support for CLOCK_MONOTONIC_RAW
   end;
   if r=0 then begin
    fClockID:=CLOCK_MONOTONIC_RAW;
   end else begin
    if clock_gettime(CLOCK_MONOTONIC, @TimeSpec_) = 0 then begin
     r := Pthread_condattr_setclock({$IFDEF fpc}@fConditionVariableAttributes{$ELSE}fConditionVariableAttributes{$ENDIF}, CLOCK_MONOTONIC);
     if r=0 then begin
      fClockID:=CLOCK_MONOTONIC;
     end;
    end;
   end;
  finally
   if fClockID<>CLOCK_REALTIME then begin
    fHasConditionVariableAttributes := True;
   end else begin
    pthread_condattr_destroy({$IFDEF fpc}@fConditionVariableAttributes{$ELSE}fConditionVariableAttributes{$ENDIF});
   end;
  end;
 end;
 if fHasConditionVariableAttributes then begin
  pthread_cond_init({$IFDEF fpc}@fConditionVariable{$ELSE}fConditionVariable{$ENDIF}, @fConditionVariableAttributes);
 end else{$IFEND}begin
  pthread_cond_init({$IFDEF fpc}@fConditionVariable{$ELSE}fConditionVariable{$ENDIF}, nil);
 end;
{$ELSE}
 fWaitCounter := 0;
 fCriticalSection := TPasMPCriticalSection.Create;
 fReleaseCounter := 0;
 fGenerationCounter := 0;
 fEvent := TPasMPEvent.Create(nil, True, False,'');
{$IFEND}
end;

destructor TPasMPConditionVariable.Destroy;
begin
{$IF DEFINED(Windows)}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
 pthread_cond_destroy(@fConditionVariable);
{$ELSE}
 pthread_cond_destroy(fConditionVariable);
{$ENDIF}
 if fHasConditionVariableAttributes then begin
  try
   pthread_condattr_destroy({$IFDEF fpc}@fConditionVariableAttributes{$ELSE}fConditionVariableAttributes{$ENDIF});
  finally
   fHasConditionVariableAttributes := False;
  end;
 end;
{$ELSE}
 fCriticalSection.Free;
 fEvent.Free;
{$IFEND}
 inherited Destroy;
end;

function TPasMPConditionVariable.Wait(const Lock: TPasMPConditionVariableLock; const dwMilliSeconds: TPasMPUInt32=INFINITE): TWaitResult;
{$IF DEFINED(Windows)}
begin
 if SleepConditionVariableCS(@fConditionVariable, @Lock.FCriticalSection,dwMilliSeconds) then begin
  Result := wrSignaled;
 end else begin
  case GetLastError of
   ERROR_TIMEOUT:begin
    Result := wrTimeOut;
   end;
   else begin
    Result := wrError;
   end;
  end;
 end;
end;
{$ELSEIF DEFINED(Unix)}
var TimeSpec_: TPasMPTimeSpec;
    tv:timeval;
    tz: TPasMPTimeZone;
begin
 if dwMilliSeconds=INFINITE then begin
  case pthread_cond_wait({$IFDEF fpc}@fConditionVariable, @Lock.fMutex{$ELSE}fConditionVariable,Lock.fMutex{$ENDIF}) of
   0:begin
    Result := wrSignaled;
   end;
   {$IFDEF fpc}ESysETIMEDOUT{$ELSE}ETIMEDOUT{$ENDIF}:begin
    Result := wrTimeOut;
   end;
   {$IFDEF fpc}ESysEINVAL{$ELSE}EINVAL{$ENDIF}:begin
    Result := wrAbandoned;
   end;
   else begin
    Result := wrError;
   end;
  end;
 end else begin
 {$IF DEFINED(Linux)}if clock_gettime(fClockID, @TimeSpec_) <> 0 then{$IFEND}begin
   tz.tz_minuteswest := 0;
   tz.tz_dsttime := 0;
{$IFDEF fpc}
   fpgettimeofday(@tv, @tz);
{$ELSE}
   gettimeofday(tv, @tz);
{$ENDIF}
   TimeSpec_.tv_sec := Tv.tv_sec;
   TimeSpec_.tv_nsec := Tv.tv_usec*1000;
  end;
  TimeSpec_.tv_sec := TimeSpec_.tv_sec + (TPasMPInt64(dwMilliSeconds) div 1000);
  TimeSpec_.tv_nsec:=((TPasMPInt64(dwMilliSeconds) mod 1000)*1000000) + (TimeSpec_.tv_nsec);
  if TimeSpec_.tv_nsec >= 1000000000 then begin
   Inc(TimeSpec_.tv_sec);
   Dec(TimeSpec_.tv_nsec,1000000000);
  end;
  case pthread_cond_timedwait({$IFDEF fpc}@fConditionVariable, @Lock.fMutex, @TimeSpec_{$ELSE}fConditionVariable,Lock.fMutex, TimeSpec_{$ENDIF}) of
   0:begin
    Result := wrSignaled;
   end;
   {$IFDEF fpc}ESysETIMEDOUT{$ELSE}ETIMEDOUT{$ENDIF}:begin
    Result := wrTimeOut;
   end;
   {$IFDEF fpc}ESysEINVAL{$ELSE}EINVAL{$ENDIF}:begin
    Result := wrAbandoned;
   end;
   else begin
    Result := wrError;
   end;
  end;
 end;
end;
{$ELSE}
var SavedGenerationCounter: TPasMPInt32;
    WaitDone,WasLastWaiter: Boolean;
begin

 Result := wrError;

 fCriticalSection.Acquire;
 try
  Inc(fWaitCounter);
  SavedGenerationCounter := fGenerationCounter;
 finally
  fCriticalSection.Release;
 end;

 Lock.Release;
 try
  repeat
   case fEvent.WaitFor(dwMilliSeconds) of
    wrSignaled:begin
     try
      WaitDone:=(fReleaseCounter > 0) and (SavedGenerationCounter<>fGenerationCounter);
     finally
      fCriticalSection.Release;
     end;
     if WaitDone then begin
      Result := wrSignaled;
     end;
    end;
    wrTimeOut:begin
     WaitDone := True;
     Result := wrTimeOut;
    end;
    wrAbandoned:begin
     WaitDone := True;
     Result := wrAbandoned;
    end;
    else begin
     WaitDone := True;
     Result := wrError;
    end;
   end;
  until WaitDone;
 finally
  Lock.Acquire;
 end;

 fCriticalSection.Acquire;
 try
  Dec(fWaitCounter);
  Dec(fReleaseCounter);
  WasLastWaiter := fReleaseCounter=0;
 finally
  fCriticalSection.Release;
 end;

 if WasLastWaiter then begin
  fEvent.ResetEvent;
 end;

end;
{$IFEND}

procedure TPasMPConditionVariable.Signal;
{$IF DEFINED(Windows)}
begin
  WakeConditionVariable(@fConditionVariable);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 pthread_cond_signal(@fConditionVariable);
{$ELSE}
 pthread_cond_signal(fConditionVariable);
{$ENDIF}
end;
{$ELSE}
begin
 fCriticalSection.Acquire;
 try
  if fWaitCounter>fReleaseCounter then begin
   Inc(fReleaseCounter);
   Inc(fGenerationCounter);
   fEvent.SetEvent;
  end;
 finally
  fCriticalSection.Release;
 end;
end;
{$IFEND}

procedure TPasMPConditionVariable.Broadcast;
{$IF DEFINED(Windows)}
begin
  WakeAllConditionVariable(@fConditionVariable);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 pthread_cond_broadcast(@fConditionVariable);
{$ELSE}
 pthread_cond_signal(fConditionVariable);
{$ENDIF}
end;
{$ELSE}
begin
 fCriticalSection.Acquire;
 try
  if fWaitCounter > 0 then begin
   fReleaseCounter := fWaitCounter;
   Inc(fGenerationCounter);
   fEvent.SetEvent;
  end;
 finally
  fCriticalSection.Release;
 end;
end;
{$IFEND}

constructor TPasMPSemaphore.Create(const InitialCount, MaximumCount: TPasMPInt32);
begin
 inherited Create;
 fInitialCount := InitialCount;
 fMaximumCount := MaximumCount;
{$IF DEFINED(Windows)}
 fHandle:=CreateSemaphore(nil, initialCount, MaximumCount, nil);
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
 sem_init(@fHandle, 0, initialCount);
{$ELSE}
 sem_init(fHandle, 0, initialCount);
{$ENDIF}
{$ELSE}
 fCurrentCount := fInitialCount;
{$IFDEF PasMPSemaphoreUseConditionVariable}
 fConditionVariableLock := TPasMPConditionVariableLock.Create;
 fConditionVariable := TPasMPConditionVariable.Create;
{$ELSE}
 fCriticalSection := TPasMPCriticalSection.Create;
 fEvent := TPasMPEvent.Create(nil, False, False,'');
{$ENDIF}
{$IFEND}
end;

destructor TPasMPSemaphore.Destroy;
begin
{$IF DEFINED(Windows)}
 FileClose(fHandle); { *Converted from CloseHandle* }
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
 sem_destroy(@fHandle);
{$ELSE}
 sem_destroy(fHandle);
{$ENDIF}
{$ELSE}
{$IFDEF PasMPSemaphoreUseConditionVariable}
 fConditionVariable.Free;
 fConditionVariableLock.Free;
{$ELSE}
 fEvent.Free;
 fCriticalSection.Free;
{$ENDIF}
{$IFEND}
  inherited Destroy;
end;

procedure TPasMPSemaphore.Acquire;
begin
  Acquire(1);
end;

procedure TPasMPSemaphore.Release;
begin
  Release(1);
end;

function TPasMPSemaphore.Acquire(const AcquireCount: TPasMPInt32): TWaitResult;
{$IF DEFINED(Windows)}
var
  Counter: TPasMPInt32;
begin
  Result := wrError;
  for Counter := 1 to AcquireCount do
  begin
    case WaitForSingleObject(fHandle, INFINITE) of
      WAIT_OBJECT_0:  begin
                        Result := wrSignaled;
                      end;
      WAIT_TIMEOUT:   begin
                        Result := wrTimeOut;
                        Exit;
                      end;
      WAIT_ABANDONED: begin
                        Result := wrAbandoned;
                        Exit;
                      end;
      else
        begin
          Result := wrError;
          Exit;
        end;
    end;
  end;
end;
{$ELSEIF DEFINED(Unix)}
var
  Counter: TPasMPInt32;
begin
  Result := wrError;
  for Counter := 1 to AcquireCount do
  begin
    case sem_wait({$IFDEF fpc}@fHandle{$ELSE}fHandle{$ENDIF}) of
      0:  begin
            Result := wrSignaled;
          end;
      {$IFDEF fpc}ESysETIMEDOUT{$ELSE}ETIMEDOUT{$ENDIF}: begin
            Result := wrTimeOut;
            Exit;
          end;
      {$IFDEF fpc}ESysEINVAL{$ELSE}EINVAL{$ENDIF}: begin
            Result := wrAbandoned;
            Exit;
          end;
      else
        begin
          Result := wrError;
          Exit;
        end;
    end;
  end;
end;
{$ELSE}
{$IFDEF PasMPSemaphoreUseConditionVariable}
var
  Counter: TPasMPInt32;
begin
 Result := wrError;
 fConditionVariableLock.Acquire;
 try
  for Counter := 1 to AcquireCount do begin
   Result := wrSignaled;
   while fCurrentCount=0 do begin
    Result := fConditionVariable.Wait(fConditionVariableLock, INFINITE);
    if result<>wrSignaled then begin
     Break;
    end;
   end;
   if result<>wrSignaled then begin
    Break;
   end;
   if fCurrentCount <> 0 then begin
    Dec(fCurrentCount);
   end;
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$ELSE}
var Counter: TPasMPInt32;
    Done: Boolean;
begin
 Result := wrError;
 for Counter := 1 to AcquireCount do begin
  Result := wrSignaled;
  repeat
   fCriticalSection.Acquire;
   try
    Done := fCurrentCount <> 0;
    if Done then begin
     Dec(fCurrentCount);
    end;
   finally
    fCriticalSection.Release;
   end;
   if Done then begin
    Break;
   end;
   Result := fEvent.WaitFor(INFINITE);
  until result<>wrSignaled;
  if result<>wrSignaled then begin
   Exit;
  end;
 end;
end;
{$ENDIF}
{$IFEND}

function TPasMPSemaphore.Release(const ReleaseCount: TPasMPInt32): TPasMPInt32;
{$IF DEFINED(Windows)}
begin
  ReleaseSemaphore(fHandle, ReleaseCount, @Result);
end;
{$ELSEIF DEFINED(Unix)}
begin
 Result := 0;
 while result<ReleaseCount do begin
  case sem_post({$IFDEF fpc}@fHandle{$ELSE}fHandle{$ENDIF}) of
   0:begin
    Inc(result);
   end;
   else begin
    Break;
   end;
  end;
 end;
end;
{$ELSE}
{$IFDEF PasMPSemaphoreUseConditionVariable}
begin
 fConditionVariableLock.Acquire;
 try
  if ((fCurrentCount+ReleaseCount)<fCurrentCount) or
     ((fCurrentCount+ReleaseCount)>fMaximumCount) then begin
   // Invalid release count
   Result := 0;
  end else begin
   if fCurrentCount <> 0 then begin
    // There can't be any thread to wake up if the value of fCurrentCount isn't zero
    Inc(fCurrentCount, ReleaseCount);
   end else begin
    fCurrentCount := ReleaseCount;
    fConditionVariable.Broadcast;
   end;
   Result := fCurrentCount;
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$ELSE}
var WakeUp: Boolean;
begin
 WakeUp := False;
 fCriticalSection.Acquire;
 try
  if ((fCurrentCount+ReleaseCount)<fCurrentCount) or
     ((fCurrentCount+ReleaseCount)>fMaximumCount) then begin
   // Invalid release count
   Result := 0;
  end else begin
   if fCurrentCount <> 0 then begin
    // There can't be any thread to wake up if the value of fCurrentCount isn't zero
    Inc(fCurrentCount, ReleaseCount);
   end else begin
    fCurrentCount := ReleaseCount;
    WakeUp := True;
   end;
   Result := fCurrentCount;
  end;
 finally
  fCriticalSection.Release;
 end;
 if WakeUp then begin
  fEvent.SetEvent;
 end;
end;
{$ENDIF}
{$IFEND}

constructor TPasMPInvertedSemaphore.Create(const InitialCount, MaximumCount: TPasMPInt32);
begin
  inherited Create;
  fInitialCount := InitialCount;
  fMaximumCount := MaximumCount;
  fCurrentCount := InitialCount;
  fConditionVariableLock := TPasMPConditionVariableLock.Create;
  fConditionVariable := TPasMPConditionVariable.Create;
end;

destructor TPasMPInvertedSemaphore.Destroy;
begin
  fConditionVariable.Free;
  fConditionVariableLock.Free;
  inherited Destroy;
end;

procedure TPasMPInvertedSemaphore.Acquire;
var
  Temp: TPasMPInt32;
begin
  Acquire(1, Temp);
end;

procedure TPasMPInvertedSemaphore.Release;
var
  Temp: TPasMPInt32;
begin
  Release(1, Temp);
end;

function TPasMPInvertedSemaphore.Acquire(const AcquireCount: TPasMPInt32; out Count: TPasMPInt32): TPasMPInt32;
begin
 fConditionVariableLock.Acquire;
 try
  if AcquireCount <= 0 then begin
   Result := 0;
  end else if (fCurrentCount+AcquireCount)<fMaximumCount then begin
   Result := AcquireCount;
  end else begin
   Result := fMaximumCount-fCurrentCount;
  end;
  Inc(fCurrentCount, Result);
  Count := fCurrentCount;
 finally
  fConditionVariableLock.Release;
 end;
end;

function TPasMPInvertedSemaphore.Release(const ReleaseCount: TPasMPInt32; out Count: TPasMPInt32): TPasMPInt32;
begin
 fConditionVariableLock.Acquire;
 try
  if ReleaseCount <= 0 then begin
   Result := 0;
  end else if fCurrentCount<ReleaseCount then begin
   Result := fCurrentCount;
  end else begin
   Result := ReleaseCount;
  end;
  Dec(fCurrentCount, Result);
  if fCurrentCount=0 then begin
   fConditionVariable.Broadcast;
  end;
  Count := fCurrentCount;
 finally
  fConditionVariableLock.Release;
 end;
end;

function TPasMPInvertedSemaphore.Wait(const dwMilliSeconds: TPasMPUInt32=INFINITE): TWaitResult;
begin
 Result := wrSignaled;
 fConditionVariableLock.Acquire;
 try
  while fCurrentCount <> 0 do begin
   Result := fConditionVariable.Wait(fConditionVariableLock,dwMilliSeconds);
   if dwMilliSeconds=INFINITE then begin
    // special case due to spurious wakeups of condition variables
    if not (result in [wrSignaled,wrTimeOut]) then begin
     Break;
    end;
   end else begin
    if result<>wrSignaled then begin
     Break;
    end;
   end;
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;

constructor TPasMPMultipleReaderSingleWriterLock.Create;
begin
  inherited Create;
{$IF DEFINED(Windows)}
  InitializeSRWLock(@fSRWLock);
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_rwlock_init(@fReadWriteLock, nil);
{$ELSE}
  pthread_rwlock_init(fReadWriteLock, nil);
{$ENDIF}
{$ELSE}
  fReaders := 0;
  fWriters := 0;
  fConditionVariableLock := TPasMPConditionVariableLock.Create;
  fConditionVariable := TPasMPConditionVariable.Create;
{$IFEND}
end;

destructor TPasMPMultipleReaderSingleWriterLock.Destroy;
begin
{$IF DEFINED(Windows)}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
 pthread_rwlock_destroy(@fReadWriteLock);
{$ELSE}
 pthread_rwlock_destroy(fReadWriteLock);
{$ENDIF}
{$ELSE}
 fConditionVariable.Free;
 fConditionVariableLock.Free;
{$IFEND}
 inherited Destroy;
end;

procedure TPasMPMultipleReaderSingleWriterLock.AcquireRead;
{$IF DEFINED(Windows)}
begin
 AcquireSRWLockShared(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 pthread_rwlock_rdlock(@fReadWriteLock);
{$ELSE}
 pthread_rwlock_rdlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
var State: TPasMPInt32;
begin
 fConditionVariableLock.Acquire;
 try
  while fWriters <> 0 do begin
   fConditionVariable.Wait(fConditionVariableLock, INFINITE);
  end;
  Inc(fReaders);
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

function TPasMPMultipleReaderSingleWriterLock.TryAcquireRead: Boolean;
{$IF DEFINED(Windows)}
begin
 Result := TryAcquireSRWLockShared(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 Result := pthread_rwlock_tryrdlock(@fReadWriteLock) = 0;
{$ELSE}
 Result := pthread_rwlock_tryrdlock(fReadWriteLock) = 0;
{$ENDIF}
end;
{$ELSE}
var State: TPasMPInt32;
begin
 fConditionVariableLock.Acquire;
 try
  Result := fWriters=0;
  if Result then begin
   Inc(fReaders);
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.ReleaseRead;
{$IF DEFINED(Windows)}
begin
 ReleaseSRWLockShared(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 pthread_rwlock_unlock(@fReadWriteLock);
{$ELSE}
 pthread_rwlock_unlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
 fConditionVariableLock.Acquire;
 try
  Dec(fReaders);
  if fReaders=0 then begin
   fConditionVariable.Broadcast;
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.AcquireWrite;
{$IF DEFINED(Windows)}
begin
 AcquireSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 pthread_rwlock_wrlock(@fReadWriteLock);
{$ELSE}
 pthread_rwlock_wrlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
 fConditionVariableLock.Acquire;
 try
  while (fReaders <> 0) or (fWriters <> 0) do begin
   fConditionVariable.Wait(fConditionVariableLock, INFINITE);
  end;
  Inc(fWriters);
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

function TPasMPMultipleReaderSingleWriterLock.TryAcquireWrite: Boolean;
{$IF DEFINED(Windows)}
begin
 Result := TryAcquireSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
 Result := pthread_rwlock_trywrlock(@fReadWriteLock) = 0;
{$ELSE}
 Result := pthread_rwlock_trywrlock(fReadWriteLock) = 0;
{$ENDIF}
end;
{$ELSE}
begin
 fConditionVariableLock.Acquire;
 try
  Result := (fReaders=0) and (fWriters=0);
  if Result then begin
   Inc(fWriters);
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.ReleaseWrite;
{$IF DEFINED(Windows)}
begin
  ReleaseSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  pthread_rwlock_unlock(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_unlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    Dec(fWriters);
    if fWriters = 0 then
    begin
      fConditionVariable.Broadcast;
    end;
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.ReadToWrite;
{$IF DEFINED(Windows)}
begin
  ReleaseSRWLockShared(@fSRWLock);
  AcquireSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  pthread_rwlock_unlock(@fReadWriteLock);
  pthread_rwlock_wrlock(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_unlock(fReadWriteLock);
  pthread_rwlock_wrlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    Dec(fReaders);
    while (fWriters <> 0) and (fReaders <> 0) do
    begin
      fConditionVariable.Wait(fConditionVariableLock, INFINITE);
    end;
    Inc(fWriters);
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.WriteToRead;
{$IF DEFINED(Windows)}
begin
  ReleaseSRWLockExclusive(@fSRWLock);
  AcquireSRWLockShared(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  pthread_rwlock_unlock(@fReadWriteLock);
  pthread_rwlock_rdlock(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_unlock(fReadWriteLock);
  pthread_rwlock_rdlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    Dec(fWriters);
    while fWriters <> 0 do
    begin
      fConditionVariable.Wait(fConditionVariableLock, INFINITE);
    end;
    Inc(fReaders);
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

procedure TPasMPMultipleReaderSingleWriterLock.BeginRead;
begin
  AcquireRead;
end;

procedure TPasMPMultipleReaderSingleWriterLock.EndRead;
begin
  ReleaseRead;
end;

function TPasMPMultipleReaderSingleWriterLock.BeginWrite: Boolean;
begin
  AcquireWrite;
  Result := True;
end;

procedure TPasMPMultipleReaderSingleWriterLock.EndWrite;
begin
  ReleaseWrite;
end;

constructor TPasMPMultipleReaderSingleWriterSpinLock.Create;
begin
  inherited Create;
  fState := 0;
end;

destructor TPasMPMultipleReaderSingleWriterSpinLock.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead;
var
  State: TPasMPInt32;
begin
  repeat
    State := fState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(fState, State+2, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
end;

function TPasMPMultipleReaderSingleWriterSpinLock.TryAcquireRead: Boolean;
var
  State: TPasMPInt32;
begin
  State := fState and TPasMPInt32(TPasMPUInt32($fffffffe));
  Result := TPasMPInterlocked.CompareExchange(fState, State+2, State) = State;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead;
begin
  TPasMPInterlocked.Sub(fState,2);
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.AcquireWrite;
var
  State: TPasMPInt32;
begin
  repeat
    State := fState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(fState, State or 1, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
  while fState <> 1 do
  begin
    TPasMP.Relax;
  end;
end;

function TPasMPMultipleReaderSingleWriterSpinLock.TryAcquireWrite: Boolean;
var
  State: TPasMPInt32;
begin
  State := fState and TPasMPInt32(TPasMPUInt32($fffffffe));
  Result := TPasMPInterlocked.CompareExchange(fState,1, State) = State;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.ReleaseWrite;
begin
  TPasMPInterlocked.Write(fState, 0);
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite;
var
  State: TPasMPInt32;
begin
  TPasMPInterlocked.Sub(fState,2);
  repeat
    State := fState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(fState, State or 1, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
  while fState <> 1 do
  begin
    TPasMP.Relax;
  end;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead;
begin
  TPasMPInterlocked.Write(fState,2);
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.BeginRead;
begin
  AcquireRead;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.EndRead;
begin
  ReleaseRead;
end;

function TPasMPMultipleReaderSingleWriterSpinLock.BeginWrite: Boolean;
begin
  AcquireWrite;
  Result := True;
end;

procedure TPasMPMultipleReaderSingleWriterSpinLock.EndWrite;
begin
  ReleaseWrite;
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(var LockState: TPasMPInt32);
var
  State: TPasMPInt32;
begin
  repeat
    State := LockState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(LockState, State+2, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
end;

class function TPasMPMultipleReaderSingleWriterSpinLock.TryAcquireRead(var LockState: TPasMPInt32): Boolean;
var
  State: TPasMPInt32;
begin
  State := LockState and TPasMPInt32(TPasMPUInt32($fffffffe));
  Result := TPasMPInterlocked.CompareExchange(LockState, State+2, State) = State;
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(var LockState: TPasMPInt32);
begin
  TPasMPInterlocked.Sub(LockState,2);
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.AcquireWrite(var LockState: TPasMPInt32);
var
  State: TPasMPInt32;
begin
  repeat
    State := LockState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(LockState, State or 1, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
  while LockState <> 1 do
  begin
    TPasMP.Relax;
  end;
end;

class function TPasMPMultipleReaderSingleWriterSpinLock.TryAcquireWrite(var LockState: TPasMPInt32): Boolean;
var
  State: TPasMPInt32;
begin
  State := LockState and TPasMPInt32(TPasMPUInt32($fffffffe));
  Result := TPasMPInterlocked.CompareExchange(LockState,1, State) = State;
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.ReleaseWrite(var LockState: TPasMPInt32);
begin
  TPasMPInterlocked.Write(LockState, 0);
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(var LockState: TPasMPInt32);
var
  State: TPasMPInt32;
begin
  TPasMPInterlocked.Sub(LockState,2);
  repeat
    State := LockState and TPasMPInt32(TPasMPUInt32($fffffffe));
    if TPasMPInterlocked.CompareExchange(LockState, State or 1, State) = State then
    begin
      Break;
    end
    else
    begin
      TPasMP.Relax;
    end;
  until False;
  while LockState <> 1 do
  begin
    TPasMP.Relax;
  end;
end;

class procedure TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(var LockState: TPasMPInt32);
begin
  TPasMPInterlocked.Write(LockState,2);
end;

constructor TPasMPSlimReaderWriterLock.Create;
begin
  inherited Create;
{$IF DEFINED(Windows)}
  InitializeSRWLock(@fSRWLock);
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_rwlock_init(@fReadWriteLock, nil);
{$ELSE}
  pthread_rwlock_init(fReadWriteLock, nil);
{$ENDIF}
{$ELSE}
  fCount := 0;
  fConditionVariableLock := TPasMPConditionVariableLock.Create;
  fConditionVariable := TPasMPConditionVariable.Create;
{$IFEND}
end;

destructor TPasMPSlimReaderWriterLock.Destroy;
begin
{$IF DEFINED(Windows)}
{$ELSEIF DEFINED(Unix)}
{$IFDEF fpc}
  pthread_rwlock_destroy(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_destroy(fReadWriteLock);
{$ENDIF}
{$ELSE}
  fConditionVariable.Free;
  fConditionVariableLock.Free;
{$IFEND}
  inherited Destroy;
end;

procedure TPasMPSlimReaderWriterLock.Acquire;
{$IF DEFINED(Windows)}
begin
  AcquireSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  pthread_rwlock_wrlock(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_wrlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    while fCount <> 0 do
    begin
      fConditionVariable.Wait(fConditionVariableLock, INFINITE);
    end;
    Inc(fCount);
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

function TPasMPSlimReaderWriterLock.TryAcquire: Boolean;
{$IF DEFINED(Windows)}
begin
  Result := TryAcquireSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  Result := pthread_rwlock_trywrlock(@fReadWriteLock) = 0;
{$ELSE}
  Result := pthread_rwlock_trywrlock(fReadWriteLock) = 0;
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    Result := fCount = 0;
    if Result then
    begin
      Inc(fCount);
    end;
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

procedure TPasMPSlimReaderWriterLock.Release;
{$IF DEFINED(Windows)}
begin
  ReleaseSRWLockExclusive(@fSRWLock);
end;
{$ELSEIF DEFINED(Unix)}
begin
{$IFDEF fpc}
  pthread_rwlock_unlock(@fReadWriteLock);
{$ELSE}
  pthread_rwlock_unlock(fReadWriteLock);
{$ENDIF}
end;
{$ELSE}
begin
  fConditionVariableLock.Acquire;
  try
    Dec(fCount);
    if fCount = 0 then
    begin
      fConditionVariable.Broadcast;
    end;
  finally
    fConditionVariableLock.Release;
  end;
end;
{$IFEND}

constructor TPasMPSpinLock.Create;
begin
  inherited Create;
{$IF DEFINED(PasMPPThreadSpinLock)}
  pthread_spin_init(@fSpinLock, 0);
{$ELSE}
  fState := 0;
{$IFEND}
end;

destructor TPasMPSpinLock.Destroy;
begin
{$IF DEFINED(PasMPPThreadSpinLock)}
  pthread_spin_destroy(@fSpinLock);
{$IFEND}
  inherited Destroy;
end;

procedure TPasMPSpinLock.Acquire; {$IF DEFINED(PasMPPThreadSpinLock)}
begin
  pthread_spin_lock(@fSpinLock);
end;
{$ELSEIF DEFINED(cpu386)}assembler; register;
asm
  test dword ptr [eax+TPasMPSpinLock.fState],1
  jnz @SpinLoop
@TryAgain:
  lock bts dword ptr [eax+TPasMPSpinLock.fState], 0
  jnc @TryDone
@SpinLoop:
  db $f3,$90 // pause (rep nop)
  test dword ptr [eax+TPasMPSpinLock.fState],1
  jnz @SpinLoop
  jmp @TryAgain
@TryDone:
end;
{$ELSEIF DEFINED(cpux86_64)}assembler; register;
{$IFDEF Windows}
asm
  // Win64 ABI
  // rcx = self
  test dword ptr [rcx+TPasMPSpinLock.fState],1
  jnz @SpinLoop
@TryAgain:
  lock bts dword ptr [rcx+TPasMPSpinLock.fState], 0
  jnc @TryDone
@SpinLoop:
  pause
  test dword ptr [rcx+TPasMPSpinLock.fState],1
  jnz @SpinLoop
  jmp @TryAgain
@TryDone:
end;
{$ELSE}
asm
  // System V ABI
  // rdi = self
  test dword ptr [edi+TPasMPSpinLock.fState],1
  jnz @SpinLoop
@TryAgain:
  lock bts dword ptr [rdi+TPasMPSpinLock.fState], 0
  jnc @TryDone
@SpinLoop:
  pause
  test dword ptr [rdi+TPasMPSpinLock.fState],1
  jnz @SpinLoop
  jmp @TryAgain
@TryDone:
end;
{$ENDIF}
{$ELSE}
begin
  while TPasMPInterlocked.CompareExchange(fState,-1, 0) <> 0 do
  begin
    TPasMP.Yield;
  end;
end;
{$IFEND}

function TPasMPSpinLock.TryAcquire: longbool; {$IF DEFINED(PasMPPThreadSpinLock)}
begin
  Result := pthread_spin_trylock(@fSpinLock) = 0;
end;
{$ELSEIF DEFINED(cpu386)}assembler; register;
asm
  xor eax, Eax
  lock bts dword ptr [eax+TPasMPSpinLock.fState], 0
  jc @Failed
  not eax
  @Failed:
end;
{$ELSEIF DEFINED(cpux86_64)}assembler; register;
{$IFDEF Windows}
asm
  // Win64 ABI
  // rcx = self
  xor rax, Rax
  lock bts dword ptr [rcx+TPasMPSpinLock.fState], 0
  jc @Failed
  not rax
  @Failed:
end;
{$ELSE}
asm
  // System V ABI
  // rdi = self
  xor rax, Rax
  lock bts dword ptr [rdi+TPasMPSpinLock.fState], 0
  jc @Failed
  not rax
  @Failed:
end;
{$ENDIF}
{$ELSE}
begin
  Result := TPasMPInterlocked.CompareExchange(fState,-1, 0) = 0;
end;
{$IFEND}

procedure TPasMPSpinLock.Release; {$IF DEFINED(PasMPPThreadSpinLock)}
begin
  pthread_spin_unlock(@fSpinLock);
end;
{$ELSEIF DEFINED(cpu386)}assembler; register;
asm
  mov dword ptr [eax+TPasMPSpinLock.fState], 0
end;
{$ELSEIF DEFINED(cpux86_64)}assembler; register;
{$IFDEF Windows}
asm
  // Win64 ABI
  // rcx = self
  mov dword ptr [rcx+TPasMPSpinLock.fState], 0
end;
{$ELSE}
asm
  // System V ABI
  // rdi = self
  mov dword ptr [rdi+TPasMPSpinLock.fState], 0
end;
{$ENDIF}
{$ELSE}
begin
  TPasMPInterlocked.Exchange(fState, 0);
end;
{$IFEND}

constructor TPasMPBenaphore.Create;
begin
  inherited Create;
  fSemaphore := TPasMPSemaphore.Create(0,1);
  fLockCount := 0;
end;

destructor TPasMPBenaphore.Destroy;
begin
  FreeAndNil(fSemaphore);
  inherited Destroy;
end;

procedure TPasMPBenaphore.Acquire;
begin
  if TPasMPInterlocked.Increment(fLockCount) > 1 then
  begin
    fSemaphore.Acquire;
  end;
end;

function TPasMPBenaphore.TryAcquire: longbool;
begin
  Result := TPasMPInterlocked.CompareExchange(fLockCount,1, 0) = 0;
end;

procedure TPasMPBenaphore.Release;
begin
  if TPasMPInterlocked.Decrement(fLockCount) > 0 then
  begin
    fSemaphore.Release;
  end;
end;

constructor TPasMPRecursiveBenaphore.Create;
begin
  inherited Create;
  fSemaphore := TPasMPSemaphore.Create(0,1);
  fOwningThreadID := 0;
  fLockCount := 0;
  fRecursionCount := 0;
end;

destructor TPasMPRecursiveBenaphore.Destroy;
begin
  FreeAndNil(fSemaphore);
  inherited Destroy;
end;

procedure TPasMPRecursiveBenaphore.Acquire;
var
  CurrentThreadID: TThreadID;
begin
{$IF (DEFINED(NEXTGEN) or not DEFINED(Windows)) and not DEFINED(FPC)}
  CurrentThreadID := TThread.CurrentThread.ThreadID;
{$ELSE}
  CurrentThreadID := GetCurrentThreadID;
{$IFEND}
  if TPasMPInterlocked.Increment(fLockCount) > 1 then
  begin
    if fOwningThreadID = CurrentThreadID then
    begin
      Inc(fRecursionCount);
      Exit;
    end
    else
    begin
      fSemaphore.Acquire;
    end;
  end;
  fOwningThreadID:=CurrentThreadID;
  fRecursionCount := 1;
end;

function TPasMPRecursiveBenaphore.TryAcquire: longbool;
var
  CurrentThreadID: TThreadID;
begin
{$IF (DEFINED(NEXTGEN) or not DEFINED(Windows)) and not DEFINED(FPC)}
  CurrentThreadID := TThread.CurrentThread.ThreadID;
{$ELSE}
  CurrentThreadID := GetCurrentThreadID;
{$IFEND}
  if TPasMPInterlocked.CompareExchange(fLockCount,1, 0) = 0 then
  begin
    fOwningThreadID:=CurrentThreadID;
    fRecursionCount := 1;
    Result := True;
  end
  else if fOwningThreadID = CurrentThreadID then
  begin
    TPasMPInterlocked.Increment(fLockCount);
    Inc(fRecursionCount);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

procedure TPasMPRecursiveBenaphore.Release;
var
  CurrentThreadID: TThreadID;
begin
{$IF (DEFINED(NEXTGEN) or not DEFINED(Windows)) and not DEFINED(FPC)}
  CurrentThreadID := TThread.CurrentThread.ThreadID;
{$ELSE}
  CurrentThreadID := GetCurrentThreadID;
{$IFEND}
  if fOwningThreadID = CurrentThreadID then
  begin
    Dec(fRecursionCount);
    if fRecursionCount=0 then
    begin
      fOwningThreadID:={$IFDEF fpc}TThreadID(0){$ELSE}0{$ENDIF};
      if TPasMPInterlocked.Decrement(fLockCount) > 0 then
      begin
        fSemaphore.Release;
      end;
    end
    else
    begin
      TPasMPInterlocked.Decrement(fLockCount);
    end;
  end
  else
  begin
    raise EPasMPRecursiveBenaphore.Create('Releasing TPasMPRecursiveBenaphore not owned by current thread!');
  end;
end;

constructor TPasMPBarrier.Create(const Count: TPasMPInt32);
begin
  inherited Create;
{$IF DEFINED(PasMPPThreadBarrier)}
  pthread_barrier_init(@fBarrier, nil, Count);
{$ELSE}
  fCount := Count;
  fTotal := 0;
  fConditionVariableLock := TPasMPConditionVariableLock.Create;
  fConditionVariable := TPasMPConditionVariable.Create;
{$IFEND}
end;

destructor TPasMPBarrier.Destroy;
begin
{$IF DEFINED(PasMPPThreadBarrier)}
 pthread_barrier_destroy(@fBarrier);
{$ELSE}
 fConditionVariableLock.Acquire;
 try
  while fTotal>PasMPBarrierFlag do begin
   // Wait until everyone exits the barrier
   fConditionVariable.Wait(fConditionVariableLock, INFINITE);
  end;
 finally
  fConditionVariableLock.Release;
 end;
 fConditionVariable.Free;
 fConditionVariableLock.Free;
{$IFEND}
 inherited Destroy;
end;

function TPasMPBarrier.Wait: Boolean;
{$IF DEFINED(PasMPPThreadBarrier)}
begin
  Result := pthread_barrier_wait(@fBarrier) = PTHREAD_BARRIER_SERIAL_THREAD;
end;
{$ELSE}
begin
 fConditionVariableLock.Acquire;
 try
  while fTotal>PasMPBarrierFlag do begin
   // Wait until everyone exits the barrier
   fConditionVariable.Wait(fConditionVariableLock, INFINITE);
  end;
  if fTotal=PasMPBarrierFlag then begin
   // Are we the first to enter?
   fTotal := 0;
  end;
  Inc(fTotal);
  if fTotal=fCount then begin
   Inc(fTotal, PasMPBarrierFlag-1);
   fConditionVariable.Broadcast;
   Result := True;
  end else begin
   while fTotal<PasMPBarrierFlag do begin
    // Wait until enough threads enter the barrier
    fConditionVariable.Wait(fConditionVariableLock, INFINITE);
   end;
   Dec(fTotal);
   if ftotal=PasMPBarrierFlag then begin
    // Get entering threads to wake up
    fConditionVariable.Broadcast;
   end;
   Result := False;
  end;
 finally
  fConditionVariableLock.Release;
 end;
end;
{$IFEND}

constructor TPasMPThreadSafeStack.Create;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
begin
  inherited Create;
  TPasMPMemory.AllocateAlignedMemory(fHead, SizeOf(TPasMPTaggedPointer), PasMPCPUCacheLineSize);
  fHead^.PointerValue := nil;
  fHead^.TagValue := 0;
end;
{$ELSE}
begin
  inherited Create;
  fCriticalSection := TPasMPCriticalSection.Create;
  fHead := nil;
end;
{$ENDIF}

destructor TPasMPThreadSafeStack.Destroy;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
begin
  TPasMPMemory.FreeAlignedMemory(fHead);
  inherited Destroy;
end;
{$ELSE}
begin
  fCriticalSection.Free;
  inherited Destroy;
end;
{$ENDIF}

procedure TPasMPThreadSafeStack.Clear;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
begin
  fHead^.PointerValue := nil;
  fHead^.TagValue := 0;
end;
{$ELSE}
begin
  fHead := nil;
end;
{$ENDIF}

function TPasMPThreadSafeStack.IsEmpty: Boolean;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
begin
  Result := not Assigned(fHead^.PointerValue);
end;
{$ELSE}
begin
  Result := True;
  if Assigned(fHead) then
  begin
    fCriticalSection.Acquire;
    try
      if Assigned(fHead) then
      begin
        Result := False;
      end;
    finally
    fCriticalSection.Leave;
    end;
  end;
end;
{$ENDIF}

function TPasMPThreadSafeStack.Push(const Item: Pointer): Pointer;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
var
  OldHead: TPasMPTaggedPointer;
  NewHead: TPasMPTaggedPointer;
  ComparsionHead: TPasMPTaggedPointer;
begin
  OldHead := fHead^;
  repeat
    Pointer(Item^):=OldHead.PointerValue;
    NewHead.PointerValue := item;
    NewHead.TagValue := OldHead.TagValue + 1;
    ComparsionHead:=OldHead;
    OldHead.Value := TPasMPInterlocked.CompareExchange(fHead^.Value,NewHead.Value, ComparsionHead.Value);
  until {$IFDEF cpu64}(OldHead.PointerValue = ComparsionHead.PointerValue) and (OldHead.TagValue = ComparsionHead.TagValue){$ELSE}OldHead.Value.Value = ComparsionHead.Value.Value{$ENDIF};
  Result := OldHead.PointerValue;
end;
{$ELSE}
begin
  fCriticalSection.Acquire;
  try
    Result := fHead;
    Pointer(Item^) := fHead;
    fHead := item;
  finally
    fCriticalSection.Leave;
  end;
end;
{$ENDIF}

function TPasMPThreadSafeStack.Pop: Pointer;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
var
  OldHead: TPasMPTaggedPointer;
  NewHead: TPasMPTaggedPointer;
  ComparsionHead: TPasMPTaggedPointer;
begin
  if Assigned(fHead^.PointerValue) then
  begin
    OldHead := fHead^;
    while Assigned(OldHead.PointerValue) do
    begin
      NewHead.PointerValue := Pointer(OldHead.PointerValue^);
      NewHead.TagValue := NewHead.TagValue + 1;
      ComparsionHead := OldHead;
      OldHead.Value := TPasMPInterlocked.CompareExchange(fHead^.Value,NewHead.Value, ComparsionHead.Value);
      if {$IFDEF cpu64}(OldHead.PointerValue = ComparsionHead.PointerValue) and (OldHead.TagValue = ComparsionHead.TagValue){$ELSE}OldHead.Value.Value = ComparsionHead.Value.Value{$ENDIF} then
      begin
        Break;
      end;
    end;
    Result := OldHead.PointerValue;
  end
  else
  begin
    Result := nil;
  end;
end;
{$ELSE}
begin
  Result := nil;
  if Assigned(fHead) then
  begin
    fCriticalSection.Acquire;
    try
      if Assigned(fHead) then
      begin
        Result := fHead;
        fHead := Pointer(Result^);
      end;
    finally
      fCriticalSection.Leave;
    end;
  end;
end;
{$ENDIF}

constructor TPasMPThreadSafeQueue.Create(ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
var
  Node: PPasMPThreadSafeQueueNode;
begin
 inherited Create;
 fItemSize := itemSize;
 fInternalNodeSize := SizeOf(TPasMPThreadSafeQueueNode)+fItemSize;
 fAddCPUCacheLinePaddingToInternalItemDataStructure:=AddCPUCacheLinePaddingToInternalItemDataStructure;
 if AddCPUCacheLinePaddingToInternalItemDataStructure then begin
  fInternalNodeSize := TPasMPMath.RoundUpToPowerOfTwo(Max(fInternalNodeSize, PasMPCPUCacheLineSize));
 end else begin
  fInternalNodeSize := TPasMPMath.RoundUpToPowerOfTwo(Max(fInternalNodeSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment));
 end;
 fHead := nil;
 fTail := nil;
 TPasMPMemory.AllocateAlignedMemory(fHead, SizeOf(TPasMPTaggedPointer), PasMPCPUCacheLineSize);
 TPasMPMemory.AllocateAlignedMemory(fTail, SizeOf(TPasMPTaggedPointer), PasMPCPUCacheLineSize);
 TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPCPUCacheLineSize);
 Node^.Previous.PointerValue := nil;
 Node^.Previous.TagValue := 0;
 Node^.Next.PointerValue := nil;
 Node^.Next.TagValue := 0;
 fHead^.PointerValue := Node;
 fHead^.TagValue := 0;
 fTail^.PointerValue := Node;
 fTail^.TagValue := 0;
 InitializeItem(@Node^.Data);
end;
{$ELSE}
begin
 inherited Create;
 fItemSize := itemSize;
 fAddCPUCacheLinePaddingToInternalItemDataStructure:=AddCPUCacheLinePaddingToInternalItemDataStructure;
 fInternalNodeSize := SizeOf(TPasMPThreadSafeQueueNode)+fItemSize;
 if AddCPUCacheLinePaddingToInternalItemDataStructure then begin
  fInternalNodeSize := TPasMPMath.RoundUpToPowerOfTwo(Max(fInternalNodeSize, PasMPCPUCacheLineSize));
 end;
 fHeadCriticalSection := TPasMPCriticalSection.Create;
 fTailCriticalSection := TPasMPCriticalSection.Create;
 fHead := nil;
 if fAddCPUCacheLinePaddingToInternalItemDataStructure then begin
  TPasMPMemory.AllocateAlignedMemory(fHead, FInternalNodeSize, PasMPCPUCacheLineSize);
 end else begin
  GetMem(fHead, FInternalNodeSize);
 end;
 fHead^.Next := nil;
 fTail := fHead;
 InitializeItem(@fHead^.Data);
end;
{$ENDIF}

destructor TPasMPThreadSafeQueue.Destroy;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
var
  Item: Pointer;
begin
  GetMem(Item, FItemSize);
  try
    InitializeItem(Item);
    while Dequeue(Item^) do
    begin
      FinalizeItem(Item);
    end;
  finally
    FreeMem(Item);
  end;
  if Assigned(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue) then
  begin
    FinalizeItem(@PPasMPThreadSafeQueueNode(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue)^.Data);
    TPasMPMemory.FreeAlignedMemory(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue);
  end;
  TPasMPMemory.FreeAlignedMemory(fTail);
  TPasMPMemory.FreeAlignedMemory(fHead);
  inherited Destroy;
end;
{$ELSE}
var
  CurrentNode: PPasMPThreadSafeQueueNode;
  NextNode: PPasMPThreadSafeQueueNode;
begin
  CurrentNode := fHead;
  while Assigned(CurrentNode) do
  begin
    NextNode := CurrentNode^.Next;
    FinalizeItem(@CurrentNode^.Data);
    if fAddCPUCacheLinePaddingToInternalItemDataStructure then
    begin
      TPasMPMemory.FreeAlignedMemory(CurrentNode);
    end
    else
    begin
      FreeMem(CurrentNode);
    end;
    CurrentNode := NextNode;
  end;
  fTailCriticalSection.Free;
  fHeadCriticalSection.Free;
  inherited Destroy;
end;
{$ENDIF}

procedure TPasMPThreadSafeQueue.InitializeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeQueue.FinalizeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeQueue.CopyItem(const Source,Destination: Pointer);
begin
  Move(Source^,Destination^, FItemSize);
end;

procedure TPasMPThreadSafeQueue.Clear;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
var
  Node: PPasMPThreadSafeQueueNode;
  Item: Pointer;
begin
  GetMem(Item, FItemSize);
  try
    InitializeItem(Item);
    while Dequeue(Item^) do
    begin
      FinalizeItem(Item);
    end;
  finally
    FreeMem(Item);
  end;
  if Assigned(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue) then
  begin
    FinalizeItem(@PPasMPThreadSafeQueueNode(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue)^.Data);
    TPasMPMemory.FreeAlignedMemory(PPasMPThreadSafeQueueNode(fTail)^.Previous.PointerValue);
  end;
  TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPCPUCacheLineSize);
  Node^.Previous.PointerValue := nil;
  Node^.Previous.TagValue := 0;
  Node^.Next.PointerValue := nil;
  Node^.Next.TagValue := 0;
  fHead^.PointerValue := Node;
  fHead^.TagValue := 0;
  fTail^.PointerValue := Node;
  fTail^.TagValue := 0;
  InitializeItem(@Node^.Data);
end;
{$ELSE}
var
  CurrentNode: PPasMPThreadSafeQueueNode;
  NextNode: PPasMPThreadSafeQueueNode;
begin
  CurrentNode := fHead;
  while Assigned(CurrentNode) do
  begin
    NextNode := CurrentNode^.Next;
    FinalizeItem(@CurrentNode^.Data);
    if fAddCPUCacheLinePaddingToInternalItemDataStructure then
    begin
      TPasMPMemory.FreeAlignedMemory(CurrentNode);
    end
    else
    begin
      FreeMem(CurrentNode);
    end;
    CurrentNode := NextNode;
  end;
  fHead := nil;
  if fAddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    TPasMPMemory.AllocateAlignedMemory(fHead, FInternalNodeSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    GetMem(fHead, FInternalNodeSize);
  end;
  fHead^.Next := nil;
  fTail := fHead;
  InitializeItem(@fHead^.Data);
end;
{$ENDIF}

function TPasMPThreadSafeQueue.IsEmpty: Boolean;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
begin
  Result := fHead^.PointerValue = fTail^.PointerValue;
end;
{$ELSE}
begin
  Result := fHead=fTail;
end;
{$ENDIF}

procedure TPasMPThreadSafeQueue.Enqueue(const Item);
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
{$IFDEF PASMP_USE_OPTIMISTIC_FIFO_QUEUE}
// Based on http://people.csail.mit.edu/edya/publications/OptimisticFIFOQueue-journal.pdf
var
  Node: PPasMPThreadSafeQueueNode;
  Tail: TPasMPTaggedPointer;
  OldTail: TPasMPTaggedPointer;
  NewTail: TPasMPTaggedPointer;
begin
 if fAddCPUCacheLinePaddingToInternalItemDataStructure then begin
  TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPCPUCacheLineSize);
 end else begin
  TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
 end;
 Node^.Previous.PointerValue := nil;
 Node^.Previous.TagValue := 0;
 InitializeItem(@Node^.Data);
 CopyItem(@Item, @Node^.Data);
 OldTail.Value := fTail^.Value;
 repeat
  Tail:=OldTail;
  Node^.Next.PointerValue := Tail.PointerValue;
  Node^.Next.TagValue := Tail.TagValue + 1;
  NewTail.PointerValue := Node;
  NewTail.TagValue := Tail.TagValue + 1;
  OldTail.Value := TPasMPInterlocked.CompareExchange(fTail^.Value,NewTail.Value, Tail.Value);
 until {$IFDEF CPU64}(OldTail.PointerValue = Tail.PointerValue) and (OldTail.TagValue = Tail.TagValue){$ELSE}OldTail.Value.Value = Tail.Value.Value{$ENDIF};
 NewTail.PointerValue := Node;
 NewTail.TagValue := Tail.TagValue;
 PPasMPThreadSafeQueueNode(Tail.PointerValue)^.Previous.Value := NewTail.Value;
end;
{$ELSE}
var Node: PPasMPThreadSafeQueueNode;
    Tail,Next, CheckTail, Temporary,OldNext: TPasMPTaggedPointer;
begin
 if fAddCPUCacheLinePaddingToInternalItemDataStructure then begin
  TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPCPUCacheLineSize);
 end else begin
  TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
 end;
 Node^.Previous.PointerValue := nil;
 Node^.Previous.TagValue := 0;
 Node^.Next.PointerValue := nil;
 Node^.Next.TagValue := 0;
 InitializeItem(@Node^.Data);
 CopyItem(@Item, @Node^.Data);
 repeat
  Tail.Value := fTail^.Value;
  TPasMPMemoryBarrier.Read;
	Next.Value := PPasMPThreadSafeQueueNode(Tail.PointerValue)^.Next.Value;
  TPasMPMemoryBarrier.Read;
  CheckTail.Value := fTail^.Value;
  if {$IFDEF CPU64}(Tail.TagValue = CheckTail.TagValue) and (Tail.PointerValue = CheckTail.PointerValue){$ELSE}Tail.Value.Value = CheckTail.Value.Value{$ENDIF} then begin
	 if Assigned(Next.PointerValue) then begin
    Temporary.PointerValue := Next.PointerValue;
    Temporary.TagValue := Tail.TagValue + 1;
    TPasMPInterlocked.CompareExchange(fTail^.Value, Temporary.Value, Tail.Value);
   end else begin
    Temporary.PointerValue := Node;
    Temporary.TagValue := Next.TagValue + 1;
    OldNext.Value := TPasMPInterlocked.CompareExchange(PPasMPThreadSafeQueueNode(Tail^.PointerValue)^.Next.Value, Temporary.Value,Next.Value);
    if {$IFDEF CPU64}(OldNext.PointerValue = Next.PointerValue) and (OldNext.TagValue = Next.TagValue){$ELSE}OldNext.Value.Value = Next.Value.Value{$ENDIF} then begin
     Temporary.PointerValue := Node;
     Temporary.TagValue := Tail.TagValue + 1;
     TPasMPInterlocked.CompareExchange(fTail^.Value, Temporary.Value, Tail.Value);
     Break;
    end;
   end;
  end;
 until False;
end;
{$ENDIF}
{$ELSE}
var
  Node: PPasMPThreadSafeQueueNode;
begin
  if fAddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    TPasMPMemory.AllocateAlignedMemory(Node, FInternalNodeSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    GetMem(Node, FInternalNodeSize);
  end;
  Node^.Next := nil;
  InitializeItem(@Node^.Data);
  CopyItem(@Item, @Node^.Data);
  fTailCriticalSection.Acquire;
  try
    fTail^.Next:=Node;
    fTail:=Node;
  finally
    fTailCriticalSection.Release;
  end;
end;
{$ENDIF}

function TPasMPThreadSafeQueue.Dequeue(out Item): Boolean;
{$IFDEF PASMP_HAS_DOUBLE_NATIVE_MACHINE_WORD_ATOMIC_COMPARE_EXCHANGE}
{$IFDEF PASMP_USE_OPTIMISTIC_FIFO_QUEUE}
// Based on http://people.csail.mit.edu/edya/publications/OptimisticFIFOQueue-journal.pdf
var
  Tail: TPasMPTaggedPointer;
  Head: TPasMPTaggedPointer;
  CheckHead: TPasMPTaggedPointer;
  FirstNodePrevious: TPasMPTaggedPointer;
  NewHead: TPasMPTaggedPointer;
  OldHead: TPasMPTaggedPointer;
  CurrentNode: TPasMPTaggedPointer;
  NextNode: TPasMPTaggedPointer;
  NewNode: TPasMPTaggedPointer;
begin
 Result := False;
 repeat
  Head.Value := fHead^.Value;
  Tail.Value := fTail^.Value;
  TPasMPMemoryBarrier.Read;
  FirstNodePrevious.Value := PPasMPThreadSafeQueueNode(Head.PointerValue)^.Previous.Value;
  TPasMPMemoryBarrier.Read;
  CheckHead.Value := fHead^.Value;
  if {$IFDEF cpu64}(Head.PointerValue = CheckHead.PointerValue) and (Head.TagValue = CheckHead.TagValue){$ELSE}Head.Value.Value = CheckHead.Value.Value{$ENDIF} then begin
   if {$IFDEF cpu64}(Head.PointerValue <> Tail.PointerValue) or (Head.TagValue <> Tail.TagValue){$ELSE}Head.Value.Value <> Tail.Value.Value{$ENDIF} then begin
    // Not in the original paper, but there is a race condition where push adds a node, but leaves Node^.Next^.Previous uninitialized for a short time.
    // This only manifests too when FirstNodePrevious.TagValue = Head.TagValue, which is also very rare. If they aren't equal, FixList fixes the issue
		// (or at least it takes long enough, so that things settle). So here ensure time is not wasted getting to the end-game only to try to dereference
    // nil.
    if Assigned(FirstNodePrevious.PointerValue) then begin
     if FirstNodePrevious.TagValue<>Head.TagValue then begin
      // Fix list
      CurrentNode := Tail;
      repeat
       CheckHead.Value := fHead^.Value;
{$IFDEF cpu64}
       if ((Head.PointerValue = CheckHead.PointerValue) and (Head.TagValue = CheckHead.TagValue)) and
          ((CurrentNode.PointerValue<>Head.PointerValue) or (CurrentNode.TagValue<>Head.TagValue)) then begin
{$ELSE}
       if (Head.Value.Value = CheckHead.Value.Value) and (CurrentNode.Value.Value<>Head.Value.Value) then begin
{$ENDIF}
        NextNode.Value := PPasMPThreadSafeQueueNode(CurrentNode.PointerValue)^.Next.Value;
        NewNode.PointerValue := CurrentNode.PointerValue;
        NewNode.TagValue := CurrentNode.TagValue - 1;
        PPasMPThreadSafeQueueNode(NextNode.PointerValue)^.Previous.Value := NewNode.Value;
        NewNode.PointerValue := NextNode.PointerValue;
        NewNode.TagValue := CurrentNode.TagValue - 1;
        CurrentNode.Value := NewNode.Value;
       end else begin
        Break;
       end;
      until False;
     end else begin
      NewHead.PointerValue := firstNodePrevious.PointerValue;
      NewHead.TagValue := Head.TagValue + 1;
      OldHead.Value := TPasMPInterlocked.CompareExchange(fHead^.Value,NewHead.Value,Head.Value);
      if {$IFDEF CPU64}(OldHead.PointerValue = Head.PointerValue) and (OldHead.TagValue = Head.TagValue){$ELSE}OldHead.Value.Value = Head.Value.Value{$ENDIF} then begin
       CopyItem(@PPasMPThreadSafeQueueNode(FirstNodePrevious.PointerValue)^.Data, @Item);
       FinalizeItem(@PPasMPThreadSafeQueueNode(FirstNodePrevious.PointerValue)^.Data);
       TPasMPMemory.FreeAlignedMemory(Head.PointerValue);
       Result := True;
       Exit;
      end;
     end;
    end;
   end else begin
    Break;
   end;
  end;
 until False;
end;
{$ELSE}
var
  Head: TPasMPTaggedPointer;
  Tail: TPasMPTaggedPointer;
  Next: TPasMPTaggedPointer;
  CheckHead: TPasMPTaggedPointer;
  OldHead: TPasMPTaggedPointer;
  Temporary: TPasMPTaggedPointer;
begin
  Result := False;
  repeat
    Head.Value := fHead^.Value;
    Tail.Value := fTail^.Value;
    TPasMPMemoryBarrier.Read;
    Next.Value := PPasMPThreadSafeQueueNode(Head.PointerValue)^.Next.Value;
    TPasMPMemoryBarrier.Read;
    CheckHead.Value := fHead^.Value;
    if {$IFDEF cpu64}(Head.PointerValue = CheckHead.PointerValue) and (Head.TagValue = CheckHead.TagValue){$ELSE}Head.Value.Value = CheckHead.Value.Value{$ENDIF} then
    begin
      if Head.PointerValue = Tail.PointerValue then
      begin
        if Assigned(Next.PointerValue) then
        begin
          Temporary.PointerValue := Next.PointerValue;
          Temporary.TagValue := Head.TagValue + 1;
          TPasMPInterlocked.CompareExchange(fTail^.Value, Temporary.Value, Tail.Value);
        end
        else
        begin
          Break;
        end;
      end
      else
      begin
        Temporary.PointerValue := Next.PointerValue;
        Temporary.TagValue := Head.TagValue + 1;
        OldHead.Value := TPasMPInterlocked.CompareExchange(fHead^.Value, Temporary.Value,Head.Value);
        if {$IFDEF CPU64}(OldHead.PointerValue = Head.PointerValue) and (OldHead.TagValue = Head.TagValue){$ELSE}OldHead.Value.Value = Head.Value.Value{$ENDIF} then
        begin
          CopyItem(@PPasMPThreadSafeQueueNode(Next.PointerValue)^.Data, @Item);
          FinalizeItem(@PPasMPThreadSafeQueueNode(Next.PointerValue)^.Data);
          TPasMPMemory.FreeAlignedMemory(Head.PointerValue);
          Result := True;
          Exit;
        end;
      end;
    end;
  until False;
end;
{$ENDIF}
{$ELSE}
var
  Node: PPasMPThreadSafeQueueNode;
  NewHead: PPasMPThreadSafeQueueNode;
begin
  Result := False;
  if Assigned(fHead) and (fHead<>fTail) then
  begin
    fHeadCriticalSection.Acquire;
    try
      Node := fHead;
      NewHead := fHead^.Next;
      if Assigned(NewHead) then
      begin
        CopyItem(@NewHead^.Data, @Item);
        FinalizeItem(@NewHead^.Data);
        fHead := NewHead;
        if fAddCPUCacheLinePaddingToInternalItemDataStructure then
        begin
          TPasMPMemory.FreeAlignedMemory(Node);
        end
        else
        begin
          FreeMem(Node);
        end;
        Result := True;
      end;
    finally
      fHeadCriticalSection.Release;
    end;
  end;
end;
{$ENDIF}

constructor TPasMPThreadSafeBoundedArrayBasedQueue.Create(const MaximalCount, itemSize: TPasMPUInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var
  i: TPasMPUInt32;
  p: PPasMPUInt8;
  QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
  inherited Create;
  fMaximalCount := TPasMPMath.RoundUpToPowerOfTwo(MaximalCount);
  if fMaximalCount<>MaximalCount then
  begin
    raise EPasMPThreadSafeBoundedArrayBasedQueue.Create('Maximum count must be power of two');
  end;
  fMask := fMaximalCount - 1;
  fItemSize := itemSize;
  fInternalItemSize := SizeOf(TPasMPThreadSafeBoundedArrayBasedQueueItemNode)+fItemSize;
  if AddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, SizeOf(TPasMPPtrUInt));
  end;
  fHeadSequence := 0;
  fTailSequence := 0;
  TPasMPMemoryBarrier.ReadWrite;
  TPasMPMemory.AllocateAlignedMemory(fData, FInternalItemSize*fMaximalCount, PasMPCPUCacheLineSize);
  p := fData;
  for i := 1 to fMaximalCount do
  begin
    QueueItemNode := Pointer(p);
    QueueItemNode^.Sequence := i - 1;
    InitializeItem(@QueueItemNode^.Data);
    Inc(p, FInternalItemSize);
  end;
  TPasMPMemoryBarrier.ReadWrite;
end;

destructor TPasMPThreadSafeBoundedArrayBasedQueue.Destroy;
var
  i: TPasMPUInt32;
  p: PPasMPUInt8;
  QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
  p := fData;
  for i := 1 to fMaximalCount do
  begin
    QueueItemNode := Pointer(p);
    FinalizeItem(@QueueItemNode^.Data);
    Inc(p, FInternalItemSize);
  end;
  TPasMPMemory.FreeAlignedMemory(fData);
  inherited Destroy;
end;

procedure TPasMPThreadSafeBoundedArrayBasedQueue.InitializeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeBoundedArrayBasedQueue.FinalizeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeBoundedArrayBasedQueue.CopyItem(const Source,Destination: Pointer);
begin
  Move(Source^,Destination^, FItemSize);
end;

procedure TPasMPThreadSafeBoundedArrayBasedQueue.Clear;
var
  Item: Pointer;
begin
  GetMem(Item, FItemSize);
  try
    InitializeItem(Item);
    while Dequeue(Item^) do
    begin
      FinalizeItem(Item);
    end;
  finally
    FreeMem(Item);
  end;
end;

function TPasMPThreadSafeBoundedArrayBasedQueue.IsEmpty: Boolean;
var LocalTailSequence, QueueItemNodeSequence: TPasMPUInt32;
    QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalTailSequence := fTailSequence;
 QueueItemNode := {%H-}Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Pointer(fData))+TPasMPPtrUInt(TPasMPPtrUInt(LocalTailSequence and fMask)*TPasMPPtrUInt(fInternalItemSize))));
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 QueueItemNodeSequence:=QueueItemNode^.Sequence;
 Result := TPasMPInt32(QueueItemNodeSequence - (LocalTailSequence + 1)) < 0;
end;

function TPasMPThreadSafeBoundedArrayBasedQueue.IsFull: Boolean;
var LocalHeadSequence, QueueItemNodeSequence: TPasMPUInt32;
    QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalHeadSequence := fHeadSequence;
 QueueItemNode := {%H-}Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Pointer(fData))+TPasMPPtrUInt(TPasMPPtrUInt(LocalHeadSequence and fMask)*TPasMPPtrUInt(fInternalItemSize))));
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 QueueItemNodeSequence:=QueueItemNode^.Sequence;
 Result := TPasMPInt32(QueueItemNodeSequence-LocalHeadSequence) < 0;
end;

function TPasMPThreadSafeBoundedArrayBasedQueue.Enqueue(const Item): Boolean;
var LocalHeadSequence, QueueItemNodeSequence: TPasMPUInt32;
    QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalHeadSequence := fHeadSequence;
 repeat
  QueueItemNode := {%H-}Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Pointer(fData))+TPasMPPtrUInt(TPasMPPtrUInt(LocalHeadSequence and fMask)*TPasMPPtrUInt(fInternalItemSize))));
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  QueueItemNodeSequence:=QueueItemNode^.Sequence;
  case TPasMPInt32(QueueItemNodeSequence-LocalHeadSequence) of
   0:begin
    if TPasMPInterlocked.CompareExchange(fHeadSequence,
                                         LocalHeadSequence+1,
                                         LocalHeadSequence) = LocalHeadSequence then begin
     Break;
    end;
   end;
   Low(TPasMPInt32)..-1:begin
    Result := False;
    Exit;
   end;
   else begin
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    LocalHeadSequence := fHeadSequence;
   end;
  end;
 until False;
 InitializeItem(@QueueItemNode^.Data);
 CopyItem(@Item, @QueueItemNode^.Data);
{$IF DEFINED(CPU386)}
 asm
  mfence;
 end;
{$ELSEIF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 QueueItemNode^.Sequence:=LocalHeadSequence + 1;
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.Write;
{$IFEND}
 Result := True;
end;

function TPasMPThreadSafeBoundedArrayBasedQueue.Dequeue(out Item): Boolean;
var LocalTailSequence, QueueItemNodeSequence: TPasMPUInt32;
    QueueItemNode:PPasMPThreadSafeBoundedArrayBasedQueueItemNode;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalTailSequence := fTailSequence;
 repeat
  QueueItemNode := {%H-}Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Pointer(fData))+TPasMPPtrUInt(TPasMPPtrUInt(LocalTailSequence and fMask)*TPasMPPtrUInt(fInternalItemSize))));
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  QueueItemNodeSequence:=QueueItemNode^.Sequence;
  case TPasMPInt32(QueueItemNodeSequence - (LocalTailSequence + 1)) of
   0:begin
    if TPasMPInterlocked.CompareExchange(fTailSequence,
                                         LocalTailSequence+1,
                                         LocalTailSequence) = LocalTailSequence then begin
     Break;
    end;
   end;
   Low(TPasMPInt32)..-1:begin
    Result := False;
    Exit;
   end;
   else begin
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    LocalTailSequence := fTailSequence;
   end;
  end;
 until False;
 CopyItem(@QueueItemNode^.Data, @Item);
 FinalizeItem(@QueueItemNode^.Data);
{$IF DEFINED(CPU386)}
 asm
  mfence;
 end;
{$ELSEIF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 QueueItemNode^.Sequence:=LocalTailSequence+fMask + 1;
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.Write;
{$IFEND}
 Result := True;
end;

const
  PasMPThreadSafeHashTableItemStateDeleted =  - 1;
  PasMPThreadSafeHashTableItemStateEmpty = 0;
  PasMPThreadSafeHashTableItemStateUsed = 1;

constructor TPasMPThreadSafeHashTable.Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create;
  fCriticalSection := TPasMPCriticalSection.Create;
  fLock := TPasMPMultipleReaderSingleWriterSpinLock.Create;
  fResizeLock := TPasMPMultipleReaderSingleWriterSpinLock.Create;
  fItemSize := itemSize;
  fInternalItemSize := SizeOf(TPasMPThreadSafeHashTableItem)+fItemSize;
  if AddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  fGrowLoadFactor:=((75 shl 7)+128) div 100; // 0.75
  TPasMPMemory.AllocateAlignedMemory(fFirstState, SizeOf(TPasMPThreadSafeHashTableState), PasMPCPUCacheLineSize);
  FillChar(fFirstState^, SizeOf(TPasMPThreadSafeHashTableState),#0);
  Initialize(fFirstState^);
  fFirstState^.Previous := nil;
  fFirstState^.Next := nil;
  fFirstState^.ReferenceCounter := 1;
  fFirstState^.Version := 0;
  fFirstState^.Size := TPasMPMath.RoundUpToPowerOfTwo(Max(16,4096 div fInternalItemSize));
  fFirstState^.Mask := fFirstState^.Size - 1;
  if fFirstState^.LogSize=0 then
  begin
    fFirstState^.LogSize := 0;
  end
  else
  begin
    fFirstState^.LogSize := TPasMPMath.BitScanReverse32(fFirstState^.Size);
  end;
  fFirstState^.Count := 0;
  TPasMPMemory.AllocateAlignedMemory(fFirstState^.Items, FFirstState^.Size*fInternalItemSize, PasMPCPUCacheLineSize);
  FillChar(fFirstState^.Items^, FFirstState^.Size*fInternalItemSize,#0);
  fLastState := fFirstState;
  fVersion := fFirstState^.Version;
end;

destructor TPasMPThreadSafeHashTable.Destroy;
begin
  while Assigned(fFirstState) do begin
    FreeState(fFirstState);
  end;
  fCriticalSection.Free;
  fLock.Free;
  fResizeLock.Free;
  inherited Destroy;
end;

function TPasMPThreadSafeHashTable.GetGrowLoadFactor:single;
begin
  Result := fGrowLoadFactor/128.0;
end;

procedure TPasMPThreadSafeHashTable.SetGrowLoadFactor(const NewGrowLoadFactor:single);
begin
  fGrowLoadFactor := Min(Max(round(fGrowLoadFactor*128.0), 0),128);
end;

function TPasMPThreadSafeHashTable.CreateState: PPasMPThreadSafeHashTableState;
begin
  TPasMPMemory.AllocateAlignedMemory(result, SizeOf(TPasMPThreadSafeHashTableState), PasMPCPUCacheLineSize);
  FillChar(Result^, SizeOf(TPasMPThreadSafeHashTableState),#0);
  Initialize(Result^);
  Result^.Previous := nil;
  Result^.Next := nil;
  Result^.ReferenceCounter := 1;
end;

procedure TPasMPThreadSafeHashTable.FreeState(const State: PPasMPThreadSafeHashTableState);
var
  Index: TPasMPInt32;
  Item: PPasMPThreadSafeHashTableItem;
begin
  fLock.AcquireWrite;
  try
    if Assigned(State^.Previous) then
    begin
      State^.Previous^.Next:=State^.Next;
    end
    else if fFirstState=State then
    begin
      fFirstState := State^.Next;
    end;
    if Assigned(State^.Next) then
    begin
      State^.Next^.Previous:=State^.Previous;
    end
    else if fLastState=State then
    begin
      fLastState := State^.Previous;
    end;
    Item:=State^.Items;
    for Index := 0 to State^.Size-1 do
    begin
      FinalizeItem(@Item^.Data);
      Finalize(Item^);
      Inc(TPasMPPtrUInt(Item), FInternalItemSize);
    end;
    TPasMPMemory.FreeAlignedMemory(State^.Items);
    Finalize(State^);
    TPasMPMemory.FreeAlignedMemory(State);
  finally
    fLock.ReleaseWrite;
  end;
end;

function TPasMPThreadSafeHashTable.AcquireState: PPasMPThreadSafeHashTableState;
begin
  Result := fLastState;
  TPasMPInterlocked.Increment(Result^.ReferenceCounter);
end;

procedure TPasMPThreadSafeHashTable.ReleaseState(const State: PPasMPThreadSafeHashTableState);
begin
  if TPasMPInterlocked.Decrement(State^.ReferenceCounter) = 0 then
  begin
    FreeState(State);
  end;
end;

procedure TPasMPThreadSafeHashTable.InitializeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.FinalizeItem(const Data: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.CopyItem(const Source,Destination: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.GetKey(const Data,Key: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.SetKey(const Data,Key: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.GetValue(const Data,Value: Pointer);
begin
end;

procedure TPasMPThreadSafeHashTable.SetValue(const Data,Value: Pointer);
begin
end;

function TPasMPThreadSafeHashTable.HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash;
begin
  Result := 0;
end;

function TPasMPThreadSafeHashTable.CompareKey(const Data,Key: Pointer): Boolean;
begin
  Result := False;
end;

procedure TPasMPThreadSafeHashTable.Clear;
begin
end;

function TPasMPThreadSafeHashTable.GetKeyValue(const Key,Value: Pointer): Boolean;
var CurrentState: PPasMPThreadSafeHashTableState;
    Hash: TPasMPThreadSafeHashTableHash;
    StartIndex, index, Step: TPasMPInt32;
    Item: PPasMPThreadSafeHashTableItem;
begin
 Result := False;
 CurrentState := AcquireState;
 try
  Hash:=HashKey(Key);
  StartIndex := (Hash shr (32-CurrentState^.LogSize)) and CurrentState^.Mask;
  Step:=((Hash shl 1) or 1) and CurrentState^.Mask;
  Index := StartIndex;
  repeat
   Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));
   case Item^.State of
    PasMPThreadSafeHashTableItemStateDeleted:begin
     // Found deleted item slot => ignore it
    end;
    PasMPThreadSafeHashTableItemStateEmpty:begin
     // Found empty item slot => abort search
     Break;
    end;
    PasMPThreadSafeHashTableItemStateUsed:begin
     // Found used item slot => try to read it
     if Item^.Hash=Hash then begin
      TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
      try
       if (Item^.State=PasMPThreadSafeHashTableItemStateUsed) and (Item^.Hash=Hash) and CompareKey(@Item^.Data,Key) then begin
        GetValue(@Item^.Data,Value);
        Result := True;
       end;
      finally
       TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
      end;
      if Result then begin
       Break;
      end;
     end;
    end;
   end;
   Index := (Index+Step) and CurrentState^.Mask;
  until Index=StartIndex;
 finally
  ReleaseState(CurrentState);
 end;
end;

function TPasMPThreadSafeHashTable.SetKeyValueOnState(const CurrentState: PPasMPThreadSafeHashTableState; const Key,Value: Pointer): Boolean;
var Hash: TPasMPThreadSafeHashTableHash;
    StartIndex, index, Step, FoundDeletedItemSlotIndex: TPasMPInt32;
    Item: PPasMPThreadSafeHashTableItem;
begin
 Result := False;

 Hash:=HashKey(Key);

 StartIndex := (Hash shr (32-CurrentState^.LogSize)) and CurrentState^.Mask;
 Step:=((Hash shl 1) or 1) and CurrentState^.Mask;

 FoundDeletedItemSlotIndex :=  - 1;

 // First try to set a existent or empty slot item
 Index := StartIndex;
 repeat
  Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));
  case Item^.State of
   PasMPThreadSafeHashTableItemStateDeleted:begin
    // Found deleted item slot => remember it for the next try iteration
    FoundDeletedItemSlotIndex := Index;
   end;
   PasMPThreadSafeHashTableItemStateEmpty:begin
    // Found empty item slot => try to use it
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
    try
     if Item^.State=PasMPThreadSafeHashTableItemStateEmpty then begin
      TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(Item^.Lock);
      try
       Item^.Hash:=Hash;
       InitializeItem(@Item^.Data);
       SetKey(@Item^.Data,Key);
       SetValue(@Item^.Data,Value);
       TPasMPInterlocked.Write(Item^.State, PasMPThreadSafeHashTableItemStateUsed);
       TPasMPInterlocked.Increment(CurrentState^.Count);
       Result := True;
      finally
       TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(Item^.Lock);
      end;
     end;
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
    end;
    if Result then begin
     Exit;
    end;
   end;
   PasMPThreadSafeHashTableItemStateUsed:begin
    // Found used item slot => try to overwrite it
    if Item^.Hash=Hash then begin
     TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
     try
      if (Item^.State=PasMPThreadSafeHashTableItemStateUsed) and (Item^.Hash=Hash) and CompareKey(@Item^.Data,Key) then begin
       TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(Item^.Lock);
       try
        SetValue(@Item^.Data,Value);
       finally
        TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(Item^.Lock);
       end;
       Result := True;
      end;
     finally
      TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
     end;
     if Result then begin
      Exit;
     end;
    end;
   end;
  end;
  Index := (Index+Step) and CurrentState^.Mask;
 until Index=StartIndex;

 // Otherwise try to set the last found deleted slot item
 if FoundDeletedItemSlotIndex>=0 then begin
  Index := FoundDeletedItemSlotIndex;
  Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
  try
   if Item^.State=PasMPThreadSafeHashTableItemStateDeleted then begin
    TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(Item^.Lock);
    try
     InitializeItem(@Item^.Data);
     Item^.Hash:=Hash;
     SetKey(@Item^.Data,Key);
     SetValue(@Item^.Data,Value);
     TPasMPInterlocked.Write(Item^.State, PasMPThreadSafeHashTableItemStateUsed);
     TPasMPInterlocked.Increment(CurrentState^.Count);
     Result := True;
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(Item^.Lock);
    end;
   end;
  finally
   TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
  end;
  if Result then begin
   Exit;
  end;
 end;

 // Otherwise try to find and set a deleted slot item
 Index := StartIndex;
 repeat
  Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));
  case Item^.State of
   PasMPThreadSafeHashTableItemStateDeleted:begin
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
    try
     if Item^.State=PasMPThreadSafeHashTableItemStateDeleted then begin
      TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(Item^.Lock);
      try
       Item^.Hash:=Hash;
       InitializeItem(@Item^.Data);
       SetKey(@Item^.Data,Key);
       SetValue(@Item^.Data,Value);
       TPasMPInterlocked.Write(Item^.State, PasMPThreadSafeHashTableItemStateUsed);
       TPasMPInterlocked.Increment(CurrentState^.Count);
       Result := True;
      finally
       TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(Item^.Lock);
      end;
     end;
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
    end;
    if Result then begin
     Exit;
    end;
   end;
  end;
  Index := (Index+Step) and CurrentState^.Mask;
 until Index=StartIndex;

 Result := False;

end;

function TPasMPThreadSafeHashTable.UnderGrowLoadFactor(const CurrentState: PPasMPThreadSafeHashTableState): Boolean;
begin
 if CurrentState^.Count<CurrentState^.Size then begin
  if CurrentState^.Count<=$7fffff then begin
   Result := CurrentState^.Count<((CurrentState^.Size*fGrowLoadFactor) shr 7);
  end else begin
   Result := CurrentState^.Count<((TPasMPInt64(CurrentState^.Size)*fGrowLoadFactor) shr 7);
  end;
 end else begin
  Result := False;
 end;
end;

procedure TPasMPThreadSafeHashTable.Grow;
var CurrentState,NewState,OldLastState: PPasMPThreadSafeHashTableState;
    StartIndex, index, Step,OtherIndex: TPasMPInt32;
    Item,OtherItem: PPasMPThreadSafeHashTableItem;
begin
 CurrentState := fLastState;

 fResizeLock.AcquireWrite;
 try

  {if not UnderGrowLoadFactor(CurrentState) then} begin

   TPasMPInterlocked.Write(fVersion, CurrentState^.Version + 1);

   fLock.AcquireWrite;
   try

    NewState := CreateState;
    NewState^.Version := fVersion;
    NewState^.Size := CurrentState^.Size shl 1;
    NewState^.Mask := NewState^.Size - 1;
    NewState^.LogSize := CurrentState^.LogSize + 1;
    NewState^.Count := CurrentState^.Count;

    TPasMPMemory.AllocateAlignedMemory(NewState^.Items,NewState^.Size*fInternalItemSize, PasMPCPUCacheLineSize);
    FillChar(NewState^.Items^,NewState^.Size*fInternalItemSize,#0);

    OtherIndex := 0;
    while OtherIndex<CurrentState^.Size do begin

     OtherItem := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(OtherIndex)*TPasMPPtrUInt(fInternalItemSize))));

     if OtherItem^.State=PasMPThreadSafeHashTableItemStateUsed then begin

      TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(OtherItem^.Lock);
      try

       if OtherItem^.State=PasMPThreadSafeHashTableItemStateUsed then begin

        StartIndex := (OtherItem^.Hash shr (32-NewState^.LogSize)) and NewState^.Mask;
        Step:=((OtherItem^.Hash shl 1) or 1) and NewState^.Mask;

        Index := StartIndex;

        repeat

         Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(NewState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));

         if Item^.State=PasMPThreadSafeHashTableItemStateEmpty then begin
          Item^.Hash:=OtherItem^.Hash;
          InitializeItem(@Item^.Data);
          CopyItem(@OtherItem^.Data, @Item^.Data);
          Item^.State := PasMPThreadSafeHashTableItemStateUsed;
          Break;
         end;

         Index := (Index+Step) and NewState^.Mask;

        until Index=StartIndex;

       end;

      finally
       TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(OtherItem^.Lock);
      end;

     end;

     Inc(OtherIndex);

    end;

    OldLastState := fLastState;
    if Assigned(OldLastState) then begin
     OldLastState^.Next:=NewState;
     NewState^.Previous:=OldLastState;
    end else begin
     NewState^.Previous := nil;
     OldLastState := NewState;
    end;
    NewState^.Next := nil;
    TPasMPInterlocked.Write(Pointer(fLastState), Pointer(NewState));

    TPasMPInterlocked.Decrement(CurrentState^.ReferenceCounter);

   finally
    fLock.ReleaseWrite;
   end;

  end;

 finally
  fResizeLock.ReleaseWrite;
 end;

end;

function TPasMPThreadSafeHashTable.SetKeyValue(const Key,Value: Pointer): Boolean;
var
  CurrentState: PPasMPThreadSafeHashTableState;
  Version: TPasMPInt32;
begin
 repeat
  Result := False;
  CurrentState := AcquireState;
  try
   Version:=CurrentState^.Version;
   if UnderGrowLoadFactor(CurrentState) and SetKeyValueOnState(CurrentState,Key,Value) then begin
    Result := True;
   end else begin
    Grow;
   end;
  finally
   ReleaseState(CurrentState);
  end;
 until Result and (Version=fVersion);
end;

function TPasMPThreadSafeHashTable.DeleteKey(const Key: Pointer): Boolean;
var
  CurrentState: PPasMPThreadSafeHashTableState;
  Hash: TPasMPThreadSafeHashTableHash;
  StartIndex,
  index,
  Step,
  Version: TPasMPInt32;
  Item: PPasMPThreadSafeHashTableItem;
begin
 repeat
  Result := False;
  CurrentState := AcquireState;
  try
   Version:=CurrentState^.Version;
   Hash:=HashKey(Key);
   StartIndex := (Hash shr (32-CurrentState^.LogSize)) and CurrentState^.Mask;
   Step:=((Hash shl 1) or 1) and CurrentState^.Mask;
   Index := StartIndex;
   repeat
    Item := Pointer(TPasMPPtrUInt(TPasMPPtrUInt(CurrentState^.Items)+TPasMPPtrUInt(TPasMPPtrUInt(Index)*TPasMPPtrUInt(fInternalItemSize))));
    case Item^.State of
     PasMPThreadSafeHashTableItemStateDeleted:begin
      // Found deleted item slot => ignore it
     end;
     PasMPThreadSafeHashTableItemStateEmpty:begin
      // Found empty item slot => abort search
      Break;
     end;
     PasMPThreadSafeHashTableItemStateUsed:begin
      // Found used item slot => try to read it
      if Item^.Hash=Hash then begin
       TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(Item^.Lock);
       try
        if (Item^.State=PasMPThreadSafeHashTableItemStateUsed) and (Item^.Hash=Hash) and CompareKey(@Item^.Data,Key) then begin
         TPasMPMultipleReaderSingleWriterSpinLock.ReadToWrite(Item^.Lock);
         try
          FinalizeItem(@Item^.Data);
          TPasMPInterlocked.Write(Item^.State, PasMPThreadSafeHashTableItemStateDeleted);
          TPasMPInterlocked.Write(Item^.Lock, 0);
          TPasMPInterlocked.Decrement(CurrentState^.Count);
          Result := True;
         finally
          TPasMPMultipleReaderSingleWriterSpinLock.WriteToRead(Item^.Lock);
         end;
        end;
       finally
        TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(Item^.Lock);
       end;
       if Result then begin
        Break;
       end;
      end;
     end;
    end;
    Index := (Index+Step) and CurrentState^.Mask;
   until Index=StartIndex;
  finally
   ReleaseState(CurrentState);
  end;
 until Version=fVersion;
end;

constructor TPasMPThreadSafeDynamicArray.Create(const AItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var BucketItemIndex: TPasMPInt32;
    Bucket: Pointer;
    BucketItemOffset: TPasMPPtrUInt;
begin
 inherited Create;
 fSize := 0;
 fAllocated := PasMPThreadSafeDynamicArrayFirstBucketSize;
 fCountBuckets := 1;
 fItemSize := AItemSize;
 fItemLockOffset := TPasMPMath.RoundUpToMask32(fItemSize, SizeOf(TPasMPInt32));
 fInternalItemSize := fItemLockOffset+SizeOf(TPasMPInt32);
 if AddCPUCacheLinePaddingToInternalItemDataStructure then begin
  fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
 end else begin
  fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, SizeOf(TPasMPPtrUInt));
 end;
 fLock := TPasMPMultipleReaderSingleWriterSpinLock.Create;
 FillChar(fBuckets, SizeOf(TPasMPThreadSafeDynamicArrayBuckets),#0);
 TPasMPMemory.AllocateAlignedMemory(Bucket, PasMPThreadSafeDynamicArrayFirstBucketSize*TPasMPPtrUInt(fInternalItemSize));
 FillChar(Bucket^, PasMPThreadSafeDynamicArrayFirstBucketSize*TPasMPPtrUInt(fInternalItemSize),#0);
 for BucketItemIndex := 0 to PasMPThreadSafeDynamicArrayFirstBucketSize-1 do begin
  BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
  InitializeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
  PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))))^ := 0;
 end;
 TPasMPInterlocked.Write(fBuckets[0], Bucket);
 TPasMPMemoryBarrier.ReadWrite;
end;

destructor TPasMPThreadSafeDynamicArray.Destroy;
var BucketIndex, BucketSize, BucketItemIndex: TPasMPInt32;
    Bucket: Pointer;
begin
 TPasMPMemoryBarrier.ReadWrite;
 for BucketIndex := low(TPasMPThreadSafeDynamicArrayBuckets) to high(TPasMPThreadSafeDynamicArrayBuckets) do begin
  Bucket := TPasMPInterlocked.Exchange(fBuckets[BucketIndex], nil);
  if Assigned(Bucket) then begin
   BucketSize := PasMPThreadSafeDynamicArrayFirstBucketSize shl BucketIndex;
   for BucketItemIndex := 0 to BucketSize-1 do begin
    FinalizeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket) + (TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize)))));
   end;
   TPasMPMemory.FreeAlignedMemory(Bucket);
  end;
 end;
 fLock.Free;
 inherited Destroy;
end;

procedure TPasMPThreadSafeDynamicArray.InitializeItem(const ItemData: Pointer);
begin
end;

procedure TPasMPThreadSafeDynamicArray.FinalizeItem(const ItemData: Pointer);
begin
end;

procedure TPasMPThreadSafeDynamicArray.CopyItem(const Source,Destination: Pointer);
begin
end;

procedure TPasMPThreadSafeDynamicArray.SetSize(const NewSize: TPasMPInt32);
var ItemIndex, BucketIndex, BucketItemIndex, Position, PositionHighestBit,OldCountBuckets,NewCountBuckets, BucketSize: TPasMPInt32;
    Bucket: Pointer;
    BucketItemOffset: TPasMPPtrUInt;
begin

 TPasMPMemoryBarrier.ReadWrite;

 if fSize<>NewSize then begin

  fLock.AcquireRead;
  try

   if fSize<>NewSize then begin

    fLock.ReadToWrite;
    try

     TPasMPMemoryBarrier.ReadWrite;

     if fSize<>NewSize then begin

      if NewSize<fSize then begin
       for ItemIndex := fSize-1 downto NewSize do begin
        Position := itemIndex+PasMPThreadSafeDynamicArrayFirstBucketSize;
        PositionHighestBit := TPasMPMath.BitScanReverse32(Position);
        BucketIndex := PositionHighestBit-PasMPThreadSafeDynamicArrayFirstBucketBits;
        BucketItemIndex := (TPasMPInt32(1) shl PositionHighestBit) xor Position;
        Bucket := fBuckets[BucketIndex];
        if Assigned(Bucket) then begin
         BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
         FinalizeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
         FillChar(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset))^, FInternalItemSize,#0);
        end;
       end;
      end;

      Position:=NewSize+PasMPThreadSafeDynamicArrayFirstBucketSize;
      PositionHighestBit := TPasMPMath.BitScanReverse32(Position);

      OldCountBuckets := fCountBuckets;
      NewCountBuckets := PositionHighestBit - (PasMPThreadSafeDynamicArrayFirstBucketBits-1);

      if OldCountBuckets<NewCountBuckets then begin
       // Grow
       for BucketIndex := OldCountBuckets to NewCountBuckets-1 do begin
        BucketSize := PasMPThreadSafeDynamicArrayFirstBucketSize shl BucketIndex;
        TPasMPMemory.AllocateAlignedMemory(Bucket, TPasMPPtrUInt(BucketSize)*TPasMPPtrUInt(fInternalItemSize));
        FillChar(Bucket^, TPasMPPtrUInt(BucketSize)*TPasMPPtrUInt(fInternalItemSize),#0);
        if Assigned(Bucket) then begin
         for BucketItemIndex := 0 to BucketSize-1 do begin
          BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
          InitializeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
          PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))))^ := 0;
         end;
        end;
        TPasMPInterlocked.Write(fBuckets[BucketIndex], Bucket);
       end;
      end else if NewCountBuckets<OldCountBuckets then begin
       // Shrink
       for BucketIndex := NewCountBuckets-1 downto OldCountBuckets do begin
        BucketSize := PasMPThreadSafeDynamicArrayFirstBucketSize shl BucketIndex;
        Bucket := TPasMPInterlocked.Exchange(fBuckets[BucketIndex], nil);
        if Assigned(Bucket) then begin
         for BucketItemIndex := 0 to BucketSize-1 do begin
          BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
          FinalizeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
          FillChar(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset))^, FInternalItemSize,#0);
         end;
         TPasMPMemory.FreeAlignedMemory(Bucket);
        end;
       end;
      end;

      fAllocated := TPasMPInt32(1) shl PositionHighestBit;
      fCountBuckets:=NewCountBuckets;
      fSize := NewSize;

     end;

    finally
     fLock.WriteToRead;
    end;

   end;

  finally
   fLock.ReleaseRead;
  end;

 end;

end;

function TPasMPThreadSafeDynamicArray.GetItem(const ItemIndex: TPasMPInt32; const ItemData: Pointer): Boolean;
var Position, PositionHighestBit, BucketIndex, BucketItemIndex: TPasMPInt32;
    Bucket: Pointer;
    BucketItemOffset: TPasMPPtrUInt;
    BucketItemLock: PPasMPInt32;
begin
 Result := False;
 if (ItemIndex>=0) and (ItemIndex<fSize) then begin
  fLock.AcquireRead;
  try
   if (ItemIndex>=0) and (ItemIndex<fSize) then begin
    Position := itemIndex+PasMPThreadSafeDynamicArrayFirstBucketSize;
    PositionHighestBit := TPasMPMath.BitScanReverse32(Position);
    BucketIndex := PositionHighestBit-PasMPThreadSafeDynamicArrayFirstBucketBits;
    BucketItemIndex := (TPasMPInt32(1) shl PositionHighestBit) xor Position;
    Bucket := fBuckets[BucketIndex];
    BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
    BucketItemLock := PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))));
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(BucketItemLock^);
    try
     CopyItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)), itemData);
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(BucketItemLock^);
    end;
    Result := True;
   end;
  finally
   fLock.ReleaseRead;
  end;
 end;
end;

function TPasMPThreadSafeDynamicArray.SetItem(const ItemIndex: TPasMPInt32; const ItemData: Pointer): Boolean;
var
  Position,
  PositionHighestBit,
  BucketIndex,
  BucketItemIndex: TPasMPInt32;
  Bucket: Pointer;
  BucketItemOffset: TPasMPPtrUInt;
  BucketItemLock: PPasMPInt32;
begin
 Result := False;
 if (ItemIndex>=0) and (ItemIndex<fSize) then begin
  fLock.AcquireRead;
  try
   if (ItemIndex>=0) and (ItemIndex<fSize) then begin
    Position := itemIndex+PasMPThreadSafeDynamicArrayFirstBucketSize;
    PositionHighestBit := TPasMPMath.BitScanReverse32(Position);
    BucketIndex := PositionHighestBit-PasMPThreadSafeDynamicArrayFirstBucketBits;
    Bucket := fBuckets[BucketIndex];
    BucketItemIndex := (TPasMPInt32(1) shl PositionHighestBit) xor Position;
    BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
    BucketItemLock := PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))));
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireWrite(BucketItemLock^);
    try
     CopyItem(ItemData, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.ReleaseWrite(BucketItemLock^);
    end;
    Result := True;
   end;
  finally
   fLock.ReleaseRead;
  end;
 end;
end;

function TPasMPThreadSafeDynamicArray.Push(const ItemData: Pointer): TPasMPInt32;
var
  NewSize: TPasMPInt32;
  Position: TPasMPInt32;
  PositionHighestBit: TPasMPInt32;
  OldCountBuckets: TPasMPInt32;
  NewCountBuckets: TPasMPInt32;
  BucketIndex: TPasMPInt32;
  BucketSize: TPasMPInt32;
  BucketItemIndex: TPasMPInt32;
  Bucket: Pointer;
  BucketItemOffset: TPasMPPtrUInt;
  BucketItemLock: PPasMPInt32;
begin
 fLock.AcquireWrite;
 try
  Result := fSize;

  NewSize := fSize + 1;

  Position:=result+PasMPThreadSafeDynamicArrayFirstBucketSize;
  PositionHighestBit := TPasMPMath.BitScanReverse32(Position);

  OldCountBuckets := fCountBuckets;
  NewCountBuckets := PositionHighestBit - (PasMPThreadSafeDynamicArrayFirstBucketBits-1);

  if OldCountBuckets<NewCountBuckets then begin
   // Grow
   for BucketIndex := OldCountBuckets to NewCountBuckets-1 do begin
    BucketSize := PasMPThreadSafeDynamicArrayFirstBucketSize shl BucketIndex;
    TPasMPMemory.AllocateAlignedMemory(Bucket, TPasMPPtrUInt(BucketSize)*TPasMPPtrUInt(fInternalItemSize));
    FillChar(Bucket^, TPasMPPtrUInt(BucketSize)*TPasMPPtrUInt(fInternalItemSize),#0);
    if Assigned(Bucket) then begin
     for BucketItemIndex := 0 to BucketSize-1 do begin
      BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
      InitializeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
      PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))))^ := 0;
     end;
    end;
    TPasMPInterlocked.Write(fBuckets[BucketIndex], Bucket);
   end;
  end;

  fAllocated := TPasMPInt32(1) shl PositionHighestBit;
  fCountBuckets:=NewCountBuckets;
  fSize := NewSize;

  Position:=(NewSize-1)+PasMPThreadSafeDynamicArrayFirstBucketSize;
  PositionHighestBit := TPasMPMath.BitScanReverse32(Position);
  BucketIndex := PositionHighestBit-PasMPThreadSafeDynamicArrayFirstBucketBits;
  Bucket := fBuckets[BucketIndex];
  BucketItemIndex := (TPasMPInt32(1) shl PositionHighestBit) xor Position;
  BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
  BucketItemLock := PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))));
  InitializeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireWrite(BucketItemLock^);
  try
   CopyItem(ItemData, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
  finally
   TPasMPMultipleReaderSingleWriterSpinLock.ReleaseWrite(BucketItemLock^);
  end;

 finally
  fLock.ReleaseWrite;
 end;
end;

function TPasMPThreadSafeDynamicArray.Pop(const ItemData: Pointer): Boolean;
var NewSize, Position, PositionHighestBit,OldCountBuckets,NewCountBuckets, BucketIndex, BucketSize, BucketItemIndex: TPasMPInt32;
    Bucket: Pointer;
    BucketItemOffset: TPasMPPtrUInt;
    BucketItemLock: PPasMPInt32;
begin

 Result := False;

 if fSize > 0 then begin

  fLock.AcquireWrite;
  try

   if fSize > 0 then begin

    NewSize := fSize - 1;

    Position:=NewSize+PasMPThreadSafeDynamicArrayFirstBucketSize;
    PositionHighestBit := TPasMPMath.BitScanReverse32(Position);

    BucketIndex := PositionHighestBit-PasMPThreadSafeDynamicArrayFirstBucketBits;
    Bucket := fBuckets[BucketIndex];
    BucketItemIndex := (TPasMPInt32(1) shl PositionHighestBit) xor Position;
    BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
    BucketItemLock := PPasMPInt32(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset+TPasMPPtrUInt(fItemLockOffset))));
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(BucketItemLock^);
    try
     CopyItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)), itemData);
    finally
     TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(BucketItemLock^);
    end;

    FinalizeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
    FillChar(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset))^, FInternalItemSize,#0);

    OldCountBuckets := fCountBuckets;
    NewCountBuckets := PositionHighestBit - (PasMPThreadSafeDynamicArrayFirstBucketBits-1);

    if NewCountBuckets<OldCountBuckets then begin
     // Shrink
     for BucketIndex := NewCountBuckets-1 downto OldCountBuckets do begin
      BucketSize := PasMPThreadSafeDynamicArrayFirstBucketSize shl BucketIndex;
      Bucket := TPasMPInterlocked.Exchange(fBuckets[BucketIndex], nil);
      if Assigned(Bucket) then begin
       for BucketItemIndex := 0 to BucketSize-1 do begin
        BucketItemOffset := TPasMPPtrUInt(BucketItemIndex)*TPasMPPtrUInt(fInternalItemSize);
        FinalizeItem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Bucket)+BucketItemOffset)));
       end;
       TPasMPMemory.FreeAlignedMemory(Bucket);
      end;
     end;
    end;

    fAllocated := TPasMPInt32(1) shl PositionHighestBit;
    fCountBuckets:=NewCountBuckets;
    fSize := NewSize;

    Result := True;

   end;

  finally
   fLock.ReleaseWrite;
  end;

 end;
end;

procedure TPasMPThreadSafeDynamicArray.Clear;
begin
 SetSize(0);
end;

constructor TPasMPSingleProducerSingleConsumerRingBuffer.Create(const Size: TPasMPInt32);
begin
  inherited Create;
  fSize := Size;
  fReadIndex := 0;
  fWriteIndex := 0;
  fData := nil;
  SetLength(fData, FSize);
  fLockState := 0;
end;

destructor TPasMPSingleProducerSingleConsumerRingBuffer.Destroy;
begin
  SetLength(fData, 0);
  inherited Destroy;
end;

procedure TPasMPSingleProducerSingleConsumerRingBuffer.Clear;
begin
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireWrite(fLockState);
  fReadIndex := 0;
  fWriteIndex := 0;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseWrite(fLockState);
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.Read(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
  ToRead: TPasMPInt32;
  p: PPasMPUInt8;
begin
  if (Bytes = 0) or (Bytes > fSize) then
  begin
    Result := 0;
  end
  else
  begin
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
    repeat
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
      TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
      LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
      TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
      TPasMPMemoryBarrier.Read;
{$IFEND}
      LocalWriteIndex := fWriteIndex;
      if LocalWriteIndex >= LocalReadIndex then
      begin
        Result := LocalWriteIndex-LocalReadIndex;
      end
      else
      begin
        Result := (fSize-LocalReadIndex)+LocalWriteIndex;
      end;
      if Bytes <= Result then
      begin
        Break;
      end
      else
      begin
        TPasMP.Yield;
      end;
    until False;
    p := Pointer(Buffer);
    if (LocalReadIndex+Bytes)>fSize then
    begin
      ToRead := fSize-LocalReadIndex;
      Move(fData[LocalReadIndex], P^, ToRead);
      Inc(p, ToRead);
      Dec(Bytes, ToRead);
      LocalReadIndex := 0;
    end;
    if Bytes > 0 then
    begin
      Move(fData[LocalReadIndex], P^, Bytes);
      Inc(LocalReadIndex, Bytes);
      if LocalReadIndex >= fSize then
      begin
        Dec(LocalReadIndex, FSize);
      end;
    end;
{$IFDEF CPU386}
    asm
      mfence
    end;
{$ELSE}
    TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
    fReadIndex := LocalReadIndex;
    TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
    Result := Bytes;
  end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.TryRead(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
  ToRead: TPasMPInt32;
  p: PPasMPUInt8;
begin
  if (Bytes = 0) or (Bytes > fSize) then
  begin
    Result := 0;
  end
  else
  begin
    TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
    TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
    LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then begin
   Result := LocalWriteIndex-LocalReadIndex;
  end else begin
   Result := (fSize-LocalReadIndex)+LocalWriteIndex;
  end;
  if Bytes>result then begin
   Result := 0;
  end else begin
   p := Pointer(Buffer);
   if (LocalReadIndex+Bytes)>fSize then begin
    ToRead := fSize-LocalReadIndex;
    Move(fData[LocalReadIndex], P^, ToRead);
    Inc(p, ToRead);
    Dec(Bytes, ToRead);
    LocalReadIndex := 0;
   end;
   if Bytes > 0 then begin
    Move(fData[LocalReadIndex], P^, Bytes);
    Inc(LocalReadIndex, Bytes);
    if LocalReadIndex >= fSize then begin
     Dec(LocalReadIndex, FSize);
    end;
   end;
{$IFDEF CPU386}
   asm
    mfence
   end;
{$ELSE}
   TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
   fReadIndex := LocalReadIndex;
   Result := Bytes;
  end;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.ReadAsMuchAsPossible(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var LocalReadIndex,LocalWriteIndex, ToRead: TPasMPInt32;
    p: PPasMPUInt8;
begin
 if (Bytes=0) or (Bytes>fSize) then begin
  Result := 0;
 end else begin
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then begin
   Result := LocalWriteIndex-LocalReadIndex;
  end else begin
   Result := (fSize-LocalReadIndex)+LocalWriteIndex;
  end;
  if Bytes>result then begin
   Bytes:=result;
  end;
  if Bytes > 0 then begin
   p := Pointer(Buffer);
   if (LocalReadIndex+Bytes)>fSize then begin
    ToRead := fSize-LocalReadIndex;
    Move(fData[LocalReadIndex], P^, ToRead);
    Inc(p, ToRead);
    Dec(Bytes, ToRead);
    LocalReadIndex := 0;
   end;
   if Bytes > 0 then begin
    Move(fData[LocalReadIndex], P^, Bytes);
    Inc(LocalReadIndex, Bytes);
    if LocalReadIndex >= fSize then begin
     Dec(LocalReadIndex, FSize);
    end;
   end;
{$IFDEF CPU386}
   asm
    mfence
   end;
{$ELSE}
   TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
   fReadIndex := LocalReadIndex;
  end;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
  Result := Bytes;
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.Write(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var LocalReadIndex,LocalWriteIndex, ToWrite: TPasMPInt32;
    p: PPasMPUInt8;
begin
 if (Bytes=0) or (Bytes>fSize) then begin
  Result := 0;
 end else begin
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
  repeat
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
   TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
   LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
   TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
   TPasMPMemoryBarrier.Read;
{$IFEND}
   LocalWriteIndex := fWriteIndex;
   if LocalWriteIndex >= LocalReadIndex then begin
    Result := ((fSize+LocalReadIndex)-LocalWriteIndex) - 1;
   end else begin
    Result := (LocalReadIndex-LocalWriteIndex) - 1;
   end;
   if Bytes <= Result then begin
    Break;
   end else begin
    TPasMP.Yield;
   end;
  until False;
  p := Pointer(Buffer);
  if (LocalWriteIndex+Bytes)>fSize then begin
   ToWrite := fSize-LocalWriteIndex;
   Move(p^, FData[LocalWriteIndex], ToWrite);
   Inc(p, ToWrite);
   Dec(Bytes, ToWrite);
   LocalWriteIndex := 0;
  end;
  if Bytes > 0 then begin
   Move(p^, FData[LocalWriteIndex], Bytes);
   Inc(LocalWriteIndex, Bytes);
   if LocalWriteIndex >= fSize then begin
    Dec(LocalWriteIndex, FSize);
   end;
  end;
{$IFDEF CPU386}
  asm
   mfence
  end;
{$ELSE}
  TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
  fWriteIndex := LocalWriteIndex;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
  Result := Bytes;
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.TryWrite(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var LocalReadIndex,LocalWriteIndex, ToWrite: TPasMPInt32;
    p: PPasMPUInt8;
begin
 if (Bytes=0) or (Bytes>fSize) then begin
  Result := 0;
 end else begin
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then begin
   Result := ((fSize+LocalReadIndex)-LocalWriteIndex) - 1;
  end else begin
   Result := (LocalReadIndex-LocalWriteIndex) - 1;
  end;
  if Bytes>result then begin
   Result := 0;
  end else begin
   p := Pointer(Buffer);
   if (LocalWriteIndex+Bytes)>fSize then begin
    ToWrite := fSize-LocalWriteIndex;
    Move(p^, FData[LocalWriteIndex], ToWrite);
    Inc(p, ToWrite);
    Dec(Bytes, ToWrite);
    LocalWriteIndex := 0;
   end;
   if Bytes > 0 then begin
    Move(p^, FData[LocalWriteIndex], Bytes);
    Inc(LocalWriteIndex, Bytes);
    if LocalWriteIndex >= fSize then begin
     Dec(LocalWriteIndex, FSize);
    end;
   end;
{$IFDEF CPU386}
   asm
    mfence
   end;
{$ELSE}
   TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
   fWriteIndex := LocalWriteIndex;
   Result := Bytes;
  end;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.WriteAsMuchAsPossible(const Buffer: Pointer;Bytes: TPasMPInt32): TPasMPInt32;
var LocalReadIndex,LocalWriteIndex, ToWrite: TPasMPInt32;
    p: PPasMPUInt8;
begin
 if (Bytes=0) or (Bytes>fSize) then begin
  Result := 0;
 end else begin
  TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then begin
   Result := ((fSize+LocalReadIndex)-LocalWriteIndex) - 1;
  end else begin
   Result := (LocalReadIndex-LocalWriteIndex) - 1;
  end;
  if Bytes>result then begin
   Bytes:=result;
  end;
  if Bytes > 0 then begin
   p := Pointer(Buffer);
   if (LocalWriteIndex+Bytes)>fSize then begin
    ToWrite := fSize-LocalWriteIndex;
    Move(p^, FData[LocalWriteIndex], ToWrite);
    Inc(p, ToWrite);
    Dec(Bytes, ToWrite);
    LocalWriteIndex := 0;
   end;
   if Bytes > 0 then begin
    Move(p^, FData[LocalWriteIndex], Bytes);
    Inc(LocalWriteIndex, Bytes);
    if LocalWriteIndex >= fSize then begin
     Dec(LocalWriteIndex, FSize);
    end;
   end;
{$IFDEF CPU386}
   asm
    mfence
   end;
{$ELSE}
   TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
   fWriteIndex := LocalWriteIndex;
  end;
  TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
  Result := Bytes;
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.AvailableForRead: TPasMPInt32;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
 TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := LocalWriteIndex-LocalReadIndex;
 end else begin
  Result := (fSize-LocalReadIndex)+LocalWriteIndex;
 end;
end;

function TPasMPSingleProducerSingleConsumerRingBuffer.AvailableForWrite: TPasMPInt32;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
 TPasMPMultipleReaderSingleWriterSpinLock.AcquireRead(fLockState);
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 TPasMPMultipleReaderSingleWriterSpinLock.ReleaseRead(fLockState);
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := ((fSize+LocalReadIndex)-LocalWriteIndex) - 1;
 end else begin
  Result := (LocalReadIndex-LocalWriteIndex) - 1;
 end;
end;

constructor TPasMPSingleProducerSingleConsumerBoundedQueue.Create(const MaximalCount, itemSize: TPasMPInt32);
begin
  inherited Create;
  fMaximalCount := MaximalCount;
  fItemSize := itemSize;
  fReadIndex := 0;
  fWriteIndex := 0;
  fData := nil;
  SetLength(fData, FMaximalCount*fItemSize);
end;

destructor TPasMPSingleProducerSingleConsumerBoundedQueue.Destroy;
begin
  SetLength(fData, 0);
  inherited Destroy;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue.Enqueue(const Item): Boolean;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := (((fMaximalCount+LocalReadIndex)-LocalWriteIndex)-1) > 0;
 end else begin
  Result := ((LocalReadIndex-LocalWriteIndex)-1) > 0;
 end;
 if Result then begin
  LocalWriteIndex := fWriteIndex;
  Move(Item, FData[LocalWriteIndex*fItemSize], FItemSize);
  Inc(LocalWriteIndex);
  if LocalWriteIndex >= fMaximalCount then begin
   LocalWriteIndex := 0;
  end;
  TPasMPMemoryBarrier.ReadWrite;
  fWriteIndex := LocalWriteIndex;
 end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue.Dequeue(out Item): Boolean;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := (LocalWriteIndex-LocalReadIndex) > 0;
 end else begin
  Result := ((fMaximalCount-LocalReadIndex)+LocalWriteIndex) > 0;
 end;
 if Result then begin
  LocalReadIndex := fReadIndex;
  Move(fData[LocalReadIndex*fItemSize], item, FItemSize);
  Inc(LocalReadIndex);
  if LocalReadIndex >= fMaximalCount then begin
   LocalReadIndex := 0;
  end;
  TPasMPMemoryBarrier.ReadWrite;
  fReadIndex := LocalReadIndex;
 end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue.AvailableForEnqueue: TPasMPInt32;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := ((fMaximalCount+LocalReadIndex)-LocalWriteIndex) - 1;
 end else begin
  Result := (LocalReadIndex-LocalWriteIndex) - 1;
 end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue.AvailableForDequeue: TPasMPInt32;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := LocalWriteIndex-LocalReadIndex;
 end else begin
  Result := (fMaximalCount-LocalReadIndex)+LocalWriteIndex;
 end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue.IsFull: Boolean;
var LocalReadIndex,LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 LocalWriteIndex := fWriteIndex;
 if LocalWriteIndex >= LocalReadIndex then begin
  Result := (LocalWriteIndex-LocalReadIndex) = 0;
 end else begin
  Result := ((fMaximalCount-LocalReadIndex)+LocalWriteIndex) = 0;
 end;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPSingleProducerSingleConsumerBoundedQueue<T>.Create(const MaximalCount: TPasMPInt32);
begin
  inherited Create;
  fMaximalCount := MaximalCount;
  fReadIndex := 0;
  fWriteIndex := 0;
  fData := nil;
  SetLength(fData, FMaximalCount);
end;

destructor TPasMPSingleProducerSingleConsumerBoundedQueue<T>.Destroy;
begin
  SetLength(fData, 0);
  inherited Destroy;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue<T>.Enqueue(const Item: T): Boolean;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then
  begin
    Result := (((fMaximalCount+LocalReadIndex)-LocalWriteIndex)-1) > 0;
  end
  else
  begin
    Result := ((LocalReadIndex-LocalWriteIndex)-1) > 0;
  end;
  if Result then
  begin
    LocalWriteIndex := fWriteIndex;
    Initialize(fData[LocalWriteIndex]);
    fData[LocalWriteIndex] := Item;
    Inc(LocalWriteIndex);
    if LocalWriteIndex >= fMaximalCount then
    begin
      LocalWriteIndex := 0;
    end;
    TPasMPMemoryBarrier.ReadWrite;
    fWriteIndex := LocalWriteIndex;
  end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue<T>.Dequeue(out Item: T): Boolean;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then
  begin
    Result := (LocalWriteIndex-LocalReadIndex) > 0;
  end
  else
  begin
    Result := ((fMaximalCount-LocalReadIndex)+LocalWriteIndex) > 0;
  end;
  if Result then
  begin
    LocalReadIndex := fReadIndex;
    Item := fData[LocalReadIndex];
    Finalize(fData[LocalReadIndex]);
    Inc(LocalReadIndex);
    if LocalReadIndex >= fMaximalCount then
    begin
      LocalReadIndex := 0;
    end;
    TPasMPMemoryBarrier.ReadWrite;
    fReadIndex := LocalReadIndex;
  end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue<T>.AvailableForEnqueue: TPasMPInt32;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then
  begin
    Result := ((fMaximalCount+LocalReadIndex)-LocalWriteIndex) - 1;
  end
  else
  begin
    Result := (LocalReadIndex-LocalWriteIndex) - 1;
  end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue<T>.AvailableForDequeue: TPasMPInt32;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then
  begin
    Result := LocalWriteIndex-LocalReadIndex;
  end
  else
  begin
    Result := (fMaximalCount-LocalReadIndex)+LocalWriteIndex;
  end;
end;

function TPasMPSingleProducerSingleConsumerBoundedQueue<T>.IsFull: Boolean;
var
  LocalReadIndex: TPasMPInt32;
  LocalWriteIndex: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
  LocalReadIndex := fReadIndex;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalWriteIndex := fWriteIndex;
  if LocalWriteIndex >= LocalReadIndex then
  begin
    Result := (LocalWriteIndex-LocalReadIndex) = 0;
  end
  else
  begin
    Result := ((fMaximalCount-LocalReadIndex)+LocalWriteIndex) = 0;
  end;
end;
{$ENDIF}

constructor TPasMPBoundedStack.Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var
  i: TPasMPInt32;
  p: PPasMPUInt8;
  StackItem: PPasMPBoundedStackItem;
begin
  inherited Create;
  fStack := TPasMPThreadSafeStack.Create;
  fFree := TPasMPThreadSafeStack.Create;
  fMaximalCount := MaximalCount;
  fItemSize := itemSize;
  fInternalItemSize := SizeOf(TPasMPBoundedStackItem)+fItemSize;
  if AddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  TPasMPMemory.AllocateAlignedMemory(fData, FInternalItemSize*fMaximalCount, PasMPCPUCacheLineSize);
  p := fData;
  for i := 0 to fMaximalCount-1 do
  begin
    StackItem := Pointer(p);
    Inc(p, FInternalItemSize);
    fFree.Push(StackItem);
  end;
end;

destructor TPasMPBoundedStack.Destroy;
begin
  TPasMPMemory.FreeAlignedMemory(fData);
  fFree.Free;
  fStack.Free;
  inherited Destroy;
end;

function TPasMPBoundedStack.IsEmpty: Boolean;
begin
  Result := fStack.IsEmpty;
end;

function TPasMPBoundedStack.IsFull: Boolean;
begin
  Result := fFree.IsEmpty;
end;

function TPasMPBoundedStack.Push(const Item): Boolean;
var
  StackItem: PPasMPBoundedStackItem;
begin
  StackItem := fFree.Pop;
  if Assigned(StackItem) then
  begin
    Move(Item, StackItem^.Data, FItemSize);
    fStack.Push(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function TPasMPBoundedStack.Pop(out Item): Boolean;
var
  StackItem: PPasMPBoundedStackItem;
begin
  StackItem := fStack.Pop;
  if Assigned(StackItem) then
  begin
    Move(StackItem^.Data, item, FItemSize);
    fFree.Push(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPBoundedStack<T>.Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var
  i: TPasMPInt32;
  p: PPasMPUInt8;
  StackItem: PPasMPBoundedTypedStackItem;
begin
  inherited Create;
  fStack := TPasMPThreadSafeStack.Create;
  fFree := TPasMPThreadSafeStack.Create;
  fMaximalCount := MaximalCount;
  fInternalItemSize := SizeOf(TPasMPBoundedTypedStackItem);
  if AddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  TPasMPMemory.AllocateAlignedMemory(fData, FInternalItemSize*fMaximalCount, PasMPCPUCacheLineSize);
  p := fData;
  for i := 0 to fMaximalCount-1 do
  begin
    StackItem := Pointer(p);
    Initialize(StackItem^);
    Inc(p, FInternalItemSize);
    fFree.Push(StackItem);
  end;
end;

destructor TPasMPBoundedStack<T>.Destroy;
var
  i: TPasMPInt32;
  p: PPasMPUInt8;
  StackItem: PPasMPBoundedTypedStackItem;
begin
  p := fData;
  for i := 0 to fMaximalCount-1 do
  begin
    StackItem := Pointer(p);
    Finalize(StackItem^);
    Inc(p, FInternalItemSize);
  end;
  TPasMPMemory.FreeAlignedMemory(fData);
  fFree.Free;
  fStack.Free;
  inherited Destroy;
end;

function TPasMPBoundedStack<T>.IsEmpty: Boolean;
begin
  Result := fStack.IsEmpty;
end;

function TPasMPBoundedStack<T>.IsFull: Boolean;
begin
  Result := fFree.IsEmpty;
end;

function TPasMPBoundedStack<T>.Push(const Item: T): Boolean;
var
  StackItem: PPasMPBoundedTypedStackItem;
begin
  StackItem := fFree.Pop;
  if Assigned(StackItem) then
  begin
    StackItem^.Data := Item;
    fStack.Push(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function TPasMPBoundedStack<T>.Pop(out Item: T): Boolean;
var
  StackItem: PPasMPBoundedTypedStackItem;
begin
  StackItem := fStack.Pop;
  if Assigned(StackItem) then
  begin
    Item := StackItem^.Data;
    Finalize(StackItem^);
    fFree.Push(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;
{$ENDIF}

constructor TPasMPUnboundedStack.Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create;
  fStack := TPasMPThreadSafeStack.Create;
  fItemSize := itemSize;
  fAddCPUCacheLinePaddingToInternalItemDataStructure:=AddCPUCacheLinePaddingToInternalItemDataStructure;
end;

destructor TPasMPUnboundedStack.Destroy;
var StackItem: PPasMPUnboundedStackItem;
begin
  repeat
    StackItem := fStack.Pop;
    if Assigned(StackItem) then
    begin
      TPasMPMemory.FreeAlignedMemory(StackItem);
    end
    else
    begin
      Break;
    end;
  until False;
  fStack.Free;
  inherited Destroy;
end;

function TPasMPUnboundedStack.IsEmpty: Boolean;
begin
  Result := fStack.IsEmpty;
end;

function TPasMPUnboundedStack.Push(const Item): Boolean;
var
  StackItem: PPasMPUnboundedStackItem;
begin
  if fAddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    TPasMPMemory.AllocateAlignedMemory(StackItem, TPasMPMath.RoundUpToMask32(SizeOf(TPasMPUnboundedStackItem)+fItemSize, PasMPCPUCacheLineSize), PasMPCPUCacheLineSize);
  end
  else
  begin
    TPasMPMemory.AllocateAlignedMemory(StackItem, TPasMPMath.RoundUpToMask32(SizeOf(TPasMPUnboundedStackItem)+fItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment), PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  Move(Item, StackItem^.Data, FItemSize);
  fStack.Push(StackItem);
  Result := True;
end;

function TPasMPUnboundedStack.Pop(out Item): Boolean;
var
  StackItem: PPasMPUnboundedStackItem;
begin
  StackItem := fStack.Pop;
  if Assigned(StackItem) then
  begin
    Move(StackItem^.Data, item, FItemSize);
    TPasMPMemory.FreeAlignedMemory(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPUnboundedStack<T>.Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create;
  fStack := TPasMPThreadSafeStack.Create;
  fItemSize := SizeOf(T);
  fAddCPUCacheLinePaddingToInternalItemDataStructure:=AddCPUCacheLinePaddingToInternalItemDataStructure;
end;

destructor TPasMPUnboundedStack<T>.Destroy;
var
  StackItem: PPasMPUnboundedTypedStackItem;
begin
  repeat
    StackItem := fStack.Pop;
    if Assigned(StackItem) then
    begin
      Finalize(StackItem^);
      TPasMPMemory.FreeAlignedMemory(StackItem);
    end
    else
    begin
      Break;
    end;
  until False;
  fStack.Free;
  inherited Destroy;
end;

function TPasMPUnboundedStack<T>.IsEmpty: Boolean;
begin
  Result := fStack.IsEmpty;
end;

function TPasMPUnboundedStack<T>.Push(const Item: T): Boolean;
var
  StackItem: PPasMPUnboundedTypedStackItem;
begin
  if fAddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    TPasMPMemory.AllocateAlignedMemory(StackItem, TPasMPMath.RoundUpToMask32(SizeOf(TPasMPUnboundedTypedStackItem), PasMPCPUCacheLineSize), PasMPCPUCacheLineSize);
  end
  else
  begin
    TPasMPMemory.AllocateAlignedMemory(StackItem, TPasMPMath.RoundUpToMask32(SizeOf(TPasMPUnboundedTypedStackItem), PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment), PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  Initialize(StackItem^);
  StackItem^.Data := Item;
  fStack.Push(StackItem);
  Result := True;
end;

function TPasMPUnboundedStack<T>.Pop(out Item: T): Boolean;
var
  StackItem: PPasMPUnboundedTypedStackItem;
begin
  StackItem := fStack.Pop;
  if Assigned(StackItem) then
  begin
    Item:=StackItem^.Data;
    Finalize(StackItem^);
    TPasMPMemory.FreeAlignedMemory(StackItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;
{$ENDIF}

constructor TPasMPBoundedQueue.Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var
  i: TPasMPInt32;
  p: PPasMPUInt8;
  QueueItem: PPasMPBoundedQueueItem;
begin
  inherited Create;
  fQueue := TPasMPThreadSafeQueue.Create(SizeOf(PPasMPBoundedQueueItem), AddCPUCacheLinePaddingToInternalItemDataStructure);
  fFree := TPasMPThreadSafeStack.Create;
  fMaximalCount := MaximalCount;
  fItemSize := itemSize;
  fInternalItemSize := SizeOf(TPasMPBoundedQueueItem)+fItemSize;
  if AddCPUCacheLinePaddingToInternalItemDataStructure then
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
  end
  else
  begin
    fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
  end;
  TPasMPMemory.AllocateAlignedMemory(fData, FInternalItemSize*fMaximalCount, PasMPCPUCacheLineSize);
  p := fData;
  for i := 0 to fMaximalCount-1 do
  begin
    QueueItem := Pointer(p);
    Inc(p, FInternalItemSize);
    fFree.Push(QueueItem);
  end;
end;

destructor TPasMPBoundedQueue.Destroy;
begin
  TPasMPMemory.FreeAlignedMemory(fData);
  fFree.Free;
  fQueue.Free;
  inherited Destroy;
end;

function TPasMPBoundedQueue.IsEmpty: Boolean;
begin
  Result := fQueue.IsEmpty;
end;

function TPasMPBoundedQueue.IsFull: Boolean;
begin
  Result := fFree.IsEmpty;
end;

function TPasMPBoundedQueue.Enqueue(const Item): Boolean;
var
  QueueItem: PPasMPBoundedQueueItem;
begin
  QueueItem := fFree.Pop;
  if Assigned(QueueItem) then
  begin
    Move(Item, QueueItem^.Data, FItemSize);
    fQueue.Enqueue(QueueItem);
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

function TPasMPBoundedQueue.Dequeue(out Item): Boolean;
var
  StackItem: PPasMPBoundedQueueItem;
begin
  Result := fQueue.Dequeue(StackItem);
  if Result then
  begin
    Move(StackItem^.Data, item, FItemSize);
    fFree.Push(StackItem);
  end;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPBoundedQueue<T>.Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
var i: TPasMPInt32;
    p: PPasMPUInt8;
    QueueItem: PPasMPBoundedTypedQueueItem;
begin
 inherited Create;
 fQueue := TPasMPThreadSafeQueue.Create(SizeOf(PPasMPBoundedQueueItem), AddCPUCacheLinePaddingToInternalItemDataStructure);
 fFree := TPasMPThreadSafeStack.Create;
 fMaximalCount := MaximalCount;
 fInternalItemSize := SizeOf(TPasMPBoundedTypedQueueItem);
 if AddCPUCacheLinePaddingToInternalItemDataStructure then begin
  fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPCPUCacheLineSize);
 end else begin
  fInternalItemSize := TPasMPMath.RoundUpToMask32(fInternalItemSize, PasMPDoubleNativeMachineWordAtomicCompareExchangeAlignment);
 end;
 TPasMPMemory.AllocateAlignedMemory(fData, FInternalItemSize*fMaximalCount, PasMPCPUCacheLineSize);
 p := fData;
 for i := 0 to fMaximalCount-1 do begin
  QueueItem := Pointer(p);
  Initialize(QueueItem^);
  Inc(p, FInternalItemSize);
  fFree.Push(QueueItem);
 end;
end;

destructor TPasMPBoundedQueue<T>.Destroy;
var i: TPasMPInt32;
    p: PPasMPUInt8;
    QueueItem: PPasMPBoundedTypedQueueItem;
begin
 p := fData;
 for i := 0 to fMaximalCount-1 do begin
  QueueItem := Pointer(p);
  Finalize(QueueItem^);
  Inc(p, FInternalItemSize);
 end;
 TPasMPMemory.FreeAlignedMemory(fData);
 fFree.Free;
 fQueue.Free;
 inherited Destroy;
end;

function TPasMPBoundedQueue<T>.IsEmpty: Boolean;
begin
  Result := fQueue.IsEmpty;
end;

function TPasMPBoundedQueue<T>.IsFull: Boolean;
begin
  Result := fFree.IsEmpty;
end;

function TPasMPBoundedQueue<T>.Enqueue(const Item: T): Boolean;
var
  QueueItem: PPasMPBoundedTypedQueueItem;
begin
 QueueItem := fFree.Pop;
 if Assigned(QueueItem) then begin
  Initialize(QueueItem^);
  QueueItem^.Data := Item;
  fQueue.Enqueue(QueueItem);
  Result := True;
 end else begin
  Result := False;
 end;
end;

function TPasMPBoundedQueue<T>.Dequeue(out Item: T): Boolean;
var
  QueueItem: PPasMPBoundedTypedQueueItem;
begin
 Result := fQueue.Dequeue(QueueItem);
 if Result then
 begin
  Item:=QueueItem^.Data;
  Finalize(QueueItem^);
  fFree.Push(QueueItem);
  Result := True;
 end
 else
 begin
  Result := False;
 end;
end;
{$ENDIF}

constructor TPasMPBoundedArrayBasedQueue.Create(const MaximalCount, itemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create(MaximalCount, itemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPBoundedArrayBasedQueue.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPBoundedArrayBasedQueue<T>.Create(const MaximalCount: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create(MaximalCount, SizeOf(T), AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPBoundedArrayBasedQueue<T>.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPBoundedArrayBasedQueue<T>.InitializeItem(const Data: Pointer);
begin
  Initialize(T(Data^));
end;

procedure TPasMPBoundedArrayBasedQueue<T>.FinalizeItem(const Data: Pointer);
begin
  Finalize(T(Data^));
end;

procedure TPasMPBoundedArrayBasedQueue<T>.CopyItem(const Source,Destination: Pointer);
begin
  T(Destination^) := T(Source^);
end;

function TPasMPBoundedArrayBasedQueue<T>.Enqueue(const Item: T): Boolean;
begin
  Result := inherited Enqueue(Item);
end;

function TPasMPBoundedArrayBasedQueue<T>.Dequeue(out Item: T): Boolean;
begin
  Result := inherited Dequeue(Item);
end;

{$ENDIF}

constructor TPasMPUnboundedQueue.Create(const ItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create(ItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPUnboundedQueue.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPUnboundedQueue<T>.Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create(SizeOf(T), AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPUnboundedQueue<T>.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPUnboundedQueue<T>.InitializeItem(const Data: Pointer);
begin
  Initialize(T(Data^));
end;

procedure TPasMPUnboundedQueue<T>.FinalizeItem(const Data: Pointer);
begin
  Finalize(T(Data^));
end;

procedure TPasMPUnboundedQueue<T>.CopyItem(const Source,Destination: Pointer);
begin
  T(Destination^) := T(Source^);
end;

procedure TPasMPUnboundedQueue<T>.Enqueue(const Item: T);
begin
  inherited Enqueue(Item);
end;

function TPasMPUnboundedQueue<T>.Dequeue(out Item: T): Boolean;
begin
  Result := inherited Dequeue(Item);
end;
{$ENDIF}

{$IFDEF HAS_GENERICS}
{$IF DEFINED(fpc) and (fpc_version>=3)}{$push}{$optimization noorderfields}{$IFEND}
constructor TPasMPMultipleProducerMultipleConsumerQueue<T>.Create(const aCapacity: TPasMPSizeInt);
var
  Index: TPasMPSizeInt;
begin
  inherited Create;

  if aCapacity < 1 then
  begin
    raise Exception.Create('Capacity < 1 is invalid');
  end;

  fCapacity:=aCapacity;

  fSlots := nil;
  SetLength(fSlots, FCapacity + 1);

  for Index := 0 to fCapacity do
  begin
    fSlots[Index].fTurn := 0;
  end;

  fHead := 0;
  fTail := 0;
end;

destructor TPasMPMultipleProducerMultipleConsumerQueue<T>.Destroy;
begin
 fSlots := nil;
 inherited Destroy;
end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.Idx(const aX: TPasMPSizeUIntEx): TPasMPSizeUIntEx;
begin
 Result := aX mod fCapacity;
end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.TurnOf(const aX: TPasMPSizeUIntEx): TPasMPSizeUIntEx;
begin
 Result := aX div fCapacity;
end;

procedure TPasMPMultipleProducerMultipleConsumerQueue<T>.Enqueue(const aValue: T);
var OldHead, SlotTurn,DesiredTurn: TPasMPSizeUIntEx;
    Slot: PSlot;
begin

 // Atomically increment fHead by 1 (fetch-and-add).
 OldHead := TPasMPInterlocked.Add({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fHead),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(1));
 Slot:=@fSlots[Idx(OldHead)];

 // Wait for the consumer to finish the previous round if needed
 DesiredTurn := TurnOf(OldHead) shl 1;
 repeat
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  SlotTurn:=Slot^.fTurn; // SlotTurn := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn));
 until SlotTurn=DesiredTurn;

 // Construct the item
 Slot^.fData := aValue;

 // Release: indicate that the slot now holds a valid item (turn + 1).
 // memory_order_release -> we do a memory barrier or store
 TPasMPMemoryBarrier.Write;  // or TPasMPMemoryBarrier.ReadWrite;
 Slot^.fTurn:=DesiredTurn + 1; //TPasMPInterlocked.Write(Slot^.fTurn,DesiredTurn + 1);

end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.TryEnqueue(const aValue: T): Boolean;
var HeadSnapshot, SlotTurn,DesiredTurn, PreviousHeadSnapshot: TPasMPSizeUIntEx;
    Slot: PSlot;
begin

 Result := False;

 // Read the local head
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 HeadSnapshot := fHead; // HeadSnapshot := TPasMPInterlocked.Read(fHead);

 // The loop
 while true do begin

  Slot:=@fSlots[Idx(HeadSnapshot)];
  DesiredTurn := TurnOf(HeadSnapshot) shl 1;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  SlotTurn:=Slot^.fTurn; // SlotTurn := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn));

  // If the slot is indeed ready to store
  if SlotTurn=DesiredTurn then begin
   // Attempt to claim by CAS the head
   if TPasMPInterlocked.CompareExchange({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fHead),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(HeadSnapshot + 1),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(HeadSnapshot)) = {$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(HeadSnapshot) then begin
    // We succeeded, now place the item
    Slot^.fData := aValue;
    TPasMPMemoryBarrier.Write;
    Slot^.fTurn:=DesiredTurn + 1; // TPasMPInterlocked.Write({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(DesiredTurn + 1));
    Result := True;
   end else begin
    // If CAS failed, someone else advanced head, so re-read and try again
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    HeadSnapshot := fHead; // HeadSnapshot := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fHead));
   end;
  end else begin
   // The slot is not ready -> queue is full or behind. Re-read head to see if it changed; if not, just fail
   PreviousHeadSnapshot:=HeadSnapshot;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
   TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
   TPasMPMemoryBarrier.Read;
{$IFEND}
   HeadSnapshot := fHead; // HeadSnapshot := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fHead));
   if HeadSnapshot=PreviousHeadSnapshot then begin
    Result := False;
    Exit;
   end else begin
    // try again
   end;
  end;
 end;

end;

procedure TPasMPMultipleProducerMultipleConsumerQueue<T>.Dequeue(out aValue: T);
var
  OldTail, SlotTurn,DesiredTurn: TPasMPSizeUIntEx;
  Slot: PSlot;
begin
// Atomically increment FTail
 OldTail := TPasMPInterlocked.Add({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fTail),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(1));
 Slot:=@fSlots[Idx(OldTail)];

 // We expect the slot turn to be: turn(OldTail)*2 + 1
 DesiredTurn:=(TurnOf(OldTail) shl 1) or 1;

 repeat
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  SlotTurn:=Slot^.fTurn; // SlotTurn := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn));
 until SlotTurn=DesiredTurn;

 // Acquire barrier
 TPasMPMemoryBarrier.Read;
 aValue := Slot^.fData;
 Finalize(Slot^.fData);

 // Mark slot free => DesiredTurn + 1
//TPasMPInterlocked.Write({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(DesiredTurn + 1));
 TPasMPMemoryBarrier.Write;
 Slot^.fTurn:=DesiredTurn + 1;
end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.TryDequeue(out AValue: T): Boolean;
var
  TailSnapshot,
  SlotTurn,
  DesiredTurn,
  PreviousTailSnapshot: TPasMPSizeUIntEx;
  Slot: PSlot;
begin
 Result := False;

{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
 TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
 TPasMPMemoryBarrier.Read;
{$IFEND}
 TailSnapshot := fTail; //TailSnapshot := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fTail));
 TPasMPMemoryBarrier.ReadDependency;

 while true do begin

  Slot:=@fSlots[Idx(TailSnapshot)];
  DesiredTurn:=(TurnOf(TailSnapshot) shl 1) or 1;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  SlotTurn:=Slot^.fTurn; //SlotTurn := TPasMPInterlocked.Read(Slot^.fTurn);
  TPasMPMemoryBarrier.ReadDependency;

  if SlotTurn=DesiredTurn then begin
   // Attempt to claim the slot by CAS
   if TPasMPInterlocked.CompareExchange({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fTail),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(TailSnapshot + 1),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(TailSnapshot)) = {$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(TailSnapshot) then begin
    TPasMPMemoryBarrier.Read;
    aValue := Slot^.fData;
    Finalize(Slot^.fData);
    Slot^.fTurn:=DesiredTurn + 1; //TPasMPInterlocked.Write({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(Slot^.fTurn),{$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(DesiredTurn + 1));
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
    TPasMPMemoryBarrier.Write;
{$IFEND}
    Result := True;
    Exit;
   end else begin
    // Another consumer got it first
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    TailSnapshot := fTail; // TailSnapshot := TPasMPInterlocked.Read(fTail);
    TPasMPMemoryBarrier.ReadDependency;
   end;
  end else begin
   // Slot doesn't hold a valid item; if fTail hasn't changed, queue is empty
   PreviousTailSnapshot := TailSnapshot;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
   TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
   TPasMPMemoryBarrier.Read;
{$IFEND}
   TailSnapshot := fTail; // TailSnapshot := TPasMPInterlocked.Read({$IFDEF cpu64}TPasMPUInt64{$ELSE}TPasMPUInt32{$ENDIF}(fTail));
   if TailSnapshot=PreviousTailSnapshot then begin
    Result := False;
    Exit;
   end else begin
    // Try again
   end;
  end;
 end;
end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.Size: TPasMPSizeUIntEx;
var
  LocalHead,
  LocalTail: TPasMPSizeInt;
begin
  LocalHead := fHead;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  LocalTail := fTail;
  Result := LocalHead-LocalTail;
end;

function TPasMPMultipleProducerMultipleConsumerQueue<T>.Empty: Boolean;
begin
  Result := Size <= 0;
end;

{$ENDIF}

constructor TPasMPHashTable.Create(const KeySize,ValueSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  fKeySize := KeySize;
  fValueSize := ValueSize;
  fItemSize := fKeySize+fValueSize;
  inherited Create(fItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPHashTable.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPHashTable.InitializeItem(const Data: Pointer);
begin
  FillChar(Data^, FItemSize,#0);
end;

procedure TPasMPHashTable.FinalizeItem(const Data: Pointer);
begin
end;

procedure TPasMPHashTable.CopyItem(const Source,Destination: Pointer);
begin
  Move(Source^,Destination^, FItemSize);
end;

procedure TPasMPHashTable.GetKey(const Data,Key: Pointer);
begin
  Move(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^,Key^, FKeySize);
end;

procedure TPasMPHashTable.SetKey(const Data,Key: Pointer);
begin
  Move(Key^, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^, FKeySize);
end;

procedure TPasMPHashTable.GetValue(const Data,Value: Pointer);
begin
  Move(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^,Value^, FValueSize);
end;

procedure TPasMPHashTable.SetValue(const Data,Value: Pointer);
begin
  Move(Value^, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^, FValueSize);
end;

function TPasMPHashTable.HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash;
{$IFDEF CPUARM}
var b: PPasMPUInt8;
    len,h, i: TPasMPUInt32;
begin
 Result := 2166136261;
 len := fKeySize;
 h:=len;
 if len > 0 then begin
  b:=Key;
  while len>3 do begin
   i := TPasMPUInt32(Pointer(b)^);
   h:=(h xor i) xor $2e63823a;
   Inc(h, (h shl 15) or (h shr (32-15)));
   Dec(h, (h shl 9) or (h shr (32-9)));
   Inc(h, (h shl 4) or (h shr (32-4)));
   Dec(h, (h shl 1) or (h shr (32-1)));
   h:=h xor (h shl 2) or (h shr (32-2));
   Result := Result xor i;
   Inc(result, (result shl 1) + (result shl 4) + (result shl 7) + (result shl 8) + (result shl 24));
   Inc(b,4);
   Dec(len,4);
  end;
  if len>1 then begin
   i := TPasMPUInt16(Pointer(b)^);
   h:=(h xor i) xor $2e63823a;
   Inc(h, (h shl 15) or (h shr (32-15)));
   Dec(h, (h shl 9) or (h shr (32-9)));
   Inc(h, (h shl 4) or (h shr (32-4)));
   Dec(h, (h shl 1) or (h shr (32-1)));
   h:=h xor (h shl 2) or (h shr (32-2));
   Result := Result xor i;
   Inc(result, (result shl 1) + (result shl 4) + (result shl 7) + (result shl 8) + (result shl 24));
   Inc(b,2);
   Dec(len,2);
  end;
  if len > 0 then begin
   i := TPasMPUInt8(b^);
   h:=(h xor i) xor $2e63823a;
   Inc(h, (h shl 15) or (h shr (32-15)));
   Dec(h, (h shl 9) or (h shr (32-9)));
   Inc(h, (h shl 4) or (h shr (32-4)));
   Dec(h, (h shl 1) or (h shr (32-1)));
   h:=h xor (h shl 2) or (h shr (32-2));
   Result := Result xor i;
   Inc(result, (result shl 1) + (result shl 4) + (result shl 7) + (result shl 8) + (result shl 24));
  end;
 end;
 Result := Result xor h;
 if Result = 0 then begin
  Result := $ffffffff;
 end;
end;
{$ELSE}
const
  m = TPasMPUInt32($57559429);
  n = TPasMPUInt32($5052acdb);
var
  b: PPasMPUInt8;
  h,k,len: TPasMPUInt32;
  p:{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF};
begin
 len := fKeySize;
 h:=len;
 k:=h+n + 1;
 if len > 0 then begin
  b:=Key;
  while len>7 do begin
   begin
    p:= TPasMPUInt32(Pointer(b)^)*{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF}(n);
    h:=h xor TPasMPUInt32(p and $ffffffff);
    k:=k xor TPasMPUInt32(p shr 32);
    Inc(b,4);
   end;
   begin
    p:= TPasMPUInt32(Pointer(b)^)*{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF}(m);
    k:=k xor TPasMPUInt32(p and $ffffffff);
    h:=h xor TPasMPUInt32(p shr 32);
    Inc(b,4);
   end;
   Dec(len,8);
  end;
  if len>3 then begin
   p:= TPasMPUInt32(Pointer(b)^)*{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF}(n);
   h:=h xor TPasMPUInt32(p and $ffffffff);
   k:=k xor TPasMPUInt32(p shr 32);
   Inc(b,4);
   Dec(len,4);
  end;
  if len > 0 then begin
   if len>1 then begin
    p := TPasMPUInt16(Pointer(b)^);
    Inc(b,2);
    Dec(len,2);
   end else begin
    p := 0;
   end;
   if len > 0 then begin
    p := P or (TPasMPUInt8(b^) shl 16);
   end;
   p := P*{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF}(m);
   k:=k xor TPasMPUInt32(p and $ffffffff);
   h:=h xor TPasMPUInt32(p shr 32);
  end;
 end;
 begin
  p:=(h xor (k+n))*{$IFDEF fpc}qword{$ELSE}TPasMPInt64{$ENDIF}(n);
  h:=h xor TPasMPUInt32(p and $ffffffff);
  k:=k xor TPasMPUInt32(p shr 32);
 end;
 Result := k xor h;
 if Result = 0 then begin
  Result := $ffffffff;
 end;
end;
{$ENDIF}

function TPasMPHashTable.CompareKey(const Data,Key: Pointer): Boolean;
{$IFDEF OldDelphi}
type PLongwords = ^TLongwords;
     TLongwords = array [0..$ffff] of TPasMPUInt32;
     PBytes = ^TBytes;
     TBytes = array [0..$ffff] of TPasMPUInt8;
var Index: TPasMPInt32;
begin
 for Index := 0 to (fKeySize div SizeOf(TPasMPUInt32))-1 do begin
  if PLongwords(Pointer(Data))^[Index]<>PLongwords(Pointer(Key))^[Index] then begin
   Result := False;
   Exit;
  end;
 end;
 for Index := (fKeySize and not (SizeOf(TPasMPUInt32)-1)) to fKeySize-1 do begin
  if PBytes(Pointer(Data))^[Index]<>PBytes(Pointer(Key))^[Index] then begin
   Result := False;
   Exit;
  end;
 end;
 Result := True;
end;
{$ELSE}
begin
 Result := CompareMem(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data))),Key, FKeySize);
end;
{$ENDIF}

function TPasMPHashTable.GetKeyValue(const Key; out Value): Boolean;
begin
 Result := inherited GetKeyValue(@Key, @Value);
end;

function TPasMPHashTable.SetKeyValue(const Key,Value): Boolean;
begin
 Result := inherited SetKeyValue(@Key, @Value);
end;

function TPasMPHashTable.DeleteKey(const Key): Boolean;
begin
 Result := inherited DeleteKey(@Key);
end;

constructor TPasMPStringHashTable.Create(const ValueSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
 fKeySize := SizeOf(string);
 fValueSize := ValueSize;
 fItemSize := fKeySize+fValueSize;
 inherited Create(fItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPStringHashTable.Destroy;
begin
 inherited Destroy;
end;

procedure TPasMPStringHashTable.InitializeItem(const Data: Pointer);
begin
 Initialize(string(Data^));
end;

procedure TPasMPStringHashTable.FinalizeItem(const Data: Pointer);
begin
 Finalize(string(Data^));
end;

procedure TPasMPStringHashTable.CopyItem(const Source,Destination: Pointer);
begin
 string(Destination^):=string(Source^);
 Move(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Source)+TPasMPPtrUInt(fKeySize)))^, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Destination)+TPasMPPtrUInt(fKeySize)))^, FValueSize);
end;

procedure TPasMPStringHashTable.GetKey(const Data,Key: Pointer);
begin
 string(Key^):=string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^);
end;

procedure TPasMPStringHashTable.SetKey(const Data,Key: Pointer);
begin
 string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^):=string(Key^);
end;

procedure TPasMPStringHashTable.GetValue(const Data,Value: Pointer);
begin
 Move(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^,Value^, FValueSize);
end;

procedure TPasMPStringHashTable.SetValue(const Data,Value: Pointer);
begin
 Move(Value^, Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^, FValueSize);
end;

function TPasMPStringHashTable.HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash;
var Index: TPasMPInt32;
begin
 Result := Length(string(Key^));
 for Index := 1 to Length(string(Key^)) do begin
  Result := ((result shl 27) or (result shl 5))+ord(string(Key^)[Index]);
 end;
 if Result = 0 then begin
  Result := $ffffffff;
 end;
end;

function TPasMPStringHashTable.CompareKey(const Data,Key: Pointer): Boolean;
begin
 Result := string(Data^) = string(Key^);
end;

function TPasMPStringHashTable.GetKeyValue(const Key: string; out Value): Boolean;
begin
 Result := inherited GetKeyValue(@Key, @Value);
end;

function TPasMPStringHashTable.SetKeyValue(const Key: string; const Value): Boolean;
begin
 Result := inherited SetKeyValue(@Key, @Value);
end;

function TPasMPStringHashTable.DeleteKey(const Key: string): Boolean;
begin
 Result := inherited DeleteKey(@Key);
end;

constructor TPasMPStringStringHashTable.Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
 fKeySize := SizeOf(string);
 fValueSize := SizeOf(string);
 fItemSize := fKeySize+fValueSize;
 inherited Create(fItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPStringStringHashTable.Destroy;
begin
 inherited Destroy;
end;

procedure TPasMPStringStringHashTable.InitializeItem(const Data: Pointer);
begin
 Initialize(string(Data^));
 Initialize(string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^));
end;

procedure TPasMPStringStringHashTable.FinalizeItem(const Data: Pointer);
begin
 Finalize(string(Data^));
 Finalize(string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^));
end;

procedure TPasMPStringStringHashTable.CopyItem(const Source,Destination: Pointer);
begin
 string(Destination^):=string(Source^);
 string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Destination)+TPasMPPtrUInt(fKeySize)))^):=string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Source)+TPasMPPtrUInt(fKeySize)))^);
end;

procedure TPasMPStringStringHashTable.GetKey(const Data,Key: Pointer);
begin
 string(Key^):=string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^);
end;

procedure TPasMPStringStringHashTable.SetKey(const Data,Key: Pointer);
begin
 string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^):=string(Key^);
end;

procedure TPasMPStringStringHashTable.GetValue(const Data,Value: Pointer);
begin
 string(Value^):=string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^);
end;

procedure TPasMPStringStringHashTable.SetValue(const Data,Value: Pointer);
begin
 string(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^):=string(Value^);
end;

function TPasMPStringStringHashTable.HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash;
var Index: TPasMPInt32;
begin
 Result := Length(string(Key^));
 for Index := 1 to Length(string(Key^)) do begin
  Result := ((result shl 27) or (result shl 5))+ord(string(Key^)[Index]);
 end;
 if Result = 0 then begin
  Result := $ffffffff;
 end;
end;

function TPasMPStringStringHashTable.CompareKey(const Data,Key: Pointer): Boolean;
begin
 Result := string(Data^) = string(Key^);
end;

function TPasMPStringStringHashTable.GetKeyValue(const Key: string; out Value: string): Boolean;
begin
 Result := inherited GetKeyValue(@Key, @Value);
end;

function TPasMPStringStringHashTable.SetKeyValue(const Key,Value: string): Boolean;
begin
 Result := inherited SetKeyValue(@Key, @Value);
end;

function TPasMPStringStringHashTable.DeleteKey(const Key: string): Boolean;
begin
 Result := inherited DeleteKey(@Key);
end;

{$IFDEF HasGenericsCollections}
constructor TPasMPHashTable<KeyType,ValueType>.Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
 fKeySize := SizeOf(KeyType);
 fValueSize := SizeOf(ValueType);
 fItemSize := fKeySize+fValueSize;
 fComparer := TEqualityComparer<KeyType>.Default;
 inherited Create(fItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPHashTable<KeyType,ValueType>.Destroy;
begin
 inherited Destroy;
end;

procedure TPasMPHashTable<KeyType,ValueType>.InitializeItem(const Data: Pointer);
begin
 Initialize(KeyType(Data^));
 Initialize(ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^));
end;

procedure TPasMPHashTable<KeyType,ValueType>.FinalizeItem(const Data: Pointer);
begin
 Finalize(KeyType(Data^));
 Finalize(ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^));
end;

procedure TPasMPHashTable<KeyType,ValueType>.CopyItem(const Source,Destination: Pointer);
begin
 KeyType(Destination^):=KeyType(Source^);
 ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Destination)+TPasMPPtrUInt(fKeySize)))^):=ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Source)+TPasMPPtrUInt(fKeySize)))^);
end;

procedure TPasMPHashTable<KeyType,ValueType>.GetKey(const Data,Key: Pointer);
begin
 KeyType(Key^):=KeyType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^);
end;

procedure TPasMPHashTable<KeyType,ValueType>.SetKey(const Data,Key: Pointer);
begin
 KeyType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)))^):=KeyType(Key^);
end;

procedure TPasMPHashTable<KeyType,ValueType>.GetValue(const Data,Value: Pointer);
begin
 ValueType(Value^):=ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^);
end;

procedure TPasMPHashTable<KeyType,ValueType>.SetValue(const Data,Value: Pointer);
begin
 ValueType(Pointer(TPasMPPtrUInt(TPasMPPtrUInt(Data)+TPasMPPtrUInt(fKeySize)))^):=ValueType(Value^);
end;

function TPasMPHashTable<KeyType,ValueType>.HashKey(const Key: Pointer): TPasMPThreadSafeHashTableHash;
begin
 Result := fComparer.GetHashCode(KeyType(Key^));
 if Result = 0 then begin
  Result := $ffffffff;
 end;
end;

function TPasMPHashTable<KeyType,ValueType>.CompareKey(const Data,Key: Pointer): Boolean;
begin
 Result := fComparer.Equals(KeyType(Data^),KeyType(Key^));
end;

{$IFDEF fpc}
procedure TPasMPHashTable<KeyType,ValueType>.Dummy(out Value:ValueType);
begin
 // "Warning: Variable "Value" does not seem to be initialized" anti-warning workaround for FPC
end;
{$ENDIF}

function TPasMPHashTable<KeyType,ValueType>.GetKeyValue(const Key:KeyType; out Value:ValueType): Boolean;
begin
{$IFDEF fpc}
 Dummy(Value);
{$ENDIF}
 Result := inherited GetKeyValue(@Key, @Value);
end;

function TPasMPHashTable<KeyType,ValueType>.SetKeyValue(const Key:KeyType; const Value:ValueType): Boolean;
begin
 Result := inherited SetKeyValue(@Key, @Value);
end;

function TPasMPHashTable<KeyType,ValueType>.DeleteKey(const Key:KeyType): Boolean;
begin
 Result := inherited DeleteKey(@Key);
end;
{$ENDIF}

constructor TPasMPDynamicArray.Create(const aItemSize: TPasMPInt32; const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
 inherited Create(aItemSize, AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPDynamicArray.Destroy;
begin
 inherited Destroy;
end;

procedure TPasMPDynamicArray.InitializeItem(const ItemData: Pointer);
begin
end;

procedure TPasMPDynamicArray.FinalizeItem(const ItemData: Pointer);
begin
end;

procedure TPasMPDynamicArray.CopyItem(const Source,Destination: Pointer);
begin
 Move(Source^,Destination^, itemSize);
end;

function TPasMPDynamicArray.GetItem(const ItemIndex: TPasMPInt32; out ItemData): Boolean;
begin
 Result := inherited GetItem(ItemIndex, @ItemData);
end;

function TPasMPDynamicArray.SetItem(const ItemIndex: TPasMPInt32; const ItemData): Boolean;
begin
 Result := inherited SetItem(ItemIndex, @ItemData);
end;

function TPasMPDynamicArray.Push(const ItemData): TPasMPInt32;
begin
 Result := inherited Push(@ItemData);
end;

function TPasMPDynamicArray.Pop(out ItemData): Boolean;
begin
 Result := inherited Pop(@ItemData);
end;

{$IFDEF HAS_GENERICS}
constructor TPasMPDynamicArray<T>.Create(const AddCPUCacheLinePaddingToInternalItemDataStructure: Boolean = True);
begin
  inherited Create(SizeOf(T), AddCPUCacheLinePaddingToInternalItemDataStructure);
end;

destructor TPasMPDynamicArray<T>.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPDynamicArray<T>.InitializeItem(const ItemData: Pointer);
begin
  Initialize(PPasMPDynamicArrayDataType(ItemData)^);
end;

procedure TPasMPDynamicArray<T>.FinalizeItem(const ItemData: Pointer);
begin
  Finalize(PPasMPDynamicArrayDataType(ItemData)^);
end;

procedure TPasMPDynamicArray<T>.CopyItem(const Source,Destination: Pointer);
begin
  PPasMPDynamicArrayDataType(Destination)^ := PPasMPDynamicArrayDataType(Source)^;
end;

function TPasMPDynamicArray<T>.GetItem(const ItemIndex: TPasMPInt32; out ItemData: T): Boolean;
begin
  Result := inherited GetItem(ItemIndex, @ItemData);
end;

function TPasMPDynamicArray<T>.SetItem(const ItemIndex: TPasMPInt32; const ItemData: T): Boolean;
begin
  Result := inherited SetItem(ItemIndex, @ItemData);
end;

function TPasMPDynamicArray<T>.Push(const ItemData: T): TPasMPInt32;
begin
  Result := inherited Push(@ItemData);
end;

function TPasMPDynamicArray<T>.Pop(out ItemData: T): Boolean;
begin
  Result := inherited Pop(@ItemData);
end;

function TPasMPDynamicArray<T>.GetPropertyItem(const ItemIndex: TPasMPInt32): T;
begin
  //Initialize(result); // <= should insert the compiler itself automatically
  if not inherited GetItem(ItemIndex, @Result) then
  begin
    raise EPasMPDynamicArrayOutOfBounds.Create('Out of bounds');
  end;
end;

procedure TPasMPDynamicArray<T>.SetPropertyItem(const ItemIndex: TPasMPInt32; const ItemData: T);
begin
  if not inherited SetItem(ItemIndex, @ItemData) then
  begin
    raise EPasMPDynamicArrayOutOfBounds.Create('Out of bounds');
  end;
end;
{$ENDIF}

{$IF DEFINED(fpc) and (DEFINED(Linux) or DEFINED(Android)) and DECLARED(TThreadPriority)}

{$IF not DECLARED(pthread_t)}
type
  pthread_t = ptruint;
{$IFEND}

{$IF not (DECLARED(Psched_param) and DECLARED(Tsched_param) and DECLARED(sched_param))}
type
  sched_param = record
    sched_priority: TPasMPInt32;
  end;
  Tsched_param = sched_param;
  Psched_param = ^Tsched_param;
{$IFEND}

{$IF not DECLARED(sched_get_priority_min)}
function sched_get_priority_min(policy: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'sched_get_priority_min';
{$IFEND}

{$IF not DECLARED(sched_get_priority_max)}
function sched_get_priority_max(policy: TPasMPInt32): TPasMPInt32; cdecl; external 'c' name 'sched_get_priority_max';
{$IFEND}

{$IF not DECLARED(pthread_getschedparam)}
function pthread_getschedparam(thread:pthread_t;policy: PPasMPInt32;param:Psched_param): TPasMPInt32; cdecl; external 'c' name 'pthread_getschedparam';
{$IFEND}

{$IF not DECLARED(pthread_setschedparam)}
function pthread_setschedparam(thread:pthread_t;policy: TPasMPInt32;param:Psched_param): TPasMPInt32; cdecl; external 'c' name 'pthread_getschedparam';
{$IFEND}

// A mapping of TThreadPriority to POSIX thread priorities as normalized-scaled 10 bit resolution (1024 levels) values
const
  POSIXPriorities: array [TThreadPriority] of TPasMPInt32 = (
    0,    // tpIdle, THREAD_PRIORITY_IDLE, lowest possible priority, 0/6 = 0.00% * 1024 ~= 0
    171,  // tpLowest, THREAD_PRIORITY_LOWEST, low priority, 1/6 = 16.66% * 1024 ~= 171
    341,  // tpLower, THREAD_PRIORITY_BELOW_NORMAL, below-normal priority, 2/6 = 33.33% * 1024 ~= 341
    512,  // tpNormal, THREAD_PRIORITY_NORMAL, normal priority, 3/6 = 50.00% * 1024 ~= 512
    683,  // tpHigher, THREAD_PRIORITY_ABOVE_NORMAL, above-normal priority, 4/6 = 66.66% * 1024 ~= 683
    853,  // tpHighest, THREAD_PRIORITY_HIGHEST, high priority, 5/6 = 83.33% * 1024 ~= 853
    1024  // tpTimeCritical, THREAD_PRIORITY_TIME_CRITICAL, highest possible priority, 6/6 = 100.00% * 1024 ~= 1024
  );

function TPasMPThread.GetPriority: TThreadPriority;
var
  Policy,
  MinPriority,
  MaxPriority,
  ScaledPriority,
  BestDifference,
  Difference: TPasMPInt32;
  Param: Tsched_param;
  CurrentPriority: TThreadPriority;
begin
  if GlobalPasMPOverrideThreadPriorityFunctions then
  begin
    // Default to tpNormal
    Result := TThreadPriority.tpNormal;

    // Initialize Param with zero
    Param.sched_priority := 0;

    // Get the current scheduling policy and priority
    if (Handle <> 0) and (pthread_getschedparam(Handle, @Policy, @Param) = 0) then
    begin
      // Get the minimum and maximum priority levels for the current policy
      MinPriority := sched_get_priority_min(Policy);
      MaxPriority := sched_get_priority_max(Policy);

      // Check if the priority range is valid, because both MinPriority and MaxPriority could be the same value, for example at SCHED_OTHER policy
      if MinPriority<MaxPriority then
      begin
        // Calculate scaled priority to a 10 bit resolution (1024 levels) value (with halfway rounding)
        ScaledPriority:=((TPasMPInt64(Param.sched_priority-MinPriority) shl 10) + (((MaxPriority-MinPriority) + 1) shr 1)) div (MaxPriority-MinPriority);

        // Find the closest priority level
        BestDifference:=High(TPasMPInt32);

        // Iterate over all possible priorities
        for CurrentPriority:=Low(TThreadPriority) to High(TThreadPriority) do
        begin
          // Calculate the absolute difference
          Difference:=abs(POSIXPriorities[CurrentPriority]-ScaledPriority);

          // Check if the current difference is better than the best difference
          if BestDifference>Difference then
          begin
            // Update the best difference
            BestDifference:=Difference;

            // Update the Result with the current priority
            Result := CurrentPriority;

            // Check if the best difference is zero
            if BestDifference = 0 then
            begin
              Break; // If it is the case, we can't get any better and we can stop the search
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    Result := inherited Priority;
  end;
end;

procedure TPasMPThread.SetPriority(Value: TThreadPriority);
var
  Policy,
  MinPriority,
  MaxPriority,
  ScaledPriority: TPasMPInt32;
  Param:Tsched_param;
begin
  if GlobalPasMPOverrideThreadPriorityFunctions then
  begin
    // Initialize Param with zero
    Param.sched_priority := 0;

    // Get the current scheduling policy and priority
    if (Handle <> 0) and (pthread_getschedparam(Handle, @Policy, @Param) = 0) then
    begin
      // Get the minimum and maximum priority levels for the current policy
      MinPriority := sched_get_priority_min(Policy);
      MaxPriority := sched_get_priority_max(Policy);

      // Check if the priority range is valid, because both MinPriority and MaxPriority could be the same value, for example at SCHED_OTHER policy
      if MinPriority < MaxPriority then
      begin
        // Calculate back-scaled priority from a 10 bit resolution (1024 levels) value (with halfway rounding) and restrict it to the valid range
        ScaledPriority := Min(Max(MinPriority + (((TPasMPInt64(MaxPriority-MinPriority)*POSIXPriorities[Value])+512) shr 10), MinPriority), MaxPriority);

        // Check if the priority has changed at all
        if Param.sched_priority <> ScaledPriority then
        begin
          // If yes, set the new priority to Param
          Param.sched_priority := ScaledPriority;

          // And set the new scheduling policy and priority
          if pthread_setschedparam(Handle, Policy, @Param) = 0 then
          begin
            // Success (nothing to do)
          end
          else
          begin
            // Error (maybe raise exception?)
          end;
        end;
      end;
    end;
  end
  else
  begin
    inherited Priority:=Value;
  end;
end;
{$IFEND}

constructor TPasMPJobTask.Create;
begin
  inherited Create;
  fFreeOnRelease := False;
  fJob := nil;
  fThreadIndex :=  - 1;
  fJobTag := 0;
end;

destructor TPasMPJobTask.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPJobTask.Run;
begin
end;

function TPasMPJobTask.Split: TPasMPJobTask;
begin
  Result := nil;
end;

function TPasMPJobTask.PartialPop: TPasMPJobTask;
begin
  Result := nil;
end;

function TPasMPJobTask.Spread: Boolean;
begin
  Result := False;
end;

constructor TPasMPJobAllocator.Create(const AJobWorkerThread: TPasMPJobWorkerThread);
begin
  inherited Create;
  fJobWorkerThread := AJobWorkerThread;
  fMemoryPoolBuckets := nil;
  fCountMemoryPoolBuckets := 1;
  SetLength(fMemoryPoolBuckets, FCountMemoryPoolBuckets);
  TPasMPMemory.AllocateAlignedMemory(fMemoryPoolBuckets[0], SizeOf(TPasMPJobAllocatorMemoryPoolBucket), SizeOf(TPasMPJob));
  fCountAllocatedJobs := 0;
  fFreeJobs := TPasMPThreadSafeStack.Create;
end;

destructor TPasMPJobAllocator.Destroy;
var
  MemoryPoolBucketIndex: TPasMPInt32;
begin
  for MemoryPoolBucketIndex := 0 to fCountMemoryPoolBuckets-1 do
  begin
    TPasMPMemory.FreeAlignedMemory(fMemoryPoolBuckets[MemoryPoolBucketIndex]);
  end;
  SetLength(fMemoryPoolBuckets, 0);
  fFreeJobs.Free;
  inherited Destroy;
end;

procedure TPasMPJobAllocator.AllocateNewBuckets(const NewCountMemoryPoolBuckets: TPasMPInt32);
var
  OldCountMemoryPoolBuckets: TPasMPInt32;
  MemoryPoolBucketIndex: TPasMPInt32;
begin
  OldCountMemoryPoolBuckets := fCountMemoryPoolBuckets;
  fCountMemoryPoolBuckets := TPasMPMath.RoundUpToPowerOfTwo(NewCountMemoryPoolBuckets);
  if OldCountMemoryPoolBuckets<fCountMemoryPoolBuckets then
  begin
    SetLength(fMemoryPoolBuckets, FCountMemoryPoolBuckets);
    for MemoryPoolBucketIndex := OldCountMemoryPoolBuckets to fCountMemoryPoolBuckets-1 do
    begin
      TPasMPMemory.AllocateAlignedMemory(fMemoryPoolBuckets[MemoryPoolBucketIndex], SizeOf(TPasMPJobAllocatorMemoryPoolBucket), SizeOf(TPasMPJob));
    end;
  end
  else
  begin
    fCountMemoryPoolBuckets:=OldCountMemoryPoolBuckets;
  end;
end;

function TPasMPJobAllocator.AllocateJob: PPasMPJob;
var
  JobIndex: TPasMPInt32;
  MemoryPoolBucketIndex: TPasMPInt32;
begin
  Result := fFreeJobs.Pop;
  if not Assigned(result) then
  begin
    JobIndex := fCountAllocatedJobs;
    Inc(fCountAllocatedJobs);
    MemoryPoolBucketIndex := JobIndex shr PasMPAllocatorPoolBucketBits;
    if fCountMemoryPoolBuckets<=MemoryPoolBucketIndex then
    begin
      AllocateNewBuckets(MemoryPoolBucketIndex + 1);
    end;
    Result := @fMemoryPoolBuckets[MemoryPoolBucketIndex]^[JobIndex and PasMPAllocatorPoolBucketMask];
  end;
end;

procedure TPasMPJobAllocator.FreeJobs;
begin
  fCountAllocatedJobs := 0;
  fFreeJobs.Clear;
end;

procedure TPasMPJobAllocator.FreeJob(const Job: PPasMPJob);
begin
  fFreeJobs.Push(Job);
  Job^.InternalData := 0;
end;

constructor TPasMPWorkerSystemThread.Create(const AJobWorkerThread: TPasMPJobWorkerThread);
begin
  fJobWorkerThread := AJobWorkerThread;
  if AJobWorkerThread.fPasMPInstance.fWorkerThreadStackSize > 0 then
  begin
    inherited Create(false, AJobWorkerThread.fPasMPInstance.fWorkerThreadStackSize);
  end
  else
  begin
    inherited Create(false);
  end;
{$IFDEF HasRealTThreadPriority}
  Priority:=AJobWorkerThread.fPasMPInstance.fWorkerThreadPriority;
{$ENDIF}
end;

destructor TPasMPWorkerSystemThread.Destroy;
begin
  inherited Destroy;
end;

procedure TPasMPWorkerSystemThread.Execute;
begin
{$IFDEF HAS_NAMETHREADFORDEBUGGING}
  NameThreadForDebugging('TPasMPWorkerSystemThread');
{$ENDIF}
  ReturnValue := 0;
{$IFDEF HasRealTThreadPriority}
  Priority := fJobWorkerThread.fPasMPInstance.fWorkerThreadPriority;
{$ENDIF}
  fJobWorkerThread.ThreadProc;
  ReturnValue := 1;
end;

constructor TPasMPJobQueue.Create(const APasMPInstance: TPasMP);
begin
  inherited Create;
  fPasMPInstance := APasMPInstance;
  fQueueLockState := 0;
  fQueueSize := TPasMPMath.RoundUpToPowerOfTwo(PasMPJobQueueStartSize);
  fQueueMask := fQueueSize - 1;
  SetLength(fQueueJobs, FQueueSize);
  fQueueBottom := 0;
  fQueueTop := 0;
end;

destructor TPasMPJobQueue.Destroy;
begin
  SetLength(fQueueJobs, 0);
  inherited Destroy;
end;

function TPasMPJobQueue.HasJobs: Boolean;
begin
  Result := fQueueBottom>fQueueTop;
end;

procedure TPasMPJobQueue.Resize(const QueueBottom, QueueTop: TPasMPInt32);
var
  QueueLockState: TPasMPInt32;
  OldMask: TPasMPInt32;
  index: TPasMPInt32;
  NewJobs: TPasMPJobQueueJobs;
begin
  NewJobs := nil;
  begin
    // Acquire single-writer-side of lock
    repeat
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
      TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
      TPasMPMemoryBarrier.Read;
{$IFEND}
      QueueLockState := fQueueLockState and TPasMPInt32(TPasMPUInt32($fffffffe));
      if TPasMPInterlocked.CompareExchange(fQueueLockState, QueueLockState or 1, QueueLockState) = QueueLockState then
      begin
        Break;
      end
      else
      begin
        TPasMP.Relax;
      end;
    until False;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    while fQueueLockState <> 1 do
    begin
      TPasMP.Yield;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
      TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
      TPasMPMemoryBarrier.Read;
{$IFEND}
    end;
  end;
  try
    OldMask := fQueueMask;
    Inc(fQueueSize, FQueueSize);
    fQueueMask := fQueueSize - 1;
    SetLength(NewJobs, FQueueSize);
    for Index := QueueTop to QueueBottom do
    begin
      NewJobs[Index and fQueueMask] := fQueueJobs[Index and OldMask];
    end;
    SetLength(fQueueJobs, 0);
    fQueueJobs := NewJobs;
    NewJobs := nil;
{$IFDEF CPU386}
    asm
      mfence
    end;
{$ELSE}
    TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
  finally
    // Release single-writer-side of lock
    TPasMPInterlocked.Exchange(fQueueLockState, 0);
  end;
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.Write;
{$IFEND}
end;

procedure TPasMPJobQueue.PushJob(const pJob: PPasMPJob);
var
  QueueBottom: TPasMPInt32;
  QueueTop: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  QueueBottom := fQueueBottom;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  QueueTop := fQueueTop;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  if (QueueBottom-QueueTop)>(fQueueSize-1) then
  begin
    // Full queue => non-lock-free resize
    Resize(QueueBottom, QueueTop);
  end;
  fQueueJobs[QueueBottom and fQueueMask] := pJob;
{$IFDEF CPU386}
  asm
    mfence
  end;
{$ELSE}
{$IFDEF CPUx86_64}
  TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
{$ENDIF}
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  fQueueBottom:=QueueBottom + 1;
{$ELSE}
  TPasMPInterlocked.Exchange(fQueueBottom, QueueBottom + 1);
{$IFEND}
end;

function TPasMPJobQueue.PopJob: PPasMPJob;
var
  QueueBottom: TPasMPInt32;
  QueueTop: TPasMPInt32;
begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  QueueBottom := fQueueBottom - 1;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
  TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
  TPasMPMemoryBarrier.Read;
{$IFEND}
  TPasMPInterlocked.Exchange(fQueueBottom, QueueBottom);
{$IFDEF CPU386}
  asm
    mfence
  end;
{$ELSE}
  TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
  QueueTop := fQueueTop;
  if QueueTop <= QueueBottom then
  begin
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    Result := Pointer(fQueueJobs[QueueBottom and fQueueMask]);
    if QueueTop = QueueBottom then
    begin
      if TPasMPInterlocked.CompareExchange(fQueueTop, QueueTop+1, QueueTop) <> QueueTop then
      begin
        // Failed race against steal operation
        Result := nil;
      end;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
      fQueueBottom := QueueTop + 1;
{$ELSE}
      TPasMPInterlocked.Exchange(fQueueBottom, QueueTop + 1);
{$IFEND}
    end
    else
    begin
      // There's still more than one item left in the queue
    end;
  end
  else
  begin
  // Deque was already empty
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
    fQueueBottom := QueueTop;
{$ELSE}
    TPasMPInterlocked.Exchange(fQueueBottom, QueueTop);
{$IFEND}
    Result := nil;
  end;
end;

function TPasMPJobQueue.StealJob: PPasMPJob;
var
  QueueTop: TPasMPInt32;
  QueueBottom: TPasMPInt32;
  QueueLockState: TPasMPInt32;
begin
  Result := nil;

  // Try to acquire multiple-reader-side of lock
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
  TPasMPMemoryBarrier.Read;
{$IFEND}

  QueueLockState := fQueueLockState and TPasMPInt32(TPasMPUInt32($fffffffe));
  if TPasMPInterlocked.CompareExchange(fQueueLockState, QueueLockState+2, QueueLockState) = QueueLockState then
  begin

    begin
{$IF not (DEFINED(CPU386) or DEFINED(CPUx86_64))}
      TPasMPMemoryBarrier.Read;
{$IFEND}
      QueueTop := fQueueTop;
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
      TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
      TPasMPMemoryBarrier.Read;
{$IFEND}
      QueueBottom := fQueueBottom;
      if QueueTop<QueueBottom then
      begin
        // Non-empty queue.
{$IF DEFINED(CPU386) or DEFINED(CPUx86_64)}
        TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
        TPasMPMemoryBarrier.Read;
{$IFEND}
        Result := fQueueJobs[QueueTop and fQueueMask];
        if TPasMPInterlocked.CompareExchange(fQueueTop, QueueTop+1, QueueTop) <> QueueTop then
        begin
          // Failed race against steal operation
          Result := nil;
        end;
      end;
    end;

    begin
     // Release multiple-reader-side of lock
     TPasMPInterlocked.Add(fQueueLockState,-2);
    end;
  end;
end;

constructor TPasMPJobWorkerThread.Create(const APasMPInstance: TPasMP; const AThreadIndex: TPasMPInt32; const aCPUAffinityMask: TPasMPUInt64);
var JobQueueIndex: TPasMPInt32;
begin
 inherited Create;
 fPasMPInstance:=APasMPInstance;
 fCPUAffinityMask := aCPUAffinityMask;
 fJobAllocator := TPasMPJobAllocator.Create(self);
 for JobQueueIndex := low(TPasMPJobQueues) to high(TPasMPJobQueues) do begin
  fJobQueues[JobQueueIndex] := TPasMPJobQueue.Create(fPasMPInstance);
 end;
 fJobQueuesUsedBitmap := 0;
 fMaxPriorityJobQueueIndex := PasMPJobQueuePriorityHigh;
 fIsReadyEvent := TPasMPEvent.Create(nil, False, False,'');
 fThreadIndex := AThreadIndex;
 fCurrentJobPriority := PasMPJobPriorityNormal;
 fDepth := 0;
 fAreaMask := 0;
 fXorShift32:=(TPasMPUInt32(AThreadIndex + 1)*83492791) or 1;
 if (fThreadIndex > 0) or fPasMPInstance.fAllWorkerThreadsHaveOwnSystemThreads then begin
  fSystemThread := TPasMPWorkerSystemThread.Create(self);
 end else begin
  fSystemThread := nil;
  ThreadInitialization;
 end;
end;

destructor TPasMPJobWorkerThread.Destroy;
var JobQueueIndex: TPasMPInt32;
begin
 if Assigned(fSystemThread) then begin
  fSystemThread.Terminate;
  fPasMPInstance.WakeUpAll;
  fSystemThread.WaitFor;
  fSystemThread.Free;
 end;
 fIsReadyEvent.Free;
 for JobQueueIndex := low(TPasMPJobQueues) to high(TPasMPJobQueues) do begin
  fJobQueues[JobQueueIndex].Free;
 end;
 fJobAllocator.Free;
 inherited Destroy;
end;

procedure TPasMPJobWorkerThread.ThreadInitialization;
var ThreadIDHash: TPasMPUInt32;
    HashJobWorkerThread: TPasMPJobWorkerThread;
{$IFDEF Windows}
    CurrentThreadHandle:THANDLE;
{$ELSE}
{$IFDEF Linux}
    CPUSet: TPasMPInt64;
{$ENDIF}
{$ENDIF}
begin

{$IFDEF PasMPHaveFPUControls}
 SetExceptionMask(fPasMPInstance.fFPUExceptionMask);
 SetPrecisionMode(fPasMPInstance.fFPUPrecisionMode);
 SetRoundMode(fPasMPInstance.fFPURoundingMode);
{$ENDIF}

 if fCPUAffinityMask <> 0 then begin

  if fPasMPInstance.fDoCPUCorePinning then begin
{$IF DEFINED(Windows)}
   CurrentThreadHandle := GetCurrentThread;
 //SetThreadIdealProcessor(CurrentThreadHandle, FPasMPInstance.fAvailableCPUCores[fThreadIndex]);
   SetThreadAffinityMask(CurrentThreadHandle, FCPUAffinityMask);
{$ELSEIF DEFINED(Linux)}
   CPUSet := TPasMPInt64(fCPUAffinityMask);
   sched_setaffinity(GetThreadID, SizeOf(CPUSet), @CPUSet);
{$IFEND}
  end;

 end else if (Length(fPasMPInstance.fAvailableCPUCores)>1) and
             (fThreadIndex<Length(fPasMPInstance.fAvailableCPUCores)) then begin

{$IF DEFINED(Windows)}
  CurrentThreadHandle := GetCurrentThread;
  if fPasMPInstance.fDoCPUCorePinning then begin
 //SetThreadIdealProcessor(CurrentThreadHandle, FPasMPInstance.fAvailableCPUCores[fThreadIndex]);
   SetThreadAffinityMask(CurrentThreadHandle, TPasMPUInt32(1) shl fPasMPInstance.fAvailableCPUCores[fThreadIndex]);
  end;
{$ELSEIF DEFINED(Linux)}
  if fPasMPInstance.fDoCPUCorePinning then begin
   CPUSet := TPasMPInt64(1) shl fPasMPInstance.fAvailableCPUCores[fThreadIndex];
   sched_setaffinity(GetThreadID, SizeOf(CPUSet), @CPUSet);
  end;
{$IFEND}

 end;

{$IFDEF UseThreadLocalStorage}

{$IF DEFINED(UseThreadLocalStorageX8632) or DEFINED(UseThreadLocalStorageX8664)}
 TLSSetValue(CurrentJobWorkerThreadTLSIndex, Self);
{$ELSE}
 CurrentJobWorkerThread:=self;
{$IFEND}

{$ELSE}

{$IF (DEFINED(NEXTGEN) or not DEFINED(Windows)) and not DEFINED(FPC)}
 fThreadID := TThread.CurrentThread.ThreadID;
{$ELSE}
 fThreadID := GetCurrentThreadID;
{$IFEND}
 ThreadIDHash := TPasMP.GetThreadIDHash(fThreadID);

 fPasMPInstance.fJobWorkerThreadHashTableCriticalSection.Acquire;
 try
  HashJobWorkerThread := fPasMPInstance.fJobWorkerThreadHashTable[ThreadIDHash and PasMPJobWorkerThreadHashTableMask];
  if Assigned(HashJobWorkerThread) then begin
   HashJobWorkerThread.fNext:=self;
  end;
  fNext := nil;
  fPasMPInstance.fJobWorkerThreadHashTable[ThreadIDHash and PasMPJobWorkerThreadHashTableMask] := self;
 finally
  fPasMPInstance.fJobWorkerThreadHashTableCriticalSection.Release;
 end;
{$ENDIF}

 fIsReadyEvent.SetEvent;

end;

{//$DEFINE AlternativeGetJobVariant}
{$IFDEF AlternativeGetJobVariant}
// A prioritized GetJob implementation variant, which is based on the paper "Load Balancing Prioritized Tasks via Work-Stealing"
// by Shams Imam and Vivek Sarkar
// Optimized here by me (Benjamin Rosseaux) by replacing the Boolean-arrays with uint32-variables for more effective atomic
// operations and better faster bit scan possibilities for to find the next active priority index, for example with the BSF and
// BSR machine instructions on the x86 CPU architecture
function TPasMPJobWorkerThread.GetJob: PPasMPJob;
var
  FoundPriorityIndex: TPasMPInt32;
  JobQueuePriorityIndex: TPasMPInt32;
  OtherJobWorkerThreadIndex: TPasMPInt32;
  OtherJobWorkerThreadCounter: TPasMPInt32;
  XorShiftTemp: TPasMPUInt32;
  PriorityJobQueueBitMask: TPasMPUInt32;
  CurrentBitmap: TPasMPUInt32;
  OtherJobWorkerThread: TPasMPJobWorkerThread;
begin

 // First search for highest priority job
 if (fJobQueuesUsedBitmap and TPasMPUInt32(TPasMPUInt32(1) shl PasMPJobQueuePriorityHigh)) <> 0 then
 begin
  // Our local bitmap claim we have a job with highest priority!
  Result := fJobQueues[PasMPJobQueuePriorityHigh].PopJob;
  if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then
  begin
   // Found a local job to execute with highest priority
   fMaxPriorityJobQueueIndex := PasMPJobQueuePriorityHigh;
   Exit;
  end
  else
  begin
   fJobQueuesUsedBitmap := fJobQueuesUsedBitmap and not TPasMPUInt32(TPasMPUInt32(1) shl PasMPJobQueuePriorityHigh);
  end;
 end;

 // Ensure we don't have any local job with a higher priority (in case global state is out of sync)
 CurrentBitmap := fPasMPInstance.fGlobalJobQueuesUsedBitmap;
 if CurrentBitmap=0 then
 begin
  FoundPriorityIndex := 0;
 end else begin
  FoundPriorityIndex := TPasMPMath.BitScanForward32(CurrentBitmap);
 end;
 for JobQueuePriorityIndex := fMaxPriorityJobQueueIndex to FoundPriorityIndex-1 do
 begin
  PriorityJobQueueBitMask := TPasMPUInt32(1) shl TPasMPUInt32(JobQueuePriorityIndex);
  if (fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
   // Our local bitmap claim we have a job with higher priority!
   Result := fJobQueues[JobQueuePriorityIndex].PopJob;
   if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then
   begin
    if fJobQueues[JobQueuePriorityIndex].HasJobs then begin
     TPasMPInterlocked.BitwiseOr(fPasMPInstance.fGlobalJobQueuesUsedBitmap, PriorityJobQueueBitMask);
     fMaxPriorityJobQueueIndex := PasMPJobQueuePriorityHigh;
    end else begin
     fJobQueuesUsedBitmap := fJobQueuesUsedBitmap and not PriorityJobQueueBitMask;
    end;
    Exit;
   end else begin
    fJobQueuesUsedBitmap := fJobQueuesUsedBitmap and not PriorityJobQueueBitMask;
   end;
  end;
 end;

 // Exhaustively search local and global pools, attempting steals
 JobQueuePriorityIndex := FoundPriorityIndex;
 while JobQueuePriorityIndex<=PasMPJobQueuePriorityLast do begin

  PriorityJobQueueBitMask := TPasMPUInt32(1) shl TPasMPUInt32(JobQueuePriorityIndex);

  if (fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
   // Our local bitmap claim we have a job
   Result := fJobQueues[JobQueuePriorityIndex].PopJob;
   if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
    // Found a local job to execute
    fMaxPriorityJobQueueIndex := JobQueuePriorityIndex;
    Exit;
   end;
  end;

  // When it is not a valid job or our own queue is empty, so try stealing from some other queue
  // Find victim index and try to steal from there
  XorShiftTemp := fXorShift32;
  XorShiftTemp := XorShiftTemp xor (XorShiftTemp shl 13);
  XorShiftTemp := XorShiftTemp xor (XorShiftTemp shr 17);
  XorShiftTemp := XorShiftTemp xor (XorShiftTemp shl 5);
  fXorShift32:=XorShiftTemp;
  OtherJobWorkerThreadIndex := ((XorShiftTemp shr 16)*TPasMPUInt32(fPasMPInstance.fCountJobWorkerThreads)) shr 16;
  for OtherJobWorkerThreadCounter := 0 to fPasMPInstance.fCountJobWorkerThreads-1 do begin
   OtherJobWorkerThread := fPasMPInstance.fJobWorkerThreads[OtherJobWorkerThreadIndex];
   if (OtherJobWorkerThread<>self) and
      ((OtherJobWorkerThread.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0) then begin
    // The victim bitmap claim we have a job
    Result := OtherJobWorkerThread.fJobQueues[JobQueuePriorityIndex].StealJob;
    if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
     // Found a stolen job to execute
     Exit;
    end;
   end;
   Inc(OtherJobWorkerThreadIndex);
   if OtherJobWorkerThreadIndex >= fPasMPInstance.fCountJobWorkerThreads then begin
    OtherJobWorkerThreadIndex := 0;
   end;
  end;

  // Otherwise try stealing from the global queue
  if (fPasMPInstance.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
   fPasMPInstance.fJobQueuesLock.Acquire;
   try
{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}
    TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
    TPasMPMemoryBarrier.Read;
{$IFEND}
    if (fPasMPInstance.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
     // The global bitmap claim we have a job
     Result := fPasMPInstance.fJobQueues[JobQueuePriorityIndex].StealJob;
     if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
      // Found a stolen global job to execute
      Exit;
     end else begin
      fPasMPInstance.fJobQueuesUsedBitmap := fPasMPInstance.fJobQueuesUsedBitmap and not PriorityJobQueueBitMask;
      TPasMPMemoryBarrier.ReadWrite;
     end;
    end;
   finally
    fPasMPInstance.fJobQueuesLock.Release;
   end;
  end;

  // No job with specified priority found, attempt to update global state
  TPasMPInterlocked.BitWiseAnd(fPasMPInstance.fGlobalJobQueuesUsedBitmap,not PriorityJobQueueBitMask);

  // Try and search for task with next available priority
  CurrentBitmap := fPasMPInstance.fGlobalJobQueuesUsedBitmap and not ((PriorityJobQueueBitMask shl 1)-1);
  if CurrentBitmap=0 then begin
   Inc(JobQueuePriorityIndex);
  end else begin
   JobQueuePriorityIndex := TPasMPMath.BitScanForward32(CurrentBitmap);
  end;

 end;

 Result := nil;
end;
{$ELSE}
// A prioritized GetJob implementation variant, which is based completety on my own ideas, which is better structured,
// easier to understand and more pretty than the implementation above, in my opinion.
function TPasMPJobWorkerThread.GetJob: PPasMPJob;
var JobQueuePriorityIndex,OtherJobWorkerThreadIndex,OtherJobWorkerThreadCounter: TPasMPInt32;
    XorShiftTemp, PriorityJobQueueBitMask, CurrentBitmap: TPasMPUInt32;
    OtherJobWorkerThread: TPasMPJobWorkerThread;
    FirstTry: Boolean;
begin

{$IF not (DEFINED(cpu386) or DEFINED(cpux86_64))}
 TPasMPMemoryBarrier.ReadWrite;
{$IFEND}
 CurrentBitmap := fPasMPInstance.fGlobalJobQueuesUsedBitmap;
{$IF not (DEFINED(cpu386) or DEFINED(cpux86_64))}
 TPasMPMemoryBarrier.Read;
{$IFEND}

 FirstTry := True;

 repeat

  // Ensure that the local bitmap content is inside the global bitmap content
  if (CurrentBitmap and fJobQueuesUsedBitmap)<>fJobQueuesUsedBitmap then begin
   CurrentBitmap := TPasMPInterlocked.ExchangeBitWiseOr(fPasMPInstance.fGlobalJobQueuesUsedBitmap, FJobQueuesUsedBitmap) or fJobQueuesUsedBitmap;
  end;

  while CurrentBitmap <> 0 do begin

   JobQueuePriorityIndex := TPasMPMath.BitScanForward32(CurrentBitmap);

   PriorityJobQueueBitMask := TPasMPUInt32(1) shl TPasMPUInt32(JobQueuePriorityIndex);

   // Try getting a job from our own queue first
   if (fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
    Result := fJobQueues[JobQueuePriorityIndex].PopJob;
    if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
     Exit;
    end else begin
     fJobQueuesUsedBitmap := fJobQueuesUsedBitmap and not PriorityJobQueueBitMask;
    end;
   end;

   // When it is not a valid job or our own queue is empty, so try stealing from some other queue
   XorShiftTemp := fXorShift32;
   XorShiftTemp := XorShiftTemp xor (XorShiftTemp shl 13);
   XorShiftTemp := XorShiftTemp xor (XorShiftTemp shr 17);
   XorShiftTemp := XorShiftTemp xor (XorShiftTemp shl 5);
   fXorShift32:=XorShiftTemp;
   OtherJobWorkerThreadIndex := ((XorShiftTemp shr 16)*TPasMPUInt32(fPasMPInstance.fCountJobWorkerThreads)) shr 16;
   for OtherJobWorkerThreadCounter := 0 to fPasMPInstance.fCountJobWorkerThreads-1 do begin
    OtherJobWorkerThread := fPasMPInstance.fJobWorkerThreads[OtherJobWorkerThreadIndex];
    if (OtherJobWorkerThread<>self) and
       ((OtherJobWorkerThread.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0) then begin
     Result := OtherJobWorkerThread.fJobQueues[JobQueuePriorityIndex].StealJob;
     if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
      Exit;
     end;
    end;
    Inc(OtherJobWorkerThreadIndex);
    if OtherJobWorkerThreadIndex >= fPasMPInstance.fCountJobWorkerThreads then begin
     OtherJobWorkerThreadIndex := 0;
    end;
   end;

   // Otherwise try stealing from the global queue
   if (fPasMPInstance.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
    fPasMPInstance.fJobQueuesLock.Acquire;
    try
{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}
     TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
     TPasMPMemoryBarrier.Read;
{$IFEND}
     if (fPasMPInstance.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) <> 0 then begin
      Result := fPasMPInstance.fJobQueues[JobQueuePriorityIndex].StealJob;
      if Assigned(Result) and ((Result^.InternalData and PasMPJobFlagActive) <> 0) then begin
       // Yay, we've stolen a job!
       Exit;
      end else begin
       fPasMPInstance.fJobQueuesUsedBitmap := fPasMPInstance.fJobQueuesUsedBitmap and not PriorityJobQueueBitMask;
       TPasMPMemoryBarrier.ReadWrite;
      end;
     end;
    finally
     fPasMPInstance.fJobQueuesLock.Release;
    end;
   end;

   // Update the global used priority queue bit mask to signal no jobs of the specified priority were available
   TPasMPInterlocked.BitWiseAnd(fPasMPInstance.fGlobalJobQueuesUsedBitmap,not PriorityJobQueueBitMask);

   // Mask out first set bit
   CurrentBitmap:=CurrentBitmap and (CurrentBitmap-1);

  end;

  // We now realize that the global used priority queue bit mask is out of sync as none of the victims including ourself could provide a job,
  // so we should update the global used priority queue bit mask with our local used priority queue bit mask and so on
  if FirstTry then begin
   FirstTry := False;
   CurrentBitmap := fJobQueuesUsedBitmap or fPasMPInstance.fJobQueuesUsedBitmap;
   CurrentBitmap := TPasMPInterlocked.ExchangeBitWiseOr(fPasMPInstance.fGlobalJobQueuesUsedBitmap, CurrentBitmap) or CurrentBitmap;
   if CurrentBitmap <> 0 then begin
    // Time for a second try
    Continue;
   end;
  end;

  // Otherwise, when everything had no success, we should give up
  Break;

 until False;

 Result := nil;

end;
{$ENDIF}

function TPasMPJobWorkerThread.HasJobs: Boolean;
begin
 Result := fJobQueues[PasMPJobQueuePriorityHigh].HasJobs or
         fJobQueues[PasMPJobQueuePriorityNormal].HasJobs or
         fJobQueues[PasMPJobQueuePriorityLow].HasJobs;
end;

procedure TPasMPJobWorkerThread.ThreadProc;
var SpinCount, CountMaxSpinCount: TPasMPInt32;
    Job: PPasMPJob;
begin
 try
  ThreadInitialization;
  fPasMPInstance.fSystemIsReadyEvent.WaitFor(INFINITE);
  fPasMPInstance.WaitForWakeUp;
  SpinCount := 0;
  CountMaxSpinCount := 128;
  while not fSystemThread.Terminated do begin
   Job := GetJob;
   if Assigned(Job) then begin
    TPasMPInterlocked.Increment(fPasMPInstance.fWorkingJobWorkerThreads);
    fPasMPInstance.ExecuteJob(Job, Self);
    TPasMPInterlocked.Decrement(fPasMPInstance.fWorkingJobWorkerThreads);
    SpinCount := 0;
   end else begin
    if SpinCount<CountMaxSpinCount then begin
     Inc(SpinCount);
    end else begin
     fPasMPInstance.WaitForWakeUp;
     SpinCount := 0;
    end;
   end;
  end;
 except
  on e:Exception do begin
   if Assigned(fPasMPInstance.fOnWorkerThreadException) then begin
    if not fPasMPInstance.fOnWorkerThreadException(e) then begin
     raise;
    end;
   end else begin
    raise;
   end;
  end;
 end;
end;

constructor TPasMPScope.Create(const APasMPInstance: TPasMP);
begin
 inherited Create;
 fPasMPInstance:=APasMPInstance;
 fWaitCalled := False;
 fJobs := nil;
 fCountJobs := 0;
end;

destructor TPasMPScope.Destroy;
begin
 if not fWaitCalled then begin
  Wait;
 end;
 fPasMPInstance.Release(fJobs);
 SetLength(fJobs, 0);
 inherited Destroy;
end;

procedure TPasMPScope.Run(const Job: PPasMPJob);
begin
 fPasMPInstance.Run(Job);
 if Length(fJobs)<=(fCountJobs + 1) then begin
  SetLength(fJobs, (fCountJobs + 1)*2);
 end;
 fJobs[fCountJobs] := Job;
 Inc(fCountJobs);
end;

procedure TPasMPScope.Run(const Jobs: array of PPasMPJob);
var Count: TPasMPInt32;
begin
 fPasMPInstance.Run(Jobs);
 Count := Length(Jobs);
 if Count > 0 then begin
  if Length(fJobs)<=(fCountJobs+Count) then begin
   SetLength(fJobs, (fCountJobs+Count)*2);
  end;
  Move(Jobs[0], FJobs[fCountJobs], Count * SizeOf(PPasMPJob));
  Inc(fCountJobs, Count);
 end;
end;

procedure TPasMPScope.Run(const JobTask: TPasMPJobTask);
begin
 Run(fPasMPInstance.Acquire(JobTask));
end;

procedure TPasMPScope.Run(const JobTasks: array of TPasMPJobTask);
var Index: TPasMPInt32;
begin
  for Index := 0 to Length(JobTasks)-1 do begin
    Run(fPasMPInstance.Acquire(JobTasks[Index]));
  end;
end;

procedure TPasMPScope.Wait;
begin
  fWaitCalled := True;
  if fCountJobs > 0 then begin
    SetLength(fJobs, FCountJobs);
    fPasMPInstance.Wait(fJobs);
  end;
end;

constructor TPasMPProfiler.Create(const pPasMPInstance: TPasMP);
begin
  inherited Create;
  fPointerToHistory:=@fHistory;
  fPasMPInstance := PPasMPInstance;
  fHighResolutionTimer := TPasMPHighResolutionTimer.Create;
  Reset;
end;

destructor TPasMPProfiler.Destroy;
begin
  fHighResolutionTimer.Free;
  inherited Destroy;
end;

function TPasMPProfiler.GetHistoryRingBufferItem(const pIndex: TPasMPUInt32): PPasMPProfilerHistoryRingBufferItem;
begin
  Result := @fHistory[pIndex and PasMPProfilerHistoryRingBufferSizeMask];
end;

procedure TPasMPProfiler.Sort;
type
  PItem = ^TItem;
  TItem=TPasMPProfilerHistoryRingBufferItem;
  PItemArray = ^TItemArray;
  TItemArray = array of TItem;
  PStackItem = ^TStackItem;
  TStackItem = record
    Left: TPasMPInt32;
    Right: TPasMPInt32;
    Depth: TPasMPInt32;
  end;

  function Compare(const a, B: TPasMPProfilerHistoryRingBufferItem): TPasMPInt32;
  begin
    if a.StartTime<b.StartTime then
    begin
     Result :=  - 1;
    end
    else if a.StartTime>b.StartTime then
    begin
     Result := 1;
    end
    else if a.EndTime<b.EndTime then
    begin
     Result :=  - 1;
    end
    else if a.EndTime>b.EndTime then
    begin
     Result := 1;
    end
    else
    begin
     Result := 0;
    end;
  end;

var
  Left, Right,Depth, i,j, Middle, Size, Parent, Child, Pivot, iA, iB, iC: TPasMPInt32;
  StackItem: PStackItem;
  Stack: array [0..31] of TStackItem;
  Temp: TPasMPProfilerHistoryRingBufferItem;
begin
 if fCount > 0 then begin
  StackItem:=@Stack[0];
  StackItem^.Left := 0;
  StackItem^.Right := Min(fCount-1, PasMPProfilerHistoryRingBufferSizeMask);
  StackItem^.Depth := TPasMPMath.BitScanReverse32(StackItem^.Right + 1) shl 1;
  Inc(StackItem);
  while TPasMPPtrUInt(Pointer(StackItem))>TPasMPPtrUInt(Pointer(@Stack[0])) do begin
   Dec(StackItem);
   Left := StackItem^.Left;
   Right := StackItem^.Right;
   Depth := StackItem^.Depth;
   Size := (Right-Left) + 1;
   if Size < 16 then begin
    // Insertion sort
    iA := Left;
    iB := iA + 1;
    while iB <= Right do begin
     iC := iB;
     while (iA >= Left) and
           (iC >= Left) and
           (Compare(fHistory[iA], FHistory[iC]) > 0) do begin
      Temp := fHistory[iA];
      fHistory[iA] := fHistory[iC];
      fHistory[iC] := Temp;
      Dec(iA);
      Dec(iC);
     end;
     iA := iB;
     Inc(iB);
    end;
   end else begin
    if (Depth = 0) or (TPasMPPtrUInt(Pointer(StackItem))>=TPasMPPtrUInt(Pointer(@Stack[high(Stack)-1]))) then begin
     // Heap sort
     i := Size div 2;
     repeat
      if i > 0 then begin
       Dec(i);
      end else begin
       Dec(Size);
       if Size > 0 then begin
        Temp := fHistory[Left+Size];
        fHistory[Left+Size] := fHistory[Left];
        fHistory[Left] := Temp;
       end else begin
        Break;
       end;
      end;
      Parent := i;
      repeat
       Child := (Parent*2) + 1;
       if Child < Size then begin
        if (Child<(Size-1)) and (Compare(fHistory[Left+Child], FHistory[Left+Child+1]) < 0) then begin
         Inc(Child);
        end;
        if Compare(fHistory[Left+Parent], FHistory[Left+Child]) < 0 then begin
         Temp := fHistory[Left+Parent];
         fHistory[Left+Parent] := fHistory[Left+Child];
         fHistory[Left+Child] := Temp;
         Parent := Child;
         Continue;
        end;
       end;
       Break;
      until False;
     until False;
    end else begin
     // Quick sort width median-of-three optimization
     Middle := Left + ((Right-Left) shr 1);
     if (Right-Left)>3 then begin
      if Compare(fHistory[Left], FHistory[Middle]) > 0 then begin
       Temp := fHistory[Left];
       fHistory[Left] := fHistory[Middle];
       fHistory[Middle] := Temp;
      end;
      if Compare(fHistory[Left], FHistory[Right]) > 0 then begin
       Temp := fHistory[Left];
       fHistory[Left] := fHistory[Right];
       fHistory[Right] := Temp;
      end;
      if Compare(fHistory[Middle], FHistory[Right]) > 0 then begin
       Temp := fHistory[Middle];
       fHistory[Middle] := fHistory[Right];
       fHistory[Right] := Temp;
      end;
     end;
     Pivot := Middle;
     i := Left;
     j := Right;
     repeat
      while (i < Right) and (Compare(fHistory[i], FHistory[Pivot]) < 0) do begin
       Inc(i);
      end;
      while (j >= i) and (Compare(fHistory[j], FHistory[Pivot]) > 0) do begin
       Dec(j);
      end;
      if i>j then begin
       Break;
      end else begin
       if i<>j then begin
        Temp := fHistory[i];
        fHistory[i] := fHistory[j];
        fHistory[j] := Temp;
        if Pivot=i then begin
         Pivot:=j;
        end else if Pivot=j then begin
         Pivot := i;
        end;
       end;
       Inc(i);
       Dec(j);
      end;
     until False;
     if i < Right then begin
      StackItem^.Left := i;
      StackItem^.Right := Right;
      StackItem^.Depth := Depth - 1;
      Inc(StackItem);
     end;
     if Left<j then begin
      StackItem^.Left := Left;
      StackItem^.Right := j;
      StackItem^.Depth := Depth - 1;
      Inc(StackItem);
     end;
    end;
   end;
  end;
 end;
end;

procedure TPasMPProfiler.Reset;
begin
  fCount := 0;
  fStartTime := HighResolutionTimer.GetTime;
  fLastTime := 0;
  fOffsetTime := fLastTime -  fStartTime;
end;

procedure TPasMPProfiler.Start(const SuppressGaps: Boolean = True);
begin
  if SuppressGaps then begin
    fStartTime := HighResolutionTimer.GetTime;
    fOffsetTime := fLastTime - fStartTime;
  end;
end;

procedure TPasMPProfiler.Stop(const MaximalTimePeriodToKeep: TPasMPHighResolutionTime=-1);
var Index, Counter: TPasMPInt32;
begin
 if fCount > 0 then begin
  Sort;
  if fCount>PasMPProfilerHistoryRingBufferSize then begin
   fCount := PasMPProfilerHistoryRingBufferSize;
  end;
  fLastTime := fHistory[(fCount-1) and PasMPProfilerHistoryRingBufferSizeMask].EndTime;
  if MaximalTimePeriodToKeep>=0 then begin
   Counter := 0;
   for Index := 0 to fCount-1 do begin
    if (fHistory[Index].StartTime<=fLastTime) and ((fLastTime-MaximalTimePeriodToKeep)<=fHistory[Index].EndTime) then begin
     if Index<>Counter then begin
      Move(fHistory[Index], FHistory[Counter], TPasMPPtrUInt(Pointer(@PPasMPProfilerHistoryRingBufferItem(nil)^.Dummy)));
     end;
     Inc(Counter);
    end;
   end;
   fCount := Counter;
  end;
 end else begin
  fLastTime := 0;
 end;
end;

function TPasMPProfiler.Acquire: PPasMPProfilerHistoryRingBufferItem;
begin
 Result := @fHistory[TPasMPUInt32(TPasMPInterlocked.Increment(TPasMPInt32(fCount))-1) and PasMPProfilerHistoryRingBufferSizeMask];
end;

constructor TPasMP.Create(const CountThreads: TPasMPInt32;
                          const MinimumCountThreads: TPasMPInt32;
                          const MaximumCountThreads: TPasMPInt32;
                          const ThreadHeadRoomForForeignTasks: TPasMPInt32;
                          const DoCPUCorePinning: Boolean;
                          const SleepingOnIdle: Boolean;
                          const AllWorkerThreadsHaveOwnSystemThreads: Boolean;
                          const Profiling: Boolean;
                          const WorkerThreadPriority: TThreadPriority;
                          const WorkerThreadStackSize: TPasMPSizeUInt;
                          const WorkerThreadMaxDepth: TPasMPUInt32);
var Index, CPUCoreIndex: TPasMPInt32;
    CPUAffinityMasks: TPasMPUInt64DynamicArray;
begin
 inherited Create;

{$IFDEF PasMPHaveFPUControls}
 fFPUExceptionMask := GetExceptionMask;
 fFPUPrecisionMode := GetPrecisionMode;
 fFPURoundingMode := GetRoundMode;
{$ENDIF}

 fAvailableCPUCores := nil;

 fDoCPUCorePinning:=DoCPUCorePinning;

 fSleepingOnIdle:=SleepingOnIdle;

 fOnWorkerThreadException := nil;

 fOnCheckJobExecution := nil;

 fRespectJobAvoidAreaMasks := False;

 fAllWorkerThreadsHaveOwnSystemThreads:=AllWorkerThreadsHaveOwnSystemThreads;

 fWorkerThreadPriority:=WorkerThreadPriority;

 fWorkerThreadStackSize := WorkerThreadStackSize;

 fWorkerThreadMaxDepth := WorkerThreadMaxDepth;

 if Profiling then begin
  fProfiler := TPasMPProfiler.Create(self);
 end else begin
  fProfiler := nil;
 end;

{$IFDEF PasMPUseGlobalPasMPCountOfHardwareThreads}
 fCountCPUThreads:=GlobalPasMPCountOfHardwareThreads;
 fAvailableCPUCores:=GlobalPasMPAvailableCPUCores;
{$ELSE}
 fCountCPUThreads := TPasMP.GetCountOfHardwareThreads(fAvailableCPUCores);
{$ENDIF}

 if CountThreads > 0 then begin
  fCountJobWorkerThreads := CountThreads;
 end else begin
  fCountJobWorkerThreads := fCountCPUThreads-ThreadHeadRoomForForeignTasks;
 end;

 if fCountJobWorkerThreads < 1 then begin
  fCountJobWorkerThreads := 1;
 end;
 if (MinimumCountThreads > 0) and (fCountJobWorkerThreads<MinimumCountThreads) then begin
  fCountJobWorkerThreads:=MinimumCountThreads;
 end;
 if (MaximumCountThreads > 0) and (fCountJobWorkerThreads>MaximumCountThreads) then begin
  fCountJobWorkerThreads:=MaximumCountThreads;
 end;
 if fCountJobWorkerThreads>=TPasMPInt32(PasMPJobThreadIndexSize) then begin
  fCountJobWorkerThreads := TPasMPInt32(PasMPJobThreadIndexSize-1);
 end;

 fSleepingJobWorkerThreads := 0;

 fSystemIsReadyEvent := TPasMPEvent.Create(nil, True, False,'');

{$IFDEF PasMPUseWakeUpConditionVariable}
 fWakeUpCounter := 0;
 fWakeUpConditionVariableLock := TPasMPConditionVariableLock.Create;
 fWakeUpConditionVariable := TPasMPConditionVariable.Create;
{$ELSE}
 fWakeUpEvent := TPasMPEvent.Create(nil, True, False,'');
{$ENDIF}

 fJobWorkerThreads := nil;
 SetLength(fJobWorkerThreads, FCountJobWorkerThreads);

 fCriticalSection := TPasMPCriticalSection.Create;

 fJobAllocatorCriticalSection := TPasMPCriticalSection.Create;

 fJobAllocator := TPasMPJobAllocator.Create(nil);

 for Index := low(TPasMPJobQueues) to high(TPasMPJobQueues) do begin
  fJobQueues[Index] := TPasMPJobQueue.Create(self);
 end;

 fJobQueuesUsedBitmap := 0;

 fJobQueuesLock := TPasMPSlimReaderWriterLock.Create;

 fGlobalJobQueuesUsedBitmap := 0;

{$IFNDEF UseThreadLocalStorage}
 fJobWorkerThreadHashTableCriticalSection := TPasMPCriticalSection.Create;

 FillChar(fJobWorkerThreadHashTable, SizeOf(TPasMPJobWorkerThreadHashTable),#0);
{$ENDIF}

 CPUAffinityMasks := nil;
 try

  // Spread the worker threads over the available CPU cores for better cache locality
  SetLength(CPUAffinityMasks, FCountJobWorkerThreads);
  FillChar(CPUAffinityMasks[0], SizeOf(TPasMPUInt64)*fCountJobWorkerThreads,#0);
  if Length(fAvailableCPUCores) > 0 then begin
   CPUCoreIndex := 0;
   for Index := 0 to fCountJobWorkerThreads-1 do begin
    CPUAffinityMasks[Index] := CPUAffinityMasks[Index] or (TPasMPUInt64(1) shl fAvailableCPUCores[CPUCoreIndex]);
    Inc(CPUCoreIndex);
    if CPUCoreIndex >= Length(fAvailableCPUCores) then begin
     CPUCoreIndex := 0;
    end;
   end;
  end;

  for Index := 0 to fCountJobWorkerThreads-1 do begin
    fJobWorkerThreads[Index] := TPasMPJobWorkerThread.Create(self, index, CPUAffinityMasks[Index]);
  end;
  for Index := 0 to fCountJobWorkerThreads-1 do begin
    fJobWorkerThreads[Index].fIsReadyEvent.WaitFor(INFINITE);
    FreeAndNil(fJobWorkerThreads[Index].fIsReadyEvent);
  end;
  fSystemIsReadyEvent.SetEvent;

 finally
  CPUAffinityMasks := nil;
 end;

end;

destructor TPasMP.Destroy;
var Index: TPasMPInt32;
    JobWorkerThread: TPasMPJobWorkerThread;
begin
  for Index := 0 to fCountJobWorkerThreads-1 do
  begin
    JobWorkerThread := fJobWorkerThreads[Index];
    if Assigned(JobWorkerThread.fSystemThread) then
    begin
      JobWorkerThread.fSystemThread.Terminate;
    end;
  end;
  WakeUpAll;
  for Index := 0 to fCountJobWorkerThreads-1 do
  begin
    JobWorkerThread := fJobWorkerThreads[Index];
    if Assigned(JobWorkerThread.fSystemThread) then
    begin
      while JobWorkerThread.fSystemThread.ReturnValue = 0 do
      begin
        WakeUpAll;
        TPasMP.Yield;
      end;
      JobWorkerThread.fSystemThread.WaitFor;
    end;
  end;
  for Index := 0 to fCountJobWorkerThreads-1 do
  begin
    JobWorkerThread := fJobWorkerThreads[Index];
    if Assigned(JobWorkerThread.fSystemThread) then
    begin
      FreeAndNil(JobWorkerThread.fSystemThread);
    end;
    JobWorkerThread.Free;
  end;
  SetLength(fJobWorkerThreads, 0);
  SetLength(fAvailableCPUCores, 0);
  for Index := low(TPasMPJobQueues) to high(TPasMPJobQueues) do
  begin
    fJobQueues[Index].Free;
  end;
  fJobQueuesLock.Free;
  fJobAllocator.Free;
  fJobAllocatorCriticalSection.Free;
  fSystemIsReadyEvent.Free;
{$IFDEF PasMPUseWakeUpConditionVariable}
  fWakeUpConditionVariable.Free;
  fWakeUpConditionVariableLock.Free;
{$ELSE}
  fWakeUpEvent.Free;
{$ENDIF}
{$IFNDEF UseThreadLocalStorage}
  fJobWorkerThreadHashTableCriticalSection.Free;
{$ENDIF}
  fProfiler.Free;
  fCriticalSection.Free;
  inherited Destroy;
end;

class function TPasMP.CreateGlobalInstance: TPasMP;
begin
 TPasMPMemoryBarrier.Sync;
 if not Assigned(GlobalPasMP) then begin
  GlobalPasMPCriticalSection.Acquire;
  try
   if not Assigned(GlobalPasMP) then begin
    GlobalPasMP := TPasMP.Create(GlobalPasMPCountThreads,
                               GlobalPasMPMinimumCountThreads,
                               GlobalPasMPMaximumCountThreads,
                               GlobalPasMPThreadHeadRoomForForeignTasks,
                               GlobalPasMPDoCPUCorePinning,
                               GlobalPasMPSleepingOnIdle,
                               GlobalPasMPAllWorkerThreadsHaveOwnSystemThreads,
                               GlobalPasMPProfiling,
                               GlobalPasMPWorkerThreadPriority,
                               GlobalPasMPWorkerThreadStackSize,
                               GlobalPasMPWorkerThreadMaxDepth);
    TPasMPMemoryBarrier.Sync;
   end;
  finally
   GlobalPasMPCriticalSection.Release;
  end;
 end;
 Result := GlobalPasMP;
end;

class procedure TPasMP.DestroyGlobalInstance;
begin
 GlobalPasMPCriticalSection.Acquire;
 try
  FreeAndNil(GlobalPasMP);
 finally
  GlobalPasMPCriticalSection.Release;
 end;
end;

class function TPasMP.GetGlobalInstance: TPasMP;
begin
  if not Assigned(GlobalPasMP) then
  begin
    CreateGlobalInstance;
  end;
  Result := GlobalPasMP;
end;

class function TPasMP.GetCountOfPhysicalCores(out AvailableCPUCores: TPasMPAvailableCPUCores): TPasMPInt32;
{$IF DEFINED(Windows)}
var
  PhysicalCores: TPasMPInt32;
  LogicalCores: TPasMPInt32;
  i: TPasMPInt32;
  //j: TPasMPInt32;
  sinfo: SYSTEM_INFO;
  dwProcessAffinityMask,
  dwSystemAffinityMask: TPasMPPtrUInt;
  CPUProcessorMasks: array of TPasMPPtrUInt;
  CPUFirstLogicalCore: array of TPasMPInt32;

  procedure GetCPUInfo(var PhysicalCores, LogicalCores: TPasMPInt32);
  const
    RelationProcessorCore = 0;
    RelationNumaNode = 1;
    RelationCache = 2;
    RelationProcessorPackage = 3;
    RelationGroup = 4;
    RelationAll = $ffff;
    CacheUnified = 0;
    CacheInstruction = 1;
    CacheData = 2;
    CacheTrace = 3;
  type
    TLogicalProcessorRelationship = TPasMPUInt32;
    TProcessorCacheType = TPasMPUInt32;
    TCacheDescriptor = packed record
      Level: TPasMPUInt8;
      Associativity: TPasMPUInt8;
      LineSize: TPasMPUInt16;
      Size: TPasMPUInt32;
      pcType: TProcessorCacheType;
    end;
    PSystemLogicalProcessorInformation = ^TSystemLogicalProcessorInformation;
    TSystemLogicalProcessorInformation = packed record
      ProcessorMask: TPasMPPtrUInt;
      case Relationship: TLogicalProcessorRelationship of
        0: ( Flags: TPasMPUInt8; );
        1: ( NodeNumber: TPasMPUInt32; );
        2: ( Cache:TCacheDescriptor; );
        3: ( Reserved: array [0..1] of TPasMPInt64; );
      end;
    TGetLogicalProcessorInformation = function(Buffer: PSystemLogicalProcessorInformation; out ReturnLength: TPasMPUInt32): bool; stdcall;
    function CountSetBits(Value: TPasMPPtrUInt): TPasMPInt32;
    begin
      Result := 0;
      while Value <> 0 do
      begin
        Inc(Result);
        Value := Value and (Value-1);
      end;
    end;
  var
    GetLogicalProcessorInformation: TGetLogicalProcessorInformation;
    Buffer: array of TSystemLogicalProcessorInformation;
    ReturnLength: TPasMPUInt32;
    Index: TPasMPInt32;
    Count: TPasMPInt32;
  begin
    Buffer := nil;
    PhysicalCores := 0;
    LogicalCores := 0;
    try
      CPUProcessorMasks := nil;
      CPUFirstLogicalCore := nil;
      GetLogicalProcessorInformation := GetProcAddress(GetModuleHandle('kernel32'),'GetLogicalProcessorInformation');
      if Assigned(GetLogicalProcessorInformation) then
      begin
        SetLength(Buffer,64);
        Count := 0;
        repeat
          ReturnLength := Length(Buffer) * SizeOf(TSystemLogicalProcessorInformation);
          if GetLogicalProcessorInformation(@Buffer[0], ReturnLength) then
          begin
            Count := ReturnLength div SizeOf(TSystemLogicalProcessorInformation);
          end
          else
          begin
            if GetLastError = ERROR_INSUFFICIENT_BUFFER then
            begin
              SetLength(Buffer, (ReturnLength div SizeOf(TSystemLogicalProcessorInformation)) + 1);
              Continue;
            end;
          end;
          Break;
        until False;
        if Count > 0 then
        begin
          PhysicalCores := 0;
          for Index := 0 to Count-1 do
          begin
            if Buffer[Index].Relationship = RelationProcessorCore then
            begin
              if Length(CPUProcessorMasks) <= PhysicalCores then
              begin
                SetLength(CPUProcessorMasks, (PhysicalCores + 1)*2);
              end;
              if Length(CPUFirstLogicalCore) <= PhysicalCores then
              begin
                SetLength(CPUFirstLogicalCore, (PhysicalCores + 1)*2);
              end;
              CPUProcessorMasks[PhysicalCores] := Buffer[Index].ProcessorMask;
              CPUFirstLogicalCore[PhysicalCores] := Index;
              Inc(PhysicalCores);
              Inc(LogicalCores, CountSetBits(Buffer[Index].ProcessorMask));
            end;
          end;
        end;
      end;
    finally
      SetLength(Buffer, 0);
    end;
  end;

begin
  CPUProcessorMasks := nil;
  CPUFirstLogicalCore := nil;
  try
    GetCPUInfo(PhysicalCores,LogicalCores);
    Result := PhysicalCores;
    GetSystemInfo(sinfo);
    GetProcessAffinityMask(GetCurrentProcess,dwProcessAffinityMask,dwSystemAffinityMask);
    SetLength(AvailableCPUCores, Result);
    for i := 0 to PhysicalCores-1 do
    begin
      AvailableCPUCores[i] := CPUFirstLogicalCore[i];
    end;
  finally
    CPUProcessorMasks := nil;
    CPUFirstLogicalCore := nil;
  end;
end;
{$ELSEIF DEFINED(Linux) or DEFINED(Android)}
var
  CountCountIDs: Int32;
  CoreID: Int32;
  CPUIndex: Int32;
  Index: Int32;
  CoreIDFile: Text;
  CoreIDs: array of Int32;
  CPUIDs: array of Int32;
  CPUPath: string;
  IsUnique: Boolean;
  CoreIDStr: string;
begin
  Result := 0;

  CountCountIDs := 0;
  CPUIndex := 0;

  CoreIDs := nil;
  CPUIDs := nil;
  try
    while true do
    begin
      // Construct the file path for each CPU core's core_id file
      CPUPath:='/sys/devices/system/cpu/cpu'+IntToStr(CPUIndex)+'/topology/core_id';

      // Check if the core_id file exists
      if not FileExists(CPUPath) then
      begin
        Break;  // Exit loop if there are no more CPUs
      end;

      // Try to open the core_id file
      AssignFile(CoreIDFile, CPUPath);
      {$i-}System.Reset(CoreIDFile);{$i+}
      if IOResult <> 0 then
      begin
        Break;  // Exit loop if there are no more CPUs
      end;

      // Read the core_id as a string and close the file
      ReadLn(CoreIDFile, CoreIDStr);
      CloseFile(CoreIDFile);

      // Convert core_id to integer
      CoreID:=StrToIntDef(CoreIDStr,-1);
      if CoreID < 0 then
      begin
        Continue;  // Skip if conversion fails
      end;

      // Check if this CoreID is unique
      IsUnique := True;
      for Index := 0 to CountCountIDs-1 do
      begin
        if CoreIDs[Index]=CoreID then
        begin
          IsUnique := False;
          Break;
        end;
      end;

      // If unique, add to dynamic array of CoreIDs
      if IsUnique then
      begin
        if Length(CoreIDs) <= CountCountIDs then
        begin
          SetLength(CoreIDs, (CountCountIDs + 1)*2);
        end;
        if Length(CPUIDs) <= CountCountIDs then
        begin
          SetLength(CPUIDs, (CountCountIDs + 1)*2);
        end;
        CoreIDs[CountCountIDs] := CoreID;
        CPUIDs[CountCountIDs] := CPUIndex;
        Inc(CountCountIDs);
        Inc(Result);
      end;

      Inc(CPUIndex);
    end;

  SetLength(AvailableCPUCores, Result);
  for Index := 0 to Result-1 do begin
    AvailableCPUCores[Index] := CPUIDs[Index];
  end;

  finally
    CoreIDs := nil;
    CPUIDs := nil;
  end;
end;
{$ELSEIF DEFINED(Solaris)}
var
  i: TPasMPInt32;
begin
  Result := sysconf(_SC_NPROC_ONLN);
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSEIF DEFINED(fpc) and DEFINED(Darwin)}
const
  IDs: array [0..3] of RawByteString = (
    'machdep.cpu.core_count',
    'hw.physicalcpu',
    'machdep.cpu.thread_count',
    'hw.logicalcpu',
  );
var
  status: cint;
  T: cint;
  i: cint;
  len: size_t;
begin
  Result := 1;
  len := SizeOf(t);
  for i := Low(IDs) to High(IDs) do
  begin
    t := 0;
    status := fpSysCtlByName(PAnsiChar(IDs[i]), @t, @len, nil, 0);
    if (status = 0) and (t >= 1) then
    begin
      Result := t;
      Break;
    end;
  end;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSEIF DEFINED(Unix)}
var
  mib: array [0..1] of cint;
  len: cint;
  t: cint;
  i: TPasMPInt32;
begin
  mib[0] := CTL_HW;
  mib[1] := HW_AVAILCPU;
  len := SizeOf(t);
  fpsysctl(Pointer(@mib),2, @t, @len, nil, 0);
  if t < 1 then
  begin
    mib[1] := HW_NCPU;
    fpsysctl(Pointer(@mib),2, @t, @len, nil, 0);
    if t < 1 then
    begin
      t := 1;
    end;
  end;
  Result := t;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSE}
var
  i: TPasMPInt32;
begin
  Result := 1;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$IFEND}

class function TPasMP.GetCountOfHardwareThreads(out AvailableCPUCores: TPasMPAvailableCPUCores): TPasMPInt32;
{$IF DEFINED(Windows)}
var
  PhysicalCores: TPasMPInt32;
  LogicalCores: TPasMPInt32;
  i: TPasMPInt32;
  j: TPasMPInt32;
  sinfo: SYSTEM_INFO;
  dwProcessAffinityMask: TPasMPPtrUInt;
  dwSystemAffinityMask: TPasMPPtrUInt;

  procedure GetCPUInfo(var PhysicalCores, LogicalCores: TPasMPInt32);
  const
    RelationProcessorCore = 0;
    RelationNumaNode = 1;
    RelationCache = 2;
    RelationProcessorPackage = 3;
    RelationGroup = 4;
    RelationAll = $ffff;
    CacheUnified = 0;
    CacheInstruction = 1;
    CacheData = 2;
    CacheTrace = 3;
  type
    TLogicalProcessorRelationship = TPasMPUInt32;
    TProcessorCacheType = TPasMPUInt32;
    TCacheDescriptor = packed record
      Level: TPasMPUInt8;
      Associativity: TPasMPUInt8;
      LineSize: TPasMPUInt16;
      Size: TPasMPUInt32;
      pcType: TProcessorCacheType;
    end;
    PSystemLogicalProcessorInformation = ^TSystemLogicalProcessorInformation;
    TSystemLogicalProcessorInformation = packed record
    ProcessorMask: TPasMPPtrUInt;
    case Relationship: TLogicalProcessorRelationship of
      0: (Flags: TPasMPUInt8;);
      1: (NodeNumber: TPasMPUInt32;);
      2: (Cache: TCacheDescriptor;);
      3: (Reserved: array [0..1] of TPasMPInt64;);
    end;
    TGetLogicalProcessorInformation = function(Buffer: PSystemLogicalProcessorInformation; out ReturnLength: TPasMPUInt32): bool; stdcall;

  function CountSetBits(Value: TPasMPPtrUInt): TPasMPInt32;
  begin
    Result := 0;
    while Value <> 0 do
    begin
      Inc(Result);
      Value := Value and (Value-1);
    end;
  end;

  var
    GetLogicalProcessorInformation: TGetLogicalProcessorInformation;
    Buffer: array of TSystemLogicalProcessorInformation;
    ReturnLength: TPasMPUInt32;
    Index: TPasMPInt32;
    Count: TPasMPInt32;
  begin
    Buffer := nil;
    PhysicalCores := 0;
    LogicalCores := 0;
    try
      GetLogicalProcessorInformation := GetProcAddress(GetModuleHandle('kernel32'), 'GetLogicalProcessorInformation');
      if Assigned(GetLogicalProcessorInformation) then
      begin
        SetLength(Buffer, 64);
        Count := 0;
        repeat
          ReturnLength := Length(Buffer) * SizeOf(TSystemLogicalProcessorInformation);
          if GetLogicalProcessorInformation(@Buffer[0], ReturnLength) then
          begin
            Count := ReturnLength div SizeOf(TSystemLogicalProcessorInformation);
          end
          else
          begin
            if GetLastError=ERROR_INSUFFICIENT_BUFFER then
            begin
              SetLength(Buffer, (ReturnLength div SizeOf(TSystemLogicalProcessorInformation)) + 1);
              Continue;
            end;
          end;
          Break;
        until False;
        if Count > 0 then
        begin
          PhysicalCores := 0;
          for Index := 0 to Count-1 do
          begin
            if Buffer[Index].Relationship=RelationProcessorCore then
            begin
              Inc(PhysicalCores);
              Inc(LogicalCores, CountSetBits(Buffer[Index].ProcessorMask));
            end;
          end;
        end;
      end;
    finally
      SetLength(Buffer, 0);
    end;
  end;

begin
  GetCPUInfo(PhysicalCores,LogicalCores);
  Result := LogicalCores;
  if Result = 0 then
  begin
    Result := PhysicalCores;
  end;
  GetSystemInfo(sinfo);
  GetProcessAffinityMask(GetCurrentProcess,dwProcessAffinityMask,dwSystemAffinityMask);
  SetLength(AvailableCPUCores, Result);
  j := 0;
  for i := 0 to sinfo.dwNumberOfProcessors-1 do
  begin
    if (dwProcessAffinityMask and (1 shl i)) <> 0 then
    begin
      AvailableCPUCores[j] := i;
      Inc(j);
      if j >= Result then
      begin
        Break;
      end;
    end;
  end;
  if Result>j then
  begin
    Result := j;
    SetLength(AvailableCPUCores, Result);
  end;
end;
{$ELSEIF DEFINED(Android)}
const
  Paths: array [0..1] of string = (
    '/sys/devices/system/cpu/possible',
    '/sys/devices/system/cpu/present'
   );
var
  TryIteration: TPasMPInt32;
  i: TPasMPInt32;
  fs: TFileStream;
  s:{$IFDEF HAS_TYPE_RAWBYTESTRING}RawByteString{$ELSE}AnsiString{$ENDIF};
begin
  for TryIteration := 0 to 1 do
  begin
    if FileExists(Paths[TryIteration]) then
    begin
      s:='';
      fs := TFileStream.Create(Paths[TryIteration], FmOpenRead or fmShareDenyWrite);
      try
        SetLength(s, Fs.Size);
        fs.Read(s[1],Length(s));
      finally
        fs.Free;
      end;
      if (Length(s) > 2) and (s[1] = '0') and (s[2] = '-') then
      begin
        Delete(s,1,2);
        Result := StrToIntDef(String(s),-1);
        if Result>=0 then
        begin
          Inc(Result);
          SetLength(AvailableCPUCores, Result);
          for i := 0 to Result-1 do
          begin
            AvailableCPUCores[i] := i;
          end;
          Exit;
        end;
      end;
    end;
  end;
  Result := 1;
  for i := 0 to 127 do
  begin
    if DirectoryExists('/sys/devices/system/cpu/cpu'+IntToStr(i)) then
    begin
      Result := i + 1;
    end
    else
    begin
      Break;
    end;
  end;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSEIF DEFINED(Linux) or DEFINED(Android)}
var
  i: TPasMPInt32;
  j: TPasMPInt32;
  CPUSet: TPasMPInt64;
begin
  Result := sysconf(_SC_NPROCESSORS_CONF);
  SetLength(AvailableCPUCores, Result);
  CPUSet := 0;
  if sched_getaffinity(GetProcessID, SizeOf(CPUSet), @CPUSet) = 0 then begin
    j := 0;
    for i := 0 to 63 do
    begin
     if (CPUSet and (TPasMPInt64(1) shl i)) <> 0 then
     begin
      AvailableCPUCores[j] := i;
      Inc(j);
      if j >= Result then
      begin
        Break;
      end;
     end;
    end;
    if Result>j then
    begin
     Result := j;
     SetLength(AvailableCPUCores, Result);
    end;
  end
  else
  begin
    for i := 0 to Result-1 do
    begin
     AvailableCPUCores[i] := i;
    end;
  end;
end;
{$ELSEIF DEFINED(Solaris)}
var
  i: TPasMPInt32;
begin
  Result := sysconf(_SC_NPROC_ONLN);
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSEIF DEFINED(fpc) and DEFINED(Darwin)}
const
  IDs: array [0..3] of RawByteString = (
    'machdep.cpu.thread_count',
    'hw.logicalcpu',
    'machdep.cpu.core_count',
    'hw.physicalcpu'
   );
var
  status: cint;
  t: cint;
  i: cint;
  len: size_t;
begin
  Result := 1;
  len := SizeOf(t);
  for i := Low(IDs) to High(IDs) do
  begin
    t := 0;
    status := fpSysCtlByName(PAnsiChar(IDs[i]), @t, @len, nil, 0);
    if (status = 0) and (t >= 1) then
    begin
      Result := t;
      Break;
    end;
  end;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSEIF DEFINED(Unix)}
var
  mib: array [0..1] of cint;
  len: cint;
  t: cint;
  i: TPasMPInt32;
begin
  mib[0] := CTL_HW;
  mib[1] := HW_AVAILCPU;
  len := SizeOf(t);
  fpsysctl(Pointer(@mib), 2, @t, @len, nil, 0);
  if t < 1 then
  begin
    mib[1] := HW_NCPU;
    fpsysctl(Pointer(@mib), 2, @t, @len, nil, 0);
    if t < 1 then
    begin
      t := 1;
    end;
  end;
  Result := t;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$ELSE}
var
  i: TPasMPInt32;
begin
  Result := 1;
  SetLength(AvailableCPUCores, Result);
  for i := 0 to Result-1 do
  begin
    AvailableCPUCores[i] := i;
  end;
end;
{$IFEND}

class function TPasMP.Once(var OnceControl: TPasMPOnce; const InitRoutine: TPasMPOnceInitRoutine): Boolean;
{$IFDEF Linux}
begin
  Result := pthread_once(@OnceControl, initRoutine) = 0;
end;
{$ELSE}
var
  SavedOnceControl: TPasMPOnce;
begin
  Result := False;
  SavedOnceControl := OnceControl;
{$IFDEF CPU386}
  asm
    mfence
  end;
{$ELSE}
  TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
  while SavedOnceControl <> 1 do
  begin
    if SavedOnceControl = 0 then
    begin
      if TPasMPInterlocked.CompareExchange(OnceControl,2, 0) = 0 then
      begin
        try
          InitRoutine;
        finally
          OnceControl := 1;
        end;
        Result := True;
        Exit;
      end;
    end;
{$IFDEF cpu386}
    asm
      db $f3,$90 // pause (rep nop)
    end;
{$ELSE}
    TPasMP.Yield;
{$ENDIF}
{$IFDEF CPU386}
    asm
      mfence
    end;
{$ELSE}
    TPasMPMemoryBarrier.ReadWrite;
{$ENDIF}
    SavedOnceControl:=OnceControl;
  end;
end;
{$ENDIF}

procedure TPasMP.Reset;
var
  Index: TPasMPInt32;
begin
  fJobAllocator.FreeJobs;
  for Index := 0 to fCountJobWorkerThreads-1 do
  begin
    fJobWorkerThreads[Index].fJobAllocator.FreeJobs;
  end;
end;

function TPasMP.CreateScope: TPasMPScope;
begin
  Result := TPasMPScope.Create(self);
end;

class function TPasMP.IsJobCompleted(const Job: PPasMPJob): Boolean;
begin
  Result := Assigned(Job) and ((Job^.InternalData and PasMPJobFlagActive) = 0);
end;

class function TPasMP.IsJobValid(const Job: PPasMPJob): Boolean;
begin
  Result := Assigned(Job) and ((Job^.InternalData and PasMPJobFlagActive) <> 0);
end;

function TPasMP.GetJobWorkerThread: TPasMPJobWorkerThread; {$IFDEF UseThreadLocalStorage}{$IF DEFINED(UseThreadLocalStorageX8632) or DEFINED(UseThreadLocalStorageX8664)}assembler;{$IFEND}{$ENDIF}
{$IFDEF UseThreadLocalStorage}
{$IF DEFINED(UseThreadLocalStorageX8632)}
asm
  mov eax,dword ptr fs:[$00000018]
  mov ecx,dword ptr CurrentJobWorkerThreadTLSOffset
  mov eax,dword ptr [eax+ecx]
end;
{$ELSEIF DEFINED(UseThreadLocalStorageX8664)}
asm
  mov rax, Qword ptr gs:[$00000058]
  mov ecx,dword ptr CurrentJobWorkerThreadTLSOffset
  mov rax, Qword ptr [rax+rcx]
end;
{$ELSE}
begin
  Result := CurrentJobWorkerThread;
end;
{$IFEND}
{$ELSE}
var
  ThreadID:{$IFDEF fpc}TThreadID{$ELSE}TPasMPUInt32{$ENDIF};
  ThreadIDHash: TPasMPUInt32;
begin
{$IF (DEFINED(NEXTGEN) or not DEFINED(Windows)) and not DEFINED(FPC)}
  ThreadID := TThread.CurrentThread.ThreadID;
{$ELSE}
  ThreadID := GetCurrentThreadID;
{$IFEND}
  ThreadIDHash := TPasMP.GetThreadIDHash(ThreadID);
  Result := fJobWorkerThreadHashTable[ThreadIDHash and PasMPJobWorkerThreadHashTableMask];
  while Assigned(Result) and (Result.fThreadID <> ThreadID) do begin
    Result := Result.fNext;
  end;
end;
{$ENDIF}

function TPasMP.GetJobWorkerThreadIndex: TPasMPInt32;
var CurrentJobWorkerThread: TPasMPJobWorkerThread;
begin
 CurrentJobWorkerThread := GetJobWorkerThread;
 if Assigned(CurrentJobWorkerThread) then begin
  Result := CurrentJobWorkerThread.fThreadIndex;
 end else begin
  Result :=  - 1;
 end;
end;

procedure TPasMP.WaitForWakeUp;
{$IFDEF PasMPUseWakeUpConditionVariable}
var SavedWakeUpCounter: TPasMPInt32;
begin
 if fSleepingOnIdle then begin
  fWakeUpConditionVariableLock.Acquire;
  try
   TPasMPInterlocked.Increment(fSleepingJobWorkerThreads);
   SavedWakeUpCounter := fWakeUpCounter;
   repeat
    fWakeUpConditionVariable.Wait(fWakeUpConditionVariableLock);
   until SavedWakeUpCounter<>fWakeUpCounter;
   TPasMPInterlocked.Decrement(fSleepingJobWorkerThreads);
  finally
   fWakeUpConditionVariableLock.Release;
  end;
 end else begin
  TPasMP.Yield;
 end;
end;
{$ELSE}
begin
 if fSleepingOnIdle then begin
  fWakeUpEvent.ResetEvent;
  TPasMPInterlocked.Increment(fSleepingJobWorkerThreads);
  fWakeUpEvent.WaitFor(INFINITE);
  TPasMPInterlocked.Decrement(fSleepingJobWorkerThreads);
 end else begin
  TPasMP.Yield;
 end;
end;
{$ENDIF}

procedure TPasMP.WakeUpAll;
{$IFDEF PasMPUseWakeUpConditionVariable}
begin
 if fSleepingJobWorkerThreads > 0 then begin
  fWakeUpConditionVariableLock.Acquire;
  try
   Inc(fWakeUpCounter);
   fWakeUpConditionVariable.Broadcast;
  finally
   fWakeUpConditionVariableLock.Release;
  end;
 end;
end;
{$ELSE}
begin
  if fSleepingJobWorkerThreads > 0 then
  begin
    fWakeUpEvent.SetEvent;
  end;
end;
{$ENDIF}

function TPasMP.CanSpread: Boolean;
var CurrentJobWorkerThread, JobWorkerThread: TPasMPJobWorkerThread;
    ThreadIndex, index: TPasMPInt32;
begin
 Result := False;
 CurrentJobWorkerThread := GetJobWorkerThread;
 if Assigned(CurrentJobWorkerThread) then begin
  ThreadIndex := CurrentJobWorkerThread.fThreadIndex;
  if ((ThreadIndex=0) and (fWorkingJobWorkerThreads=0)) or ((ThreadIndex <> 0) and (fWorkingJobWorkerThreads=1)) then begin
   for Index := 0 to fCountJobWorkerThreads-1 do begin
    JobWorkerThread := fJobWorkerThreads[Index];
    if (JobWorkerThread<>CurrentJobWorkerThread) and JobWorkerThread.HasJobs then begin
     // We are not alone with queued work.
     Exit;
    end;
   end;
   // We are alone with queued work.
   Result := True;
  end;
 end;
end;


function TPasMP.IsFull: Boolean;
var
  CurrentJobWorkerThread,
  JobWorkerThread: TPasMPJobWorkerThread;
//  ThreadIndex: TPasMPInt32;
  Index: TPasMPInt32;
begin
  Result := False;
  CurrentJobWorkerThread := GetJobWorkerThread;
  if Assigned(CurrentJobWorkerThread) and (fWorkerThreadMaxDepth > 0) then
  begin
    Result := True;
    for Index := 0 to fCountJobWorkerThreads-1 do
    begin
      JobWorkerThread := fJobWorkerThreads[Index];
      if (JobWorkerThread<>CurrentJobWorkerThread) and (JobWorkerThread.fDepth<fWorkerThreadMaxDepth) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;


function TPasMP.GlobalAllocateJob: PPasMPJob;
begin
  fJobAllocatorCriticalSection.Acquire;
  try
    Result := fJobAllocator.AllocateJob;
  finally
    fJobAllocatorCriticalSection.Release;
  end;
end;

procedure TPasMP.GlobalFreeJob(const Job: PPasMPJob);
begin
  fJobAllocatorCriticalSection.Acquire;
  try
    fJobAllocator.FreeJob(Job);
  finally
    fJobAllocatorCriticalSection.Release;
  end;
end;

function TPasMP.AllocateJob(const MethodCode, MethodData,Data: Pointer; const ParentJob: PPasMPJob; const Flags, AreaMask, AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var
  JobWorkerThread: TPasMPJobWorkerThread;
  InternalData: TPasMPUInt32;
begin
  if Assigned(ParentJob) and ((ParentJob^.InternalData and PasMPJobFlagActive) <> 0) then
  begin
    TPasMPInterlocked.Increment(ParentJob^.ChildrenJobs);
  end;
  JobWorkerThread := GetJobWorkerThread;
  InternalData := PasMPJobFlagActive or Flags;
  if Assigned(JobWorkerThread) then
  begin
    if (InternalData and PasMPJobPriorityShiftedMask) = PasMPJobPriorityInherited then
    begin
      InternalData := InternalData or JobWorkerThread.fCurrentJobPriority;
    end;
    InternalData := InternalData or (PasMPJobFlagHasOwnerWorkerThread or TPasMPUInt32(JobWorkerThread.fThreadIndex));
    Result := JobWorkerThread.fJobAllocator.AllocateJob;
  end
  else
  begin
    if (InternalData and PasMPJobPriorityShiftedMask) = PasMPJobPriorityInherited then
    begin
      InternalData := InternalData or PasMPJobPriorityNormal;
    end;
    Result := GlobalAllocateJob;
  end;
  Result^.Method.Code:=MethodCode;
  Result^.Method.Data := MethodData;
  Result^.ParentJob := ParentJob;
  Result^.ChildrenJobs := 0;
  Result^.InternalData := InternalData;
  Result^.AreaMask := AreaMask;
  Result^.AvoidAreaMask := AvoidAreaMask;
  Result^.Data := Data;
end;

{$IFDEF HAS_ANONYMOUS_METHODS}
type PPasMPJobReferenceProcedureJobData = ^TPasMPJobReferenceProcedureJobData;
     TPasMPJobReferenceProcedureJobData=record
      JobReferenceProcedure: TPasMPJobReferenceProcedure;
      Data: Pointer;
     end;

procedure TPasMP.JobReferenceProcedureJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var JobReferenceProcedureJobData: PPasMPJobReferenceProcedureJobData;
begin
 JobReferenceProcedureJobData := PPasMPJobReferenceProcedureJobData(Pointer(@Job^.Data));
 try
  JobReferenceProcedureJobData^.JobReferenceProcedure(JobReferenceProcedureJobData^.Data, ThreadIndex);
 finally
  Finalize(JobReferenceProcedureJobData^);
 end;
end;

function TPasMP.Acquire(const JobReferenceProcedure: TPasMPJobReferenceProcedure; const Data: Pointer; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var JobMethod: TPasMPJobMethod;
    JobReferenceProcedureJobData: PPasMPJobReferenceProcedureJobData;
begin
 JobMethod := JobReferenceProcedureJobFunction;
 Result := AllocateJob(TMethod(JobMethod).Code, TMethod(JobMethod).Data, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
 if Assigned(Result) then begin
  JobReferenceProcedureJobData := PPasMPJobReferenceProcedureJobData(Pointer(@Result^.Data));
  Initialize(JobReferenceProcedureJobData^);
  JobReferenceProcedureJobData^.JobReferenceProcedure := JobReferenceProcedure;
  JobReferenceProcedureJobData^.Data := Data;
 end;
end;
{$ENDIF}

function TPasMP.Acquire(const JobProcedure: TPasMPJobProcedure; const Data: Pointer; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
begin
  Result := AllocateJob(Addr(JobProcedure), nil,Data, ParentJob, Flags, AreaMask, AvoidAreaMask);
end;

function TPasMP.Acquire(const JobMethod: TPasMPJobMethod; const Data: Pointer; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
begin
  Result := AllocateJob(TMethod(JobMethod).Code, TMethod(JobMethod).Data,Data, ParentJob, Flags, AreaMask, AvoidAreaMask);
end;

function TPasMP.Acquire(const JobTask: TPasMPJobTask; const Data: Pointer; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
begin
  Result := AllocateJob(nil, Pointer(JobTask),Data, ParentJob, Flags or TPasMP.EncodeJobTagToJobFlags(JobTask.fJobTag), AreaMask, AvoidAreaMask);
  JobTask.fJob:=Result;
  JobTask.fThreadIndex :=  - 1;
end;

procedure TPasMP.Release(const Job: PPasMPJob);
begin
 if Assigned(Job) then begin
  if (Assigned(Job^.Method.Data) and not Assigned(Job^.Method.Code)) and TPasMPJobTask(Pointer(Job^.Method.Data)).fFreeOnRelease then begin
   TPasMPJobTask(Pointer(Job^.Method.Data)).Free;
  end;
  if (Job^.InternalData and PasMPJobFlagHasOwnerWorkerThread) <> 0 then begin
   fJobWorkerThreads[(Job^.InternalData shr PasMPJobThreadIndexShift) and PasMPJobThreadIndexMask].fJobAllocator.FreeJob(Job);
  end else begin
   GlobalFreeJob(Job);
  end;
 end;
end;

procedure TPasMP.Release(const Jobs: array of PPasMPJob);
var
  JobIndex: TPasMPInt32;
begin
  for JobIndex := 0 to Length(Jobs)-1 do begin
    Release(Jobs[JobIndex]);
  end;
end;

procedure TPasMP.ExecuteJobTask(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread; const ThreadIndex: TPasMPInt32);
var
  JobTask,NewJobTask: TPasMPJobTask;
  NewJob: PPasMPJob;
begin
 JobTask := TPasMPJobTask(Pointer(Job^.Method.Data));
 JobTask.fThreadIndex := ThreadIndex;

 if CanSpread then begin
  // First try to spread, when all worker threads (except us) are jobless
  JobTask.Spread;
 end;

 if ((Job^.InternalData and PasMPJobFlagHasOwnerWorkerThread) <> 0) and
    (TPasMPInt32((Job^.InternalData shr PasMPJobThreadIndexShift) and PasMPJobThreadIndexMask) <> ThreadIndex) then begin
  // It's a stolen job => try Split
  NewJobTask := JobTask.Split;
  if not Assigned(NewJobTask) then begin
   // if Split of a stolen job has failed => try PartialPop
   NewJobTask := JobTask.PartialPop;
  end;
 end else begin
  // It's a non-stolen job => try PartialPop
  NewJobTask := JobTask.PartialPop;
 end;

 if Assigned(NewJobTask) then begin
  // Run our both halfed jobs
  NewJob:=Acquire(NewJobTask, nil, nil, 0, Job^.AreaMask, Job^.AvoidAreaMask);
  Run(NewJob);
  JobTask.Run;
  Wait(NewJob);
  Release(NewJob);
 end else begin
  // if PartialPop has also failed => just execute the job as whole
  JobTask.Run;
 end;
end;

procedure TPasMP.WaitOnChildrenJobs(const Job: PPasMPJob);
var SpinCount, CountMaxSpinCount: TPasMPInt32;
    NextJob: PPasMPJob;
    JobWorkerThread: TPasMPJobWorkerThread;
begin
 if Assigned(Job) then begin
  JobWorkerThread := GetJobWorkerThread;
  SpinCount := 0;
  CountMaxSpinCount := 128;
  while Job^.ChildrenJobs > 0 do begin
   if Assigned(JobWorkerThread) then begin
    NextJob := JobWorkerThread.GetJob;
    if Assigned(NextJob) then begin
     ExecuteJob(NextJob, JobWorkerThread);
     SpinCount := 0;
    end else begin
     if SpinCount<CountMaxSpinCount then begin
      Inc(SpinCount);
     end else begin
      TPasMP.Yield;
     end;
    end;
   end else begin
    TPasMP.Yield;
   end;
  end;
 end;
end;

function TPasMP.CheckJobExecution(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread): Boolean;
begin
  if Assigned(fOnCheckJobExecution) and not fOnCheckJobExecution(Self, Job, JobWorkerThread) then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
end;

procedure TPasMP.ExecuteJob(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread);
var
  LastJobPriority: TPasMPUInt32;
  OldAreaMask: TPasMPUInt32;
  ProfilerHistoryRingBufferItem: PPasMPProfilerHistoryRingBufferItem;
begin
  if JobWorkerThread.HasJobs then
  begin
    WakeUpAll;
  end;

 // Check if the job is allowed to run now here
  if (fRespectJobAvoidAreaMasks and ((JobWorkerThread.fAreaMask and Job^.AvoidAreaMask) <> 0)) or not CheckJobExecution(Job, JobWorkerThread) then
  begin
    // Job is not allowed to run alright now, so re-enqueue it for later

    // Clear the requeue flag, if it was set, so we don't requeue it again and again
    TPasMPInterlocked.BitwiseAnd(Job^.InternalData, PasMPJobFlagRequeueAndNotMask);

    // Requeue the job, so it will be executed later, but into the global job queue for better chances to be executed directly without re-enqueueing again
    Run(Job, True);

    Exit;
  end;

  if Assigned(fProfiler) then
  begin
    ProfilerHistoryRingBufferItem := fProfiler.Acquire;
    ProfilerHistoryRingBufferItem^.JobTag := TPasMP.DecodeJobTagFromJobFlags(Job^.InternalData);
    ProfilerHistoryRingBufferItem^.ThreadIndexStackDepth := TPasMPUInt32(JobWorkerThread.fThreadIndex and $ffff) or (JobWorkerThread.fDepth shl 16);
    ProfilerHistoryRingBufferItem^.StartTime := fProfiler.fHighResolutionTimer.GetTime+fProfiler.fOffsetTime;
  end
  else
  begin
    ProfilerHistoryRingBufferItem := nil;
  end;

  Inc(JobWorkerThread.fDepth);

  OldAreaMask := JobWorkerThread.fAreaMask;
  JobWorkerThread.fAreaMask := OldAreaMask or Job^.AreaMask;

{  OldAvoidAreaMask := JobWorkerThread.fAvoidAreaMask;
  JobWorkerThread.fAvoidAreaMask := OldAreaMask or Job^.AvoidAreaMask;}

  LastJobPriority := JobWorkerThread.fCurrentJobPriority;
  JobWorkerThread.fCurrentJobPriority := Job^.InternalData and PasMPJobPriorityShiftedMask;

  if Assigned(Job^.Method.Data) then
  begin
    if Assigned(Job^.Method.Code) then
    begin
      TPasMPJobMethod(Job^.Method)(Job, JobWorkerThread.ThreadIndex);
    end
    else
    begin
      ExecuteJobTask(Job, JobWorkerThread, JobWorkerThread.ThreadIndex);
    end;
  end
  else
  begin
    if Assigned(Job^.Method.Code) then
    begin
      TPasMPJobProcedure(Pointer(Job^.Method.Code))(Job, JobWorkerThread.ThreadIndex);
    end;
  end;

  JobWorkerThread.fCurrentJobPriority:=LastJobPriority;

  if ((Job^.InternalData and PasMPJobFlagRequeue) = 0) and (Job^.ChildrenJobs > 0) then
  begin
    WaitOnChildrenJobs(Job);
  end;

  if Assigned(ProfilerHistoryRingBufferItem) then
  begin
    ProfilerHistoryRingBufferItem^.EndTime := fProfiler.fHighResolutionTimer.GetTime+fProfiler.fOffsetTime;
  end;

  JobWorkerThread.fAreaMask := OldAreaMask;

  //JobWorkerThread.fAvoidAreaMask := OldAvoidAreaMask;

  Dec(JobWorkerThread.fDepth);

  if (Job^.InternalData and PasMPJobFlagRequeue) <> 0 then
  begin
    TPasMPInterlocked.BitwiseAnd(Job^.InternalData, PasMPJobFlagRequeueAndNotMask);

    Run(Job, True);
  end
  else
  begin
    if Assigned(Job^.ParentJob) then
    begin
      TPasMPInterlocked.Decrement(Job^.ParentJob^.ChildrenJobs);
    end;

    TPasMPInterlocked.BitwiseAnd(Job^.InternalData, PasMPJobFlagActiveAndNotMask);

    if (Job^.InternalData and PasMPJobFlagReleaseOnFinish) <> 0 then
    begin
      Release(Job);
    end;
  end;
end;

procedure TPasMP.PushJob(const Job: PPasMPJob; const JobWorkerThread: TPasMPJobWorkerThread);
var
  JobQueueIndex: TPasMPUInt32;
  PriorityJobQueueBitMask: TPasMPUInt32;
begin
  JobQueueIndex := PasMPJobQueuePriorityLast - (((Job^.InternalData and PasMPJobPriorityShiftedMask) shr PasMPJobPriorityShift) - (PasMPJobPriorityLow shr PasMPJobPriorityShift));
  PriorityJobQueueBitMask := TPasMPUInt32(1) shl TPasMPUInt32(JobQueueIndex);
  if Assigned(JobWorkerThread) then
  begin
    JobWorkerThread.fJobQueues[JobQueueIndex].PushJob(Job);
    if (JobWorkerThread.fJobQueuesUsedBitmap and PriorityJobQueueBitMask) = 0 then
    begin
      JobWorkerThread.fJobQueuesUsedBitmap := JobWorkerThread.fJobQueuesUsedBitmap or PriorityJobQueueBitMask;
      TPasMPInterlocked.BitwiseOr(fGlobalJobQueuesUsedBitmap, PriorityJobQueueBitMask);
    end;
  end
  else
  begin
    fJobQueuesLock.Acquire;
    try
      fJobQueues[JobQueueIndex].PushJob(Job);
{$IF DEFINED(cpu386) or DEFINED(cpux86_64)}
      TPasMPMemoryBarrier.ReadDependency;
{$ELSE}
      TPasMPMemoryBarrier.Read;
{$IFEND}
      if (fJobQueuesUsedBitmap and PriorityJobQueueBitMask) = 0 then
      begin
        fJobQueuesUsedBitmap := fJobQueuesUsedBitmap or PriorityJobQueueBitMask;
        TPasMPMemoryBarrier.ReadWrite;
        TPasMPInterlocked.BitwiseOr(fGlobalJobQueuesUsedBitmap, PriorityJobQueueBitMask);
      end;
    finally
      fJobQueuesLock.Release;
    end;
  end;
end;

procedure TPasMP.Run(const Job: PPasMPJob; const GlobalQueue: Boolean);
var
  JobWorkerThread: TPasMPJobWorkerThread;
begin
  if Assigned(Job) then
  begin
    if GlobalQueue then
    begin
      JobWorkerThread := nil;
    end
    else
    begin
      JobWorkerThread := GetJobWorkerThread;
    end;
    PushJob(Job, JobWorkerThread);
    WakeUpAll;
  end;
end;

procedure TPasMP.Run(const Jobs: array of PPasMPJob; const GlobalQueue: Boolean);
var
  JobWorkerThread: TPasMPJobWorkerThread;
  JobIndex: TPasMPInt32;
  Job: PPasMPJob;
begin
  if GlobalQueue then
  begin
    JobWorkerThread := nil;
  end
  else
  begin
    JobWorkerThread := GetJobWorkerThread;
  end;
  for JobIndex := 0 to Length(Jobs)-1 do
  begin
    Job := Jobs[JobIndex];
    if Assigned(Job) then
    begin
      PushJob(Job, JobWorkerThread);
    end;
  end;
  WakeUpAll;
end;

function TPasMP.StealAndExecuteJob: Boolean;
var
  NextJob: PPasMPJob;
  JobWorkerThread: TPasMPJobWorkerThread;
begin
  Result := False;
  JobWorkerThread := GetJobWorkerThread;
  if Assigned(JobWorkerThread) then
  begin
    NextJob := JobWorkerThread.GetJob;
    if Assigned(NextJob) then
    begin
      ExecuteJob(NextJob, JobWorkerThread);
      Result := True;
    end;
  end;
end;

procedure TPasMP.Wait(const Job: PPasMPJob);
var
  SpinCount: TPasMPInt32;
  CountMaxSpinCount: TPasMPInt32;
  NextJob: PPasMPJob;
  JobWorkerThread: TPasMPJobWorkerThread;
begin
  if Assigned(Job) then
  begin
    JobWorkerThread := GetJobWorkerThread;
    SpinCount := 0;
    CountMaxSpinCount := 128;
    while (Job^.InternalData and PasMPJobFlagActive) <> 0 do
    begin
      if Assigned(JobWorkerThread) then
      begin
        NextJob := JobWorkerThread.GetJob;
        if Assigned(NextJob) then
        begin
          ExecuteJob(NextJob, JobWorkerThread);
          SpinCount := 0;
        end
        else
        begin
         if SpinCount < CountMaxSpinCount then
         begin
           Inc(SpinCount);
         end
         else
         begin
           TPasMP.Yield;
         end;
        end;
      end
      else
      begin
        TPasMP.Yield;
      end;
    end;
  end;
end;

procedure TPasMP.Wait(const Jobs: array of PPasMPJob);
var
  JobIndex: TPasMPInt32;
  CountJobs: TPasMPInt32;
  SpinCount: TPasMPInt32;
  CountMaxSpinCount: TPasMPInt32;
  Job: PPasMPJob;
  NextJob: PPasMPJob;
  Done: Boolean;
  JobWorkerThread: TPasMPJobWorkerThread;
begin
  CountJobs := Length(Jobs);
  if CountJobs > 0 then
  begin
    JobWorkerThread := GetJobWorkerThread;
    SpinCount := 0;
    CountMaxSpinCount := 128;
    repeat
      Done := True;
      for JobIndex := 0 to CountJobs-1 do
      begin
        Job := Jobs[JobIndex];
        if Assigned(Job) and ((Job^.InternalData and PasMPJobFlagActive) <> 0) then
        begin
          Done := False;
          Break;
        end;
      end;
      if Done then
      begin
        Break;
      end
      else
      begin
        if Assigned(JobWorkerThread) then
        begin
          NextJob := JobWorkerThread.GetJob;
          if Assigned(NextJob) then
          begin
            ExecuteJob(NextJob, JobWorkerThread);
            SpinCount := 0;
          end
          else
          begin
            if SpinCount < CountMaxSpinCount then
            begin
              Inc(SpinCount);
            end
            else
            begin
              TPasMP.Yield;
            end;
          end;
        end
        else
        begin
          TPasMP.Yield;
        end;
      end;
    until False;
  end;
end;

procedure TPasMP.RunWait(const Job: PPasMPJob);
begin
  if Assigned(Job) then begin
    Run(Job);
    Wait(Job);
  end;
end;

procedure TPasMP.RunWait(const Jobs: array of PPasMPJob);
begin
  Run(Jobs);
  Wait(Jobs);
end;

procedure TPasMP.WaitRelease(const Job: PPasMPJob);
begin
  if Assigned(Job) then begin
    Wait(Job);
    Release(Job);
  end;
end;

procedure TPasMP.WaitRelease(const Jobs: array of PPasMPJob);
begin
  Wait(Jobs);
  Release(Jobs);
end;

procedure TPasMP.Invoke(const Job: PPasMPJob);
begin
  if Assigned(Job) then
  begin
    Run(Job);
    Wait(Job);
    Release(Job);
  end;
end;

procedure TPasMP.Invoke(const Jobs: array of PPasMPJob);
begin
  Run(Jobs);
  Wait(Jobs);
  Release(Jobs);
end;

procedure TPasMP.Invoke(const JobTask: TPasMPJobTask);
begin
  Invoke(Acquire(JobTask));
end;

procedure TPasMP.Invoke(const JobTasks: array of TPasMPJobTask);
var
  CountJobTasks,
  Index: TPasMPInt32;
  Jobs: array of PPasMPJob;
begin
  Jobs := nil;
  CountJobTasks := Length(JobTasks);
  SetLength(Jobs, CountJobTasks);
  try
    for Index := 0 to CountJobTasks-1 do
    begin
     Jobs[Index] := Acquire(JobTasks[Index]);
    end;
    Invoke(Jobs);
  finally
    SetLength(Jobs, 0);
  end;
end;

{$IFDEF HAS_ANONYMOUS_METHODS}
type
  PPasMPParallelForReferenceProcedureStartJobData = ^TPasMPParallelForReferenceProcedureStartJobData;
    TPasMPParallelForReferenceProcedureStartJobData = record
    ParallelForReferenceProcedure: TPasMPParallelForReferenceProcedure;
    Data: Pointer;
    FirstIndex: TPasMPNativeInt;
    LastIndex: TPasMPNativeInt;
    Granularity: TPasMPInt32;
    Depth: TPasMPInt32;
    CanSpread: longbool;
    RecursiveSplit: longbool;
  end;

  PPasMPParallelForReferenceProcedureJobData = ^TPasMPParallelForReferenceProcedureJobData;
  TPasMPParallelForReferenceProcedureJobData = record
    StartJobData: PPasMPParallelForReferenceProcedureStartJobData;
    FirstIndex: TPasMPNativeInt;
    LastIndex: TPasMPNativeInt;
    RemainDepth: TPasMPInt32;
  end;

procedure TPasMP.ParallelForJobReferenceProcedureProcess(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  JobData: PPasMPParallelForReferenceProcedureJobData;
  StartJobData: PPasMPParallelForReferenceProcedureStartJobData;
begin
  JobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@Job^.Data));
  StartJobData := JobData^.StartJobData;
  if Assigned(StartJobData^.ParallelForReferenceProcedure) then
  begin
    StartJobData^.ParallelForReferenceProcedure(Job, ThreadIndex, StartJobData^.Data, JobData^.FirstIndex, JobData^.LastIndex);
  end;
end;

procedure TPasMP.ParallelForJobReferenceProcedureFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  NewJobs: array [0..1] of PPasMPJob;
  StartJobData: PPasMPParallelForReferenceProcedureStartJobData;
  JobData: PPasMPParallelForReferenceProcedureJobData;
  NewJobData: PPasMPParallelForReferenceProcedureJobData;
begin
  JobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@Job^.Data));
  if JobData^.FirstIndex<=JobData^.LastIndex then
  begin
    StartJobData := JobData^.StartJobData;
    if (((JobData^.LastIndex-JobData^.FirstIndex) + 1)<=StartJobData^.Granularity) or (JobData^.RemainDepth = 0) or not StartJobData^.RecursiveSplit then
    begin
      ParallelForJobReferenceProcedureProcess(Job, ThreadIndex);
    end
    else
    begin
      if ((Job^.InternalData and PasMPJobFlagHasOwnerWorkerThread) <> 0) and
        (TPasMPInt32((Job^.InternalData shr PasMPJobThreadIndexShift) and PasMPJobThreadIndexMask) <> ThreadIndex) then
      begin
        // It is a stolen job => split in two halfs
        begin
          NewJobs[0] := Acquire(ParallelForJobReferenceProcedureFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.StartJobData := StartJobData;
          NewJobData^.FirstIndex := JobData^.FirstIndex;
          NewJobData^.LastIndex := (JobData^.FirstIndex + ((JobData^.LastIndex-JobData^.FirstIndex) div 2)) - 1;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
        end;
        begin
          NewJobs[1] := Acquire(ParallelForJobReferenceProcedureFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@NewJobs[1]^.Data));
          NewJobData^.StartJobData := StartJobData;
          NewJobData^.FirstIndex := PPasMPParallelForReferenceProcedureJobData(Pointer(@NewJobs[0]^.Data))^.LastIndex + 1;
          NewJobData^.LastIndex := JobData^.LastIndex;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
        end;
        Invoke(NewJobs);
      end
      else
      begin
        // It is a non-stolen job => split and increment by granularity count
        begin
          NewJobs[0] := Acquire(ParallelForJobReferenceProcedureFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.StartJobData := StartJobData;
          NewJobData^.FirstIndex := JobData^.FirstIndex+StartJobData^.Granularity;
          NewJobData^.LastIndex := JobData^.LastIndex;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
          JobData^.LastIndex := NewJobData^.FirstIndex - 1;
        end;
        Run(NewJobs[0]);
        ParallelForJobReferenceProcedureProcess(Job, ThreadIndex);
        WaitRelease(NewJobs[0]);
      end;
    end;
  end;
end;

procedure TPasMP.ParallelForStartJobReferenceProcedureFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  NewJobs: array [0..31] of PPasMPJob;
  JobData: PPasMPParallelForReferenceProcedureStartJobData;
  NewJobData: PPasMPParallelForReferenceProcedureJobData;
  NewJobDataEx: PPasMPParallelForReferenceProcedureJobData;
  Index: TPasMPNativeInt;
  EndIndex: TPasMPNativeInt;
  Granularity: TPasMPNativeInt;
  Count: TPasMPNativeInt;
  CountJobs: TPasMPNativeInt;
  PartSize: TPasMPNativeInt;
  Rest: TPasMPNativeInt;
  Size: TPasMPNativeInt;
  JobIndex: TPasMPInt32;
  JobEx: TPasMPJob;
begin
  JobData := PPasMPParallelForReferenceProcedureStartJobData(Pointer(@Job^.Data));
  try
    Index := JobData^.FirstIndex;
    EndIndex := JobData^.LastIndex + 1;
    if JobData^.FirstIndex<EndIndex then
    begin
      Granularity := JobData^.Granularity;
      Count := EndIndex-Index;
      if Count<=Granularity then
      begin
        JobEx := Job^;
        NewJobDataEx := PPasMPParallelForReferenceProcedureJobData(Pointer(@JobEx.Data));
        NewJobDataEx^.StartJobData := JobData;
        NewJobDataEx^.FirstIndex := JobData^.FirstIndex;
        NewJobDataEx^.LastIndex := JobData^.LastIndex;
        NewJobDataEx^.RemainDepth := JobData^.Depth;
        ParallelForJobReferenceProcedureProcess(@JobEx, ThreadIndex);
      end
      else
      begin
        if JobData^.CanSpread or not JobData^.RecursiveSplit then
        begin
          // Only try to spread, when all worker threads (except us) are jobless
          CountJobs := Count div Granularity;
        end
        else
        begin
          CountJobs := 1;
        end;
        if CountJobs < 1 then
        begin
          CountJobs := 1;
        end
        else if CountJobs>Length(NewJobs) then
        begin
          CountJobs := Length(NewJobs);
        end;
        PartSize := Count div CountJobs;
        Rest := Count - (CountJobs*PartSize);
        for JobIndex := 0 to CountJobs-1 do
        begin
          Size := PartSize;
          if Rest>JobIndex then
          begin
            Inc(Size);
          end;
          NewJobs[JobIndex] := Acquire(ParallelForJobReferenceProcedureFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForReferenceProcedureJobData(Pointer(@NewJobs[JobIndex]^.Data));
          NewJobData^.StartJobData := JobData;
          NewJobData^.FirstIndex := Index;
          NewJobData^.LastIndex := (Index+Size) - 1;
          if NewJobData^.LastIndex>JobData^.LastIndex then
          begin
            NewJobData^.LastIndex := JobData^.LastIndex;
          end;
          NewJobData^.RemainDepth := JobData^.Depth;
          Run(NewJobs[JobIndex]);
          Inc(Index, Size);
        end;
        for JobIndex := 0 to CountJobs-1 do
        begin
          WaitRelease(NewJobs[JobIndex]);
        end;
      end;
    end;
  finally
    Finalize(JobData^);
  end;
end;

function TPasMP.ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForReferenceProcedure: TPasMPParallelForReferenceProcedure; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32; const RecursiveSplit: Boolean): PPasMPJob;
var
  JobData: PPasMPParallelForReferenceProcedureStartJobData;
begin
  Result := Acquire(ParallelForStartJobReferenceProcedureFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
  JobData := PPasMPParallelForReferenceProcedureStartJobData(Pointer(@Result^.Data));
  Initialize(JobData^);
  JobData^.ParallelForReferenceProcedure := ParallelForReferenceProcedure;
  JobData^.Data := Data;
  JobData^.FirstIndex := FirstIndex;
  JobData^.LastIndex := LastIndex;
  JobData^.Granularity := Granularity;
  JobData^.Depth := Depth;
  JobData^.CanSpread:=CanSpread;
  JobData^.RecursiveSplit:=RecursiveSplit;
end;
{$ENDIF}

type
  PPasMPParallelForStartJobData = ^TPasMPParallelForStartJobData;
  TPasMPParallelForStartJobData = record
    Method:TMethod;
    Data: Pointer;
    FirstIndex: TPasMPNativeInt;
    LastIndex: TPasMPNativeInt;
    Granularity: TPasMPInt32;
    Depth: TPasMPInt32;
    CanSpread: longbool;
    RecursiveSplit: longbool;
  end;

  PPasMPParallelForJobData = ^TPasMPParallelForJobData;
  TPasMPParallelForJobData = record
    StartJobData: PPasMPParallelForStartJobData;
    FirstIndex: TPasMPNativeInt;
    LastIndex: TPasMPNativeInt;
    RemainDepth: TPasMPInt32;
  end;

procedure TPasMP.ParallelForJobFunctionProcess(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  JobData: PPasMPParallelForJobData;
  StartJobData: PPasMPParallelForStartJobData;
begin
  JobData := PPasMPParallelForJobData(Pointer(@Job^.Data));
  StartJobData := JobData^.StartJobData;
  if Assigned(StartJobData^.Method.Data) then
  begin
    TPasMPParallelForMethod(StartJobData^.Method)(Job, ThreadIndex, StartJobData^.Data, JobData^.FirstIndex, JobData^.LastIndex);
  end
  else
  begin
    TPasMPParallelForProcedure(StartJobData^.Method.Code)(Job, ThreadIndex, StartJobData^.Data, JobData^.FirstIndex, JobData^.LastIndex);
  end;
end;

procedure TPasMP.ParallelForJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  NewJobs: array [0..1] of PPasMPJob;
  JobData: PPasMPParallelForJobData;
  NewJobData: PPasMPParallelForJobData;
  StartJobData: PPasMPParallelForStartJobData;
begin
  JobData := PPasMPParallelForJobData(Pointer(@Job^.Data));
  if JobData^.FirstIndex<=JobData^.LastIndex then
  begin
    StartJobData := JobData^.StartJobData;
    if (((JobData^.LastIndex-JobData^.FirstIndex) + 1)<=StartJobData^.Granularity) or (JobData^.RemainDepth <= 0) or not StartJobData^.RecursiveSplit then
    begin
     ParallelForJobFunctionProcess(Job, ThreadIndex);
    end
    else
    begin
      if ((Job^.InternalData and PasMPJobFlagHasOwnerWorkerThread) <> 0) and
      (TPasMPInt32((Job^.InternalData shr PasMPJobThreadIndexShift) and PasMPJobThreadIndexMask) <> ThreadIndex) then
      begin
        // It is a stolen job => split in two halfs
        begin
          NewJobs[0] := Acquire(ParallelForJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.StartJobData := JobData^.StartJobData;
          NewJobData^.FirstIndex := JobData^.FirstIndex;
          NewJobData^.LastIndex := (JobData^.FirstIndex + ((JobData^.LastIndex-JobData^.FirstIndex) div 2)) - 1;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
        end;
        begin
          NewJobs[1] := Acquire(ParallelForJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForJobData(Pointer(@NewJobs[1]^.Data));
          NewJobData^.StartJobData := JobData^.StartJobData;
          NewJobData^.FirstIndex := PPasMPParallelForJobData(Pointer(@NewJobs[0]^.Data))^.LastIndex + 1;
          NewJobData^.LastIndex := JobData^.LastIndex;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
        end;
        Invoke(NewJobs);
      end
      else
      begin
        // It is a non-stolen job => split and increment by granularity count
        begin
          NewJobs[0] := Acquire(ParallelForJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelForJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.StartJobData := JobData^.StartJobData;
          NewJobData^.FirstIndex := JobData^.FirstIndex+StartJobData^.Granularity;
          NewJobData^.LastIndex := JobData^.LastIndex;
          NewJobData^.RemainDepth := JobData^.RemainDepth - 1;
          JobData^.LastIndex := NewJobData^.FirstIndex - 1;
        end;
        Run(NewJobs[0]);
        ParallelForJobFunctionProcess(Job, ThreadIndex);
        WaitRelease(NewJobs[0]);
      end;
    end;
  end;
end;

procedure TPasMP.ParallelForStartJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  NewJobs: array [0..31] of PPasMPJob;
  JobData: PPasMPParallelForStartJobData;
  NewJobData: PPasMPParallelForJobData;
  NewJobDataEx: PPasMPParallelForJobData;
  Index: TPasMPNativeInt;
  EndIndex: TPasMPNativeInt;
  Granularity: TPasMPNativeInt;
  Count: TPasMPNativeInt;
  CountJobs: TPasMPNativeInt;
  PartSize: TPasMPNativeInt;
  Rest: TPasMPNativeInt;
  Size: TPasMPNativeInt;
  JobIndex: TPasMPInt32;
  JobEx: TPasMPJob;
begin
  JobData := PPasMPParallelForStartJobData(Pointer(@Job^.Data));
  Index := JobData^.FirstIndex;
  EndIndex := JobData^.LastIndex + 1;
  if JobData^.FirstIndex<EndIndex then
  begin
    Granularity := JobData^.Granularity;
    Count := EndIndex-Index;
    if Count<=Granularity then
    begin
      JobEx := Job^;
      NewJobDataEx := PPasMPParallelForJobData(Pointer(@JobEx.Data));
      NewJobDataEx^.StartJobData := JobData;
      NewJobDataEx^.FirstIndex := JobData^.FirstIndex;
      NewJobDataEx^.LastIndex := JobData^.LastIndex;
      NewJobDataEx^.RemainDepth := JobData^.Depth;
      ParallelForJobFunctionProcess(@JobEx, ThreadIndex);
    end
    else
    begin
      if JobData^.CanSpread or not JobData^.RecursiveSplit then
      begin
        // Only try to spread, when all worker threads (except us) are jobless
        CountJobs := Count div Granularity;
      end
      else
      begin
        CountJobs := 1;
      end;
      if CountJobs < 1 then
      begin
        CountJobs := 1;
      end
      else if CountJobs>Length(NewJobs) then
      begin
        CountJobs := Length(NewJobs);
      end;
      PartSize := Count div CountJobs;
      Rest := Count - (CountJobs*PartSize);
      NewJobs[0] := nil;
      for JobIndex := 0 to CountJobs-1 do
      begin
        Size := PartSize;
        if Rest>JobIndex then
        begin
          Inc(Size);
        end;
        NewJobs[JobIndex] := Acquire(ParallelForJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
        NewJobData := PPasMPParallelForJobData(Pointer(@NewJobs[JobIndex]^.Data));
        NewJobData^.StartJobData := JobData;
        NewJobData^.FirstIndex := Index;
        NewJobData^.LastIndex := (Index+Size) - 1;
        if NewJobData^.LastIndex>JobData^.LastIndex then
        begin
          NewJobData^.LastIndex := JobData^.LastIndex;
        end;
        NewJobData^.RemainDepth := JobData^.Depth;
        Run(NewJobs[JobIndex]);
        Inc(Index, Size);
      end;
      for JobIndex := 0 to CountJobs-1 do
      begin
        WaitRelease(NewJobs[JobIndex]);
      end;
    end;
  end;
end;

function TPasMP.ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForProcedure: TPasMPParallelForProcedure; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32; const RecursiveSplit: Boolean): PPasMPJob;
var
  JobData: PPasMPParallelForStartJobData;
begin
  Result := Acquire(ParallelForStartJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
  JobData := PPasMPParallelForStartJobData(Pointer(@Result^.Data));
  JobData^.Method.Code := Addr(ParallelForProcedure);
  JobData^.Method.Data := nil;
  JobData^.Data := Data;
  JobData^.FirstIndex := FirstIndex;
  JobData^.LastIndex := LastIndex;
  if Granularity < 1 then
  begin
    JobData^.Granularity := 1;
  end else
  begin
    JobData^.Granularity := Granularity;
  end;
  JobData^.Depth := Depth;
  JobData^.CanSpread := CanSpread;
  JobData^.RecursiveSplit := RecursiveSplit;
end;

function TPasMP.ParallelFor(const Data: Pointer; const FirstIndex,LastIndex: TPasMPNativeInt; const ParallelForMethod: TPasMPParallelForMethod; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32; const RecursiveSplit: Boolean): PPasMPJob;
var
  JobData: PPasMPParallelForStartJobData;
begin
  Result := Acquire(ParallelForStartJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
  JobData := PPasMPParallelForStartJobData(Pointer(@Result^.Data));
  JobData^.Method := TMethod(ParallelForMethod);
  JobData^.Data := Data;
  JobData^.FirstIndex := FirstIndex;
  JobData^.LastIndex := LastIndex;
  if Granularity < 1 then
  begin
    JobData^.Granularity := 1;
  end
  else
  begin
    JobData^.Granularity := Granularity;
  end;
  JobData^.Depth := Depth;
  JobData^.CanSpread:=CanSpread;
  JobData^.RecursiveSplit:=RecursiveSplit;
end;

type
  PPasMPParallelDirectIntroSortJobData = ^TPasMPParallelDirectIntroSortJobData;
  TPasMPParallelDirectIntroSortJobData = record
    Items: Pointer;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
    ElementSize: TPasMPInt32;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;

procedure TPasMP.ParallelDirectIntroSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
type
  PByteArray = ^TByteArray;
  TByteArray = array [0..$3fffffff] of TPasMPUInt8;
var
  NewJobs: array [0..1] of PPasMPJob;
  JobData: PPasMPParallelDirectIntroSortJobData;
  NewJobData: PPasMPParallelDirectIntroSortJobData;
  Left: TPasMPNativeInt;
  Right: TPasMPNativeInt;
  Size: TPasMPNativeInt;
  Parent: TPasMPNativeInt;
  Child: TPasMPNativeInt;
  Middle: TPasMPNativeInt;
  Pivot: TPasMPNativeInt;
  i: TPasMPNativeInt;
  j: TPasMPNativeInt;
  iA: TPasMPNativeInt;
  iB: TPasMPNativeInt;
  iC: TPasMPNativeInt;
  ElementSize: TPasMPInt32;
  CompareFunc: TPasMPParallelSortCompareFunction;
  Items{$IFDEF PasMPAlternativeDirectHeapSort}, Temp{$ENDIF}: Pointer;
begin
  JobData := PPasMPParallelDirectIntroSortJobData(Pointer(@Job^.Data));
  Left := JobData^.Left;
  Right := JobData^.Right;
  if Left < Right then
  begin
    Items := JobData^.Items;
    ElementSize := JobData^.ElementSize;
    CompareFunc := JobData^.CompareFunc;
    Size := (Right-Left) + 1;
    if Size < 16 then
    begin
      // Insertion sort
      iA := Left;
      iB := iA + 1;
      while iB <= Right do
      begin
        iC := iB;
        while (iA >= Left) and
        (iC >= Left) and
        (CompareFunc(Pointer(@PByteArray(Items)^[iA*ElementSize]), Pointer(@PByteArray(Items)^[iC*ElementSize])) > 0) do
        begin
          MemorySwap(@PByteArray(Items)^[iA*ElementSize], @PByteArray(Items)^[iC*ElementSize], ElementSize);
          Dec(iA);
          Dec(iC);
        end;
        iA := iB;
        Inc(iB);
        end;
    end
    else
    begin
      if (JobData^.Depth = 0) or (Size <= JobData^.Granularity) then
      begin
        // Heap sort
        {$IFDEF PasMPAlternativeDirectHeapSort}
        GetMem(Temp, JobData^.ElementSize);
        try
          i := Size div 2;
          repeat
            if i > 0 then
            begin
              Dec(i);
              Move(PByteArray(Items)^[(Left+i)*ElementSize], Temp^, ElementSize);
            end
            else
            begin
              Dec(Size);
              if Size > 0 then
              begin
                Move(PByteArray(Items)^[(Left+Size)*ElementSize], Temp^, ElementSize);
                Move(PByteArray(Items)^[Left*ElementSize], PByteArray(Items)^[(Left+Size)*ElementSize], ElementSize);
              end
              else
              begin
                Break;
              end;
            end;
            Parent := i;
            Child := (i*2) + 1;
            while Child < Size do
            begin
              if ((Child + 1) < Size) and (CompareFunc(Pointer(@PByteArray(Items)^[((Left+Child) + 1)*ElementSize]), Pointer(@PByteArray(Items)^[(Left+Child)*ElementSize])) > 0) then
              begin
                Inc(Child);
              end;
              if CompareFunc(Pointer(@PByteArray(Items)^[(Left+Child)*ElementSize]), Temp) > 0 then
              begin
                Move(PByteArray(Items)^[(Left+Child)*ElementSize], PByteArray(Items)^[(Left+Parent)*ElementSize], ElementSize);
                Parent := Child;
                Child := (Parent*2) + 1;
              end
              else
              begin
                Break;
              end;
            end;
            Move(Temp^, PByteArray(Items)^[(Left+Parent)*ElementSize], ElementSize);
          until False;
        finally
          FreeMem(Temp);
        end;
        {$ELSE}
        i := Size div 2;
        repeat
          if i > 0 then
          begin
            Dec(i);
          end
          else
          begin
            Dec(Size);
            if Size > 0 then
            begin
              MemorySwap(@PByteArray(Items)^[(Left+Size)*ElementSize], @PByteArray(Items)^[Left*ElementSize], ElementSize);
            end
            else
            begin
              Break;
            end;
          end;
          Parent := i;
          repeat
            Child := (Parent*2) + 1;
            if Child < Size then
            begin
              if (Child < (Size-1)) and (CompareFunc(Pointer(@PByteArray(Items)^[(Left+Child)*ElementSize]), Pointer(@PByteArray(Items)^[(Left+Child + 1)*ElementSize])) < 0) then
              begin
                Inc(Child);
              end;
              if CompareFunc(Pointer(@PByteArray(Items)^[(Left+Parent)*ElementSize]), Pointer(@PByteArray(Items)^[(Left+Child)*ElementSize])) < 0 then
              begin
                MemorySwap(@PByteArray(Items)^[(Left+Parent)*ElementSize], @PByteArray(Items)^[(Left+Child)*ElementSize], ElementSize);
                Parent := Child;
                Continue;
              end;
            end;
            Break;
          until False;
        until False;
{$ENDIF}
      end
      else
      begin
        // Quick sort width median-of-three optimization
        Middle := Left + ((Right-Left) shr 1);
        if (Right-Left) > 3 then
        begin
          if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Middle*ElementSize])) > 0 then
          begin
            MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Middle*ElementSize], ElementSize);
          end;
          if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) > 0 then
          begin
            MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
          end;
          if CompareFunc(Pointer(@PByteArray(Items)^[Middle*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) > 0 then
          begin
            MemorySwap(@PByteArray(Items)^[Middle*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
          end;
        end;
        Pivot := Middle;
        i := Left;
        j := Right;
        repeat
          while (i < Right) and (CompareFunc(Pointer(@PByteArray(Items)^[i*ElementSize]), Pointer(@PByteArray(Items)^[Pivot*ElementSize])) < 0) do
          begin
            Inc(i);
          end;
          while (j >= i) and (CompareFunc(Pointer(@PByteArray(Items)^[j*ElementSize]), Pointer(@PByteArray(Items)^[Pivot*ElementSize])) > 0) do
          begin
            Dec(j);
          end;
          if i>j then
          begin
            Break;
          end
          else
          begin
            if i<>j then
            begin
              MemorySwap(@PByteArray(Items)^[i*ElementSize], @PByteArray(Items)^[j*ElementSize], ElementSize);
              if Pivot = i then
              begin
                Pivot := j;
              end
              else if Pivot = j then
              begin
                Pivot := i;
              end;
            end;
            Inc(i);
            Dec(j);
          end;
        until False;
        if Left < j then
        begin
          NewJobs[0] := Acquire(ParallelDirectIntroSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelDirectIntroSortJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.Items := JobData^.Items;
          NewJobData^.Left := Left;
          NewJobData^.Right := j;
          NewJobData^.Depth := JobData^.Depth - 1;
          NewJobData^.ElementSize := JobData^.ElementSize;
          NewJobData^.Granularity := JobData^.Granularity;
          NewJobData^.CompareFunc := CompareFunc;
        end
        else
        begin
          NewJobs[0] := nil;
        end;
        if i < Right then
        begin
          NewJobs[1] := Acquire(ParallelDirectIntroSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelDirectIntroSortJobData(Pointer(@NewJobs[1]^.Data));
          NewJobData^.Items := JobData^.Items;
          NewJobData^.Left := i;
          NewJobData^.Right := Right;
          NewJobData^.Depth := JobData^.Depth - 1;
          NewJobData^.ElementSize := JobData^.ElementSize;
          NewJobData^.Granularity := JobData^.Granularity;
          NewJobData^.CompareFunc := CompareFunc;
        end
        else
        begin
          NewJobs[1] := nil;
        end;
        Invoke(NewJobs);
      end;
    end;
  end;
end;

function TPasMP.ParallelDirectIntroSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const ElementSize: TPasMPInt32; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var
  JobData: PPasMPParallelDirectIntroSortJobData;
begin
  Result := Acquire(ParallelDirectIntroSortJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
  JobData := PPasMPParallelDirectIntroSortJobData(Pointer(@Result^.Data));
  JobData^.Items := Items;
  JobData^.Left := Left;
  JobData^.Right := Right;
  if Left < Right then
  begin
    JobData^.Depth := TPasMPMath.BitScanReverse((Right-Left) + 1) shl 1;
    if JobData^.Depth>Depth then
    begin
      JobData^.Depth := Depth;
    end;
  end
  else
  begin
    JobData^.Depth := 0;
  end;
  JobData^.ElementSize := ElementSize;
  JobData^.Granularity := Granularity;
  JobData^.CompareFunc := CompareFunc;
end;

type
  PPasMPParallelIndirectIntroSortJobData = ^TPasMPParallelIndirectIntroSortJobData;
  TPasMPParallelIndirectIntroSortJobData = record
    Items: Pointer;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;

procedure TPasMP.ParallelIndirectIntroSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
type
  PPointers = ^TPointers;
  TPointers = array [0..($7fffffff div SizeOf(Pointer))-1] of Pointer;
var
  NewJobs: array [0..1] of PPasMPJob;
  JobData: PPasMPParallelIndirectIntroSortJobData;
  NewJobData: PPasMPParallelIndirectIntroSortJobData;
  Left: TPasMPNativeInt;
  Right: TPasMPNativeInt;
  Size: TPasMPNativeInt;
  Parent: TPasMPNativeInt;
  Child: TPasMPNativeInt;
  Middle: TPasMPNativeInt;
  i: TPasMPNativeInt;
  j: TPasMPNativeInt;
  CompareFunc: TPasMPParallelSortCompareFunction;
  Items: Pointer;
  Temp: Pointer;
  Pivot: Pointer;
begin
  JobData := PPasMPParallelIndirectIntroSortJobData(Pointer(@Job^.Data));
  Left := JobData^.Left;
  Right := JobData^.Right;
  if Left < Right then
  begin
    Items := JobData^.Items;
    CompareFunc := JobData^.CompareFunc;
    Size := (Right-Left) + 1;
    if Size < 16 then
    begin
      // Insertion sort
      for i := Left+1 to Right do
      begin
        Temp := PPointers(Items)^[i];
        j := i - 1;
        if (j >= Left) and (CompareFunc(PPointers(Items)^[j], Temp) > 0) then
        begin
          repeat
            PPointers(Items)^[j+1] := PPointers(Items)^[j];
            Dec(j);
          until not ((j >= Left) and (CompareFunc(PPointers(Items)^[j], Temp) > 0));
          PPointers(Items)^[j+1] := Temp;
        end;
      end;
    end
    else
    begin
      if (JobData^.Depth = 0) or (Size <= JobData^.Granularity) then
      begin
        // Heap sort
{$IFDEF PasMPAlternativeIndirectHeapSort}
        i := Size div 2;
        repeat
          if i > 0 then
          begin
            Dec(i);
          end
          else
          begin
            Dec(Size);
            if Size > 0 then begin
            Temp := PPointers(Items)^[Left+Size];
            PPointers(Items)^[Left+Size] := PPointers(Items)^[Left];
            PPointers(Items)^[Left] := Temp;
            end else begin
            Break;
            end;
          end;
          Parent := i;
          repeat
            Child := (Parent*2) + 1;
            if Child < Size then
            begin
              if (Child < (Size-1)) and (CompareFunc(PPointers(Items)^[Left+Child], PPointers(Items)^[Left+Child+1]) < 0) then begin
                Inc(Child);
              end;
              if CompareFunc(PPointers(Items)^[Left+Parent], PPointers(Items)^[Left+Child]) < 0 then
              begin
                Temp := PPointers(Items)^[Left+Parent];
                PPointers(Items)^[Left+Parent] := PPointers(Items)^[Left+Child];
                PPointers(Items)^[Left+Child] := Temp;
                Parent := Child;
                Continue;
              end;
            end;
            Break;
          until False;
        until False;
{$ELSE}
        i := Size div 2;
        Temp := nil;
        repeat
          if i > 0 then
          begin
            Dec(i);
            Temp := PPointers(Items)^[Left+i];
          end
          else
          begin
            Dec(Size);
            if Size > 0 then
            begin
              Temp := PPointers(Items)^[Left+Size];
              PPointers(Items)^[Left+Size] := PPointers(Items)^[Left];
            end
            else
            begin
              Break;
            end;
          end;
          Parent := i;
          Child := (i*2) + 1;
          while Child < Size do
          begin
            if ((Child + 1) < Size) and (CompareFunc(PPointers(Items)^[Left+Child+1], PPointers(Items)^[Left+Child]) > 0) then begin
            Inc(Child);
            end;
            if CompareFunc(PPointers(Items)^[Left+Child], Temp) > 0 then begin
              PPointers(Items)^[Left+Parent] := PPointers(Items)^[Left+Child];
              Parent := Child;
              Child := (Parent*2) + 1;
            end
            else
            begin
              Break;
            end;
          end;
          PPointers(Items)^[Left+Parent] := Temp;
        until False;
{$ENDIF}
      end
      else
        begin
        // Quick sort width median-of-three optimization
        Middle := Left + ((Right-Left) shr 1);
        if (Right-Left) > 3 then
        begin
          if CompareFunc(PPointers(Items)^[Left], PPointers(Items)^[Middle]) > 0 then
          begin
            Temp := PPointers(Items)^[Left];
            PPointers(Items)^[Left] := PPointers(Items)^[Middle];
            PPointers(Items)^[Middle] := Temp;
          end;
          if CompareFunc(PPointers(Items)^[Left], PPointers(Items)^[Right]) > 0 then
          begin
            Temp := PPointers(Items)^[Left];
            PPointers(Items)^[Left] := PPointers(Items)^[Right];
            PPointers(Items)^[Right] := Temp;
          end;
          if CompareFunc(PPointers(Items)^[Middle], PPointers(Items)^[Right]) > 0 then
          begin
            Temp := PPointers(Items)^[Middle];
            PPointers(Items)^[Middle] := PPointers(Items)^[Right];
            PPointers(Items)^[Right] := Temp;
          end;
        end;
        Pivot := PPointers(Items)^[Middle];
        i := Left;
        j := Right;
        repeat
          while (i < Right) and (CompareFunc(PPointers(Items)^[i], Pivot) < 0) do
          begin
            Inc(i);
          end;
          while (j >= i) and (CompareFunc(PPointers(Items)^[j], Pivot) > 0) do
          begin
            Dec(j);
          end;
          if i>j then
          begin
            Break;
          end
          else
          begin
            if i <> j then
            begin
              Temp := PPointers(Items)^[i];
              PPointers(Items)^[i] := PPointers(Items)^[j];
              PPointers(Items)^[j] := Temp;
            end;
            Inc(i);
            Dec(j);
          end;
        until False;
        if Left<j then
        begin
          NewJobs[0] := Acquire(ParallelIndirectIntroSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelIndirectIntroSortJobData(Pointer(@NewJobs[0]^.Data));
          NewJobData^.Items := JobData^.Items;
          NewJobData^.Left := Left;
          NewJobData^.Right := j;
          NewJobData^.Depth := JobData^.Depth - 1;
          NewJobData^.Granularity := JobData^.Granularity;
          NewJobData^.CompareFunc := CompareFunc;
        end
        else
        begin
          NewJobs[0] := nil;
        end;
        if i < Right then
        begin
          NewJobs[1] := Acquire(ParallelIndirectIntroSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
          NewJobData := PPasMPParallelIndirectIntroSortJobData(Pointer(@NewJobs[1]^.Data));
          NewJobData^.Items := JobData^.Items;
          NewJobData^.Left := i;
          NewJobData^.Right := Right;
          NewJobData^.Depth := JobData^.Depth - 1;
          NewJobData^.Granularity := JobData^.Granularity;
          NewJobData^.CompareFunc := CompareFunc;
        end
        else
        begin
        NewJobs[1] := nil;
        end;
        Invoke(NewJobs);
      end;
    end;
  end;
end;

function TPasMP.ParallelIndirectIntroSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var
  JobData:PPasMPParallelIndirectIntroSortJobData;
begin
  Result := Acquire(ParallelIndirectIntroSortJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
  JobData := PPasMPParallelIndirectIntroSortJobData(Pointer(@Result^.Data));
  JobData^.Items := Items;
  JobData^.Left := Left;
  JobData^.Right := Right;
  if Left < Right then
  begin
    JobData^.Depth := TPasMPMath.BitScanReverse((Right-Left) + 1) shl 1;
    if JobData^.Depth > Depth then
    begin
      JobData^.Depth := Depth;
    end;
  end
  else
  begin
    JobData^.Depth := 0;
  end;
  JobData^.Granularity := Granularity;
  JobData^.CompareFunc := CompareFunc;
end;

type
  PPasMPParallelDirectMergeSortData = ^TPasMPParallelDirectMergeSortData;
  TPasMPParallelDirectMergeSortData = record
    Items: Pointer;
    Temp: Pointer;
    ElementSize: TPasMPInt32;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;

  PPasMPParallelDirectMergeSortJobData = ^TPasMPParallelDirectMergeSortJobData;
  TPasMPParallelDirectMergeSortJobData = record
    Data: PPasMPParallelDirectMergeSortData;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
  end;

procedure TPasMP.ParallelDirectMergeSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
type PByteArray = ^TByteArray;
     TByteArray = array [0..$3fffffff] of TPasMPUInt8;
var NewJobs: array [0..1] of PPasMPJob;
    JobData,NewJobData: PPasMPParallelDirectMergeSortJobData;
    Left, Right, Size, Middle, iA, iB, iC, Count: TPasMPNativeInt;
    ElementSize: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
    Items, Temp: Pointer;
    Data: PPasMPParallelDirectMergeSortData;
begin
 JobData := PPasMPParallelDirectMergeSortJobData(Pointer(@Job^.Data));
 Left := JobData^.Left;
 Right := JobData^.Right;
 if Left < Right then begin
  Data := JobData^.Data;
  Items := Data^.Items;
  ElementSize := Data^.ElementSize;
  CompareFunc := Data^.CompareFunc;
  Size := (Right-Left) + 1;
  case Size of
   2:begin
      if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) > 0 then begin
       MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
      end;
     end;
   3:begin
      Middle := Left + 1;
      if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Middle*ElementSize])) <= 0 then begin
       if CompareFunc(Pointer(@PByteArray(Items)^[Middle*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) <= 0 then begin
        // 0 <= 1 <= 2
       end
       else if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) <= 0 then begin
        // 0 <= 2 < 1
        MemorySwap(@PByteArray(Items)^[Middle*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
       end else begin
        // 2 <= 1
        MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
        MemorySwap(@PByteArray(Items)^[Middle*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
       end;
      end else begin
       if CompareFunc(Pointer(@PByteArray(Items)^[Left*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) <= 0 then begin
        // 1 <= 2
        MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Middle*ElementSize], ElementSize);
       end else if CompareFunc(Pointer(@PByteArray(Items)^[Middle*ElementSize]), Pointer(@PByteArray(Items)^[Right*ElementSize])) <= 0 then begin
        // 1 <= 2
        MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Middle*ElementSize], ElementSize);
        MemorySwap(@PByteArray(Items)^[Middle*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
       end else begin
        // 2 < 1
        MemorySwap(@PByteArray(Items)^[Left*ElementSize], @PByteArray(Items)^[Right*ElementSize], ElementSize);
       end;
      end;
     end;
   else begin
    if (JobData^.Depth = 0) or (Size <= JobData^.Data.Granularity) then begin
{    // Insertion sort (with temporary memory)
     GetMem(Temp, ElementSize);
     try
      for iA := Left+1 to Right do begin
       iB := iA - 1;
       if (iB >= Left) and (CompareFunc(Pointer(@PByteArray(Items)^[iB*ElementSize]), Pointer(@PByteArray(Items)^[iA*ElementSize])) > 0) then begin
        Move(PByteArray(Items)^[iA*ElementSize], Temp^, ElementSize);
        repeat
         Move(PByteArray(Items)^[iB*ElementSize], PByteArray(Items)^[(iB + 1)*ElementSize], ElementSize);
         Dec(iB);
        until not ((iB >= Left) and (CompareFunc(Pointer(@PByteArray(Items)^[iB*ElementSize]), Temp) > 0));
        Move(Temp^, PByteArray(Items)^[(iB + 1)*ElementSize], ElementSize);
       end;
      end;
     finally
      FreeMem(Temp);
     end;}
     // Insertion sort (in-place)
     iA := Left;
     iB := iA + 1;
     while iB <= Right do begin
      iC := iB;
      while (iA >= Left) and
            (iC >= Left) and
            (CompareFunc(Pointer(@PByteArray(Items)^[iA*ElementSize]), Pointer(@PByteArray(Items)^[iC*ElementSize])) > 0) do begin
       MemorySwap(@PByteArray(Items)^[iA*ElementSize], @PByteArray(Items)^[iC*ElementSize], ElementSize);
       Dec(iA);
       Dec(iC);
      end;
      iA := iB;
      Inc(iB);
     end;
    end else begin
     Middle := Left + ((Right-Left) shr 1);
     if Left<Middle then begin
      NewJobs[0] := Acquire(ParallelDirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
      NewJobData := PPasMPParallelDirectMergeSortJobData(Pointer(@NewJobs[0]^.Data));
      NewJobData^.Data := Data;
      NewJobData^.Left := Left;
      NewJobData^.Right := Middle - 1;
      NewJobData^.Depth := JobData^.Depth - 1;
     end else begin
      NewJobs[0] := nil;
     end;
     if Middle <= Right then begin
      NewJobs[1] := Acquire(ParallelDirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
      NewJobData := PPasMPParallelDirectMergeSortJobData(Pointer(@NewJobs[1]^.Data));
      NewJobData^.Data := JobData^.Data;
      NewJobData^.Left := Middle;
      NewJobData^.Right := Right;
      NewJobData^.Depth := JobData^.Depth - 1;
     end else begin
      NewJobs[1] := nil;
     end;
     Invoke(NewJobs);
     begin
      // Merge
      Temp := Data^.Temp;
      iA := Left;
      iB := Middle;
      iC := Left;
      while (iA < Middle) and
            (CompareFunc(Pointer(@PByteArray(Items)^[iA*ElementSize]), Pointer(@PByteArray(Items)^[iB*ElementSize])) <= 0) do begin
       Inc(iA);
      end;
      if iA < Middle then begin
       Left := iA;
       iC := iA;
       Move(PByteArray(Items)^[iB*ElementSize], PByteArray(Temp)^[iC*ElementSize], ElementSize);
       Inc(iB);
       Inc(iC);
       while (iA < Middle) and (iB <= Right) do begin
        if CompareFunc(Pointer(@PByteArray(Items)^[iA*ElementSize]), Pointer(@PByteArray(Items)^[iB*ElementSize])) > 0 then begin
         Move(PByteArray(Items)^[iB*ElementSize], PByteArray(Temp)^[iC*ElementSize], ElementSize);
         Inc(iB);
        end else begin
         Move(PByteArray(Items)^[iA*ElementSize], PByteArray(Temp)^[iC*ElementSize], ElementSize);
         Inc(iA);
        end;
        Inc(iC);
       end;
       if iA < Middle then begin
        Count := Middle-iA;
        Move(PByteArray(Items)^[iA*ElementSize], PByteArray(Temp)^[iC*ElementSize], Count*ElementSize);
        Inc(iC, Count);
       end;
       if iB <= Right then begin
        Count := (Right-iB) + 1;
        Move(PByteArray(Items)^[iB*ElementSize], PByteArray(Temp)^[iC*ElementSize], Count*ElementSize);
       end;
       Move(PByteArray(Temp)^[Left*ElementSize], PByteArray(Items)^[Left*ElementSize], ((Right-Left) + 1)*ElementSize);
      end;
     end;
    end;
   end;
  end;
 end;
end;

type
  PPasMPParallelDirectMergeSortRootJobData = ^TPasMPParallelDirectMergeSortRootJobData;
  TPasMPParallelDirectMergeSortRootJobData = record
    Items: Pointer;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
    ElementSize: TPasMPInt32;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;

procedure TPasMP.ParallelDirectMergeSortRootJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var Data: TPasMPParallelDirectMergeSortData;
    JobData: PPasMPParallelDirectMergeSortRootJobData;
    ChildJobData: PPasMPParallelDirectMergeSortJobData;
    ChildJob: PPasMPJob;
begin
  JobData := PPasMPParallelDirectMergeSortRootJobData(Pointer(@Job^.Data));
  GetMem(Data.Temp, ((JobData^.Right-JobData^.Left) + 1)*JobData^.ElementSize);
  try
    Data.Items := JobData^.Items;
    Data.ElementSize := JobData^.ElementSize;
    Data.Granularity := JobData^.Granularity;
    Data.CompareFunc := JobData^.CompareFunc;
    ChildJob:=Acquire(ParallelDirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
    ChildJobData := PPasMPParallelDirectMergeSortJobData(Pointer(@ChildJob^.Data));
    ChildJobData^.Data := @Data;
    ChildJobData^.Left := JobData^.Left;
    ChildJobData^.Right := JobData^.Right;
    ChildJobData^.Depth := JobData^.Depth;
    Invoke(ChildJob);
  finally
    FreeMem(Data.Temp);
  end;
end;

function TPasMP.ParallelDirectMergeSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const ElementSize: TPasMPInt32; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var JobData: PPasMPParallelDirectMergeSortRootJobData;
begin
  if ((Left + 1) < Right) and (ElementSize > 0) then
  begin
    Result := Acquire(ParallelDirectMergeSortRootJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
    JobData := PPasMPParallelDirectMergeSortRootJobData(Pointer(@Result^.Data));
    JobData^.Items := Items;
    JobData^.Left := Left;
    JobData^.Right := Right;
    JobData^.ElementSize := ElementSize;
    JobData^.Granularity := Granularity;
    JobData^.CompareFunc := CompareFunc;
    if Left < Right then
    begin
      JobData^.Depth := TPasMPMath.BitScanReverse((Right-Left) + 1);
      if JobData^.Depth > Depth then
      begin
        JobData^.Depth := Depth;
      end;
    end
    else
    begin
      JobData^.Depth := 0;
    end;
  end
  else
  begin
    Result := nil;
  end;
end;

type
  PPasMPParallelIndirectMergeSortData = ^TPasMPParallelIndirectMergeSortData;
  TPasMPParallelIndirectMergeSortData = record
    Items: Pointer;
    Temp: Pointer;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;

  PPasMPParallelIndirectMergeSortJobData = ^TPasMPParallelIndirectMergeSortJobData;
  TPasMPParallelIndirectMergeSortJobData = record
    Data: PPasMPParallelIndirectMergeSortData;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
  end;

procedure TPasMP.ParallelIndirectMergeSortJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
type
  PPointers = ^TPointers;
  TPointers = array [0..($7fffffff div SizeOf(Pointer))-1] of Pointer;
var
  ChildJobs: array [0..1] of PPasMPJob;
  JobData: PPasMPParallelIndirectMergeSortJobData;
  ChildJobData: PPasMPParallelIndirectMergeSortJobData;
  Left: TPasMPNativeInt;
  Right: TPasMPNativeInt;
  Size: TPasMPNativeInt;
  Middle: TPasMPNativeInt;
  i: TPasMPNativeInt;
  j: TPasMPNativeInt;
  iA: TPasMPNativeInt;
  iB: TPasMPNativeInt;
  iC: TPasMPNativeInt;
  Count: TPasMPNativeInt;
  CompareFunc: TPasMPParallelSortCompareFunction;
  Items: Pointer;
  Temp: Pointer;
  Data: PPasMPParallelIndirectMergeSortData;
begin
  JobData := PPasMPParallelIndirectMergeSortJobData(Pointer(@Job^.Data));
  Left := JobData^.Left;
  Right := JobData^.Right;
  if Left < Right then
  begin
    Data := JobData^.Data;
    Items := Data^.Items;
    CompareFunc := Data^.CompareFunc;
    Size := (Right-Left) + 1;
    case Size of
      2:  begin
            if CompareFunc(PPointers(Items)^[Left], PPointers(Items)^[Right]) > 0 then
            begin
              Temp := PPointers(Items)^[Left];
              PPointers(Items)^[Left] := PPointers(Items)^[Right];
              PPointers(Items)^[Right] := Temp;
            end;
          end;
      3:  begin
            if CompareFunc(PPointers(Items)^[Left+0], PPointers(Items)^[Left+1]) <= 0 then
            begin
              if CompareFunc(PPointers(Items)^[Left+1], PPointers(Items)^[Left+2]) <= 0 then
              begin
                // 0 <= 1 <= 2
              end
              else if CompareFunc(PPointers(Items)^[Left+0], PPointers(Items)^[Left+2]) <= 0 then
              begin
                // 0 <= 2 < 1
                Temp := PPointers(Items)^[Left+1];
                PPointers(Items)^[Left+1] := PPointers(Items)^[Left+2];
                PPointers(Items)^[Left+2] := Temp;
              end
              else
              begin
                // 2 <= 1
                Temp := PPointers(Items)^[Left+0];
                PPointers(Items)^[Left+0] := PPointers(Items)^[Left+2];
                PPointers(Items)^[Left+2] := PPointers(Items)^[Left+1];
                PPointers(Items)^[Left+1] := Temp;
              end;
            end
            else
            begin
              if CompareFunc(PPointers(Items)^[Left+0], PPointers(Items)^[Left+2]) <= 0 then
              begin
                // 1 <= 2
                Temp := PPointers(Items)^[Left+0];
                PPointers(Items)^[Left+0] := PPointers(Items)^[Left+1];
                PPointers(Items)^[Left+1] := Temp;
              end
              else if CompareFunc(PPointers(Items)^[Left+1], PPointers(Items)^[Left+2]) <= 0 then
              begin
                // 1 <= 2
                Temp := PPointers(Items)^[Left+0];
                PPointers(Items)^[Left+0] := PPointers(Items)^[Left+1];
                PPointers(Items)^[Left+1] := PPointers(Items)^[Left+2];
                PPointers(Items)^[Left+2] := Temp;
              end
              else
              begin
                // 2 < 1
                Temp := PPointers(Items)^[Left+0];
                PPointers(Items)^[Left+0] := PPointers(Items)^[Left+2];
                PPointers(Items)^[Left+2] := Temp;
              end;
            end;
          end;//3
      else
        begin
          if (JobData^.Depth = 0) or (Size <= JobData^.Data.Granularity) then
          begin
            // Insertion sort
            for i := Left+1 to Right do
            begin
              j := i - 1;
              if (j >= Left) and (CompareFunc(PPointers(Items)^[j], PPointers(Items)^[i]) > 0) then
              begin
                Temp := PPointers(Items)^[i];
                repeat
                  PPointers(Items)^[j+1] := PPointers(Items)^[j];
                  Dec(j);
                until not ((j >= Left) and (CompareFunc(PPointers(Items)^[j], Temp) > 0));
                PPointers(Items)^[j+1] := Temp;
              end;
            end;
          end
          else
          begin
            Middle := Left + ((Right-Left) shr 1);
            if Left < Middle then
              begin
              ChildJobs[0] := Acquire(ParallelIndirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
              ChildJobData := PPasMPParallelIndirectMergeSortJobData(Pointer(@ChildJobs[0]^.Data));
              ChildJobData^.Data := Data;
              ChildJobData^.Left := Left;
              ChildJobData^.Right := Middle - 1;
              ChildJobData^.Depth := JobData^.Depth - 1;
            end
            else
            begin
              ChildJobs[0] := nil;
            end;
            if Middle <= Right then
            begin
              ChildJobs[1] := Acquire(ParallelIndirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
              ChildJobData := PPasMPParallelIndirectMergeSortJobData(Pointer(@ChildJobs[1]^.Data));
              ChildJobData^.Data := JobData^.Data;
              ChildJobData^.Left := Middle;
              ChildJobData^.Right := Right;
              ChildJobData^.Depth := JobData^.Depth - 1;
            end
            else
            begin
              ChildJobs[1] := nil;
            end;
            Invoke(ChildJobs);
            begin
              // Merge
              Temp := Data^.Temp;
              iA := Left;
              iB := Middle;
              iC := Left;
              while (iA < Middle) and (CompareFunc(PPointers(Items)^[iA], PPointers(Items)^[iB]) <= 0) do
              begin
                Inc(iA);
              end;
              if iA < Middle then
              begin
                Left := iA;
                iC := iA;
                PPointers(Temp)^[iC] := PPointers(Items)^[iB];
                Inc(iB);
                Inc(iC);
                while (iA < Middle) and (iB <= Right) do
                begin
                  if CompareFunc(PPointers(Items)^[iA], PPointers(Items)^[iB]) > 0 then
                  begin
                    PPointers(Temp)^[iC] := PPointers(Items)^[iB];
                    Inc(iB);
                  end
                  else
                  begin
                    PPointers(Temp)^[iC] := PPointers(Items)^[iA];
                    Inc(iA);
                  end;
                  Inc(iC);
                end;
                if iA < Middle then
                begin
                  Count := Middle-iA;
                  Move(PPointers(Items)^[iA], PPointers(Temp)^[iC], Count * SizeOf(Pointer));
                  Inc(iC, Count);
                end;
                if iB <= Right then
                begin
                  Count := (Right-iB) + 1;
                  Move(PPointers(Items)^[iB], PPointers(Temp)^[iC], Count * SizeOf(Pointer));
                end;
                Move(PPointers(Temp)^[Left], PPointers(Items)^[Left], ((Right-Left) + 1) * SizeOf(Pointer));
              end;
            end;
          end;
         end;
    end;// case
  end;
end;


type
  PPasMPParallelIndirectMergeSortRootJobData = ^TPasMPParallelIndirectMergeSortRootJobData;
  TPasMPParallelIndirectMergeSortRootJobData = record
    Items: Pointer;
    Left: TPasMPNativeInt;
    Right: TPasMPNativeInt;
    Depth: TPasMPInt32;
    Granularity: TPasMPInt32;
    CompareFunc: TPasMPParallelSortCompareFunction;
  end;


procedure TPasMP.ParallelIndirectMergeSortRootJobFunction(const Job: PPasMPJob; const ThreadIndex: TPasMPInt32);
var
  Data: TPasMPParallelIndirectMergeSortData;
  JobData: PPasMPParallelIndirectMergeSortRootJobData;
  ChildJobData: PPasMPParallelIndirectMergeSortJobData;
  ChildJob: PPasMPJob;
begin
  JobData := PPasMPParallelIndirectMergeSortRootJobData(Pointer(@Job^.Data));
  GetMem(Data.Temp, ((JobData^.Right-JobData^.Left) + 1) * SizeOf(Pointer));
  try
    Data.Items := JobData^.Items;
    Data.Granularity := JobData^.Granularity;
    Data.CompareFunc := JobData^.CompareFunc;
    ChildJob := Acquire(ParallelIndirectMergeSortJobFunction, nil, nil, Job^.InternalData and PasMPJobTagShiftedMask, Job^.AreaMask, Job^.AvoidAreaMask);
    ChildJobData := PPasMPParallelIndirectMergeSortJobData(Pointer(@ChildJob^.Data));
    ChildJobData^.Data := @Data;
    ChildJobData^.Left := JobData^.Left;
    ChildJobData^.Right := JobData^.Right;
    ChildJobData^.Depth := JobData^.Depth;
    Invoke(ChildJob);
  finally
    FreeMem(Data.Temp);
  end;
end;

function TPasMP.ParallelIndirectMergeSort(const Items: Pointer; const Left, Right: TPasMPNativeInt; const CompareFunc: TPasMPParallelSortCompareFunction; const Granularity: TPasMPInt32; const Depth: TPasMPInt32; const ParentJob: PPasMPJob; const Flags: TPasMPUInt32; const AreaMask: TPasMPUInt32; const AvoidAreaMask: TPasMPUInt32): PPasMPJob;
var
  JobData: PPasMPParallelIndirectMergeSortRootJobData;
begin
  if (Left + 1) < Right then
  begin
    Result := Acquire(ParallelIndirectMergeSortRootJobFunction, nil, ParentJob, Flags, AreaMask, AvoidAreaMask);
    JobData := PPasMPParallelIndirectMergeSortRootJobData(Pointer(@Result^.Data));
    JobData^.Items := Items;
    JobData^.Left := Left;
    JobData^.Right := Right;
    JobData^.Granularity := Granularity;
    JobData^.CompareFunc := CompareFunc;
    if Left < Right then
    begin
      JobData^.Depth := TPasMPMath.BitScanReverse((Right-Left) + 1);
      if JobData^.Depth > Depth then
      begin
        JobData^.Depth := Depth;
      end;
    end
    else
    begin
      JobData^.Depth := 0;
    end;
  end
  else
  begin
    Result := nil;
  end;
end;


initialization
{$IFDEF UseThreadLocalStorage}
  {$IF DEFINED(UseThreadLocalStorageX8632) or DEFINED(UseThreadLocalStorageX8664)}
  CurrentJobWorkerThreadTLSIndex := TLSAlloc;
  CurrentJobWorkerThreadTLSOffset := {$IF DEFINED(UseThreadLocalStorageX8632)} $e10 + (CurrentJobWorkerThreadTLSIndex * 4) {$ELSE} $1480 + (CurrentJobWorkerThreadTLSIndex * 8){$IFEND};
  {$IFEND}
{$ENDIF}
  GlobalPasMP := nil;
  GlobalPasMPCriticalSection := TPasMPCriticalSection.Create;
{$IFDEF PasMPUseGlobalPasMPCountOfHardwareThreads}
  GlobalPasMPCountOfHardwareThreads := TPasMP.GetCountOfHardwareThreads(GlobalPasMPAvailableCPUCores);
  if GlobalPasMPCountOfHardwareThreads < 1 then
  begin
    GlobalPasMPCountOfHardwareThreads := 1;
  end;
{$ENDIF}
{$IFDEF Windows}
  timeBeginPeriod(1);
{$ENDIF}


finalization
{$IFDEF Windows}
  timeEndPeriod(1);
{$ENDIF}
  if Assigned(GlobalPasMP) then
  begin
    TPasMP.DestroyGlobalInstance;
  end;
  GlobalPasMPCriticalSection.Free;
end.
