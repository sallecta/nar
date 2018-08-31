unit nar_unit;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils;
{       Start
Nar}
type
  nar = object
    type narInt = int64;
    type narStr = ansistring;
    type narShStr = shortstring;
    type narKeyStr = shortstring;
    type narKeyInt = int64;
    type narVal = ansistring;
    type narArStr = array of ansistring;
    type narArShStr = array of shortstring;
    type narArInt = array of int64;

  private
    class var MasterStrings: narArStr;
    class var MasterIntegers: narArInt;
    class var MasterValues: narArStr;


    type msg = object
      const
        good: narShStr = 'good';
        ItemExist: narShStr = 'item already exist';
        ItemNotExist: narShStr = 'item absent';
        KeyIntegerNotExist: narShStr = 'KeyInteger not exist';
        nothing: narShStr = 'nothing';
        Type_IvS_expected: narShStr = 'Bad NarType, expected IvS';
        Type_SIvS_expected: narShStr = 'Bad NarType, expected SIvS';
        Type_SvS_expected: narShStr = 'Bad NarType, expected SvS';
        wrongArgs = 'Wrong argument/s';
      end;

    type conf = object
      const
        NarType: byte = 0; // type not set
      end;

    type NarTypes = object
      const
        total: byte = 4;
        notSet: byte = 0;
        SIvS: byte = 1;
        SvS: byte = 2;
        IvS: byte = 3;
      end;
     {       Start Private Methods Declaration
    Nar}
    type priv = object
        //filterArrByKey
        class function filterArrByKey(ArIn: narArStr; KeyExclude: narInt): narArStr;
          overload;
        class function filterArrByKey(ArIn: narArInt; KeyExclude: narInt): narArInt;
          overload;
        //getKeyMaster
        class function getKeyMaster(KeyString: narKeyStr): narInt; overload;
        class function getKeyMaster(KeyInteger: narKeyInt): narInt; overload;
        //getKeyUser
        class function getKeyUser(var ArrIn: narArStr; KeyMaster: narInt):
          narKeyStr; overload;
        class function getKeyUser(var ArrIn: narArInt; KeyMaster: narInt):
          nar.narKeyInt; overload;
        //Insert
        class procedure Insert(KeyString: narKeyStr; KeyInteger: narKeyInt;
          Value: narVal; KeyMaster: narInt); overload;
        class procedure Insert(KeyString: narKeyStr; Value: narVal;
          KeyMaster: narInt); overload;
        class procedure Insert(KeyInteger: narKeyInt; Value: narVal;
          KeyMaster: narInt); overload;
        //ItemExist
        class function ItemExist(KeyStr: narKeyStr;
          KeyInt: narKeyInt): shortint; overload;
        class function ItemExist(KeyStr: narKeyStr): shortint; overload;
        class function ItemExist(KeyInt: narKeyInt): shortint; overload;
        //SetNarLength
        class procedure SetNarLength(len: narInt);
      end;//priv
     {       End Private Methods Declaration
    Nar}


{       Start Public Methods Declaration
Nar}
  public
    //create
    class function Create(argNarType: byte): narShStr;

    //add
    class function Add(KeyStr: narKeyStr; KeyInt: narKeyInt;
      Val: narVal): narShStr; overload;
    class function Add(KeyStr: narKeyStr;
      Val: narVal): narShStr; overload;
    class function Add(KeyInt: narKeyInt;
      Val: narVal): narShStr; overload;

    //Delete
    class function Delete(KeyString: narKeyStr; KeyInteger: narKeyInt): narShStr;
      overload;
    class function Delete(KeyString: narKeyStr): narShStr; overload;
    class function Delete(KeyInteger: narKeyInt): narShStr; overload;

    //read
    class function Read(KeyStr: narKeyStr;
      KeyInt: narKeyInt): narVal; overload;
    class function Read(KeyStr: narKeyStr): narVal; overload;
    class function Read(KeyInt: narKeyInt): narVal; overload;
    class function getKeyBy(KeyStr: narKeyStr; var OutVar: narKeyInt): narShStr;
      overload;
    class function getKeyBy(KeyInt: narKeyInt; var OutVar: narKeyStr): narShStr;
      overload;

    //getSize
    class function getLength(): narInt;

    //getHigh
    class function getHigh(): narInt;

    //getByKeyMaster
     //class function getByKeyMaster(KeyM: narInt; var OutVar: narKeyStr): byte;
     // overload;
     //class function getByKeyMaster(KeyM: narInt; var OutVar: narKeyInt): byte;
     // overload;

 {       End Public Methods Declaration
Nar}
  end;
 {       End nar = object
 Nar}


