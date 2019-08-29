unit test_job_11;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls, Windows;

const
  nStepCount : integer = 13;
type

  { TForm1 }

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    Memo2: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PopupMenu1: TPopupMenu;
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem19Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure FuncCalc(ntypeFunc : integer); // Процедура, которая вычисляет значения функции
    function CritCalc() : double;            // Функция, которая вычисляет критерии , выбранные во 2-ом пункте меню
    procedure WriteResult();
  public

  end;


var
  Form1: TForm1;
  lMaxEl, lMinEl, lSumAllEl, lMulAllEl, lSumAllNegEl, lMulAllNegEl, lSumAllPosEl, lMulAllPosEl : Boolean;
  nMaxEl, nMinEl, nSumAllEl, nMulAllEl, nSumAllNegEl, nMulAllNegEl, nSumAllPosEl, nlMulAllPosEl : Double; // Значения по критериям
  nA : integer;      // параметр А для выбора вида функции
  nStep, x : double; // Шаг движения по шкале OX
  y : array of double;  // Массивы для всех элементов и для положительных и отрицательных элементов
  ndlgRes  : Longint;

implementation

{$R *.lfm}

{ TForm1 }

function TForm1.CritCalc() : double;
var
  nRes : double;
  i : integer;
begin
   nRes := 0.0;
   if lMaxEl then
   begin
      nRes := y[0];
      for i := 1 to Length(y)-1 do
          if nRes < y[i] then
             nRes := y[i];
   end;
   if lMinEl then
   begin
      nRes := y[0];
      for i := 1 to Length(y)-1 do
          if nRes > y[i] then
             nRes := y[i];
   end;
   if lSumAllEl then
   begin
      nRes := 0;
      for i := 0 to Length(y)-1 do
          nRes := nRes + y[i];
   end;
   if lMulAllEl then
   begin
      nRes := 1;
      for i := 0 to Length(y)-1 do
          nRes := nRes * y[i];
   end;
   if lSumAllNegEl then
   begin
      nRes := 0;
       for i := 0 to Length(y)-1 do
           if y[i] < 0 then
              nRes := nRes + y[i];
   end;
   if lMulAllNegEl then
   begin
      nRes := 1;
     for i := 0 to Length(y)-1 do
       if y[i] < 0 then
          nRes := nRes * y[i];
   end;
   if lSumAllPosEl then
   begin
      nRes := 0;
     for i := 0 to Length(y)-1 do
       if y[i] > 0 then
          nRes := nRes + y[i];
   end;
   if lMulAllPosEl then
   begin
      nRes := 1;
     for i := 0 to Length(y)-1 do
       if y[i] > 0 then
          nRes := nRes * y[i];
   end;
   CritCalc := nRes;
end;

procedure TForm1.FuncCalc(ntypeFunc : integer);
var
   i : integer; // Счетчики цикла и количества положительных и отрицательных элементов
begin
  x := -6; // Начало отрезка , согласно задания
  nStep := 1;  // Шаг движени япо оси OX
  for i := 0 to Length(y) - 1 do y[i] := 0.0; // Обнулим данные предыдущего расчета
  case ntypeFunc of
       -2 : for i := 0 to nStepCount -1 do
            begin
                y[i] :=  (x*x*x)/ntypeFunc;
                x:= x + nStep;
            end;
       10 : begin
                 i := 0;
                 while x <= 6 do
                 begin
                     y[i] :=  Sin( ntypeFunc - x);
                     x:= x + nStep;
                     inc(i);
                 end;
            end;
        4 : begin
                 i := 0;
                 repeat
                     begin
                         if x <> 0 then
                           y[i] :=  ln( ntypeFunc/(x*x))
                         else
                           y[i] := 10000000.0;  // если х = 0 , то у[i] = очень большому числу
                     end;
                     x:= x + nStep;
                     Inc(i);
                 until x > 6
            end;
     end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
   Form1.close;
end;

procedure TForm1.WriteResult();
var
   lCalculated : Boolean;    // Признак расчета функции
   i : integer;
   sOut : Ansistring;      // Строка для вывода ы Мемо
   sCritName : string; // Название расчтанного критерия
   nCritRes : double;  // Результат расчета критерия

