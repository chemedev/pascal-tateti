//
// TP ANUAL | AEDD | 1ro | COM. 13 | I.S.I. | 2011
//
// Por CHEMELLO, Juan
//
// -----------------------------------------------------------------------------
//
//  Bugs:
//          - No se puede borrar al ingresar nombre                [PENDIENTE]
//          - No se puede volver al menu tras iniciar partida     [SOLUCIONADO]
//          - Máximos jugadores diferentes = 1000                  [PENDIENTE]
//
//
Program TaTeTi(Input, Output);

Uses
    CRT, GRAPH;

Type
    Registro = Record                                                           //registro de jugadores
                   Id: String[10];
                   Score: Integer;
               End;
    Archivo = File Of Registro;                                                 //archivo

Var
    Tecla: Char;
    TTT, Flag: Boolean;
    Driver, Mode: SmallInt;                                                     //variables p/libreria GRAPH
    Buff, I2S,XO, Win, Lose: String[10];
    T, Mayor, Max, I, J, Num, X, C, P: Integer;
    V: Array[1..9] Of Integer;
    J1, J2: Array[1..10] Of Char;
    Puntos : Array[1..1000] Of Integer;
    Nombre : Array[1..1000] Of String[10];
    Buffer: Registro;
    Top10: Archivo;

Procedure SIGNOS();                                                             //borra numero previo en tablero
Begin                                                                           //y grafica 'X' u 'O'
    SetTextStyle(DefaultFont, HorizDir,5);
    Case X Of
        1 : Begin
            SetColor(0);
	        OutTextXY(410, 330, '1');
            SetColor(14);
	        OutTextXY(410, 330, XO);
            C := C + 1
            End;
        2 : Begin
            SetColor(0);
	        OutTextXY(510, 330, '2');
            SetColor(14);
	        OutTextXY(510, 330, XO);
            C := C + 1
            End;
        3 : Begin
            SetColor(0);
	        OutTextXY(610, 330, '3');
            SetColor(14);
	        OutTextXY(610, 330, XO);
            C := C + 1
            End;
        4 : Begin
            SetColor(0);
            OutTextXY(410, 230, '4');
            SetColor(14);
            OutTextXY(410, 230, XO);
            C := C + 1
            End;
        5 : Begin
            SetColor(0);
            OutTextXY(510, 230, '5');
            SetColor(14);
            OutTextXY(510, 230, XO);
            C := C + 1
            End;
        6 : Begin
            SetColor(0);
            OutTextXY(610, 230, '6');
            SetColor(14);
            OutTextXY(610, 230, XO);
            C := C + 1
            End;
        7 : Begin
            SetColor(0);
            OutTextXY(410, 130, '7');
            SetColor(14);
            OutTextXY(410, 130, XO);
            C := C + 1
            End;
        8 : Begin
            SetColor(0);
            OutTextXY(510, 130, '8');
            SetColor(14);
            OutTextXY(510, 130, XO);
            C := C + 1
            End;
        9 : Begin
            SetColor(0);
            OutTextXY(610, 130, '9');
            SetColor(14);
            OutTextXY(610, 130, XO);
            C := C + 1
            End
    End
End;

Procedure CHECK();                                                              //algun ganador?
Begin                                                                           //suma = 0 o 3 para ganar
    If (V[7] + V[8] + V[9] = 0) OR (V[7] + V[8] + V[9] = 3) Then
    Begin
    TTT := TRUE;
    P := 1                                                                      //P guarda en que linea se gana
    End;                                                                        //para aplicar EFECTO
    If (V[4] + V[5] + V[6] = 0) OR (V[4] + V[5] + V[6] = 3) Then
    Begin
    TTT := TRUE;
    P := 2
    End;
    If (V[1] + V[2] + V[3] = 0) OR (V[1] + V[2] + V[3] = 3) Then
    Begin
    TTT := TRUE;
    P := 3
    End;
    If (V[7] + V[4] + V[1] = 0) OR (V[7] + V[4] + V[1] = 3) Then
    Begin
    TTT := TRUE;
    P := 4
    End;
    If (V[8] + V[5] + V[2] = 0) OR (V[8] + V[5] + V[2] = 3) Then
    Begin
    TTT := TRUE;
    P := 5
    End;
    If (V[9] + V[6] + V[3] = 0) OR (V[9] + V[6] + V[3] = 3) Then
    Begin
    TTT := TRUE;
    P := 6
    End;
    If (V[7] + V[5] + V[3] = 0) OR (V[7] + V[5] + V[3] = 3) Then
    Begin
    TTT := TRUE;
    P := 7
    End;
    If (V[1] + V[5] + V[9] = 0) OR (V[1] + V[5] + V[9] = 3) Then
    Begin
    TTT := TRUE;
    P := 8
    End;