implementation


  {       Start Methods Definintion
  Nar}
  {       Start Public Methods Definition
  Nar}

//create
class function nar.Create(argNarType: byte): narShStr; //just sets NarType Var
begin
  //checking args
  if (argNarType < 1) or (argNarType > nar.NarTypes.total) then
    exit(msg.wrongArgs);
  nar.conf.NarType := argNarType;
  nar.priv.SetNarLength(0); //clear all
  exit(msg.good);
end;//nar.create KeyStr KeyInt

// api add
//api add
class function nar.Add(KeyStr: narKeyStr; KeyInt: narKeyInt;
  Val: narVal): narShStr; overload;
var
  KeyMaster: narInt;
begin
  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    //getting latest KeyMaster
    KeyMaster := High(MasterValues);
    //checking if data item allready exist
    if nar.priv.ItemExist(KeyStr, KeyInt) = 1 then
      exit(nar.msg.ItemExist);
    //setting KeyMaster to new Position
    KeyMaster := KeyMaster + 1;
    //increasing data size so it can accept new item
    nar.priv.SetNarLength(Length(nar.MasterValues) + 1);
    //finally write new item to data
    nar.priv.Insert(KeyStr, KeyInt, Val, KeyMaster);
    exit(msg.good);
  end;//end NarType SIvS
  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end NarType SvS
  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_IvS_expected);//end NarType IvS
  exit(msg.nothing);
end;//nar.Add KeyStr KeyInt

class function nar.Add(KeyStr: narKeyStr;
  Val: narVal): narShStr; overload;
var
  KeyMaster: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    ////if no MasterValues set, redirect self task to nar.Create method
    //if Length(nar.MasterValues) <= 0 then
    //begin
    //  exit(nar.Create(KeyStr, Val));
    //end
    //getting latest KeyMaster
    KeyMaster := High(MasterValues);
    //checking if data item allready exist
    if nar.priv.ItemExist(KeyStr) = 1 then exit(nar.msg.ItemExist);
    //setting KeyMaster to new Position
    KeyMaster := KeyMaster + 1;
    //increasing data size so it can accept new item
    nar.priv.SetNarLength(Length(nar.MasterValues) + 1);
    //finally write new item to data
    nar.priv.Insert(KeyStr, Val, KeyMaster);
    exit(msg.good);
  end;//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_IvS_expected);//end NarType IvS

  exit(msg.nothing);
end;//nar.Add KeyStr

class function nar.Add(KeyInt: narKeyInt;
  Val: narVal): narShStr; overload;
var
  KeyMaster: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
  begin
    ////if no MasterValues set, redirect self task to nar.Create method
    //if Length(nar.MasterValues) <= 0 then exit(nar.Create(KeyInt, Val));
    //getting latest KeyMaster
    KeyMaster := High(MasterValues);
    //checking if data item allready exist
    if nar.priv.ItemExist(KeyInt) = 1 then exit(nar.msg.ItemExist);
    //setting KeyMaster to new Position
    KeyMaster := KeyMaster + 1;
    //increasing data size so it can accept new item
    nar.priv.SetNarLength(Length(nar.MasterValues) + 1);
    //finally write new item to data
    nar.priv.Insert(KeyInt, Val, KeyMaster);
    exit(msg.good);
  end;//end NarType IvS

  exit(msg.nothing);
end;//nar.Add KeyInt

//api Delete


//nar.Delete KeyString KeyInteger
class function nar.Delete(KeyString: narKeyStr; KeyInteger: narKeyInt): narShStr;
  overload;
var
  KeyToDelete: narInt;
