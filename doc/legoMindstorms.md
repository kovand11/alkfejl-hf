@page robotleiras Lego MINDSTORMS robot bemutatása

@section s0 Mi a Lego Mindstorms?  
A LEGO MINDSTORMS egy programozható robotikai építőkészlet, amely lehetővé teszi, hogy a felhasználó számára, hogy saját robotot építhessen és programozhasson. Az új LEGO MINDSTORMS EV3 készlet olyan elemeket tartalmaz, amelyek segítségével ahhoz kell, létrehozható a gyártó által előre definiált 17 robot bármelyike, melyej képesek járni, beszélni, mozogni és egyéb parancsokat végrehajtani. Az EV3 ingyenes szoftvert és ingyenes appokat kapott, amelyekkel a robotokat lehet építeni, programozni és irányítani PC-ről, Mac-ről, tabletről vagy okostelefonról. 
A rendelkezésre álló robot a LEGO MINDSTORMS platform harmadik generációja, az “EV” pedig evolúciót jelent, innen származik az EV3 elnevezés. [1]

@section s1 A készlet tartalma 
@subsection s1_1 EV3 építőelem
Az EV3 Építőelem egy programozató intelligens Építőelem, amely nem más, mint a robot agya. Irányítja a motorokat és az érzékelőket, hogy mozogjanak, lépjenek és beszéljenek, valamint vezeték nélküli kommunikációt szolgáltat Wi-Fi-n és Bluetooth-on keresztül.
<img src="EV3_brick.png" style="width: 50%;"/>

A Display (Kijelző) megmutatja, hogy mi zajlik az EV3 Brick-en belül, és lehetővé teszi a tégla felhasználói felületének használatát. Ez alkalmat ad arra is, hogy szöveggel és számjegyes vagy grafikus válaszokkal egészíthessük ki programjainkat vagy kísérleteinket. Például, be szeretnénk programozni, hogy a Kijelzőn egy összehasonlítás eredményeként egy vidám arc (vagy egy szomorú) jelenjen meg, vagy egy számot szeretnénk kijelezni, amely egy matematikai számítás eredménye. [2]
A Brick Buttons (Tégla gombok) lehetővé teszik az EV3 Brick felhasználói felületén belüli navigálást. Programozható aktiválóként is használhatók. Például, úgy szeretnénk beprogramozni egy robotot, hogy a Fel gomb megnyomásakor emelje fel a karját, vagy a Le gomb megnyomásakor engedje le.
A Brick Status Light (Tégla állapotjelző fény), amely körülveszi a Brick Buttons-okat (Tégla gombokat) tájékoztat az EV3 Brick aktuális állapotáról. Ez lehet zöld, narancsszínű vagy piros, de villoghat is. A Brick Status Light kódja a következő: [2]
	- Piros = Indítás, Frissítés, Leállítás 
	- Villogó piros = Elfoglalt 
	- Narancsszínű = Figyelmeztetés, Kész 
	- Villogó narancsszínű = Figyelmeztetés, Működés 
	- Zöld = Kész 
	- Villogó zöld = Programfutás

@subsection s1_2 2 Nagy interaktív szervomotor (Large Motor)
A Large Motor egy erőteljes „okos” motor. Beépített Rotation Sensorral (Forgásérzékelő) van felszerelve, amely 1-fokos pontosságú, precíz szabályozást tesz lehetővé. A Large Motor arra optimalizálva, hogy ez legyen robotjaink meghajtásának alapja. Ha az EV3 Software Move Steering (Mozgásvezérlés) vagy Move Tank programming block-ját (Mozgástank programblokk) használjuk, akkor a Large Motors egyidejűleg koordinálják a mozgást. [2]
<img src="large_motor.png" style="width: 30%;"/>
 
@subsection s1_3 1 Közepes méretű interaktív szervomotor (Medium Motor)
A Medium Motor-ban is megtalálunk egy beépített Rotation Sensor-t (1-fokos érzékenységű), de ez kisebb és könnyebb, mint a Large Motor. Ez azt jelenti, hogy gyorsabban reagál, mint a Large Motor. A Medium Motor-t beprogramozhatjuk be- és kikapcsolásra, megadott ideig tartó mozgásra vagy adott számú fordulatra, és szabályozhatjuk az erejét. [2]
<img src="medium_motor.png" style="width: 30%;"/>
 
@subsection s1_4 1 Érintésérzékelő (Touch Sensor)
A Touch Sensor egy analóg érzékelő, amely képes érzékelni, amikor az érzékelő piros gomb pressed (megnyomták), vagy released (feloldották). Ez annyit jelent, hogy a Touch Sensor-t beprogramozhatjuk úgy, hogy három különböző feltétel esetén reagáljon – megnyomásra, feloldásra vagy bumped-re (ütközött) (megnyomás és feloldás együtt). A Touch Sensor-ról érkező bemenőjelet felhasználva egy robotot be lehet úgy programozni, hogy úgy érzékelje a világot mint egy vak ember, aki kinyújtja a kezét és akkor reagál, ha megérint valamit (megnyomás). [2]
<img src="touch_sensor.png" style="width: 30%;"/>