End;

Procedure EFECTO();                                                             //borra las X u O ganadoras
Begin                                                                           //y desplaza titulo TA TE TI
    SetColor(0);                                                                //a dichas posiciones
    SetTextStyle(DefaultFont, HorizDir, 5);
    OutTextXY(0, 20, '         TA-TE-TI');
    Case P Of
        1 : Begin
            SetColor(0);
            OutTextXY(410, 130, 'X');
            OutTextXY(510, 130, 'X');
            OutTextXY(610, 130, 'X');
            OutTextXY(410, 130, 'O');
            OutTextXY(510, 130, 'O');
            OutTextXY(610, 130, 'O');
            SetColor(9);
            OutTextXY(390, 130, 'TA');
            OutTextXY(490, 130, 'TE');
            OutTextXY(590, 130, 'TI');
            C := C + 1
            End;
        2 : Begin
            SetColor(0);
            OutTextXY(410, 230, 'X');
            OutTextXY(510, 230, 'X');
            OutTextXY(610, 230, 'X');
            OutTextXY(410, 230, 'O');
            OutTextXY(510, 230, 'O');
            OutTextXY(610, 230, 'O');
            SetColor(9);
            OutTextXY(390, 230, 'TA');
            OutTextXY(490, 230, 'TE');
            OutTextXY(590, 230, 'TI');
            C := C + 1
            End;
        3 : Begin
            SetColor(0);
	        OutTextXY(410, 330, 'X');
	        OutTextXY(510, 330, 'X');
	        OutTextXY(610, 330, 'X');
	        OutTextXY(410, 330, 'O');
	        OutTextXY(510, 330, 'O');
	        OutTextXY(610, 330, 'O');
            SetColor(9);
	        OutTextXY(390, 330, 'TA');
	        OutTextXY(490, 330, 'TE');
	        OutTextXY(590, 330, 'TI');
            C := C + 1
            End;
        4 : Begin
            SetColor(0);
            OutTextXY(410, 130, 'X');
            OutTextXY(410, 230, 'X');
	        OutTextXY(410, 330, 'X');
            OutTextXY(410, 130, 'O');
            OutTextXY(410, 230, 'O');
	        OutTextXY(410, 330, 'O');
            SetColor(9);
            OutTextXY(390, 130, 'TA');
            OutTextXY(390, 230, 'TE');
	        OutTextXY(390, 330, 'TI');
            C := C + 1
            End;
        5 : Begin
            SetColor(0);
            OutTextXY(510, 130, 'X');
            OutTextXY(510, 230, 'X');
	        OutTextXY(510, 330, 'X');
            OutTextXY(510, 130, 'O');
            OutTextXY(510, 230, 'O');
	        OutTextXY(510, 330, 'O');
            SetColor(9);
            OutTextXY(490, 130, 'TA');
            OutTextXY(490, 230, 'TE');
	        OutTextXY(490, 330, 'TI');
            C := C + 1
            End;
        6 : Begin
            SetColor(0);
            OutTextXY(610, 130, 'X');
            OutTextXY(610, 230, 'X');
	        OutTextXY(610, 330, 'X');
            OutTextXY(610, 130, 'O');
            OutTextXY(610, 230, 'O');
	        OutTextXY(610, 330, 'O');
            SetColor(9);
            OutTextXY(590, 130, 'TA');
            OutTextXY(590, 230, 'TE');
	        OutTextXY(590, 330, 'TI');
            C := C + 1
            End;
        7 : Begin
            SetColor(0);
            OutTextXY(410, 130, 'X');
            OutTextXY(510, 230, 'X');
	        OutTextXY(610, 330, 'X');
            OutTextXY(410, 130, 'O');
            OutTextXY(510, 230, 'O');
	        OutTextXY(610, 330, 'O');
            SetColor(9);
            OutTextXY(390, 130, 'TA');
            OutTextXY(490, 230, 'TE');
	        OutTextXY(590, 330, 'TI');
            C := C + 1
            End;
        8 : Begin
            SetColor(0);
            OutTextXY(610, 130, 'X');
            OutTextXY(510, 230, 'X');
	        OutTextXY(410, 330, 'X');
            OutTextXY(610, 130, 'O');
            OutTextXY(510, 230, 'O');
	        OutTextXY(410, 330, 'O');
            SetColor(9);
            OutTextXY(590, 130, 'TI');
            OutTextXY(490, 230, 'TE');
	        OutTextXY(390, 330, 'TA');
            C := C + 1
            End
    End
