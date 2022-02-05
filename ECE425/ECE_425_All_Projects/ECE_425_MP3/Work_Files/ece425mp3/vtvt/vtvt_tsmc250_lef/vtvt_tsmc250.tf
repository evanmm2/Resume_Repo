; **************************
; VTVT LAB
; Generated: Friday, December 8, 2006
; Author: Jeannette Djigbenou
; This Technology File for TSMC_CMOS025_DEEP
; is configured for Place and Route
; It contains modifications to the NCSU Kit 1.5.1
; Files listed here are:
;	tsmc03d.tf
;	layerDefinitions.tf (from tsmc03d.tf)
;	layerRules.tf (Only modified in this file)
;	physicalRules.tf
; 	electricalRules.tf (new one)
;	devices.tf
; 	physicalDesignAppRules.tf
;	prRules.tf (modified for P&R)
; **************************

;********************************
; CONTROLS
;********************************
controls(
    techParams(
        ( lambda               0.12 )
        ( technology           "TSMC_CMOS025_DEEP" )
        ( metal3Available      t )
        ( metal4Available      t )
        ( metal5Available      t )
        ( metalcapAvailable    t )
        ( sblockAvailable      t )
        ( hvAvailable          t )
    )
);controls

;********************************
; LAYER DEFINITION
;********************************
layerDefinitions(

 techPurposes(
 ;( PurposeName               Purpose#   Abbreviation )
 ;( -----------               --------   ------------ )
 ;User-Defined Purposes:
 ;System-Reserved Purposes:
  ( warning                   234        wng          )
  ( tool1                     235        tl1          )
  ( tool0                     236        tl0          )
  ( label                     237        lbl          )
  ( flight                    238        flt          )
  ( error                     239        err          )
  ( annotate                  240        ant          )
  ( drawing1                  241        dr1          )
  ( drawing2                  242        dr2          )
  ( drawing3                  243        dr3          )
  ( drawing4                  244        dr4          )
  ( drawing5                  245        dr5          )
  ( drawing6                  246        dr6          )
  ( drawing7                  247        dr7          )
  ( drawing8                  248        dr8          )
  ( drawing9                  249        dr9          )
  ( boundary                  250        bnd          )
  ( pin                       251        pin          )
  ( drawing                   252        drw          )
  ( net                       253        net          )
  ( cell                      254        cel          )
  ( all                       255        all          )
 ) ;techPurposes

 techLayers(
 ;( LayerName                 Layer#     Abbreviation )
 ;( ---------                 ------     ------------ )
 ;User-Defined Layers:
  ( default                   0          default      )
  ( nactive                   1          nactive      )
  ( pactive                   2          pactive      )
  ( active                    3          active       )
  ( tactive                   5          tactive      )
  ( pwell                     6          pwell        )
  ( via2                      7          via2         )
  ( via                       8          via          )
  ( via3                      9          via3         )
  ( via4                      10         via4         )
  ( nwell                     12         nwell        )
  ( gwell                     18         gwell        )
  ( pad                       29         pad          )
  ( poly                      35         poly         )
  ( glass                     36         glass        )
  ( nselect                   39         nselect      )
  ( pselect                   40         pselect      )
  ( gselect                   41         gselect      )
  ( metal1                    45         metal1       )
  ( metal3                    46         metal3       )
  ( metal4                    47         metal4       )
  ( metal5                    48         metal5       )
  ( metal2                    50         metal2       )
  ( ca                        56         ca           )
  ( cp                        57         cp           )
  ( cc                        59         cc           )
  ( sblock                    62         sblock       )
  ( metalcap                  64         metalcap     )
  ( nodrc                     80         nodrc        )
  ( cap_id                    81         cap_id       )
  ( res_id                    82         res_id       )
  ( nolpe                     83         nolpe        )
  ( dio_id                    84         dio_id       )
  ( hdrc                      126        hdrc         )
 ;System-Reserved Layers:
  ( Unrouted                  200        Unroute      )
  ( Row                       201        Row          )
  ( Group                     202        Group        )
  ( Cannotoccupy              203        Cannoto      )
  ( Canplace                  204        Canplac      )
  ( hardFence                 205        hardFen      )
  ( softFence                 206        softFen      )
  ( y0                        207        y0           )
  ( y1                        208        y1           )
  ( y2                        209        y2           )
  ( y3                        210        y3           )
  ( y4                        211        y4           )
  ( y5                        212        y5           )
  ( y6                        213        y6           )
  ( y7                        214        y7           )
  ( y8                        215        y8           )
  ( y9                        216        y9           )
  ( designFlow                217        designF      )
  ( stretch                   218        stretch      )
  ( edgeLayer                 219        edgeLay      )
  ( changedLayer              220        changed      )
  ( unset                     221        unset        )
  ( unknown                   222        unknown      )
  ( spike                     223        spike        )
  ( hiz                       224        hiz          )
  ( resist                    225        resist       )
  ( drive                     226        drive        )
  ( supply                    227        supply       )
  ( wire                      228        wire         )
  ( pin                       229        pin          )
  ( text                      230        text         )
  ( device                    231        device       )
  ( border                    232        border       )
  ( snap                      233        snap         )
  ( align                     234        align        )
  ( prBoundary                235        prBound      )
  ( instance                  236        instanc      )
  ( annotate                  237        annotat      )
  ( marker                    238        marker       )
  ( select                    239        select       )
  ( grid                      251        grid         )
  ( axis                      252        axis         )
  ( hilite                    253        hilite       )
  ( background                254        backgro      )
 ) ;techLayers

 techLayerPurposePriorities(
 ;layers are ordered from lowest to highest priority
 ;( LayerName                 Purpose    )
 ;( ---------                 -------    )
  ( pwell                     drawing    )
  ( nwell                     drawing    )
  ( active                    drawing    )
  ( tactive                   drawing    )
  ( nactive                   drawing    )
  ( pactive                   drawing    )
  ( nselect                   drawing    )
  ( pselect                   drawing    )
  ( poly                      drawing    )
  ( metal1                    drawing    )
  ( metal2                    drawing    )
  ( metal3                    drawing    )
  ( metal4                    drawing    )
  ( metalcap                  drawing    )
  ( metal5                    drawing    )
  ( cp                        drawing    )
  ( ca                        drawing    )
  ( cc                        drawing    )
  ( via                       drawing    )
  ( via2                      drawing    )
  ( via3                      drawing    )
  ( via4                      drawing    )
  ( glass                     drawing    )
  ( background                drawing    )
  ( grid                      drawing    )
  ( grid                      drawing1   )
  ( annotate                  drawing    )
  ( annotate                  drawing1   )
  ( annotate                  drawing2   )
  ( annotate                  drawing3   )
  ( annotate                  drawing4   )
  ( annotate                  drawing5   )
  ( annotate                  drawing6   )
  ( annotate                  drawing7   )
  ( annotate                  drawing8   )
  ( annotate                  drawing9   )
  ( default                   drawing    )
  ( instance                  drawing    )
  ( instance                  label      )
  ( prBoundary                drawing    )
  ( prBoundary                boundary   )
  ( prBoundary                label      )
  ( gselect                   drawing    )
  ( gwell                     drawing    )
  ( align                     drawing    )
  ( hardFence                 drawing    )
  ( softFence                 drawing    )
  ( nodrc                     drawing    )
  ( nolpe                     drawing    )
  ( pad                       drawing    )
  ( text                      drawing    )
  ( text                      drawing1   )
  ( text                      drawing2   )
  ( res_id                    drawing    )
  ( cap_id                    drawing    )
  ( dio_id                    drawing    )
  ( sblock                    drawing    )
  ( border                    drawing    )
  ( device                    drawing    )
  ( device                    label      )
  ( device                    drawing1   )
  ( device                    drawing2   )
  ( device                    annotate   )
  ( wire                      drawing    )
  ( wire                      label      )
  ( wire                      flight     )
  ( pin                       label      )
  ( pin                       drawing    )
  ( pin                       annotate   )
  ( axis                      drawing    )
  ( edgeLayer                 drawing    )
  ( edgeLayer                 pin        )
  ( snap                      drawing    )
  ( stretch                   drawing    )
  ( y0                        drawing    )
  ( y1                        drawing    )
  ( y2                        drawing    )
  ( y3                        drawing    )
  ( y4                        drawing    )
  ( y5                        drawing    )
  ( y6                        drawing    )
  ( y7                        drawing    )
  ( y8                        drawing    )
  ( y9                        drawing    )
  ( hilite                    drawing    )
  ( hilite                    drawing1   )
  ( hilite                    drawing2   )
  ( hilite                    drawing3   )
  ( hilite                    drawing4   )
  ( hilite                    drawing5   )
  ( hilite                    drawing6   )
  ( hilite                    drawing7   )
  ( hilite                    drawing8   )
  ( hilite                    drawing9   )
  ( select                    drawing    )
  ( drive                     drawing    )
  ( hiz                       drawing    )
  ( resist                    drawing    )
  ( spike                     drawing    )
  ( supply                    drawing    )
  ( unknown                   drawing    )
  ( unset                     drawing    )
  ( designFlow                drawing    )
  ( designFlow                drawing1   )
  ( designFlow                drawing2   )
  ( designFlow                drawing3   )
  ( designFlow                drawing4   )
  ( designFlow                drawing5   )
  ( designFlow                drawing6   )
  ( designFlow                drawing7   )
  ( designFlow                drawing8   )
  ( designFlow                drawing9   )
  ( changedLayer              tool0      )
  ( changedLayer              tool1      )
  ( marker                    warning    )
  ( marker                    error      )
  ( Row                       drawing    )
  ( Row                       label      )
  ( Group                     drawing    )
  ( Group                     label      )
  ( ca                        label      )
  ( cc                        label      )
  ( cp                        label      )
  ( metal1                    label      )
  ( metal2                    label      )
  ( metal3                    label      )
  ( metal4                    label      )
  ( metalcap                  label      )
  ( metal5                    label      )
  ( poly                      label      )
  ( via                       label      )
  ( via2                      label      )
  ( via3                      label      )
  ( via4                      label      )
  ( pwell                     net        )
  ( nwell                     net        )
  ( gwell                     net        )
  ( active                    net        )
  ( tactive                   net        )
  ( nactive                   net        )
  ( pactive                   net        )
  ( poly                      net        )
  ( metal1                    net        )
  ( metal2                    net        )
  ( metal3                    net        )
  ( metal4                    net        )
  ( metalcap                  net        )
  ( metal5                    net        )
  ( ca                        net        )
  ( cc                        net        )
  ( cp                        net        )
  ( via                       net        )
  ( via2                      net        )
  ( via3                      net        )
  ( via4                      net        )
  ( active                    pin        )
  ( tactive                   pin        )
  ( ca                        pin        )
  ( cc                        pin        )
  ( cp                        pin        )
  ( gwell                     pin        )
  ( metal1                    pin        )
  ( metal2                    pin        )
  ( metal3                    pin        )
  ( metal4                    pin        )
  ( metalcap                  pin        )
  ( metal5                    pin        )
  ( nactive                   pin        )
  ( nwell                     pin        )
  ( pactive                   pin        )
  ( poly                      pin        )
  ( pwell                     pin        )
  ( via                       pin        )
  ( via2                      pin        )
  ( via3                      pin        )
  ( via4                      pin        )
  ( Cannotoccupy              drawing    )
  ( Cannotoccupy              boundary   )
  ( Canplace                  drawing    )
  ( ca                        boundary   )
  ( cc                        boundary   )
  ( cp                        boundary   )
  ( metal1                    boundary   )
  ( metal2                    boundary   )
  ( metal3                    boundary   )
  ( metal4                    boundary   )
  ( metalcap                  boundary   )
  ( metal5                    boundary   )
  ( poly                      boundary   )
  ( via                       boundary   )
  ( via2                      boundary   )
  ( via3                      boundary   )
  ( via4                      boundary   )
  ( hdrc                      boundary   )
  ( Unrouted                  drawing    )
  ( Unrouted                  drawing1   )
  ( Unrouted                  drawing2   )
  ( Unrouted                  drawing3   )
  ( Unrouted                  drawing4   )
  ( Unrouted                  drawing5   )
  ( Unrouted                  drawing6   )
  ( Unrouted                  drawing7   )
  ( Unrouted                  drawing8   )
  ( Unrouted                  drawing9   )
 ) ;techLayerPurposePriorities

 techDisplays(
 ;( LayerName    Purpose      Packet          Vis Sel Con2ChgLy DrgEnbl Valid )
 ;( ---------    -------      ------          --- --- --------- ------- ----- )
  ( pwell        drawing      pwell            t t t t t )
  ( nwell        drawing      nwell            t t t t t )
  ( active       drawing      active           t t t t t )
  ( tactive      drawing      tactive          t t t t t )
  ( nactive      drawing      nactive          t t t t t )
  ( pactive      drawing      pactive          t t t t t )
  ( nselect      drawing      nselect          t t t t t )
  ( pselect      drawing      pselect          t t t t t )
  ( poly         drawing      poly             t t t t t )
  ( metal1       drawing      metal1           t t t t t )
  ( metal2       drawing      metal2           t t t t t )
  ( metal3       drawing      metal3           t t t t t )
  ( metal4       drawing      metal4           t t t t t )
  ( metalcap     drawing      metalcap         t t t t t )
  ( metal5       drawing      metal5           t t t t t )
  ( cp           drawing      cp               t t t t nil )
  ( ca           drawing      ca               t t t t nil )
  ( cc           drawing      cc               t t t t t )
  ( via          drawing      via              t t t t t )
  ( via2         drawing      via2             t t t t t )
  ( via3         drawing      via3             t t t t t )
  ( via4         drawing      via4             t t t t t )
  ( glass        drawing      glass            t t t t t )
  ( background   drawing      background       t nil t nil nil )
  ( grid         drawing      grid             t nil t nil nil )
  ( grid         drawing1     grid1            t nil t nil nil )
  ( annotate     drawing      annotate         t t t t nil )
  ( annotate     drawing1     annotate1        t t t t nil )
  ( annotate     drawing2     annotate2        t t t t nil )
  ( annotate     drawing3     annotate3        t t t t nil )
  ( annotate     drawing4     annotate4        t t t t nil )
  ( annotate     drawing5     annotate5        t t t t nil )
  ( annotate     drawing6     annotate6        t t t t nil )
  ( annotate     drawing7     annotate7        t t t t nil )
  ( annotate     drawing8     annotate8        t t t t nil )
  ( annotate     drawing9     annotate9        nil t t t nil )
  ( default      drawing      default          t t t t nil )
  ( instance     drawing      instance         t t t t nil )
  ( instance     label        instanceLbl      t t t t nil )
  ( prBoundary   drawing      prBoundary       t t t t nil )
  ( prBoundary   boundary     prBoundaryBnd    t t t t nil )
  ( prBoundary   label        prBoundaryLbl    t t t t nil )
  ( gselect      drawing      gselect          t t t t nil )
  ( gwell        drawing      gwell            t t t t nil )
  ( align        drawing      align            t t t t nil )
  ( hardFence    drawing      hardFence        t t t t nil )
  ( softFence    drawing      softFence        t t t t nil )
  ( nodrc        drawing      nodrc            t t t t t )
  ( nolpe        drawing      nolpe            t t t t t )
  ( pad          drawing      pad              t t t t t )
  ( text         drawing      text             t t t t t )
  ( text         drawing1     text1            t t t t nil )
  ( text         drawing2     text2            t t t t nil )
  ( res_id       drawing      res_id           t t t t t )
  ( cap_id       drawing      cap_id           t t t t t )
  ( dio_id       drawing      dio_id           t t t t t )
  ( sblock       drawing      sblock           t t t t t )
  ( border       drawing      border           t t t t nil )
  ( device       drawing      device           t t t t nil )
  ( device       label        deviceLbl        t t t t nil )
  ( device       drawing1     device1          t t t t nil )
  ( device       drawing2     device2          t t t t nil )
  ( device       annotate     deviceAnt        t t t t nil )
  ( wire         drawing      wire             t t t t nil )
  ( wire         label        wireLbl          t t t t nil )
  ( wire         flight       wireFlt          t t t t nil )
  ( pin          label        pinLbl           t t t t nil )
  ( pin          drawing      pin              t t t t nil )
  ( pin          annotate     pinAnt           t t t t nil )
  ( axis         drawing      axis             t nil t t nil )
  ( edgeLayer    drawing      edgeLayer        t t t t nil )
  ( edgeLayer    pin          edgeLayerPin     t t t t nil )
  ( snap         drawing      snap             t t t t nil )
  ( stretch      drawing      stretch          t t t t nil )
  ( y0           drawing      y0               t t t t nil )
  ( y1           drawing      y1               t t t t nil )
  ( y2           drawing      y2               t t t t nil )
  ( y3           drawing      y3               t t t t nil )
  ( y4           drawing      y4               t t t t nil )
  ( y5           drawing      y5               t t t t nil )
  ( y6           drawing      y6               t t t t nil )
  ( y7           drawing      y7               t t t t nil )
  ( y8           drawing      y8               t t t t nil )
  ( y9           drawing      y9               t t t t nil )
  ( hilite       drawing      hilite           t t t t nil )
  ( hilite       drawing1     hilite1          t t t t nil )
  ( hilite       drawing2     hilite2          t t t t nil )
  ( hilite       drawing3     hilite3          t t t t nil )
  ( hilite       drawing4     hilite4          t t t t nil )
  ( hilite       drawing5     hilite5          t t t t nil )
  ( hilite       drawing6     hilite6          t t t t nil )
  ( hilite       drawing7     hilite7          t t t t nil )
  ( hilite       drawing8     hilite8          t t t t nil )
  ( hilite       drawing9     hilite9          t t t t nil )
  ( select       drawing      select           t t t t nil )
  ( drive        drawing      drive            t t t t nil )
  ( hiz          drawing      hiz              t t t t nil )
  ( resist       drawing      resist           t t t t nil )
  ( spike        drawing      spike            t t t t nil )
  ( supply       drawing      supply           t t t t nil )
  ( unknown      drawing      unknown          t t t t nil )
  ( unset        drawing      unset            t t t t nil )
  ( designFlow   drawing      designFlow       t t t nil nil )
  ( designFlow   drawing1     designFlow1      t t t nil nil )
  ( designFlow   drawing2     designFlow2      t t t nil nil )
  ( designFlow   drawing3     designFlow3      t t t nil nil )
  ( designFlow   drawing4     designFlow4      t t t nil nil )
  ( designFlow   drawing5     designFlow5      t t t nil nil )
  ( designFlow   drawing6     designFlow6      t t t nil nil )
  ( designFlow   drawing7     designFlow7      t t t nil nil )
  ( designFlow   drawing8     designFlow8      t t t nil nil )
  ( designFlow   drawing9     designFlow9      t t t nil nil )
  ( changedLayer tool0        changedLayerTl0  nil nil t nil nil )
  ( changedLayer tool1        changedLayerTl1  nil nil t nil nil )
  ( marker       warning      markerWarn       t t t t nil )
  ( marker       error        markerErr        t t t t nil )
  ( Row          drawing      Row              t t t t nil )
  ( Row          label        RowLbl           t nil t t nil )
  ( Group        drawing      Group            t t t t nil )
  ( Group        label        GroupLbl         t nil t t nil )
  ( ca           label        caLbl            t t t nil nil )
  ( cc           label        ccLbl            t t t nil nil )
  ( cp           label        cpLbl            t t t nil nil )
  ( metal1       label        metal1Lbl        t t t nil nil )
  ( metal2       label        metal2Lbl        t t t nil nil )
  ( metal3       label        metal3Lbl        t t t nil nil )
  ( metal4       label        metal4Lbl        t t t nil nil )
  ( metalcap     label        metalcapLbl      t t t nil nil )
  ( metal5       label        metal5Lbl        t t t nil nil )
  ( poly         label        polyLbl          t t t nil nil )
  ( via          label        viaLbl           t t t nil nil )
  ( via2         label        via2Lbl          t t t nil nil )
  ( via3         label        via3Lbl          t t t nil nil )
  ( via4         label        via4Lbl          t t t nil nil )
  ( pwell        net          pwellNet         t t t nil t )
  ( nwell        net          nwellNet         t t t nil t )
  ( gwell        net          gwellNet         t t t nil nil )
  ( active       net          activeNet        t t t nil t )
  ( tactive      net          tactiveNet       t t t nil t )
  ( nactive      net          nactiveNet       t t t nil t )
  ( pactive      net          pactiveNet       t t t nil t )
  ( poly         net          polyNet          t t t nil t )
  ( metal1       net          metal1Net        t t t nil t )
  ( metal2       net          metal2Net        t t t nil t )
  ( metal3       net          metal3Net        t t t nil t )
  ( metal4       net          metal4Net        t t t nil t )
  ( metalcap     net          metalcapNet      t t t nil t )
  ( metal5       net          metal5Net        t t t nil t )
  ( ca           net          caNet            t t t nil nil )
  ( cc           net          ccNet            t t t nil t )
  ( cp           net          cpNet            t t t nil nil )
  ( via          net          viaNet           t t t nil t )
  ( via2         net          via2Net          t t t nil t )
  ( via3         net          via3Net          t t t nil t )
  ( via4         net          via4Net          t t t nil t )
  ( active       pin          activePin        t t t nil nil )
  ( tactive      pin          tactivePin       t t t nil nil )
  ( ca           pin          caPin            t t t nil nil )
  ( cc           pin          ccPin            t t t nil nil )
  ( cp           pin          cpPin            t t t nil nil )
  ( gwell        pin          gwellPin         t t t nil nil )
  ( metal1       pin          metal1Pin        t t t nil nil )
  ( metal2       pin          metal2Pin        t t t nil nil )
  ( metal3       pin          metal3Pin        t t t nil nil )
  ( metal4       pin          metal4Pin        t t t nil nil )
  ( metalcap     pin          metalcapPin      t t t nil nil )
  ( metal5       pin          metal5Pin        t t t nil nil )
  ( nactive      pin          nactivePin       t t t nil nil )
  ( nwell        pin          nwellPin         t t t nil nil )
  ( pactive      pin          pactivePin       t t t nil nil )
  ( poly         pin          polyPin          t t t nil nil )
  ( pwell        pin          pwellPin         t t t nil nil )
  ( via          pin          viaPin           t t t nil nil )
  ( via2         pin          via2Pin          t t t nil nil )
  ( via3         pin          via3Pin          t t t nil nil )
  ( via4         pin          via4Pin          t t t nil nil )
  ( Cannotoccupy drawing      Cannotoccupy     t t t t nil )
  ( Cannotoccupy boundary     CannotoccupyBnd  t t t t nil )
  ( Canplace     drawing      Canplace         t t t t nil )
  ( ca           boundary     caBnd            t t t nil nil )
  ( cc           boundary     ccBnd            t t t nil nil )
  ( cp           boundary     cpBnd            t t t nil nil )
  ( metal1       boundary     metal1Bnd        t t t nil nil )
  ( metal2       boundary     metal2Bnd        t t t nil nil )
  ( metal3       boundary     metal3Bnd        t t t nil nil )
  ( metal4       boundary     metal4Bnd        t t t nil nil )
  ( metalcap     boundary     metalcapBnd      t t t nil nil )
  ( metal5       boundary     metal5Bnd        t t t nil nil )
  ( poly         boundary     polyBnd          t t t nil nil )
  ( via          boundary     viaBnd           t t t nil nil )
  ( via2         boundary     via2Bnd          t t t nil nil )
  ( via3         boundary     via3Bnd          t t t nil nil )
  ( via4         boundary     via4Bnd          t t t nil nil )
  ( hdrc         boundary     hdrcBnd          t nil t nil nil )
  ( Unrouted     drawing      Unrouted         t t t t nil )
  ( Unrouted     drawing1     Unrouted1        t t t t nil )
  ( Unrouted     drawing2     Unrouted2        t t t t nil )
  ( Unrouted     drawing3     Unrouted3        t t t t nil )
  ( Unrouted     drawing4     Unrouted4        t t t t nil )
  ( Unrouted     drawing5     Unrouted5        t t t t nil )
  ( Unrouted     drawing6     Unrouted6        t t t t nil )
  ( Unrouted     drawing7     Unrouted7        t t t t nil )
  ( Unrouted     drawing8     Unrouted8        t t t t nil )
  ( Unrouted     drawing9     Unrouted9        t t t t nil )
 ) ;techDisplays

techLayerProperties(
;( PropName               Layer1 [ Layer2 ]            PropValue )
 ( sheetResistance        nwell                          1191 )
 ( sheetResistance        poly                           4 )
 ( sheetResistance        sblock                         190 )
 ( areaCap                default      poly              97 )
 ( areaCap                default      metal1            38 )
 ( areaCap                default      metal3            13 )
 ( areaCap                default      metal4            8 )
 ( areaCap                default      metal5            8 )
 ( areaCap                default      metal2            19 )
 ( perimeterCap           default      metal1            23 )
 ( perimeterCap           default      metal3            56 )
 ( perimeterCap           default      metal4            42 )
 ( perimeterCap           default      metal5            24 )
 ( perimeterCap           default      metal2            60 )
 ( areaCap                active       metal1            50 )
 ( areaCap                active       metal3            14 )
 ( areaCap                active       metal4            11 )
 ( areaCap                active       metal5            9 )
 ( areaCap                active       metal2            20 )
 ( areaCap                poly         metal1            63 )
 ( areaCap                poly         metal3            10 )
 ( areaCap                poly         metal4            7 )
 ( areaCap                poly         metal5            6 )
 ( areaCap                poly         metal2            17 )
 ( perimeterCap           poly         metal1            70 )
 ( perimeterCap           poly         metal3            30 )
 ( perimeterCap           poly         metal4            24 )
 ( perimeterCap           poly         metal5            21 )
 ( perimeterCap           poly         metal2            42 )
 ( areaCap                metal1       metal3            15 )
 ( areaCap                metal1       metal4            9 )
 ( areaCap                metal1       metal5            7 )
 ( areaCap                metal1       metal2            37 )
 ( perimeterCap           metal1       metal3            36 )
 ( perimeterCap           metal1       metal4            29 )
 ( perimeterCap           metal1       metal5            24 )
 ( perimeterCap           metal1       metal2            52 )
 ( areaCap                metal3       metal2            38 )
 ( areaCap                metal3       metal4            38 )
 ( areaCap                metal3       metal5            15 )
 ( perimeterCap           metal3       metal2            49 )
 ( perimeterCap           metal3       metal4            52 )
 ( perimeterCap           metal3       metal5            38 )
 ( areaCap                metal4       metal2            15 )
 ( areaCap                metal4       metalcap          1000 )
 ( areaCap                metal4       metal5            37 )
 ( perimeterCap           metal4       metal2            36 )
 ( perimeterCap           metal4       metal5            65 )
 ( areaCap                metal5       metal2            9 )
 ( perimeterCap           metal5       metal2            29 )
)

) ;layerDefinitions

;********************************
; LAYER RULES
;********************************

layerRules(

let( (cwellAvailable polycapAvailable metal3Available metal4Available 
      metal5Available metal6Available npnAvailable ccdAvailable 
      sblockAvailable elecAvailable memsAvailable hvAvailable 
      highresAvailable metalcapAvailable)

 cwellAvailable    = techParam( "cwellAvailable" )
 polycapAvailable  = techParam( "polycapAvailable" )
 npnAvailable      = techParam( "npnAvailable" )
 ccdAvailable      = techParam( "ccdAvailable" )
 metal3Available   = techParam( "metal3Available" )
 metal4Available   = techParam( "metal4Available" )
 metal5Available   = techParam( "metal5Available" )
 metal6Available   = techParam( "metal6Available" )
 elecAvailable     = techParam( "elecAvailable" )
 memsAvailable     = techParam( "memsAvailable" )
 sblockAvailable   = techParam( "sblockAvailable" )
 hvAvailable       = techParam( "hvAvailable" )
 highresAvailable  = techParam( "highresAvailable" )
 metalcapAvailable = techParam( "metalcapAvailable" )
 egrcAvailable     = techParam( "egrcAvailable" )
 
/*
 * viaLayers
 */
; Removed ca and cp viaLayers
; These layers are obsolete and generate error
; messages in Abstract. (jddjig01)
viaLayers(
 ;( layer1      viaLayer    layer2     )
;  ( poly        cp          metal1     )
  ( poly        cc          metal1     )
; ( active      ca          metal1     )
  ( active      cc          metal1     )
; ( nactive     ca          metal1     )
  ( nactive     cc          metal1     )
; ( pactive     ca          metal1     )
  ( pactive     cc          metal1     )
  ( metal1      via         metal2     )
 )

if( elecAvailable then
    viaLayers(
      ( elec        ce          metal1     )
      ( elec        cc          metal1     )
    )
)

if( npnAvailable then
    viaLayers(
;     ( cactive     ca          metal1      )
      ( cactive     cc          metal1      )
    )
)

if( polycapAvailable then
    viaLayers(
;      ( polycap     cp          metal1     )
      ( polycap     cc          metal1     )
    )
)

if( metal3Available then
    viaLayers(
      ( metal2      via2        metal3     )
    )
)

if( metal4Available then
    viaLayers(
      ( metal3      via3        metal4     )
    )
)

if( metal5Available then
    viaLayers(
      ( metal4      via4        metal5     )
    )
)

if( metal6Available then
    viaLayers(
      ( metal5      via5        metal6     )
    )
)

if( hvAvailable then
    viaLayers(
;    ( tactive     ca          metal1      )
      ( tactive     cc          metal1      )
    )
)
; end viaLayers


/*
 * no equivalentLayers needed (?)
 */


/*
 * streamLayers
 */

streamLayers(
; ( layer     stream#   dataType    translate )
  ( gwell     53        0           t )
  ( nwell     42        0           t )
  ( pwell     41        0           t )
  ( active    43        0           t )
  ( nactive   43        0           t )
  ( pactive   43        0           t )
  ( gselect   54        0           t )
  ( nselect   45        0           t )
  ( pselect   44        0           t )
  ( poly      46        0           t )
  ( metal1    49        0           t )
  ( ca        25        0           t )
  ( cp        25        0           t )
  ( cc        25        0           t )
  ( metal2    51        0           t )
  ( via       50        0           t )
  ( glass     52        0           t )
  ( pad       26        0           t )
)

if( metal3Available then
    streamLayers(
      ( metal3    62        0           t )
      ( via2      61        0           t )
    )
)
if( metal4Available then
    streamLayers(
      ( metal4    31        0           t )
      ( via3      30        0           t )
    )
)
if( metal5Available then
    streamLayers(
      ( metal5    33        0           t )
      ( via4      32        0           t )
    )
)
if( metal6Available then
    streamLayers(
      ( metal6    99        0           t )
      ( via5      98        0           t )
    )
)
if( cwellAvailable then
    streamLayers(
      ( cwell     59        0           t )
    )
)
if( polycapAvailable then
    streamLayers(
      ( polycap   28        0           t )
    )
)
if( npnAvailable then
    streamLayers(
      ( pbase     58        0           t )
      ( cactive   43        0           t )
    )
)
if( ccdAvailable then
    streamLayers(
      ( ccd       57        0           t )
    )
)
if( elecAvailable then
    streamLayers(
      ( elec      56        0           t )
      ( ce        25        0           t )
    )
)
if( memsAvailable then
    streamLayers(
      ( open      23        0           t )
      ( pstop     24        0           t )
    )
)
if( sblockAvailable then
    streamLayers(
      ( sblock    29        0           t )
    )
)
if( hvAvailable then
    streamLayers(
      ( tactive   60        0           t )
    )
)
if( highresAvailable then
    streamLayers(
      ( highres   34        0           t )
    )
)
if( metalcapAvailable then
    streamLayers(
      ( metalcap  35        0           t )
    )
)
if( egrcAvailable then
    streamLayers(
      ( via3         30       0           t   )
      ( metal1_cut   0        0           nil )
      ( metal2_cut   1        0           nil )
      ( metal3_cut   2        0           nil )
      ( ac_pad       3        0           t   )
      ( contact_pad  4        0           t   )
      ( contct_ubm   5        0           t   )
      ( mech0        6        0           t   )
      ( mech0_cut    7        0           nil )
      ( mech1        8        0           t   )
      ( mech1_cut    9        0           nil )
      ( sac0         10       0           t   )
      ( sac0_cut     11       0           nil )
      ( sac1         12       0           t   )
      ( sac1_cut     13       0           nil )
      ( bulk         14       0           t   )
      ( bulk_cut     15       0           nil )
      ( ground       16       0           t   )
      ( ground_cut   17       0           nil )
    )
)
; end streamLayers

 ) ; let
) ; layerRules

;********************************
; PHYSICAL RULES
;********************************
physicalRules(

let( (lambda technology cwellAvailable metal3Available metal4Available
      metal5Available metal6Available elecAvailable hvAvailable
      submicronAvailable deepAvailable)

lambda          = techParam( "lambda" )
technology      = techParam( "technology" )
cwellAvailable  = techParam( "cwellAvailable" )
metal3Available = techParam( "metal3Available" )
metal4Available = techParam( "metal4Available" )
metal5Available = techParam( "metal5Available" )
metal6Available = techParam( "metal6Available" )
elecAvailable   = techParam( "elecAvailable" )
hvAvailable     = techParam( "hvAvailable" )

if( NCSU_techData[ technology ] == nil then
    hiGetAttention()
    error( "Unrecognizable \"technology\" property!" )
)

submicronAvailable = NCSU_techData[ technology ]->submicronRules
deepAvailable = NCSU_techData[ technology ]->deepRules

/*
 * Rule numbers refer to SCMOS rules
 */

/*
 * we aren't trying to do all the applicable rules here, since our setup
 * doesn't use them all yet (eg, we don't do P&R yet). the pcells do use
 * some of these.
 */

orderedSpacingRules(
    ; rule          layer 1     layer 2      value
    ( minEnclosure  nselect     active       (lambda * 2.0) ) ; 4.2
    ( minEnclosure  pselect     active       (lambda * 2.0) ) ; 4.2
    ( minEnclosure  nselect     ca           (lambda * 1.0) ) ; 4.3, ohmic
    ( minEnclosure  pselect     ca           (lambda * 1.0) ) ; 4.3, ohmic
    ( minEnclosure  nselect     cc           (lambda * 1.0) ) ; 4.3, ohmic
    ( minEnclosure  pselect     cc           (lambda * 1.0) ) ; 4.3, ohmic
    ( minEnclosure  active      ca           (lambda * 1.0) ) ; 6.2.b
    ( minEnclosure  active      cc           (lambda * 1.0) ) ; 6.2.b
    ( minEnclosure  poly        cp           (lambda * 1.0) ) ; 5.2.b
    ( minEnclosure  poly        cc           (lambda * 1.0) ) ; 5.2.b
    ( minEnclosure  active      via          (lambda * 2.0) ) ; 8.5 XXX
    ( minEnclosure  poly        via          (lambda * 2.0) ) ; 8.5 XXX
    ( minEnclosure  metal1      ca           (lambda * 1.0) ) ; 7.3
    ( minEnclosure  metal1      cp           (lambda * 1.0) ) ; 7.3
    ( minEnclosure  metal1      cc           (lambda * 1.0) ) ; 7.3
    ( minEnclosure  metal1      via          (lambda * 1.0) ) ; 8.3
    ( minEnclosure  metal2      via          (lambda * 1.0) ) ; 9.3
) ; orderedSpacingRules

; - the followings are for DEEP only
if( deepAvailable then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  nselect     ca           (lambda * 1.5) ) ; 4.3, ohmic
        ( minEnclosure  pselect     ca           (lambda * 1.5) ) ; 4.3, ohmic
        ( minEnclosure  nselect     cc           (lambda * 1.5) ) ; 4.3, ohmic
        ( minEnclosure  pselect     cc           (lambda * 1.5) ) ; 4.3, ohmic
    ) ; orderedSpacingRules
else
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  nselect     ca           (lambda * 1.0) ) ; 4.3, ohmic
        ( minEnclosure  pselect     ca           (lambda * 1.0) ) ; 4.3, ohmic
        ( minEnclosure  nselect     cc           (lambda * 1.0) ) ; 4.3, ohmic
        ( minEnclosure  pselect     cc           (lambda * 1.0) ) ; 4.3, ohmic
    ) ; orderedSpacingRules
)

/*  exist a bug in compile SUBM library  corrected  -gma2

; - do not apply for DEEP, and maybe also some SUBM
if( ( ( !deepAvailable ) && ( ( metal3Available ) || ( !submicronAvailable ) ) ) then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value - soj
        ( minEnclosure  active      via          (lambda * 2.0) ) ; 8.5 XXX
        ( minEnclosure  poly        via          (lambda * 2.0) ) ; 8.5 XXX
    ) ; orderedSpacingRules
) */



; - do not apply for DEEP, and maybe also some SUBM
if( ( ( !deepAvailable ) && (  metal3Available  || ( !submicronAvailable ) ) ) then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value - soj
        ( minEnclosure  active      via          (lambda * 2.0) ) ; 8.5 XXX
        ( minEnclosure  poly        via          (lambda * 2.0) ) ; 8.5 XXX
    ) ; orderedSpacingRules
) 



