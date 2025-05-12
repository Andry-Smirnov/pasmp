program fibonacci;
{$ifdef fpc}
 {$mode delphi}
{$endif}
{$APPTYPE CONSOLE}

uses
  {$ifdef unix}
  cthreads,
  {$endif}
  SysUtils,
  PasMP in '..\..\src\PasMP.pas',
  BeRoHighResolutionTimer in '..\common\BeRoHighResolutionTimer.pas';

  {$if defined(win32) or defined(win64) or defined(windows)}
procedure Sleep(ms:longword); stdcall; external 'kernel32.dll' name 'Sleep';
  {$ifend}

var
  PasMPInstance: TPasMP;

  function fibI(n: longint): longint;
  var
    Last, Temporary: longint;
  begin
    Last := 0;
    Result := 1;
    Dec(n);
    while n > 0 do
    begin
      Dec(n);
      Temporary := Result;
      Inc(Result, Last);
      Last := Temporary;
    end;
  end;

  function fibR(n: longint): longint;
  begin
    if n < 2 then
    begin
      Result := n;
    end
    else
    begin
      Result := fibR(n - 2) + fibR(n - 1);
    end;
  end;

type
  PfibRPJobData = ^TfibRPJobData;

  TfibRPJobData = record
    Current: longint;
    Depth: longint;
    ReturnValue: longint;
  end;

  procedure fibRPJobFunction(const Job: PPasMPJob; const ThreadIndex: longint);
  var
    JobData, NewJobData: PfibRPJobData;
    Jobs: array[0..1] of PPasMPJob;
  begin
    JobData := PfibRPJobData(pointer(@Job^.Data));
    if JobData^.Current < 2 then
    begin
      JobData^.ReturnValue := JobData^.Current;
    end
    else if JobData^.Depth > 8 then
    begin
      JobData^.ReturnValue := fibR(JobData^.Current);
    end
    else
    begin
      Jobs[0] := PasMPInstance.Acquire(fibRPJobFunction, nil);
      NewJobData := PfibRPJobData(pointer(@Jobs[0]^.Data));
      NewJobData^.Current := JobData^.Current - 2;
      NewJobData^.Depth := JobData^.Depth + 1;

      Jobs[1] := PasMPInstance.Acquire(fibRPJobFunction, nil);
      NewJobData := PfibRPJobData(pointer(@Jobs[1]^.Data));
      NewJobData^.Current := JobData^.Current - 1;
      NewJobData^.Depth := JobData^.Depth + 1;

      PasMPInstance.RunWait(Jobs); // <= RunWait combines Run and Wait into a single call
      // and Invoke combines Run, Wait and Release into a single call, but
      // Invoke isn't applicable here, since we do need the return values of
      // our children jobs

      JobData^.ReturnValue := PfibRPJobData(pointer(@Jobs[0].Data))^.ReturnValue +
        PfibRPJobData(pointer(@Jobs[1].Data))^.ReturnValue;

      PasMPInstance.Release(Jobs);
      // Release our children jobs onto the job allocator free list (=> otherwise memory leak)
    end;
  end;

  function fibRP(n: longint): longint;
  var
    Job: PPasMPJob;
    JobData: PfibRPJobData;
  begin
    Job := PasMPInstance.Acquire(fibRPJobFunction);
    JobData := PfibRPJobData(pointer(@Job^.Data));
    JobData^.Current := n;
    JobData^.Depth := 0;
    PasMPInstance.RunWait(Job); // <= RunWait combines Run and Wait into a single call
    // and Invoke combines Run, Wait and Release into a single call, but
    // Invoke isn't applicable here, since we do need the return values of
    // our children job
    Result := JobData^.ReturnValue;
    PasMPInstance.Release(Job);
    // Release our children jobs onto the job allocator free list (=> otherwise memory leak)
  end;

const
  N = 45;

var
  HighResolutionTimer: THighResolutionTimer;
  StartTime, EndTime: int64;
  i: longint;
begin
  PasMPInstance := TPasMP.Create;

  HighResolutionTimer := THighResolutionTimer.Create;

  for i := 1 to 1 do
  begin
    Write('                fibI (iterate): ');
    StartTime := HighResolutionTimer.GetTime;
    Write(fibI(N));
    EndTime := HighResolutionTimer.GetTime;
    writeln(' in ', HighResolutionTimer.ToFloatSeconds(EndTime - StartTime): 1: 8, 's');
  end;

  for i := 1 to 1 do
  begin
    Write('              fibR (recursive): ');
    StartTime := HighResolutionTimer.GetTime;
    Write(fibR(N));
    EndTime := HighResolutionTimer.GetTime;
    writeln(' in ', HighResolutionTimer.ToFloatSeconds(EndTime - StartTime): 1: 8, 's');
  end;

  for i := 1 to 9 do
  begin
    PasMPInstance.Reset;
    // <= optional per workload-frame, triggers amongst other things the job queue memory pool garbage collector
    Write('fibRP (parallelized recursive): ');
    StartTime := HighResolutionTimer.GetTime;
    Write(fibRP(N));
    EndTime := HighResolutionTimer.GetTime;
    writeln(' in ', HighResolutionTimer.ToFloatSeconds(EndTime - StartTime): 1: 8, 's');
  end;

  readln;

  HighResolutionTimer.Free;

  PasMPInstance.Free;

end.