End;

Procedure TABLERO();                                                            //entorno
Begin
    ClearDevice;
    SetColor(3);
    Rectangle(250,75,800, 600);
    SetTextStyle(DefaultFont, HorizDir, 5);
    SetColor(9);
    OutTextXY(0, 20, '         TA-TE-TI');
    SetColor(112);
    OutTextXY(410, 130, '7');
    OutTextXY(510, 130, '8');
    OutTextXY(610, 130, '9');
    OutTextXY(410, 230, '4');
    OutTextXY(510, 230, '5');
    OutTextXY(610, 230, '6');
    OutTextXY(410, 330, '1');
    OutTextXY(510, 330, '2');
    OutTextXY(610, 330, '3');
    SetTextStyle(DefaultFont, HorizDir, 2);
    SetColor(15);
    OutTextXY(435, 470, 'Jugador 1 ');
    OutTextXY(435, 500, 'Jugador 2 ');
    SetColor(14);
    OutTextXY(600, 470, J1);
    OutTextXY(600, 500, J2);
    OutTextXY(380, 470, '[X]');
    SetColor(0);
    SetFillStyle(1, 15);
    Bar3D(475, 105, 480, 400, 0, TopOff);                                       //1ra barra vertical
    Bar3D(575, 105, 580, 400, 0, TopOff);                                       //2da barra vertical
    Bar3D(380, 200, 675, 205, 0, TopOff);                                       //1ra barra horizontal
    Bar3D(380, 300, 675, 305, 0, TopOff)                                        //2da barra horizontal
End;

Procedure RANKING();															//muestra ranking
Begin
    ClearDevice;
	SetColor(3);
	Rectangle(0, 75, GetMaxX, 700);
	SetTextStyle(DefaultFont, HorizDir, 5);
	SetColor(9);
	OutTextXY(0, 20, '         TA-TE-TI');
	SetTextStyle(DefaultFont, HorizDir, 2);
    SetColor(14);
	OutTextXY(0, 150, '          Rank                Player            Score');
	SetColor(15);

    FillChar(Puntos, SizeOf(Puntos), 0);                                        //FillChar para limpiar vectores
    FillChar(Nombre, SizeOf(Nombre), ' ');
    Max := FileSize(Top10) - 1;
    C := 1;
    J := 0;
    For I := 0 To Max Do                                                        //Guardamos registros en vectores
    Begin                                                                       //(Limitado a 1000 jugadores)
        Seek(Top10, I);
        Read(Top10, Buffer);
        Puntos[C] := Buffer.Score;
        Nombre[C] := Buffer.Id;
        C := C + 1
    End;
    For Num := 1 To C Do                                                        //Ordenamiento de vectores de > a <
        For T := Num + 1 To C Do
        Begin
            If Puntos[Num] < Puntos[T] Then
            Begin
                Mayor := Puntos[T];
                Puntos[T] := Puntos[Num];
                Puntos[Num] := Mayor;
                Buff := Nombre[T];
                Nombre[T] := Nombre[Num];
                Nombre[Num] := Buff
            End
    End;
    If Max < 10 Then                                                            //Por si hay menos de 10 registros
        Num := Max + 1
    Else
        Num := 10;
    For T := 1 To Num Do                                                        //Mostramos ranking
    Begin
        STR(T, I2S);
        OutTextXY(170, 200 + j, '#'+I2S);
        OutTextXY(480, 200 + j, Nombre[T]);
        STR(Puntos[T], I2S);
        OutTextXY(780, 200 + j, I2S);
        J := J + 50
    End;
    ReadKey;                                                                    //Cualquier tecla para continuar