orderedSpacingRules(
    ; these use [np]active to distinguish them from the "active" rules
    ; below (2.3) so the ohmic contact pcells can get this value, which
    ; is not the same as 2.3, which is needed by the MOSFET pcells
    ; rule          layer 1     layer 2      value
    ( minEnclosure  nwell       nactive      (lambda * 3.0) ) ; 2.4, ohmic
    ( minEnclosure  pwell       pactive      (lambda * 3.0) ) ; 2.4, ohmic
) ; orderedSpacingRules

; - add conditionals for DEEP
if( ( submicronAvailable || deepAvailable ) then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  nwell       active       (lambda * 6.0) ) ; 2.3
        ( minEnclosure  pwell       active       (lambda * 6.0) ) ; 2.3
    ) ; orderedSpacingRules
else
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  nwell       active       (lambda * 5.0) ) ; 2.3
        ( minEnclosure  pwell       active       (lambda * 5.0) ) ; 2.3
    ) ; orderedSpacingRules
)

if( elecAvailable then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  elec        ce           (lambda * 2.0) ) ; 13.4
        ( minEnclosure  metal1      ce           (lambda * 1.0) ) ; 7.3
        ( minEnclosure  elec        cc           (lambda * 2.0) ) ; 13.4
        ( minEnclosure  metal1      cc           (lambda * 1.0) ) ; 7.3
    )
) ; orderedSpacingRules