begin
   lCalculated := False;
   Form1.Memo1.Clear; // Очистим Мемо для записи новых значений
   Form1.Memo2.Clear; // Очистим Мемо для записи новых значений ( отрицательных / положительных элеьентов массива )


//   ShowMessage('->'+Form1.ComboBox1.Text+'<-');
   case  Form1.ComboBox1.Text of
        ''   : ndlgRes := Application.MessageBox( PChar('Вы не выбрали параметр А ( тип функции ) ! Расчет не возможен !'),'Ошибка !',MB_OK);
        '-2' : begin Form1.FuncCalc(-2); lCalculated := True; end;
        '10' : begin Form1.FuncCalc(10); lCalculated := True; end;
        '4'  : begin Form1.FuncCalc(4); lCalculated := True; end;
   end;
   if lCalculated then // Если расчет состоялся, то сделаем вывод данных согласно критериям расчета
   begin
        for i := 0 to Length(y) - 1 do
        begin
            sOut := 'y['+IntToStr(i)+'] = '+ FloatToStr(y[i]);
            Form1.Memo1.Append(sOut);
        end;
        // Выводим положительные элементы
        sOut := '';
        for i := 0 to Length(y) - 1 do
            if y[i] > 0 then
               if sOut = '' then
                  sOut := FloatToStr(y[i])
               else
                  sOut := sOut + Chr(13)+Chr(10)+FloatToStr(y[i]);
        if sOut <> '' then begin
           Form1.Memo2.Append('Положительные элементы массива :');
           Form1.Memo2.Append(sOut);
        end else
           Form1.Memo2.Append('Положительные элементы отсутствуют !');

        // Выводим отрицательные элемнты
        sOut := '';
        for i := 0 to Length(y) - 1 do
            if y[i] < 0 then
               if sOut = '' then
                  sOut := FloatToStr(y[i])
               else
                  sOut := sOut + Chr(13)+Chr(10)+FloatToStr(y[i]);
        if sOut <> '' then begin
           Form1.Memo2.Append('Отрицательные элементы массива :');
           Form1.Memo2.Append(sOut);
        end else
            Form1.Memo2.Append('Отрицательные элементы отсутствуют !');
        // Выводим результат расчета критерия
        if lMaxEl then sCritName := 'Максимальный элемент массива';
        if lMinEl then sCritName := 'Минимальный элемент массива';
        if lSumAllEl then sCritName := 'Сумма всех элементов массива';
        if lMulAllEl then sCritName := 'Произведение всех элементов массива';
        if lSumAllNegEl then sCritName := 'Сумма всех отрицательных элементов массива';
        if lMulAllNegEl then sCritName := 'Произведение всех отрицательных элементов массива';
        if lSumAllPosEl then sCritName := 'Сумма всех положительных элементов массива';
        if lMulAllPosEl then sCritName := 'Произведение всех положительных элементов массива';
        nCritRes := Form1.CritCalc();
        sCritName := sCritName + ' = '+ FloatToStr(nCritRes);
        ndlgRes := Application.MessageBox( PChar(sCritName),'Расчитанные критериии',MB_OK);
        //ShowMessage(sCritName);
   end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
     Form1.WriteResult();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  lMaxEl := true; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
  nMaxEl := 0; nMinEl := 0; nSumAllEl := 0; nMulAllEl := 0; nSumAllNegEl := 0; nMulAllNegEl := 0; nSumAllPosEl := 0; nlMulAllPosEl := 0;
  SetLength(y, nStepCount);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
   case  Form1.ComboBox1.Text of
        ''   : begin Form1.Label1.Caption := 'Значения функции :'; Form1.Memo1.Clear; Form1.Memo2.Clear; end;
        '-2' : begin Form1.Label1.Caption := 'Значения функции '+' y = x^3/A :'; Form1.Memo1.Clear; Form1.Memo2.Clear; end;
        '10' : begin Form1.Label1.Caption := 'Значения функции '+' y = Sin(A - x) :'; Form1.Memo1.Clear; Form1.Memo2.Clear; end;
        '4'  : begin Form1.Label1.Caption := 'Значения функции '+' y = ln(A/x^2) :'; Form1.Memo1.Clear; Form1.Memo2.Clear; end;
   end;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
   ndlgRes := Application.MessageBox('Вы хотите завершить программу ?','Завершение программы ...',MB_YESNO);
   if  (6 = ndlgRes) then
       CanClose := True
   else
       CanClose := False;