End;

Procedure NOMBRES();                                                            //carga nombres
Begin
    FillChar(J1, SizeOf(J1), ' ');                                              //borra nombres previos
    FillChar(J2, SizeOf(J2), ' ');
    ClearDevice;
    SetColor(3);
    Rectangle(0, 75, GetMaxX, 700);
	SetTextStyle(DefaultFont, HorizDir, 5);
    SetColor(9);
    OutTextXY(0, 20, '         TA-TE-TI');
    SetTextStyle(DefaultFont, HorizDir, 2);
    SetColor(15);
    OutTextXY(22, 200, 'Nombre Jugador 1:');
    SetColor(14);
    Tecla := 'X';
    I := 0;
    J := 280;
    While (Ord(Tecla) <> 13) AND (I <> 10) Do                                   //muestra letra x letra
    Begin                                                                       //enter p/continuar
        I := I + 1;                                                             //long max. 10
        J := J + 16;
        Tecla := ReadKey;
        If Ord(Tecla) <> 13 Then
        Begin
            J1[I] := Tecla;
            OutTextXY(J, 200, J1[I])
        End
    End;
    SetColor(15);
    OutTextXY(22, 250, 'Nombre Jugador 2:');
    SetColor(14);
    Tecla := 'X';
    I := 0;
    J := 280;
    While (Ord(Tecla) <> 13) AND (I <> 10) Do                                   //muestra letra x letra
    Begin                                                                       //enter p/continuar
        I := I + 1;                                                             //long max. 10
        J := J + 16;
        Tecla := ReadKey;
        If Ord(Tecla) <> 13 Then
        Begin
            J2[I] := Tecla;
            OutTextXY(J, 250, J2[I])
        End
    End
End;