if( hvAvailable then
    orderedSpacingRules(
        ; rule          layer 1     layer 2      value
        ( minEnclosure  tactive     active       (lambda * 4.0) ) ; 24.3
    )
) ; orderedSpacingRules
    
; via-enclosure rules change a little depending on what the top-level metal is...
; "metal6" section is new addition
cond(
        (metal6Available
            orderedSpacingRules(
                ; rule          layer 1   layer 2   value
                ( minEnclosure  metal2    via2      (lambda * 1.0) ) ; 14.3
                ( minEnclosure  metal3    via2      (lambda * 1.0) ) ; 15.3
                ( minEnclosure  metal3    via3      (lambda * 1.0) ) ; 21.3
                ( minEnclosure  metal4    via3      (lambda * 1.0) ) ; 22.3
                ( minEnclosure  metal4    via4      (lambda * 1.0) ) ; 25.3
                ( minEnclosure  metal5    via4      (lambda * 1.0) ) ; 26.3
                ( minEnclosure  metal5    via5      (lambda * 1.0) ) ; 29.3
                ( minEnclosure  metal6    via5      (lambda * 2.0) ) ; 30.3
            )
        )

        (metal5Available
            orderedSpacingRules(
                ; rule          layer 1   layer 2   value
                ( minEnclosure  metal2    via2      (lambda * 1.0) ) ; 14.3
                ( minEnclosure  metal3    via2      (lambda * 1.0) ) ; 15.3
                ( minEnclosure  metal3    via3      (lambda * 1.0) ) ; 21.3
                ( minEnclosure  metal4    via3      (lambda * 1.0) ) ; 22.3
                ( minEnclosure  metal4    via4      (lambda * 1.0) ) ; 25.3
            )
            if( deepAvailable then
                orderedSpacingRules(
                ( minEnclosure  metal5    via4      (lambda * 2.0) ) ; 26.3 DEEP
                ) ; orderedSpacingRules
            else
                orderedSpacingRules(
                  ; rule          layer 1     layer 2      value
                ( minEnclosure  metal5    via4      (lambda * 1.0) ) ; 26.3
                ) ; orderedSpacingRules
            )
        )
        
	(metal4Available
            orderedSpacingRules(
                ; rule          layer 1   layer 2   value
                ( minEnclosure  metal2    via2      (lambda * 1.0) ) ; 14.3
                ( minEnclosure  metal3    via2      (lambda * 1.0) ) ; 15.3
                ( minEnclosure  metal3    via3      (lambda * 1.0) ) ; 21.3
                ( minEnclosure  metal4    via3      (lambda * 2.0) ) ; 22.3
            )
        )
        (metal3Available
            orderedSpacingRules(
            ; rule          layer 1   layer 2   value
            ( minEnclosure  metal2    via2      (lambda * 1.0) ) ; 14.3
            ( minEnclosure  metal3    via2      (lambda * 2.0) ) ; 15.3
            )
        )
    )

