@page commands Parancsok leírása

A felhasználói felületen az IP cím és port beírása utána Connect gombra kell kattintani.
Sikeres csatlakozás esetén üzenetet kapunk és megjelenik fekete háttéren egy piros pötty, amit megfogva és mozgatva joystick-szerűen kell irányítani a robotot.
A robottól kapott információk szövegesen és vizuálisan is megjelennek.
A tesztek indítása a bal oldalon található.
Robot hiányában a robot emulálható, ehhez balra lent kell bejelölni az erre utaló nevű checkbox-ot.


A robotnak küldhető üzenetek: 
    * ping - Ezt küldve ok-t várunk válasznak
    * ok - ping-re adott válasz
    * speed s:float - sebesség beállítása m/s-ban
    * forward - előremenet
    * backward - hátramenet
    * stop - megállítás
    * turn: ang:float - elfordulás megadása °-ban
    * starttest - Teszt: maxspeed és előre, visszavárja a startresult-ot
    * turntest - Teszt: kormány ütközésig, visszavárja a turnresult-ot


A robottól kapott üzenetek:
    * ping - Ezt küldve ok-t várunk válasznak
    * ok - ping-re adott válasz
    * touch t:bool - indulásnál és állapotváltozásnál
    * rgb r:float g:float b:float - a színszenzor átltal mért érték színcsatornánként
    * dist d:float - távolságérzékelő aktuális értéke m-ben
    * speed s:float - sebesség aktuális értéke m/s-ban
    * steer s:float - kormányállás aktuális értéke °-ban
    * log l:string - tetszőleges szöveges üzenet a robottól, amit meg kell jeleníteni a felhasználó számára
    * log l:string - tetszőleges szöveges üzenet a robottól, amit meg kell jeleníteni a felhasználó számára
    * startresult time:int speed:float time speed time speed .... - visszaadja, hogy hogyan indult el (n darab timestamp = ms és speed érték)
    * turnresult left:float right:float - 	visszaadja, hogy meddig sikerült a kormányt kitéríteni