begin
  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    //checking if data item exist
    if nar.priv.ItemExist(KeyString, KeyInteger) = 0 then
      exit(nar.msg.ItemNotExist);
    KeyToDelete := nar.priv.getKeyMaster(KeyString);

    MasterStrings := nar.priv.filterArrByKey(MasterStrings, KeyToDelete);
    MasterIntegers := nar.priv.filterArrByKey(MasterIntegers, KeyToDelete);
    MasterValues := nar.priv.filterArrByKey(MasterValues, KeyToDelete);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_IvS_expected);//end NarType IvS

  exit(msg.nothing);
end;//end nar.Delete KeyString KeyInteger


//nar.Delete KeyString
class function nar.Delete(KeyString: narKeyStr): narShStr; overload;
var
  KeyToDelete: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    //checking if data item exist
    if nar.priv.ItemExist(KeyString) = 0 then
      exit(nar.msg.ItemNotExist);
    KeyToDelete := nar.priv.getKeyMaster(KeyString);
    MasterStrings := nar.priv.filterArrByKey(MasterStrings, KeyToDelete);
    MasterValues := nar.priv.filterArrByKey(MasterValues, KeyToDelete);
    exit(msg.good);
  end;//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_IvS_expected);//end NarType IvS

  exit(msg.nothing);
end;//end nar.Delete KeyString

//nar.Delete KeyInteger
class function nar.Delete(KeyInteger: narKeyInt): narShStr; overload;
var
  KeyToDelete: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
  begin
    //checking if data item exist
    if nar.priv.ItemExist(KeyInteger) = 0 then
      exit(nar.msg.ItemNotExist);
    KeyToDelete := nar.priv.getKeyMaster(KeyInteger);
    MasterIntegers := nar.priv.filterArrByKey(MasterIntegers, KeyToDelete);
    MasterValues := nar.priv.filterArrByKey(MasterValues, KeyToDelete);
    exit(msg.good);
  end;//end NarType IvS

  exit(msg.nothing);
end;//end nar.Delete KeyInteger

//nar.read
class function nar.Read(KeyStr: narKeyStr;
  KeyInt: narKeyInt): narVal; overload;
var
  KmStr, KmInt: narInt;
begin
  //mode SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    KmStr := nar.priv.getKeyMaster(KeyStr);
    KmInt := nar.priv.getKeyMaster(KeyInt);
    if ( KmStr <> KmInt ) then exit('');
    exit(nar.MasterValues[KmStr]);
  end;//end mode SIvS

  //mode SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end mode SvS

  //mode IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(nar.msg.Type_IvS_expected);//end mode IvS
  exit(nar.msg.nothing);
end;//nar.Read KeyStr KeyInt

class function nar.Read(KeyStr: narKeyStr): narVal; overload;
var
  KmStr: narInt;
begin
  //mode SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end mode SIvS

  //mode SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    KmStr := nar.priv.getKeyMaster(KeyStr);
    exit(nar.MasterValues[KmStr]);
  end;//end mode SvS

  //mode IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_IvS_expected);//end mode IvS
  exit(nar.msg.nothing);
end;//nar.Read KeyStr

class function nar.Read(KeyInt: narKeyInt): narVal; overload;
var
  KmInt: narInt;
begin
  //mode SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
    exit(msg.Type_SvS_expected);//end mode SIvS

  //mode SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end mode SvS

  //mode IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
  begin
    KmInt := nar.priv.getKeyMaster(KeyInt);
    exit(nar.MasterValues[KmInt]);
  end;//end mode IvS
  exit(nar.msg.nothing);
end;//nar.Read KeyInt

class function nar.getKeyBy(KeyInt: narKeyInt; var OutVar: narKeyStr): narShStr;
  overload;
var
  KmInt: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    KmInt := nar.priv.getKeyMaster(KeyInt);
    if KmInt < 0 then exit(msg.KeyIntegerNotExist);
    OutVar := MasterStrings[KmInt];
    exit(msg.good);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(msg.Type_SvS_expected);//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(msg.Type_SvS_expected);//end NarType IvS

  exit(msg.nothing);
end;//nar.getKeyBy KeyInt

class function nar.getKeyBy(KeyStr: narKeyStr; var OutVar: narKeyInt): narShStr;
  overload;
