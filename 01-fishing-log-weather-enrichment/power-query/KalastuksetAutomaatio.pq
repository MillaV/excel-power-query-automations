let
    Kalastukset = Excel.CurrentWorkbook(){[Name="Kalastukset"]}[Content],
    MuutettuFMISID = Table.TransformColumnTypes(Kalastukset,{{"FMISID", type number}}),
    LisattyLampotila = Table.AddColumn(MuutettuFMISID, "Lampotila_ka", each
        let
            Yritys = try HaeKeskiarvo([FMISID], [Aloitusaika], [Lopetusaika], "t2m")
        in
            if Yritys[HasError] then "Virhe: säätietoa ei saatu" else Yritys[Value]
    ),
    LisattyIlmanpaine = Table.AddColumn(LisattyLampotila, "Ilmanpaine_ka", each
        let
            Yritys = try HaeKeskiarvo([FMISID], [Aloitusaika], [Lopetusaika], "p_sea")
        in
            if Yritys[HasError] then "Virhe: säätietoa ei saatu" else Yritys[Value]
    ),
    PalautettuPaivamaarat = Table.TransformColumnTypes(LisattyIlmanpaine,{
        {"Aloitusaika", type datetime}, 
        {"Lopetusaika", type datetime}
    })
in
    PalautettuPaivamaarat
