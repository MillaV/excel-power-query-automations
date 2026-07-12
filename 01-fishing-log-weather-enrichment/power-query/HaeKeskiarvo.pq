(FmisidArvo as any, AlkuArvo as datetime, LoppuArvo as datetime, ParametriArvo as text) as number =>
let
    Fmisid = Number.ToText(FmisidArvo),
    AlkuAikaUTC = AlkuArvo - #duration(0, 3, 0, 0),
    LoppuAikaUTC = LoppuArvo - #duration(0, 3, 0, 0),
    AlkuAika = DateTime.ToText(AlkuAikaUTC, "yyyy-MM-ddTHH:mm:ss", "en-US") & "Z",
    LoppuAika = DateTime.ToText(LoppuAikaUTC, "yyyy-MM-ddTHH:mm:ss", "en-US") & "Z",
    Lahde = Xml.Tables(
        Web.Contents(
            "https://opendata.fmi.fi/wfs",
            [
                Query = [
                    service = "WFS",
                    version = "2.0.0",
                    request = "getFeature",
                    storedquery_id = "fmi::observations::weather::simple",
                    fmisid = Fmisid,
                    parameters = ParametriArvo,
                    starttime = AlkuAika,
                    endtime = LoppuAika
                ]
            ]
        )
    ),
    member = Lahde{0}[member],
    Laajennettu1 = Table.ExpandTableColumn(member, "http://xml.fmi.fi/schema/wfs/2.0", {"BsWfsElement"}, {"BsWfsElement"}),
    Laajennettu2 = Table.ExpandTableColumn(Laajennettu1, "BsWfsElement", {"ParameterValue"}, {"ParameterValue"}),
    Muutettu = Table.TransformColumnTypes(Laajennettu2, {{"ParameterValue", type number}}, "en-US"),
    Keskiarvo = List.Average(Muutettu[ParameterValue])
in
    Keskiarvo