Procedure TOP();																//actualiza top10
Begin
    If FileSize(Top10) <> 0 Then                                                //si ya jugaron antes
    Begin
        If TTT = TRUE Then                                                      //si no hubo empate
        Begin
            Seek(Top10, 0);
            Flag := FALSE;
            While (Not EOF(Top10)) Do                                           //*1* buscamos si ya jugo alguna vez
            Begin
                Read(Top10, Buffer);
                If Buffer.ID = Win Then                                         //*2* si lo encuentra, actualizamos
                Begin
                    Buffer.Score := Buffer.Score + 10;
                    Seek(Top10, FilePos(Top10) - 1);
                    Write(Top10, Buffer);
                    FLAG := TRUE
                End
            End;
            If FLAG = FALSE Then                                                //*3* sino, creamos nuevo registro
            Begin
                Seek(Top10, FileSize(Top10));
                Buffer.Id := Win;
                Buffer.Score := 10;
                Write(Top10, Buffer)
            End;
            Seek(Top10, 0);
            Flag := FALSE;
            While (Not EOF(Top10)) Do                                           //igual a *1* pero para el perdedor
            Begin
                Read(Top10, Buffer);
                If Buffer.Id = Lose Then                                        //igual a *2* pero para el perdedor
                Begin
                    Buffer.Score := Buffer.Score + 0;
                    Seek(Top10, FilePos(Top10) - 1);
                    Write(Top10, Buffer);
                    FLAG := TRUE
                End
            End;
            If FLAG = FALSE Then                                                //igual a *3* pero para el perdedor
            Begin
                Seek(Top10, FileSize(Top10));
                Buffer.Id := Lose;
                Buffer.Score := 0;
                Write(Top10, Buffer)
            End
        End
        Else                                                                    //si hubo empate...
        Begin
            Seek(Top10, 0);
            Flag := FALSE;
            While (Not EOF(Top10)) Do                                           //igual a *1*
            Begin
                Read(Top10, Buffer);
                If Buffer.Id = Win Then                                         //igual a *2*
                Begin
                    Buffer.Score := Buffer.Score + 5;
                    Seek(Top10, FilePos(Top10) - 1);
                    Write(Top10, Buffer);
                    FLAG := TRUE
                End
            End;
            If FLAG = FALSE Then                                                //igual a *3*
            Begin
                Seek(Top10, FileSize(Top10));
                Buffer.Id := Win;
                Buffer.Score := 5;
                Write(Top10, Buffer)
            End;
            Seek(Top10, 0);
            Flag := FALSE;
            While (Not EOF(Top10)) Do                                           //igual a *1*
            Begin
                Read(Top10, Buffer);
                If Buffer.Id = Lose Then                                        //igual a *2*
                Begin
                    Buffer.Score := Buffer.Score + 5;
                    Seek(Top10, FilePos(Top10) - 1);
                    Write(Top10, Buffer);
                    FLAG := TRUE
                End
            End;
            If FLAG = FALSE Then                                                //igual a *3*
            Begin
                Seek(Top10, FileSize(Top10));
                Buffer.Id := Lose;
                Buffer.Score := 5;
                Write(Top10, Buffer)
            End
        End
    End
    Else                                                                        //si juegan por primera vez
    Begin
        If TTT = TRUE Then                                                      //si hubo ganador...
        Begin
            Buffer.Id := Win;
            Buffer.Score := 10;
            Write(Top10, Buffer);
            Buffer.Id := Lose;
            Buffer.Score := 0;
            Write(Top10, Buffer)
        End
        Else                                                                    //si hubo empate...
        Begin
            Buffer.Score := 5;
            Buffer.Id := Win;
            Write(Top10, Buffer);
            Buffer.Id := Lose;
            Write(Top10, Buffer)
        End
    End
End;

Procedure JUGAR();
Begin
    For I := 1 to 9 Do V[I] := 9;                                               //vector en 9
    NUM := 1;                                                                   //turno en jug. 1
    C := 0;                                                                     //contador de movs. en 0
    P := 0;
    TTT := FALSE;                                                               //flag de ganador en false
    While (C <> 9) AND (TTT = FALSE) Do
        If NUM = 1 Then                                                         //turno jug 1
        Begin
                Repeat                                                          //solo teclado numerico
                Tecla := ReadKey
                Until (Ord(Tecla) > 48) AND (Ord(Tecla) < 58);
                Case Tecla Of
                    '1' : X := 1;
                    '2' : X := 2;
                    '3' : X := 3;
                    '4' : X := 4;
                    '5' : X := 5;
                    '6' : X := 6;
                    '7' : X := 7;
                    '8' : X := 8;
                    '9' : X := 9
                End;
                If V[X] = 9 Then                                                //para no re-ingresar
                Begin                                                           //2 veces misma Tecla
                    NUM := 2;
                    V[X] := 0;                                                  //en 0 para que suma de 0
                    XO := 'X';
                    Check;                                                      //algun ganador?
                    Signos;                                                     //dibujo X u O
                    SetTextStyle(DefaultFont, HorizDir,2);
                    SetColor(14);
                    OutTextXY(380, 500, '[O]');                                 //marca de turno O
                    SetColor(0);
                    OutTextXY(380, 470, '[X]');
                End
                Else
                    Sound(0)                                                    //bip
                End
        Else                                                                    //turno jug 2
        Begin
                Repeat                                                          //solo teclado numerico
                Tecla := ReadKey
                Until (Ord(Tecla) > 48) AND (Ord(Tecla) < 58);
                Case Tecla Of
                    '1' : X := 1;
                    '2' : X := 2;
                    '3' : X := 3;
                    '4' : X := 4;
                    '5' : X := 5;
                    '6' : X := 6;
                    '7' : X := 7;
                    '8' : X := 8;
                    '9' : X := 9
                End;
                If V[X] = 9 Then                                                //para no re-ingresar
                Begin                                                           //2 veces misma tecla
                    NUM := 1;
                    V[X] := 1;                                                  //en 1 para que suma de 3
                    XO := 'O';
                    Check;                                                      //algun ganador?
                    Signos;                                                     //dibujo X u O
                    SetTextStyle(DefaultFont, HorizDir, 2);
                    SetColor(14);
                    OutTextXY(380, 470, '[X]');                                 //marca de turno X
                    SetColor(0);
                    OutTextXY(380, 500, '[O]');
                End
                Else
                    Sound(0)                                                    //bip

    End;

    If NUM = 1 Then                                                             //nombre ganador en Win
    Begin                                                                       //y de perdedor en Lose
        Win := J2;
        Lose := J1
    End
    Else
    Begin
        Win := J1;
        Lose := J2
    End;
    If TTT = TRUE Then                                                          //mostrar ganador o empate
    Begin
        Efecto;                                                                 //poner ta-te-ti en la linea
        SetTextStyle(DefaultFont, HorizDir, 3);
        SetColor(4);
        OutTextXY(270, 550, 'Ganador ' + Win);
        Sound(0)                                                                //bip
    End
    Else
    Begin
        SetTextStyle(DefaultFont, HorizDir, 3);
        SetColor(4);
        OutTextXY(270, 550, 'EMPATE!');
        Sound(0)
    End;
    TOP;                                                                        //actualiza top10
    SetTextStyle(DefaultFont, HorizDir, 2);
    SetColor(15);
    OutTextXY(400, 665, 'Revancha? y / n / m');
    Repeat                                                                      //revancha con y o n
    Tecla := ReadKey;
        If Tecla = 'y' Then
        Begin
            Tablero;
            Jugar
        End
        Else If Tecla = 'n' Then
            Halt
    Until (Tecla = 'y') OR (Tecla = 'n') OR (Tecla = 'm')
