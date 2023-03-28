program A;

uses sysutils;

function getBufferWriter(fileName: string): TextFile;
var
  f: TextFile; // Change from File to TextFile
begin
  AssignFile(f, fileName); // Change from Assign to AssignFile
  if FileExists(fileName) then
  begin
    Rewrite(f);
    CloseFile(f); // Change from Close to CloseFile
  end;
  Append(f);
  Result := f; // Use function name instead of Result
end;

var
  bufferedWriter: TextFile;
  a: LongWord; // unsigned 32-bit integer
  b: LongWord; // unsigned 32-bit integer
  startTime: Int64;
  stopTime: Int64;
  c, n: LongWord;
begin
  bufferedWriter := getBufferWriter('./float/java.txt');
  a := $01000000; // 2^24
  b := $02000000; // 2^25
  WriteLn('a = ', a);
  WriteLn('b = ', b);

  startTime := DateTimeToFileDate(Now) * 1000000; // Use DateTimeToFileDate instead of DateTimeToUnix
  n := 0;
  for c := a to b do
  begin
    Write(bufferedWriter, Format('c = %08d => %8.1f', [c, c]));
    Flush(bufferedWriter^); // Use Flush with pointer to file

    if n = Trunc((c - a) * 100 / a) then
    begin
      n += 1;
      WriteLn(bufferedWriter, Format('%d/100', [n])); // Change from WriteLn to WriteLn with TextFile
    end;
  end;
  stopTime := DateTimeToFileDate(Now) * 1000000; // Use DateTimeToFileDate instead of DateTimeToUnix

  WriteLn((stopTime - startTime) div 1000000);
  Flush(bufferedWriter^); // Use Flush with pointer to file
  CloseFile(bufferedWriter); // Change from Close to CloseFile
end.
