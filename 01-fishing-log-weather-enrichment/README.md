# Excel-taulukon rikastaminen säädatalla (Power Query)

## Ongelma
Kalastaja pitää Excel-taulukkoa kalapäiväkirjana, johon kirjaa jokaisesta kalastuskerrasta mm. sijainnin, kellonajat ja saalismäärän. Hän haluaisi liittää jokaiseen kirjaukseen myös kyseisen ajanjakson keskeiset säätiedot. Esimerkiksi keskilämpötilan ja -ilmanpaineen. Tietojen hakeminen käsin Ilmatieteenlaitoksen sivuilta jokaiselle riville on niin työlästä, että säätiedot jäävät usein kokonaan kirjaamatta.

## Tavoite
Automatisoida säätietojen haku ja liittäminen kalapäiväkirjaan Ilmatieteenlaitoksen avoimen datan avulla, niin että käyttäjä syöttää vain sijainnin (sääasema), saalismäärän sekä kalastuksen aloitus- ja lopetusajan. Kyseiseltä ajalta säätiedot täyttyy automaattisesti taulukkoon.

## Rajaukset
Tässä projektissa säätiedoista haetaan vain lämpötila sekä ilmanpaineen keskiarvo.

## Käytetyt teknologiat
- Microsoft Excel / Power Query (M-kieli)
- Ilmatieteenlaitoksen avoin data, WFS-rajapinta

## Työnkulku (lopullinen ratkaisu)
1. Käyttäjä lisää "Kalastukset"-taulukkoon uuden rivin: FMISID (sääasema), aloitusaika, lopetusaika ja saalis-lkm
2. Erillinen Power Query -funktio (`HaeKeskiarvo`) hakee annetulla aikavälillä havainnot Ilmatieteenlaitoksen rajapinnasta ja laskee niistä keskiarvon.
3. Toinen kysely (`KalastuksetAutomaatio`) käy koko taulukon läpi rivi riviltä ja kutsuu funktiota kahdesti per rivi – kerran lämpötilalle (t2m), kerran ilmanpaineelle (p_sea).
4. Tulos ladataan omalle "Tulokset"-välilehdelle, josta käyttäjä näkee jokaisen kalastuskerran keskilämpötilan ja -ilmanpaineen.
5. Käyttäjä päivittää tiedot napista ("Päivitä kaikki") aina lisättyään uusia rivejä.

## Projektin vaiheet ja ratkaisut
1. **Työkalun valinta.** Aluksi ajattelin tehdä tämän MAKE.com:n avulla, mutta kysyin vielä tekoälyltä ehdotusta vaihtoehtoisista toteutustavoista. Sieltä kautta ehdotuksena olivat Google Apps Script ja Power Query. Valitsin Power Queryn, koska käyttäjä kirjasi Exceliin tiedot. 
2. **Liian laaja yritys** Kokeilin ensin hakea koko vuorokauden datan yhdellä laajalla kyselyllä, jonka XML-vastaus osoittautui erittäin syvästi sisäkkäiseksi (6+ tasoa INSPIRE/GML-rakennetta). Tämä teki rakentamisesta hidasta ja virhealtista – väärän haaran klikkaaminen johti useita kertoja umpikujaan. Hakua oli vaikea hallita.
3. **Yksinkertaistus.** Lähdin yksinkertaistamaan kyselyn rakennetta. Se antoi saman tiedon paljon selkeämmässä, suoraviivaisemmassa muodossa, jolloin oikean tiedon löytäminen helpottui huomattavasti.
4. **Raakadatan testaus ennen laskentaa.** Ennen kuin aloin laskea mitään keskiarvoja, halusin ensin varmistaa, että saan ylipäätään oikeat säätiedot oikealta ajalta näkyviin Exceliin. Tämä osoittautui hyväksi tavaksi edetä, koska pystyin tarkistamaan yksinkertaisesti silmämääräisesti, että luvut näyttivät järkeviltä, ennen kuin lisäsin monimutkaisempaa logiikkaa päälle.
5. **Sain vain yhden rivin toimimaan – piti keksiä miten koko taulukko saadaan toimimaan.** Ensimmäinen toimiva versioni haki tiedot aina vain taulukon ensimmäiseltä riviltä, jonka takia uusien kalastuspäivien lisääminen ei tuonut niille omia säätietoja – kaikki rivit näyttivät saman, ensimmäisen rivin luvut. Piti siis muuttaa tapaa niin, että sama haku toistuu automaattisesti jokaiselle riville erikseen, sen mukaan mitkä ajat kyseiselle riville on kirjoitettu.
6. **Varmistin, ettei yksi puutteellinen rivi kaada koko taulukkoa.** Jos joltain riviltä puuttuu esim. lopetusaika, koko automaatio olisi voinut kaatua virheeseen jokaisen päivityksen yhteydessä. Lisäsin logiikkaan suojan, jonka ansiosta puutteellinen rivi jää vain tyhjäksi eikä estä muiden rivien tietojen päivittymistä.

