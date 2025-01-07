#Include %A_ScriptDir%\Lib\FindText.ahk


pick_card := "|<>*135$26.zzzzzzzzzzzzzzzzzzz1zzz03zzU0Tzk03zs00Ty3s7z0z0zkTsDw7y3y1zUzUTsDs7y3y1zUzUTsDs7y3z1zUzkTkDw3w7zUS1zs00zz00Dzs0DzzU7zzzzzzzzzzzzzzzzzzzzzzy"
;if (ok:=FindText(&X, &Y, 391-150000, 249-150000, 391+150000, 249+150000, 0, 0, pick_card))

new_path := "|<>*135$100.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz7zy7szzzzzy0DzztwDzsTXzzzzzs0Tzz3kzzUyDzzzzzU0zzwD3zy1szzzzzy73zzkwDzs3XkCCCDsS7WC0E3zUCC00kszVsM0E107y0Mk0V13y7101040Ds0X3W44Ds0A060k0TV0AC801zU0ksQD3Vy60k0k07y077VkwC7sQ30700zs1wA73ksTVsADy23zVzk0Q73Vy7Uk0s8Dy7z01sAC7sT3U3llzsTy07UlsTXyD0T77zXzy8z37nzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"

health := "|<>*136$48.zzzzzzzzzzzzzzzzzzzzyTtzttzzyQtzttzzyQtzttxzyMtzttkQ2E87s1UM2E87s161WMtXtt0FWQtXttbs2QtXttUM2A9XttkQ2CNnzzzzzzzzzzzzzzzzzzzzzzzzU"

regen := "|<>*135$47.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz0zzzzzzy0zzzzzzwlxzzrzztnUs630zn61U861zU8kA34lz0E4M0NXyMnw1Dn7wtUM21aDtnUs63CTzzzqTzzzzzz0zzzzzzz3zzzzzzzzzzzU"

speed := "|<>*133$44.zzzzzzzzzzzzzzzzzzzzzzzzzzzzxz1zzzzyDUTzzzzXtjzxzTsyDUQ71kDUM61UM3y2M61WMzsa0416D682Tbs3s61UM60z3Uw71kDztzzzzzzyTzzzzzzbzzzzzzzzzzzzzzzzzzzs"

explosive_death := "|<>*121$103.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz0zzszzlzzy7zzxXzz0TzwTzxzzy0zzwlzzXzzyDzzzzz4Dzy8zzkQE16323Y7XY60033s710X0Z4k1lk1000Zw3lW16EW00ss04H6EyDkF0WAFV0wM0W9XAD0E86888lkS0kM41U7k9o7666wwDUwC35m7zzyDzzzzzzzzzzzzzzzz7zzzzzzzzzzzzzzzzrzzzzzzzzzzzzzw"

range := "|<>*136$68.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy0DzzzzzzzzzU1zzzzzzzzzs0Dzzzzzzzzy73zzzzzzzzzVsS8sVz2D0zsS6060DU3U3y7101U1k0k0zU0k0M0A0ACDs0AC673733Xy077VVklsk0zU0kkMQAAA0TsQA0673033zy7V01Vks0k0zVsM0MwD0C0DszDWCDbtXk7zzzzzzzxkzzzzzzzzzy0DzzzzzzzzzU7zzzzzzzzzs3zzzzzzzzzzVzzzzzzzzzzzzzzs"

attack := "|<>*133$70.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzXzzlznszzzzy7zy7y73zzzzsTzkDsQDzzzzVzz0zVkzzzzy7zs1w00T4TUsRzU7U01k0s1V3y0C00603060Dkkw00M0A0M0z31sQDVkkzUDs07VkyD37y0zU0S73sMADs1w00sC7U0k1U3kz3kM60306467y70UQ0C0MMQTsy7XwFy3XnzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

cooldown := "|<>*135$93.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyTzDzzzzzzzUzzzzlzkzzzzzzzk1zzzyDy7zzzzzzw0Dzzzlzkzzzzzzz0lzzzyDy7zzzzzzsTz1y3lw0sDCCMXz7zk3U6D060ElV0Dszw0M0lk0U344M0z7zVV32C44A80X23szwQ8sFlkXV00MsT3zXV72CC4QA0773sCAA8MFkUVVUUssTU1U3062040S4D73y0C0w1kM0k7klssTw3sDkT3VD1zCT7bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzw"

shield := "|<>*135$43.zzzzzzzzzzzzzzzzDnznzT1btztz70nxzwzXatzzSTllw3C3D0s61a1b0T1AGAHaDsa90NX6AH4nws3UNWM6A1sQtC370zzzzzzzzzzzzzzw"


yen := "|<>*135$42.zzzzzzzzzzzzzzzzzzzzzyzrzzzzwTVzzzzsDVzzzzwD1zzzzy73zzzzy270wEzz060A0TzUA0A0DzUQCA07zkQCAC7zkw0AC7zkw0QC7zkwDwC7zkw0AC7zky0AS7zsz0QTDzzzzzzzzzzzzzzU"

global textCards := Map(
    "new_path", new_path,
    "health", health,
    "regen", regen,
    "speed", speed,
    "explosive_death", explosive_death,
    "range", range,
    "attack", attack,
    "cooldown", cooldown,
    "shield", shield,
    "yen", yen
)