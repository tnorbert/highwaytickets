# highwaytickets

Telepítési útmutató:
Az alkalmazásban egy target található, development build configgal. Aláírás nélkül, szimulátorban futtatható (fejlesztve: iPhone 16, iOS 18.4).
A mellékelt docker képfájlt használtam a fejlesztéshez. A szerver ip címét az "ApplicationConfiguration" Osztályon belül lehet módosítani.

Architektúra:
Úgy gondoltam, hogy SwiftUI-ban készítem el a teszt projektet UIKit helyett. Az elmúlt időszak tapasztalatai alapján ios 17+ targetelés esetén már "production ready", szinte minden elkészíthető benne, ami nem, azt meg "UIKit bridging" segítségével át lehet hidalni.

UIKit-ben MVVM + Coordinator pattern-t szoktam alkalmazni, itt viszont MVI + coordinator pattern van használva, azaz "Minimum Viable Implementation". 
Tapasztalataim szerint SwiftUI környezetben erősen lehet támaszkodni a rendszer belső működésére (Observable, states, concurrency, combine) és kevésbé kell túlmérnökölni az oldalakat. 

Javaslatok a tovább fejlesztésekhez:

1.) SwiftUI-ban a navbar állíthatósága korlátos, jelenleg a gyári navbar van használva, annak is egy UIKit-es megfestett verziója (Appearence), azonban GeometryReader segítségével implementálható lett volna a corner radiusos navbar, bár ez erősen egyedi megoldás lett volna.

2.) A "loader" és az utolsó oldalon alkalmaztam animációkat, ezek csak minta jellegűek, SwiftUI-ban nagyon könnyen lehet animálni és érdemes minden oldalon kisebb nagyobb animációkat elrejteni.

3.) Dependency injection: A projektekben használok DI-t, a SwiftUI alapból egy .environmentObject-et használ az injektálásra, ezt használtam én is, bár nálam az oldlaknál jelenleg paraméterben mennek be usecase-ek de ezeket érdemes lenne mind átvinni .environmentObject-be.

4.) Offline mód: Jelenleg nincs semmilyen offline mód vagy cache implementálva. Normál esetben minimum egy SQLite megoldással szoktam adatokat menteni, de SwiftUI esetében a SwiftData használata is előnyös lehet. 

5.) Térkép: Azt a megoldást találtam ki, hogy az eredeti hungary svg-t daraboltam fel úgy, hogy az eredeti térkép viewport-ja megmaradjon. Elkészítettem az összes megye saját svg-jét, ami a "parent" viewport-jában helyezkedik el, így egymásra rajzolva pont kiadják a Magyarország térképet. Ezzel a megoldással könnyen lehet állítani az egyes megyéket és teljesítmény problémákat sem okoz, mivel kis adatokról van csak szó. Amennyiben szofisztikáltabb megoldás fele mennénk, az egyes megyék "path" adatit átkonvertálnám CGPath adatra és egy Canvasra egyedi felrajzolással szintén meg lehetne csinálni a térképet. Ezt az alapján dönteném el éles helyzetben,hogy megvizsgálnám az alkalmazás működését régebbi támogatott eszközön, pl iPhone 12.

6.) API: A jelenlegi API-t próbáltam implementálni. Az éves vármegyés rész sajátosan sikerült, mert csak azt nézem, hogy "year" kategóriájú vignette van-e a válaszban és ha van, akkor ennek az árával kezelem az összes vármegyét, illetve, ebben az esetben mindig megvásolható az összes vármegye. Remélem ez nem okoz problémát, a végeredmény szempontjából az app egyéb működését nem befolyásolja. Mivel a megyék száma fix és az esetleges változás egy lassú folyamat, éles helyzetben javasolnám a kevésbé dinamikus API-t, azaz, az API-ban definiálnám külön az összes megyét, saját árazásukkal, adataikkal.

7.) Dark mode: Jelenleg ki van kapcsolva a dark mode, kényszerítve van a light, azonban az asset szinten vannak definiálva a színek, így meglévő paletta esetén viszonylag könnyen lehetne dark mode-ot implementálni

8.) iPad: Ipad support jelenleg nincs, viszont a SwiftUI segítségével relatíve könnyen lehet támogatni további eszköz típusokat is.