## Keskeiset haasteet
- **Numeroiden ja päivämäärien muoto aiheutti eniten ongelmia:** Suomalainen Excel kirjoittaa luvut ja kellonajat eri tavalla kuin mitä säätiedot-rajapinta odotti (esim. pilkku pisteen sijaan luvuissa, piste kaksoispisteen sijaan kellonajoissa). Tämän takia sain useita virheilmoituksia, vaikka data näytti silmämääräisesti aivan oikealta.
- **Ulkoisen rajapinnan (Ilmatieteenlaitoksen säädatan) hakeminen ei ollut suoraviivaista:** Data tuli monimutkaisessa muodossa, ja jouduin useaan otteeseen yksinkertaistamaan lähestymistapaani, jotta sain siitä irti juuri ne tiedot, joita tarvitsin (lämpötila ja ilmanpaine).
- **Kiinteästä hausta joustavaan hakuun:** Ensimmäinen versioni haki tiedot aina vain taulukon ensimmäiseltä riviltä, joten uusien kalastuspäivien lisääminen ei toiminut. Jouduin rakentamaan ratkaisun uudelleen niin, että sama haku toistuu automaattisesti jokaiselle riville erikseen.
- **Tekoäly (Claude) ei tehnyt virheitä tyhjäksi, mutta nopeutti niiden ratkaisemista:** Käytin projektin tekemisessä apuna Claudea sparrauskumppanina koko prosessin ajan. Vaikka tekoäly ehdotti korjauksia, matkan varrella tuli silti useita virheilmoituksia – osa johtui väärinymmärryksistä puolin ja toisin, osa siitä, että ongelma paljastui vasta kun kokeilin ratkaisua käytännössä. Tekoälyn kanssa työskentely on iteratiivista: virhe, korjausehdotus, uusi testi, seuraava virhe – ei suoraa "kysy ja saat toimivan koodin" -prosessia.

## Mitä opin
- Kannattaa testata jokainen rakennuspala (raakadatan haku, yhden rivin laskenta) erikseen ennen kuin yhdistää ne isommaksi automaatioksi – tämä paljastaa virheet paljon aikaisemmin kuin jos yrittää rakentaa koko putken kerralla.
- Kiinnittämään huomiota siihen, että jo kirjausvaiheessa data kirjataan oikein. Excelin työkalulla "Tietojen kelpoisuuden tarkastaminen" pystyy asettamaan ehtoja, jotta kirjaukset menee oikein.
- Tekoälyn käyttö kehitystyössä on taito siinä missä koodaaminenkin: osasin kuvata virhetilanteet tarkasti (mm. kuvakaappauksilla) ja edetä pienin askelin, mikä teki yhteistyöstä tehokasta. Jatkossa määrittelisin vielä tarkemmin alkuun projektin suunnitelmaa.

- ## Jatkokehitysideat
- Virheilmoitusten sijaan käyttöliittymään voisi lisätä selkeän tekstin ("Tarkista aloitus-/lopetusaika"), kun rivi jää tyhjäksi.
- Sääaseman (FMISID) voisi hakea automaattisesti sijainnin perusteella, jos kalastuspaikkoja olisi useampi (aiemmin hylätty toteutustapa – ks. alkuperäinen Miro-suunnitelma).
- Automaattinen päivitys tiedoston avautuessa ("Refresh on open") sen sijaan, että käyttäjä painaa "Päivitä kaikki" manuaalisesti.

## Kuvakaappaukset
*(lisää vielä: Kalastukset-taulukko, Power Query -funktio HaeKeskiarvo, KalastuksetAutomaatio-kyselyn koodi, Tulokset-välilehti)*