@subsection s1_5 1 Színérzékelő (Color Sensor)
A Color Sensor egy olyan digitális érzékelő, amely érzékeli annak a fénynek a színét vagy erősségét, amely bejut az érzékelő elején elhelyezett kis ablakon. Ennek az érzékelőnek három különböző üzemmódja lehet: Color Mode (Szín mód), Reflected Light Intensity Mode (Visszavert fényerősség mód) és Ambient Light Intensity Mode (Szórt fényerősség mód). [2]
<img src="color_sensor.png" style="width: 30%;"/>
 
@subsection s1_6 1 Infravörös érzékelő (Infrared Sensor)
Az Infrared Sensor egy olyan digitális érzékelő, amely képes észlelni a szilárd tárgyakról visszaverődő infravörös fényt. A Remote Infrared Beacon infravörös fényét is képes észlelni. Az Infrared Sensor-nak három különböző üzemmódja lehet: Proximity Mode (Közelségi mód), Beacon Mode (Irányjeladó mód) és Remote Mode (Távirányító mód). [2]
<img src="infrared_sensor.png" style="width: 30%;"/>
![](infrared_sensor_range.png)
 
@subsection s1_7 1 Infravörös irányjeladó (Remote Infrared Beacon)
A Remote Infrared Beacon (Távirányító infravörös irányjeladó) egy önálló eszköz, amelyet tarthatunk kézben, vagy beépíthetjük egy másik LEGO® modellbe. Két AAA méretű alkáli elemre van szükség a működéséhez. A Remote Infrared Beacon bekapcsolásához, nyomjuk meg az eszköz tetején található Beacon Mode (Irányjeladó mód) gombot. Egy zöld színű LED kijelző világítani kezd, ez jelzi, hogy az eszköz aktív és folyamatosan jelet sugároz. Ha ismét megnyomjuk a Beacon Mode gombot, akkor kikapcsol (egy órányi tétlenség után az irányjeladó önműködően kikapcsol). [2]
<img src="remote_infrared_beacon.png" style="width: 30%;"/>
 
@section s2 Miben jelent újat a MINDSTORMS az elődjéhez, NTX-hez képest?
Nagyon sok új funkcióval bővült és fejlesztésen ment át az EV3 Szoftver az NXT Szoftverhez képest. A leginkább figyelemre méltók közül néhány: [1]
Lobby (Előszoba):
	- Új, teljes képernyős Lobby-ban lehet navigálni a rendelkezésre álló tartalomban, köztük az öt EV3 Hősrobot, TRACK3R, SPIK3R, R3PTAR, GRIPP3R és EV3RSTORM projektfájljaiban, plusz közvetlen kapcsolat van a 12 Rajongók által készített jutalom robothoz is.

Content Editor (Tartalomszerkesztő):
	- A tartalmat közvetlenül a szoftverben lehet szerkeszteni, ezzel egyénivé alakíthatóak át a meglévő projektek, de akár teljesen újakat is lehet alkotni a semmiből.

Szorosabb integráció az EV3 Építőelem és a programozási környezet között:
	- A hardveroldal lehetővé teszi az állapot és a mért értékek figyelését minden hardverelemnél.
	- A hardverelemek automatikus felismerése az Auto ID-nek köszönhetően.
	- A Bluetooth konfigurációt támogatják az USB-Bluetooth szolgáltatások.
	
A hibakeresési szolgáltatások a programozási környezet részei lettek:
	- A végrehajtás lényegesebb elemei
	- A programblokkok figyelmeztető jelet jelenítenek meg, ha a programblokk által várt hardver és az Auto ID által érzékelt hardver nem egyezik.
	- Szondák teszik lehetővé az értékek megjelenítését adatvezetékeken keresztül.

Új programblokk kezelési lehetőségek:
	- Egyszerűsíthető a programozás a blokkok összekattintásával (nem kell többé a sugarat használni).
	- A blokkparamétereket közvetlenül a blokkokban lehet beállítani.
	- A programsorrend közvetlenül beolvasható a blokkokba.
	- Jobb sorrendi vezetéke segítik a program szerkezetének áttekintését, és párhuzamos végrehajtás kialakítását.
	- “Változásra váró funkcióval is kiegészült, így egyszerűen lehet olyan robotokat alkotni, amelyek a környezet változására reagálnak, ahelyett, hogy egy küszöbértékre várnának, ami csak mért értékek összehasonlításával működik.
	- Az adatvonalak is fejlődtek, és adat átalakítással is bővült, ez egyszerűbbé teszi az adattípusok átalakítását.
	- A tömbök a normál blokkokba vannak integrálva.
	- Hurokmegszakítás is lehetővé vált, ez pedig fejlettebb állapotvezérlő mechanizmusokat tesz lehetővé.