spacingRules(
    ; rule          layer1      layer2      value

    ; nwell
    ( minNotch      nwell                   (lambda * 6.0) ) ; 1.3
    ( minSpacing    nwell       active      (lambda * 3.0) )
    ( minSpacing    nwell       nactive     (lambda * 5.0) ) ; XXX

    ; pwell
    ( minNotch      pwell                   (lambda * 6.0) ) ; 1.3

    ; active
    ( minSpacing    active                  (lambda * 3.0) )
    ( minNotch      active                  (lambda * 3.0) )
    ( minWidth      active                  (lambda * 3.0) )

    ; selects
    ( minSpacing    nselect                 (lambda * 2.0) )
    ( minSpacing    pselect                 (lambda * 2.0) )
    ( minNotch      nselect                 (lambda * 2.0) )
    ( minNotch      pselect                 (lambda * 2.0) )
    ( minWidth      nselect                 (lambda * 2.0) ) ; 4.4
    ( minWidth      pselect                 (lambda * 2.0) ) ; 4.4

    ; poly
    ( minWidth      poly                    (lambda * 2.0) ) ; 3.1 
    ( minSpacing    poly        ca          (lambda * 2.0) ) ; 6.4
    ( minSpacing    poly        cc          (lambda * 2.0) ) ; 6.4

    ; metal1
    ( minSpacing    metal1                  (lambda * 3.0) ) ; 7.2.a
    ( minNotch      metal1                  (lambda * 3.0) ) ; 7.2.a
    ( minWidth      metal1                  (lambda * 3.0) ) ; 7.1

    ; metal2
    ( minWidth      metal2                  (lambda * 3.0) ) ; 9.1

    ; via
    ( minSpacing    via                     (lambda * 3.0) ) ; 8.2
) ; spacingRules

