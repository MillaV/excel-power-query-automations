# Backlog

## Tehdyt korjaukset

| # | Kohde | Ratkaisu | Tila |
|---|---|---|---|
| 1 | Kyselyihin liittyvät virheviestit | Poistettiin/lopetettiin turhien, vanhentuneiden kyselyjen lataus | ✅ Tehty |
| 2 | Estä negatiivinen saalismäärä | Excelin "Tietojen kelpoisuuden tarkistaminen" -työkalulla | ✅ Tehty |
| 3 | Estä aloitusaika lopetusajan jälkeen | Excelin "Tietojen kelpoisuuden tarkistaminen" -työkalulla | ✅ Tehty |
| 4 | Havaintoaseman koodi (FMISID) väärin | Tarkistetaan merkkimäärä "Tietojen kelpoisuuden tarkistaminen" -työkalulla. **Huom:** ei takaa, että koodi todellisuudessa vastaa olemassa olevaa asemaa – vain oikea pituus varmistetaan. | ✅ Tehty (kevyt versio) |
| 5 | Säätietoja ei saada haettua (virheellinen FMISID tai puuttuva data ajankohdalta) | Muutettiin kyselyn logiikkaa: tyhjän solun sijaan näytetään teksti "Virhe: säätietoa ei saatu" | ✅ Tehty |
| 6 | Estä tulevaisuuteen osoittava päivämäärä  | Excelin "Tietojen kelpoisuuden tarkistaminen" -työkalulla | ✅ Tehty |

## Suunnitellut lisäykset/muutokset

- Pilvisyys (asteikko 0–8/8)
- Säätiedot vain aloitus- ja lopetusajalta, keskiarvon sijaan

## Mahdollisia jatkokehityskohteita

- FMISID pudotusvalikoksi kiinteästä asemalistasta (tarkempi kuin nykyinen merkkimäärätarkistus)
- Asemanimi näkyviin FMISID-numeron rinnalle, luettavuuden parantamiseksi
- Kesto-sarake (lopetusaika − aloitusaika tunteina)
- Yksinkertainen kaavio saalismäärän ja säätietojen välisestä yhteydestä
