program named_array;

uses
  SysUtils, nar_unit;





var
  //resBool: boolean;
  resStr: string;
  //resInt: integer;
  i: integer;
  StrOutVar: nar.narShStr;IntOutVar: nar.narKeyInt;

  //end var
begin {main block}


  Writeln('');

  writeln(LineEnding, 'Tests in SIvS NarType', LineEnding);
  i := 1;
  writeln(i, ') ', 'nar.Create (nar.NarTypes.SIvS)');
  resStr := nar.Create(nar.NarTypes.SIvS);
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (msgGood, 1, no problema)');
  resStr := nar.Add('msgGood', 1, 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (msgGoodtypo, 0, no problema)');
  resStr := nar.Add('msgGoodtypo', 0, 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, 404, Page not Found)');
  resStr := nar.Add('NotFound', 404, 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, Page not Found)');
  resStr := nar.Add('NotFound', 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotAllowed, Method Not Allowed)');
  resStr := nar.Add('NotAllowed', 'Method Not Allowed');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  writeln('   read: ', nar.Read('NotAllowed'));
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');

  writeln(LineEnding, 'Tests in SvS NarType', LineEnding);
  i := 1;
  writeln(i, ') ', 'nar.Create(nar.NarTypes.SvS)');
  resStr := nar.Create(nar.NarTypes.SvS);
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (msgGood, no problema)');
  resStr := nar.Add('msgGood', 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (msgGoodtypo, no problema)');
  resStr := nar.Add('msgGoodtypo', 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, 404, Page not Found)');
  resStr := nar.Add('NotFound', 404, 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, Page not Found)');
  resStr := nar.Add('NotFound', 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);;
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotAllowed, Method Not Allowed)');
  resStr := nar.Add('NotAllowed', 'Method Not Allowed');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  writeln('   read: ', nar.Read('NotAllowed'));
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');

  writeln(LineEnding, 'Tests in IvS NarType', LineEnding);
  i := 1;
  writeln(i, ') ', 'nar.Create(nar.NarTypes.IvS)');
  resStr := nar.Create(nar.NarTypes.IvS);
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (0, no problema)');
  resStr := nar.Add(0, 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (-20, less than zero integer user key)');
  resStr := nar.Add(-20, 'less than zero integer user key');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, 404, Page not Found)');
  resStr := nar.Add('NotFound', 404, 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (NotFound, Page not Found)');
  resStr := nar.Add('NotFound', 'Page not Found');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (-20, Method Not Allowed)');
  resStr := nar.Add(-20, 'Method Not Allowed');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  writeln('   read: ', nar.Read(-20));
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Read(0)');
  resStr := nar.Read(0);
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  writeln('   read: ', nar.Read(0));
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');

  writeln(LineEnding, 'Testing nar.getKeyBy', LineEnding);
  i := 1;
  writeln(i, ') ', 'nar.Create (nar.NarTypes.SIvS)');
  resStr := nar.Create(nar.NarTypes.SIvS);
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.Add (msgGood, 1, no problema)');
  resStr := nar.Add('msgGood', 1, 'no problema');
  writeln('   result: ', resStr);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.getKeyBy (11, StrOutVar)');
  resStr := nar.getKeyBy(11, StrOutVar);
  writeln('   result: ', resStr, ', key: ', StrOutVar);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.getKeyBy (1, StrOutVar)');
  resStr := nar.getKeyBy(1, StrOutVar);
  writeln('   result: ', resStr, ', key: ', StrOutVar);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');
  writeln(i, ') ', 'nar.getKeyBy (msgGood, StrOutVar)');
  resStr := nar.getKeyBy('msgGood', IntOutVar);
  writeln('   result: ', resStr, ', key: ', IntOutVar);
  writeln('   len:    ', nar.GetLength);
  resStr := 'main-unset'; i := i + 1;
  writeln('   ---------------------------------');



  Writeln('');
end. {main block}