var
  KmStr: narInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    KmStr := nar.priv.getKeyMaster(KeyStr);
    if KmStr < 0 then exit(msg.KeyIntegerNotExist);
    OutVar := nar.MasterIntegers[KmStr];
    exit(nar.msg.good);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
    exit(nar.msg.Type_SvS_expected);//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
    exit(nar.msg.Type_SvS_expected);//end NarType IvS

  exit(msg.nothing);

end;//nar.getKeyBy KeyStr

//nar.priv.getLength
class function nar.getLength(): narInt;
begin
  exit(Length(nar.MasterValues));
end; //end nar.priv.getLength
//nar.priv.getHigh
class function nar.getHigh(): narInt;
begin
  exit(High(nar.MasterValues));
end;//end nar.priv.getHigh

{       End Public Methods Definition
Nar}


{       Start Private Methods Definition
Nar}

//nar.priv.filterArrByKey
class function nar.priv.filterArrByKey(ArIn: narArStr; KeyExclude: narInt): narArStr;
  overload;
var
  arOut: narArStr;
  index, newIndex: narInt;
begin
  newIndex := 0;
	 index := 0;
   while index < Length(ArIn) do
	 begin
     if index <> KeyExclude then
     begin
       SetLength(arOut, newIndex + 1);
       ArOut[newIndex] := ArIn[index];
       newIndex := newIndex + 1;
     end; //if index <> KeyExclude

	   index := index + 1
	 end;//while

   exit(ArOut);
end;//end priv.filterArrByKey narArStr

class function nar.priv.filterArrByKey(ArIn: narArInt; KeyExclude: narInt): narArInt;
  overload;
var
  arOut: narArInt;
  index, newIndex: narInt;
begin
  newIndex := 0;
  index := 0;
  while index < Length(ArIn) do
  begin
    if index <> KeyExclude then
    begin
      SetLength(arOut, newIndex + 1);
      ArOut[newIndex] := ArIn[index];
      newIndex := newIndex + 1;
    end; //if index <> KeyExclude

    index := index + 1
  end;//while
  exit(ArOut);
end;//end priv.filterArrByKey narArInt
//nar.priv.filterArrByKey

//nar.priv.getKeyMaster
class function nar.priv.getKeyMaster(KeyString: narKeyStr): narInt; overload;
var
  KeyMaster: narInt;
begin
  if Length(MasterStrings) < 1 then exit(-1);

  {while start}
  KeyMaster := 0;
  while KeyMaster < Length(MasterStrings) do
  begin//while
    if MasterStrings[KeyMaster] = KeyString then
      exit(KeyMaster);
    {!}KeyMaster := KeyMaster + 1
  end;//while
  {while end}

  exit(-1);
end; //end priv.getKeyMaster KeyString

class function nar.priv.getKeyMaster(KeyInteger: narKeyInt): narInt; overload;
var
  KeyMaster: narInt;
begin
  if Length(MasterIntegers) < 1 then exit(-1);
  {while start}
  KeyMaster := 0;
  while KeyMaster < Length(MasterIntegers) do
  begin//while
    if MasterIntegers[KeyMaster] = KeyInteger then
      exit(KeyMaster);
    {!}KeyMaster := KeyMaster + 1
  end;//while
  {while end}
  exit(-1);
end;//end priv.getKeyMaster KeyInteger
//end nar.priv.getKeyMaster

//nar.priv.getKeyUser
class function nar.priv.getKeyUser(var ArrIn: narArStr; KeyMaster: narInt):
narKeyStr; overload;
var
  index: narInt;
begin
  if Length(ArrIn) < 1 then exit('');
  {while start}
  index := 0;
  while index < Length(ArrIn) do
  begin//while
    if index = KeyMaster then
      exit(ArrIn[index]);
    {!}index := index + 1;
  end;//while
  {while end}
  exit('');
end;//end nar.priv.getKeyUser narArStr

class function nar.priv.getKeyUser(var ArrIn: narArInt; KeyMaster: narInt):
nar.narKeyInt; overload;
var
  index: narInt;
begin
  if Length(ArrIn) < 1 then exit(-1);
  {while start}
  index := 0;
  while index < Length(ArrIn) do
  begin//while
    if index = KeyMaster then
      exit(ArrIn[index]);
    {!}index := index + 1;
  end;//while
  {while end}
  exit(-1);
