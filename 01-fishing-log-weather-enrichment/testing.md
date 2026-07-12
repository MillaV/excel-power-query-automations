# Testaus

Manuaalisesti läpikäydyt testitapaukset ennen projektin viimeistelyä.

| # | Testitapaus | Tulos |
|---|---|---|
| 1 | Hakeeko kysely oikeat luvut? Verrattu Ilmatieteenlaitoksen omiin havaintoarvoihin. | ✅ OK |
| 2 | Mitä tapahtuu, jos aloitus- tai lopetusaika puuttuu? | Säätietoja ei haeta. Käyttäjän syöttämä data (esim. saalismäärä) tallentuu silti normaalisti. |
| 3 | Mitä tapahtuu, jos aloitusaika on vahingossa lopetusajan jälkeen? | Säätietoja ei haeta. Käyttäjän syöttämä data tallentuu silti normaalisti. |
| 4 | Mitä tapahtuu, jos saalismäärä on negatiivinen? | Syöttö estetään kokonaan Excelin tietojen vahvistuksella – väärää arvoa ei pääse edes tallentamaan. |
| 5 | Mitä tapahtuu, jos havaintoaseman koodi (FMISID) on väärä? | Säätietoja ei haeta. Käyttäjän syöttämä data tallentuu silti normaalisti. |
| 6 | Mitä tapahtuu, jos päivämäärä on tulevaisuudessa? | Säätietoja ei haeta. Käyttäjän syöttämä data tallentuu silti normaalisti. |

## Huomio
Testit 2, 3, 5 ja 6 kuvaavat tilannetta ennen backlogin kohdan 5 korjausta (ks. `backlog.md`). Näissä tapauksissa Lampotila_ka/Ilmanpaine_ka jäivät aiemmin tyhjiksi ilman selitystä; korjauksen jälkeen sarakkeisiin tulee näkyviin teksti "Virhe: säätietoa ei saatu", jotta syy on käyttäjälle heti selvä.