; - the following rules for SELECT are changed - DEEP is different
if( deepAvailable then
    spacingRules(
        ; rule          layer 1     layer 2      value
        ; selects
        ( minSpacing    nselect                 (lambda * 4.0) )
        ( minSpacing    pselect                 (lambda * 4.0) )
        ( minNotch      nselect                 (lambda * 4.0) )
        ( minNotch      pselect                 (lambda * 4.0) )
        ( minWidth      nselect                 (lambda * 4.0) ) ; 4.4
        ( minWidth      pselect                 (lambda * 4.0) ) ; 4.4
    ) ; spacingRules
else
    spacingRules(
        ; rule          layer 1     layer 2      value
        ; selects
        ( minSpacing    nselect                 (lambda * 2.0) )
        ( minSpacing    pselect                 (lambda * 2.0) )
        ( minNotch      nselect                 (lambda * 2.0) )
        ( minNotch      pselect                 (lambda * 2.0) )
        ( minWidth      nselect                 (lambda * 2.0) ) ; 4.4
        ( minWidth      pselect                 (lambda * 2.0) ) ; 4.4
    ) ; spacingRules
)

if( submicronAvailable then
    spacingRules(
        ; rule             layer1           value
        ( minSpacing       metal2           (lambda * 3.0) )  ; 9.2.b
        ( minNotch         metal2           (lambda * 3.0) )  ; 9.2.b
        ( minSpacing       ca               (lambda * 3.0) )  ; 6b.3
        ( minSpacing       cp               (lambda * 3.0) )  ; 5b.3
        ( minSpacing       cc               (lambda * 3.0) )  ; 5b.3
        ( minSpacing       poly             (lambda * 3.0) )  ; 3.2
        ( minWidth         nwell            (lambda * 12.0))  ; 1.1
        ( minWidth         pwell            (lambda * 12.0))  ; 1.1
        ( minSpacing       nwell            (lambda * 18.0))  ; 1.2
        ( minSpacing       pwell            (lambda * 18.0))  ; 1.2
    ) ; spacingRules
else
  if( deepAvailable then
    spacingRules(
        ; rule             layer1           value - again, DEEP is different
        ( minSpacing       metal2           (lambda * 4.0) )  ; 9.2.b
        ( minNotch         metal2           (lambda * 4.0) )  ; 9.2.b
        ( minSpacing       ca               (lambda * 4.0) )  ; 6b.3
        ( minSpacing       cp               (lambda * 4.0) )  ; 5b.3
        ( minSpacing       cc               (lambda * 4.0) )  ; 5b.3
        ( minSpacing       poly             (lambda * 4.0) )  ; 3.2 3 for field poly??
        ( minWidth         nwell            (lambda * 12.0))  ; 1.1
        ( minWidth         pwell            (lambda * 12.0))  ; 1.1
        ( minSpacing       nwell            (lambda * 18.0))  ; 1.2
        ( minSpacing       pwell            (lambda * 18.0))  ; 1.2
    ) ; spacingRules
else
    spacingRules(
        ; rule             layer1           value
        ( minSpacing       metal2           (lambda * 4.0) )  ; 9.2.a
        ( minNotch         metal2           (lambda * 4.0) )  ; 9.2.a
        ( minSpacing       ca               (lambda * 2.0) )  ; 6b.3
        ( minSpacing       cp               (lambda * 2.0) )  ; 5b.3
        ( minSpacing       cc               (lambda * 2.0) )  ; 5b.3
        ( minSpacing       poly             (lambda * 2.0) )  ; 3.2
        ( minWidth         nwell            (lambda * 10.0))  ; 1.1
        ( minWidth         pwell            (lambda * 10.0))  ; 1.1
        ( minSpacing       nwell            (lambda * 9.0))   ; 1.2
        ( minSpacing       pwell            (lambda * 9.0))   ; 1.2
    ) ; spacingRules
)  )