end;


procedure TForm1.MenuItem4Click(Sender: TObject); // Выбор пункта меню "Максимальный элемент массива" и его выделение цветом
begin
     lMaxEl := true; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=true; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=true; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=true; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=true; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem5Click(Sender: TObject); // Выбор пункта меню "Минимальный элемент массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := true; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=true;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=true;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=true;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=true;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem6Click(Sender: TObject); // Выбор пункта меню "Сумма всех элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := true; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=true;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=true;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=true;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=true;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem7Click(Sender: TObject); // Выбор пункта меню "Произведение всех элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := true; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=true;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=true;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=true;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=true;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem8Click(Sender: TObject); // Выбор пункта меню "Сумма всех отрицательных элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := true; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=true;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=true;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=true;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=true;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem9Click(Sender: TObject); // Выбор пункта меню "Произведение всех отрицательных элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := true; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=true;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=true;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=true;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=true;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem10Click(Sender: TObject); // Выбор пункта меню "Сумма всех положительных элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := true; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=true;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=true;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=true;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=true;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem11Click(Sender: TObject); // Выбор пункта меню "Произведение всех положительных элементов массива" и его выделение цветом
begin
     lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := true;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=true;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=true;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=true;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=true;
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
   Form1.close;
end;

procedure TForm1.MenuItem14Click(Sender: TObject);
begin
   Form1.WriteResult;
end;

procedure TForm1.MenuItem15Click(Sender: TObject);
begin
   lMaxEl := true; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=true; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=true; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=true; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=true; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
     lMaxEl := false; lMinEl := true; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
     Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=true;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
     Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
     Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=true;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
     Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
     Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=true;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
     Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
     Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=true;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
     Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := true; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=true;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=true;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=true;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=true;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := true; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=true;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=true;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=true;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=true;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem19Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := true; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=true;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=true;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=true;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=true;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := true; lSumAllPosEl := false; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=true;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=true;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=true;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=true;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem21Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := true; lMulAllPosEl := false;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=true;Form1.MenuItem11.Checked:=false;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=true;Form1.MenuItem11.Default:=false;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=true;Form1.MenuItem22.Checked:=false;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=true;Form1.MenuItem22.Default:=false;
end;

procedure TForm1.MenuItem22Click(Sender: TObject);
begin
   lMaxEl := false; lMinEl := false; lSumAllEl := false; lMulAllEl := false; lSumAllNegEl := false; lMulAllNegEl := false; lSumAllPosEl := false; lMulAllPosEl := true;
   Form1.MenuItem4.Checked:=false; Form1.MenuItem5.Checked:=false;Form1.MenuItem6.Checked:=false;Form1.MenuItem7.Checked:=false;Form1.MenuItem8.Checked:=false;
   Form1.MenuItem9.Checked:=false;Form1.MenuItem10.Checked:=false;Form1.MenuItem11.Checked:=true;
   Form1.MenuItem4.Default:=false; Form1.MenuItem5.Default:=false;Form1.MenuItem6.Default:=false;Form1.MenuItem7.Default:=false;Form1.MenuItem8.Default:=false;
   Form1.MenuItem9.Default:=false;Form1.MenuItem10.Default:=false;Form1.MenuItem11.Default:=true;
   Form1.MenuItem15.Checked:=false; Form1.MenuItem16.Checked:=false;Form1.MenuItem17.Checked:=false;Form1.MenuItem18.Checked:=false;Form1.MenuItem19.Checked:=false;
   Form1.MenuItem20.Checked:=false;Form1.MenuItem21.Checked:=false;Form1.MenuItem22.Checked:=true;
   Form1.MenuItem15.Default:=false; Form1.MenuItem16.Default:=false;Form1.MenuItem17.Default:=false;Form1.MenuItem18.Default:=false;Form1.MenuItem19.Default:=false;
   Form1.MenuItem20.Default:=false;Form1.MenuItem21.Default:=false;Form1.MenuItem22.Default:=true;
end;


end.