end;//end nar.priv.getKeyUser narArInt
//end nar.priv.getKeyUser

//nar.priv.Insert
class procedure nar.priv.Insert(KeyString: narKeyStr; KeyInteger: narKeyInt;
  Value: narVal; KeyMaster: narInt); overload;
begin
  nar.MasterStrings[KeyMaster] := KeyString;
  nar.MasterIntegers[KeyMaster] := KeyInteger;
  nar.MasterValues[KeyMaster] := Value;
end;

class procedure nar.priv.Insert(KeyString: narKeyStr; Value: narVal;
  KeyMaster: narInt); overload;
begin
  nar.MasterStrings[KeyMaster] := KeyString;
  nar.MasterValues[KeyMaster] := Value;
end;

class procedure nar.priv.Insert(KeyInteger: narKeyInt; Value: narVal;
  KeyMaster: narInt); overload;
begin
  nar.MasterIntegers[KeyMaster] := KeyInteger;
  nar.MasterValues[KeyMaster] := Value;
end;
//end nar.priv.Insert

//nar.priv.ItemExist
class function nar.priv.ItemExist(KeyStr: narKeyStr;
  KeyInt: narKeyInt): shortint; overload;
begin
  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    if (nar.priv.getKeyMaster(KeyStr) >= 0)
      or (nar.priv.getKeyMaster(KeyInt) >= 0) then exit(1);
    exit(0);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    if (nar.priv.getKeyMaster(KeyStr) >= 0) then exit(1);
    exit(0);
  end;//end NarType SvS

  exit(-1);
end;//end priv.ItemExist KeyStr KeyInt

class function nar.priv.ItemExist(KeyStr: narKeyStr): shortint; overload;
var
  KmStr, KmInt: narInt;
  KeyInt: narKeyInt;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    kmStr := nar.priv.getKeyMaster(KeyStr);
    KeyInt := getKeyUser(nar.MasterIntegers, kmStr);
    KmInt := nar.priv.getKeyMaster(KeyInt);
    if (kmStr >= 0) or (KmInt >= 0) then exit(1);
    exit(0);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    if (nar.priv.getKeyMaster(KeyStr) >= 0) then exit(1);
    exit(0);
  end;//end NarType SvS

  exit(-1);
end;//end priv.ItemExist KeyStr

class function nar.priv.ItemExist(KeyInt: narKeyInt): shortint; overload;
var
  KmStr, KmInt: narInt;
  KeyStr: narKeyStr;
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    KmInt := nar.priv.getKeyMaster(KeyInt);
    KeyStr := getKeyUser(nar.MasterStrings, KmInt);
    kmStr := nar.priv.getKeyMaster(KeyStr);
    if (kmStr >= 0) or (KmInt >= 0) then exit(1);
    exit(0);
  end;//end NarType SIvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
  begin
    if nar.priv.getKeyMaster(KeyInt) >= 0 then exit(1);
    exit(0);
  end;// end NarType IvS

  exit(-1);
end;//end priv.ItemExist KeyInt
//end nar.priv.ItemExist

//nar.priv.SetNarLength
class procedure nar.priv.SetNarLength(len: narInt);
begin

  //NarType SIvS
  if nar.conf.NarType = nar.NarTypes.SIvS then
  begin
    SetLength(MasterStrings, len);
    SetLength(MasterIntegers, len);
    SetLength(nar.MasterValues, len);
  end;//end NarType SIvS

  //NarType SvS
  if nar.conf.NarType = nar.NarTypes.SvS then
  begin
    SetLength(MasterStrings, len);
    SetLength(MasterIntegers, 0);
    SetLength(nar.MasterValues, len);
  end;//end NarType SvS

  //NarType IvS
  if nar.conf.NarType = nar.NarTypes.IvS then
  begin
    SetLength(MasterStrings, 0);
    SetLength(MasterIntegers, len);
    SetLength(nar.MasterValues, len);
  end;//end NarType IvS

end;
//end nar.priv.SetNarLength

{       End Private Methods Definition
Nar}


{       End Methods Definintion
Nar}

{       End
Nar}

end.