cond( 
; - additions for metal6 and DEEP
        (metal6Available
            spacingRules(
                 ; rule             layer1           value
                 ( minSpacing       metal6       (lambda * 4.0) )  ; 30.2
                 ( minNotch         metal6       (lambda * 4.0) )  ; 30.2
                 ( minWidth         metal6       (lambda * 4.0) )  ; 30.1
                 ( minSpacing       via5         (lambda * 4.0) )  ; 29.2
                 ( minSpacing       metal5       (lambda * 4.0) )  ; 26.2
                 ( minNotch         metal5       (lambda * 4.0) )  ; 26.2
                 ( minWidth         metal5       (lambda * 4.0) )  ; 26.1
                 ( minSpacing       via4         (lambda * 3.0) )  ; 25.2
                 ( minWidth         metal4       (lambda * 3.0) )  ; 22.1
                 ( minSpacing       via3         (lambda * 3.0) )  ; 21.2
                 ( minWidth         metal3       (lambda * 3.0) )  ; 15.1
                 ( minSpacing       via2         (lambda * 3.0) )  ; 14.2
            ) ; spacingRules
            if( deepAvailable then
                spacingRules(
                     ; rule             layer1           value - soj
                     ( minSpacing       metal4       (lambda * 4.0) )  ; 22.2
                     ( minNotch         metal4       (lambda * 4.0) )  ; 22.2
                     ( minSpacing       metal3       (lambda * 4.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 4.0) )  ; 15.2
                ) ; spacingRules
            else
                spacingRules(
                     ; rule             layer1           value
                     ( minSpacing       metal4       (lambda * 3.0) )  ; 22.2
                     ( minNotch         metal4       (lambda * 3.0) )  ; 22.2
                     ( minSpacing       metal3       (lambda * 3.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 3.0) )  ; 15.2
                ) ; spacingRules
            ) ; if
        ) ; metal6Available

        (metal5Available
	;; Jeannette- Modified rule value: 22.1 and added sameNet information
            spacingRules(
                 ; rule             layer1           value
                 ( minSpacing       metal5       (lambda * 4.0) )  ; 26.2
                 ( minNotch         metal5       (lambda * 4.0) )  ; 26.2
                 ( minWidth         metal5       (lambda * 4.0) )  ; 26.1
                 ( minSpacing       via4         (lambda * 3.0) )  ; 25.2
                 ( minWidth         metal4       (lambda * 3.0) )  ; 22.1
                 ( minSpacing       via3         (lambda * 3.0) )  ; 21.2
                 ( minWidth         metal3       (lambda * 3.0) )  ; 15.1
                 ( minSpacing       via2         (lambda * 3.0) )  ; 14.2
            ) ; spacingRules
            if( deepAvailable then
                spacingRules(
                     ; rule             layer1           value - soj
                     ( minSpacing       metal4       (lambda * 4.0) )  ; 22.2
                     ( minNotch         metal4       (lambda * 4.0) )  ; 22.2
                     ( minSpacing       metal3       (lambda * 4.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 4.0) )  ; 15.2
		     ( sameNet  cc	cc	     (lambda * 4.0) )	
		     ( sameNet 	metal1  metal1	     (lambda * 3.0) )
		     ( sameNet 	cc	via	     (lambda * 0.0) )
		     ( sameNet  metal2	metal2	     (lambda * 4.0) )
		     ( sameNet  via	via2	     (lambda * 0.0) )
		     ( sameNet  metal3	metal3	     (lambda * 4.0) )
		     ( sameNet  via2	via3	     (lambda * 0.0) )
		     ( sameNet  metal4	metal4	     (lambda * 4.0) )
		     ( sameNet  via3	via4	     (lambda * 0.0) )
		     ( sameNet  metal5	metal5	     (lambda * 4.0) )
		     ( sameNet  via	via	     (lambda * 3.0) )
		     ( sameNet  via2	via2	     (lambda * 3.0) )
		     ( sameNet  via3	via3	     (lambda * 3.0) )
		     ( sameNet  via4	via4	     (lambda * 3.0) )
                ) ; spacingRules
            else
                spacingRules(
                     ; rule             layer1           value
                     ( minSpacing       metal4       (lambda * 3.0) )  ; 22.2
                     ( minNotch         metal4       (lambda * 3.0) )  ; 22.2
                     ( minSpacing       metal3       (lambda * 3.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 3.0) )  ; 15.2
                ) ; spacingRules
            )
        )

        (metal4Available
            spacingRules(
                 ; rule             layer1           value
                 ( minSpacing       metal4       (lambda * 6.0) )  ; 22.2
                 ( minNotch         metal4       (lambda * 6.0) )  ; 22.2
                 ( minWidth         metal4       (lambda * 6.0) )  ; 22.1
                 ( minSpacing       via3         (lambda * 3.0) )  ; 21.2
                 ( minWidth         metal3       (lambda * 3.0) )  ; 15.1
                 ( minSpacing       via2         (lambda * 3.0) )  ; 14.2
            ) ; spacingRules
            if( deepAvailable then
                spacingRules(
                     ; rule             layer1           value - soj
                     ( minSpacing       metal3       (lambda * 4.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 4.0) )  ; 15.2
                ) ; spacingRules
            else
                spacingRules(
                     ; rule             layer1           value
                     ( minSpacing       metal3       (lambda * 3.0) )  ; 15.2
                     ( minNotch         metal3       (lambda * 3.0) )  ; 15.2
                ) ; spacingRules
            )
        )

        (metal3Available && ( submicronAvailable || deepAvailable )
            spacingRules(
                 ; rule             layer1           value
                 ( minSpacing       metal3       (lambda * 3.0) )  ; 15.2
                 ( minNotch         metal3       (lambda * 3.0) )  ; 15.2
                 ( minWidth         metal3       (lambda * 5.0) )  ; 15.1
                 ( minSpacing       via2         (lambda * 3.0) )  ; 14.2
            ) ; spacingRules
        )

        (metal3Available
             spacingRules(
                 ; rule             layer1           value
                 ( minSpacing       metal3       (lambda * 4.0) )  ; 15.2
                 ( minNotch         metal3       (lambda * 4.0) )  ; 15.2
                 ( minWidth         metal3       (lambda * 6.0) )  ; 15.1
                 ( minSpacing       via2         (lambda * 3.0) )  ; 14.2
           ) ; spacingRules
        )
    )

if( cwellAvailable then
    if( ( submicronAvailable || deepAvailable ) then
        spacingRules(
            ; rule             layer1           value
            ( minWidth         cwell          (lambda * 12.0)  )  ; 17.1
            ( minSpacing       cwell          (lambda * 18.0)  )  ; 17.2
            ( minNotch         cwell          (lambda * 18.0)  )  ; 17.2
        ) ; spacingRules
     else
        spacingRules(
            ; rule             layer1           value
            ( minWidth         cwell          (lambda * 10.0) )   ; 17.1
            ( minSpacing       cwell          (lambda * 9.0)  )   ; 17.2
            ( minNotch         cwell          (lambda * 9.0)  )   ; 17.2
        ) ; spacingRules
    )
)

if( elecAvailable then
    spacingRules(
        ; rule           layer1       value
        ( minSpacing     elec         (lambda * 3.0) )
        ( minNotch       elec         (lambda * 3.0) )
        ( minWidth       elec         (lambda * 2.0) )
    )
    if( submicronAvailable then
        spacingRules(
            ( minSpacing     ce           (lambda * 3.0) )
            ( minSpacing     cc           (lambda * 3.0) )
        ) ; spacingRules
; - addition for DEEP
    else
      if( deepAvailable then
        spacingRules(
            ( minSpacing     ce           (lambda * 4.0) )
            ( minSpacing     cc           (lambda * 4.0) )
        ) ; spacingRules
    else
        spacingRules(
            ( minSpacing     ce           (lambda * 2.0) )
            ( minSpacing     cc           (lambda * 2.0) )
        ) ; spacingRules
    )  )
)

; mfgGridResolution() requires a list argument
mfgGridResolution( list(lambda * 0.5) )

   ) ; let
); physicalRules

;********************************
; ELECTRICAL RULES
;********************************
; Added this portion
electricalRules(

let( (lambda technology cwellAvailable metal3Available metal4Available
      metal5Available metal6Available elecAvailable hvAvailable
      submicronAvailable deepAvailable)

lambda          = techParam( "lambda" )
technology      = techParam( "technology" )
cwellAvailable  = techParam( "cwellAvailable" )
metal3Available = techParam( "metal3Available" )
metal4Available = techParam( "metal4Available" )
metal5Available = techParam( "metal5Available" )
metal6Available = techParam( "metal6Available" )
elecAvailable   = techParam( "elecAvailable" )
hvAvailable     = techParam( "hvAvailable" )


;/*
; * Electrical Rules...
; * This file was modified to use the kit for P&R
; * Jeannette Djigbenou (jddjig01@vt.edu)
; * The numerical values are from file n94s-params.txt (mosis.org)
; * 
; */
;
;case( technology
 ;   ( ("TSMC_CMOS025_DEEP")
	;; TSMC025 0.25um
	;; run N94S
	;; SheetRes unit:ohm/sq
       characterizationRules(
        ;( rule                 layer       	value )
      	( sheetRes          	"metal1"	0.06	 )
  	( areaCap             	"metal1"	0.00	 )
  	( currentDensity        "metal1"	0.00	 )
	( sheetRes          	"metal2"	0.08	 )
  	( areaCap             	"metal2"	0.00	 )
  	( currentDensity      	"metal2"	0.00	 )
	( sheetRes          	"metal3"	0.08	 )
  	( areaCap             	"metal3"	0.00	 )
  	( currentDensity      	"metal3"	0.00	 )
	( sheetRes            	"metal4"	0.08	 )
  	( areaCap             	"metal4"	0.00	 )
  	( currentDensity      	"metal4"	0.00	 )
	( sheetRes           	"metal5"	0.03	 )
  	( areaCap             	"metal5"	0.00	 )
  	( currentDensity      	"metal5"	0.00	 )
       ) ;characterizationRules
;    );TSMC_CMOS025_DEEP
;);case
   ) ; let
); electricalRules