End;

Procedure MENU();                                                               //menu de opciones
Begin
    Repeat                                                                      //opciones validadas
    ClearDevice;                                                                //y sin ENTER
    SetColor(3);
    Rectangle(250, 75, 800, 700);
    SetTextStyle(DefaultFont, HorizDir, 5);
    SetColor(9);
    OutTextXY(0, 20, '         TA-TE-TI');
    SetTextStyle(DefaultFont, HorizDir, 2);
    SetColor(15);
    OutTextXY(0, 200, '                   1> Juego Nuevo');
    OutTextXY(0, 280, '                   2> Jugadores');
    OutTextXY(0, 360, '                   3> Mejores Puntajes');
    OutTextXY(0, 440, '                   4> Salir');
    Tecla := ReadKey;
        Case Tecla Of
            '1' : Begin
				  Tablero;
				  Jugar
                  End;
		    '2' : Begin
		          Nombres;
		          Menu
		          End;
            '3' : Begin
                  Ranking;
                  Menu
                  End;
            '4' : Close(Top10)                                                  //cierre de archivo
        End
    Until (Tecla = '4');
End;

Begin                                                                           //prog. principal
	Assign(Top10, 'ranking.dat');                                               //asignacion y apertura de archivo
	{$1-}
	Reset(Top10);
	If IOResult = 2 Then
		ReWrite(Top10);                                                         //verif. si existe o crea archivo
	{$1+}
	HighVideo;                                                                  //letras claras
	CursorOff;                                                                  //no se ve el cursor
	WriteLn;
	WriteLn;
	WriteLn;
	WriteLn('                       Made by MECHELL');                  //creditos
	WriteLn;
	WriteLn('                               PURELY');
	WriteLn;
	WriteLn('                               AND TOTALLY.');
	WriteLn;
	WriteLn;
	WriteLn;
	WriteLn;
	WriteLn;
	WriteLn('                             (ENTER para continuar)');
	Repeat                                                                      //continuar SOLO con ENTER
		Tecla := ReadKey
	Until Ord(Tecla) = 13;
	ClrScr;
	TextColor(0);
	InitGraph(Driver, Mode, '');                                                //inicia modo grafico
	Menu
End.