;********************************
; DEVICES
;********************************
devices(

let( (technology lambda wellType contactSpacing submicronAvailable deepAvailable
      cwellAvailable polycapAvailable metal3Available metal4Available
      metal5Available metal6Available npnAvailable ccdAvailable
      elecAvailable sblockAvailable)

technology = techParam( "technology" )

if( NCSU_techData[ technology ] == nil then
    hiGetAttention()
    error( "Unrecognizable \"technology\" property!" )
)

wellType = substring( NCSU_techData[ technology ]->mosisCode 3 1 )
submicronAvailable = NCSU_techData[ technology ]->submicronRules
deepAvailable = NCSU_techData[ technology ]->deepRules
lambda = atof( NCSU_techData[ technology ]->lambda )

cwellAvailable   = techParam( "cwellAvailable" )
polycapAvailable = techParam( "polycapAvailable" )
npnAvailable     = techParam( "npnAvailable" )
elecAvailable    = techParam( "elecAvailable" )
ccdAvailable     = techParam( "ccdAvailable" )
metal3Available  = techParam( "metal3Available" )
metal4Available  = techParam( "metal4Available" )
metal5Available  = techParam( "metal5Available" )
metal6Available  = techParam( "metal6Available" )
sblockAvailable  = techParam( "sblockAvailable" )
hvAvailable      = techParam( "hvAvailable" )

; Set contact spacing here. Saves room later.

cond(
    ( submicronAvailable
        contactSpacing = 5*lambda )
     
    
    ( deepAvailable
        contactSpacing = 6*lambda )
      
    ( t
        
        contactSpacing = 4*lambda )
    )

tcCreateCDSDeviceClass()

/*
 * symbolic contacts
 *
 * Format:
 *
 * (name  viaLayer  viaPurpose
 *        layer1    purpose1  [(enclosure1  encpurpose1  encspacing1)]
 *        layer2    purpose2  [(enclosure2  encpurpose2  encspacing2)]
 *        width          length        
 *        (rows cols    xPitch         yPitch         xBias   yBias)
 *        encByLayer1    encByLayer2    legalRegion)
 *
 * See "Technology File and Display Resource File User Guide" for more info
 */

cond(
    ( wellType == "P"
        symContactDevice(
          (M1_P  cc        drawing
                 pactive   drawing   (pselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (outside pwell drawing))

          (M1_N  cc        drawing
                 nactive   drawing   (nselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (inside pwell drawing))

          (PTAP  cc        drawing
                 pwell     drawing   (pselect     drawing     (lambda * -1.0))
                 metal1    drawing   (pactive     drawing     0)
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 4.0) (lambda * 1.0) (inside pwell drawing))
        )
    )
    ( wellType == "E"
        symContactDevice(
          (M1_P  cc        drawing
                 pactive   drawing   (pselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (inside nwell drawing))

          (M1_N  cc        drawing
                 nactive   drawing   (nselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (inside pwell drawing))

          (PTAP  cc        drawing
                 pwell     drawing   (pselect     drawing     (lambda * -1.0))
                 metal1    drawing   (pactive     drawing     0)
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 4.0) (lambda * 1.0) (inside pwell drawing))

          (NTAP  cc        drawing
                 nwell     drawing   (nselect     drawing     (lambda * -1.0))
                 metal1    drawing   (nactive     drawing     0)
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 4.0) (lambda * 1.0) (inside nwell drawing))
        )
    )
    ( t
        symContactDevice(
          (M1_P  cc        drawing
                 pactive   drawing   (pselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (inside nwell drawing))

          (M1_N  cc        drawing
                 nactive   drawing   (nselect     drawing     (lambda * 2.0))
                 metal1    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 1.0) (lambda * 1.0) (outside nwell drawing))

          (NTAP  cc        drawing
                 nwell     drawing   (nselect     drawing     (lambda * -1.0))
                 metal1    drawing   (nactive     drawing     0)
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       contactSpacing contactSpacing center  center)
                 (lambda * 4.0) (lambda * 1.0) (inside nwell drawing))
        )
    )
)

symContactDevice(
  (M1_POLY cc     drawing
         poly      drawing
         metal1    drawing
         (lambda * 2.0) (lambda * 2.0)
         (1    1       contactSpacing contactSpacing center  center)
         (lambda * 1.0) (lambda * 1.0) _NA_)
)

if( npnAvailable then
    symContactDevice(
      (M1_COLLECTOR cc      drawing
                    cactive drawing
                    metal1  drawing
                    (lambda * 2.0) (lambda * 2.0)
                    (1    1       (lambda * 4.0) (lambda * 4.0) center  center)
                    (lambda * 2.0) (lambda * 1.0) _NA_)
    )
    symContactDevice(
      (M1_EMITTER cc      drawing
                  nselect drawing
                  metal1  drawing
                  (lambda * 2.0) (lambda * 2.0)
                  (1    1       (lambda * 4.0) (lambda * 4.0) center  center)
                  (lambda * 3.0) (lambda * 1.0) _NA_)
    )
    symContactDevice(
      (M1_BASE cc      drawing
               pselect drawing
               metal1  drawing
               (lambda * 2.0) (lambda * 2.0)
               (1    1       (lambda * 4.0) (lambda * 4.0) center  center)
               (lambda * 2.0) (lambda * 1.0) _NA_)
    )
)

if( polycapAvailable then
    symContactDevice(
      (M1_POLYCAP cc      drawing
                  polycap drawing
                  metal1  drawing
                  (lambda * 2.0) (lambda * 2.0)
                  (1    1       (lambda * 4.0) (lambda * 4.0) center  center)
                  (lambda * 2.0) (lambda * 1.0) _NA_)
    )
)

if( elecAvailable then
    symContactDevice(
      (M1_ELEC cc     drawing
               elec      drawing
               metal1    drawing
               (lambda * 2.0) (lambda * 2.0)
               (1    1       (lambda * 4.0) (lambda * 4.0) center  center)
               (lambda * 2.0) (lambda * 1.0) _NA_)
    )
)

if( deepAvailable then
symContactDevice(
  (M2_M1 via       drawing
         metal1    drawing
         metal2    drawing
         (lambda * 3.0) (lambda * 3.0)
         (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
         (lambda * 1.0) (lambda * 1.0) _NA_)
  )

else 

symContactDevice(
  (M2_M1 via       drawing
         metal1    drawing
         metal2    drawing
         (lambda * 2.0) (lambda * 2.0)
         (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
         (lambda * 1.0) (lambda * 1.0) _NA_)
  )
) 



if( cwellAvailable then
    symContactDevice(
      (M1_CAP cc       drawing
              metal1   drawing
              active   drawing
              (lambda * 2.0) (lambda * 2.0)
              (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
              (lambda * 1.0) (lambda * 2.0) (inside cwell drawing))
    )
)

cond( 
        (metal6Available && deepAvailable
            
	    
	    symContactDevice(
            (M6_M5 via5    drawing
                 metal5    drawing
                 metal6    drawing
                 (lambda * 4.0) (lambda * 4.0)
                 (1    1       (lambda * 8.0) (lambda * 8.0) center  center)
                 (lambda * 1.0) (lambda * 2.0) _NA_)
            (M5_M4 via4    drawing
                 metal4    drawing
                 metal5    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M4_M3 via3      drawing
                 metal3    drawing
                 metal4    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 7.0) (lambda * 7.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M3_M2 via2      drawing
                 metal2    drawing
                 metal3    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            )
       
           )
	   
	 (metal6Available && submicronAvailable
	   
	   symContactDevice(
            (M6_M5 via5    drawing
                 metal5    drawing
                 metal6    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 7.0) (lambda * 7.0) center  center)
                 (lambda * 1.0) (lambda * 2.0) _NA_)
            (M5_M4 via4    drawing
                 metal4    drawing
                 metal5    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M4_M3 via3      drawing
                 metal3    drawing
                 metal4    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M3_M2 via2      drawing
                 metal2    drawing
                 metal3    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            )
       
        )
       
	  (metal5Available && deepAvailable
		;; Corrected rule overlap by metal5 is 2lambda for DEEP
            symContactDevice(
            (M5_M4 via4    drawing
                 metal4    drawing
                 metal5    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 2.0) _NA_)
            (M4_M3 via3      drawing
                 metal3    drawing
                 metal4    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 7.0) (lambda * 7.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M3_M2 via2      drawing
                 metal2    drawing
                 metal3    drawing
                 (lambda * 3.0) (lambda * 3.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            )
        )
      
      
      (metal5Available && submicronAvailable
            symContactDevice(
            (M5_M4 via4    drawing
                 metal4    drawing
                 metal5    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M4_M3 via3      drawing
                 metal3    drawing
                 metal4    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            (M3_M2 via2      drawing
                 metal2    drawing
                 metal3    drawing
                 (lambda * 2.0) (lambda * 2.0)
                 (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                 (lambda * 1.0) (lambda * 1.0) _NA_)
            )
        )
        
        
	(metal4Available
            symContactDevice(
              (M4_M3 via3      drawing
                     metal3    drawing
                     metal4    drawing
                     (lambda * 2.0) (lambda * 2.0)
                     (1    1       (lambda * 6.0) (lambda * 6.0) center  center)
                     (lambda * 1.0) (lambda * 2.0) _NA_)
              (M3_M2 via2      drawing
                     metal2    drawing
                     metal3    drawing
                     (lambda * 2.0) (lambda * 2.0)
                     (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                     (lambda * 1.0) (lambda * 1.0) _NA_)
            )
        )
        (metal3Available
            symContactDevice(
              (M3_M2 via2      drawing
                     metal2    drawing
                     metal3    drawing
                     (lambda * 2.0) (lambda * 2.0)
                     (1    1       (lambda * 5.0) (lambda * 5.0) center  center)
                     (lambda * 1.0) (lambda * 2.0) _NA_)
            )
        )
    )

;---------------- end contacts


;
; no depletion devices
;

;
; no enhancement devices - if we ever use LAS, then we'll need them...
;


/*
 * symbolic pins
 *
 * (name maskable layer1 purpose1 w1 layer2 purpose2 w2 legalRegion)
 */


cond(
    ( wellType == "P"
        symPinDevice(
            (pwell nil pwell drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
        )
    )
    ( wellType == "E"
        symPinDevice(
            (pwell nil pwell drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
            (nwell nil nwell drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
        )
    )
    ( wellType == "N"
        symPinDevice(
            (nwell nil nwell drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
        )
    )
)

symPinDevice(
  (nactive nil nactive drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
  (pactive nil pactive drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
  (active nil active drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
  (poly nil poly drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
  (metal1 nil metal1 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
  (metal2 nil metal2 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
)

if( npnAvailable then
    symPinDevice(
      (cactive nil cactive drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( hvAvailable then
    symPinDevice(
      (tactive nil tactive drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( cwellAvailable then
    symPinDevice(
      (cwell nil cwell drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( elecAvailable then
    symPinDevice(
      (elec nil elec drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( polycapAvailable then
    symPinDevice(
      (polycap nil polycap drawing (lambda * 2.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( metal3Available then
    symPinDevice(
      (metal3 nil metal3 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( metal4Available then
    symPinDevice(
      (metal4 nil metal4 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( metal5Available then
    symPinDevice(
      (metal5 nil metal5 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
    )
)

if( metal6Available then
    symPinDevice(
      (metal6 nil metal6 drawing (lambda * 3.0) _NA_ _NA_ _NA_ _NA_)
    )
)


;
; no ruleContact devices
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Opus Symbolic Device Class Definition
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; no other device classes
;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Opus Symbolic Device Declaration
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;
; no other devices
;
  ) ; let

) ;devices


;********************************
; LX RULES
;********************************
; Removed ca via layers from this section too (jddjig01)
lxRules(

let( (technology cwellAvailable metal3Available npnAvailable
      ccdAvailable elecAvailable metal4Available polycapAvailable
      metal5Available metal6Available)


technology       = techParam( "technology" )
cwellAvailable   = techParam( "cwellAvailable" )
npnAvailable     = techParam( "npnAvailable" )
ccdAvailable     = techParam( "ccdAvailable" )
elecAvailable    = techParam( "elecAvailable" )
metal3Available  = techParam( "metal3Available" )
metal4Available  = techParam( "metal4Available" )
metal5Available  = techParam( "metal5Available" )
metal6Available  = techParam( "metal6Available" )
polycapAvailable = techParam( "polycapAvailable" )

lxExtractLayers(
    ( gwell pwell nwell active nactive pactive metal1 metal2 via ca cp cc )
)

if( cwellAvailable then
    lxExtractLayers(
        ( cwell )
    )
)
if( npnAvailable then
    lxExtractLayers(
        ( pbase cactive )
    )
)
if( ccdAvailable then
    lxExtractLayers(
        ( ccd )
    )
)
if( polycapAvailable then
    lxExtractLayers(
        ( polycap )
    )
)
if( elecAvailable then
    lxExtractLayers(
        ( elec ce )
    )
)
if( metal3Available then
    lxExtractLayers(
        ( metal3 )
    )
)
if( metal4Available then
    lxExtractLayers(
        ( metal4 )
    )
)
if( metal5Available then
    lxExtractLayers(
        ( metal5 )
    )
)
if( metal6Available then
    lxExtractLayers(
        ( metal6 )
    )
)

lxNoOverlapLayers(
    ( poly active )
    ( poly nactive )
    ( poly pactive )
;   ( via  ca )
;    ( via  cp )
    ( via  cc )
)
if( npnAvailable then
    lxNoOverlapLayers(
        ( poly cactive )
    )
)
if( polycapAvailable then
    lxNoOverlapLayers(
        ( poly polycap )
        ( metal1 polycap )
        ( metal2 polycap )
    )
)
if( elecAvailable then
    lxNoOverlapLayers(
        ( elec active )
        ( via ce )
    )
)
if( metal3Available && !metal4Available then
    lxNoOverlapLayers(
        ( via2 via )
    )
)

  ) ; let
) ;lxRules

/**************
 *
 * device-level router rules
 *
 **************/

dlrRules(

let( (metal3Available metal4Available metal5Available metal6Available)


metal3Available  = techParam( "metal3Available" )
metal4Available  = techParam( "metal4Available" )
metal5Available  = techParam( "metal5Available" )
metal6Available  = techParam( "metal6Available" )

dlrRoutingLayers(
   ;( layer     direction )
    ( poly      "horizontal" )
    ( metal1    "horizontal" )
    ( metal2    "vertical" )
)

if( metal3Available then
    dlrRoutingLayers(
       ;( layer     direction )
        ( metal3    "horizontal" )
    )
)

if( metal4Available then
    dlrRoutingLayers(
       ;( layer     direction )
        ( metal4    "vertical" )
    )
)

if( metal5Available then
    dlrRoutingLayers(
       ;( layer     direction )
        ( metal5    "horizontal" )
    )
)

if( metal6Available then
    dlrRoutingLayers(
       ;( layer     direction )
        ( metal6    "vertical" )
    )
)

; DLR only supports 1 poly layer for MOS creation (p.5-17, TF & DRF User Guide)

dlrDevices(
    ( poly active )
)

  ) ; let
) ;dlrRules

/**************
 *
 * place-and-route rules
 *
 **************/


prRules(

let( (metal3Available metal4Available metal5Available 
      metal6Available submicronAvailable deepAvailable lambda rules )

 technology = techParam( "technology" )

 if( NCSU_techData[ technology ] == nil then
     hiGetAttention()
     error( "Unrecognizable \"technology\" property!" )
 )

 submicronAvailable = NCSU_techData[ technology ]->submicronRules
 deepAvailable = NCSU_techData[ technology ]->deepRules
 lambda = techParam( "lambda" )
 metal3Available  = techParam( "metal3Available" )
 metal4Available  = techParam( "metal4Available" )
 metal5Available  = techParam( "metal5Available" )
 metal6Available  = techParam( "metal6Available" )

 prRoutingLayers(
 ;( layer                       preferredDirection  )
 ;( -----                       ------------------  )
  ( metal1                   	"horizontal" )
  ( metal2                   	"vertical" )
   ( metal3                   	"horizontal" )
   ( metal4                   	"vertical" )
   ( metal5                   	"horizontal" )
 ) ;prRoutingLayers
 if( metal6Available then
  prRoutingLayers(
   ( metal6                   	"vertical" )
  ) ;prRoutingLayers
 ) ;if metal6Available


 prViaTypes(
 ;( device viewName             viaType    )
 ;( ---------------             -------    )
  ( ("M2_M1"  "symbolic")	"default"  )
   ( ("M3_M2" "symbolic")	"default"  )
   ( ("M4_M3" "symbolic")	"default"  )
   ( ("M5_M4" "symbolic")	"default"  )
 ) ;prViaTypes
 if( metal6Available then
  prViaTypes(
   ( ("M6_M5" "symbolic")	"default"  )
  ) ;prViaTypes
 ) ;if metal6Available

 prStackVias(
;( viaLayerPairList    stackable )
 ;( ----------------    --------- )
  ( cc 		cc	)
  ( metal1	metal1 	)
  ( cc 		via 	)
  ( metal2	metal2 	)
  ( via		via2 	)
  ( metal3	metal3  )
  ( via2	via3 	)
  ( metal4	metal4 	)
  ( via3	via4 	)
  ( metal5	metal5 	)
  ( via		via 	)
  ( via2	via2 	)
  ( via3	via3 	)
  ( via4	via4 	)
 ) ;prStackVias

 ;prMaxStackVias(
 ; not needed
 ;) ;prMaxStackVias


 prMastersliceLayers(
 ;( layers : listed in order of lowest (closest to substrate) to highest )
 ;( -------------------------------------------------------------------- )
  ( nwell	nactive	pactive	poly	glass	pad	sblock	text	res_id	cap_id	metalcap	nodrc)
 ) ;prMastersliceLayers

 ;prViaRules(
 ; not needed
 ;) ;prViaRules

 ; PR Gen Via Rules are needed to import Generated Array Vias from P&R tools
 ; The rules here are adapted from the via rules in $cdk_dir/techfile/devices.tf

 ;( ViaRuleName         viaLayer     (lowerPt upperPt xPitch yPitch resistence) 
 ;    Layer1            Direction|(overhang1 overhang2)    (wMin wMax overHang metalOverHang) 
 ;    Layer2            Direction|(overhang1 overhang2)    (wMin wMax overHang metalOverHang) 
 ;    (properties)
 ;)

 ;( ---------------------------------------------------------------------- ) 
 rules = list( 
     list( 'viagen21	"via"		list( list( 'range -1.5* lambda -1.5* lambda) list( 'range 1.5*lambda 1.5*lambda) 8*lambda 8*lambda '_NA_ )
      'metal1         	"horizontal"	list( '_NA_ '_NA_ lambda 0.0 )
      'metal2         	"vertical"	list( '_NA_ '_NA_ lambda 0.0 )
         )
     list( 'viagen54	"via4"		list( list( 'range -1.5*lambda -1.5*lambda) list( 'range 1.5*lambda 1.5*lambda) 12*lambda 12*lambda '_NA_ )
      'metal5         	"horizontal"	list( '_NA_ '_NA_ lambda 0.0 )
      'metal4         	"vertical"	list( '_NA_ '_NA_ lambda 0.0 )
         )
     list( 'viagen43	"via3"		list( list( 'range -1.5*lambda -1.5*lambda) list( 'range 1.5*lambda 1.5*lambda) 8*lambda 8*lambda '_NA_ )
      'metal3         	"horizontal"	list(  '_NA_ '_NA_ lambda 0.0 )
      'metal4         	"vertical"	list(  '_NA_ '_NA_ lambda 0.0 )
         )
     list( 'viagen32	"via2"		list( list( 'range -1.5*lambda -1.5*lambda) list( 'range 1.5*lambda 1.5*lambda) 8*lambda 8*lambda '_NA_ )
      'metal3         	"horizontal"	list(  '_NA_ '_NA_ lambda 0.0 )
      'metal2         	"vertical"	list(  '_NA_ '_NA_ lambda 0.0 )
         )
	)
 apply( 'prGenViaRules rules )
 prGenViaRules(
  ( TURN1       	nil	( _NA_ _NA_ _NA_ _NA_ _NA_ )
      metal1         	"vertical"	( _NA_ _NA_ _NA_ _NA_ )
      metal1         	"horizontal"	( _NA_ _NA_ _NA_ _NA_ )
  )
  ( TURN2       	nil	( _NA_ _NA_ _NA_ _NA_ _NA_ )
      metal2         	"vertical"	( _NA_ _NA_ _NA_ _NA_ )
      metal2         	"horizontal"	( _NA_ _NA_ _NA_ _NA_ )
  )
   ( TURN3       	nil	( _NA_ _NA_ _NA_ _NA_ _NA_ )
       metal3         	"vertical"	( _NA_ _NA_ _NA_ _NA_ )
       metal3         	"horizontal"	( _NA_ _NA_ _NA_ _NA_ )
   )
   ( TURN4       	nil	( _NA_ _NA_ _NA_ _NA_ _NA_ )
       metal4         	"vertical"	( _NA_ _NA_ _NA_ _NA_ )
       metal4         	"horizontal"	( _NA_ _NA_ _NA_ _NA_ )
   )
   ( TURN5       	nil	( _NA_ _NA_ _NA_ _NA_ _NA_ )
       metal5         	"vertical"	( _NA_ _NA_ _NA_ _NA_ )
       metal5         	"horizontal"	( _NA_ _NA_ _NA_ _NA_ )
   )
 ) ;prGenViaRules

 ;prNonDefaultRules(
 ; not needed
 ;) ;prNonDefaultRules

;; Jeannette Djigbenou: Friday November 17, 2006:
;; Pitch is 9 lambda for m1...m4. pitch=18 lambda for m5. lambda =0.12um
 prRoutingPitch(
 ;( layer                pitch )
 ;( -----                ----- )
  ( metal1               1.08 )
  ( metal2               1.08 )
  ( metal3               1.08 )
  ( metal4               1.08 )
  ( metal5               2.16 )
 ; ( metal6               1.6 )
 ) ;prRoutingPitch

;; Jeannette Djigbenou
;; Modified prRoutingOffset to 0 
prRoutingOffset(
 ;( layer                offset )
 ;( -----                ------ )
  ( metal1               0.0 )
  ( metal2               0.0 )
  ( metal3               0.0 )
  ( metal4               0.0 )
  ( metal5               0.0 )
 ) ;prRoutingOffset

 ;prOverlapLayer(
 ; not needed
 ;) ;prOverlapLayer

) ;let
) ;prRules
