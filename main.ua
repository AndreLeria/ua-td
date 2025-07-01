# Experimental!

Month ← "06"
Days  ← ≡(⬚⌞@0 ↯ [2] °⋕) +1 ⇡ 31
Files ← ≡($"./data/_-_.txt" Month) Days

┌─╴DaySeries
  ~ [month day]
  NormalizeNumbers  ← ≡(⬚⌞@0 ↯ ¤2 °⋕)
  FileName          ← $"./data/_-_.txt" °⊟ NormalizeNumbers
  ToTable           ← ↯ ∞_5 ⊜□ ¬ ↥ ⊸⊃(=@\n|=@\r)
  DiscardNotWorking ← ▽ ⊸≡(¬ ◇≍ "Not Working" ⊏ 3)
  OnlyRelevantCols  ← ≡↙₂
  PrependDate       ← ≡˜⊂ ⊙(□$"_-_-_" ⊡ 0 datetime now°⊟ NormalizeNumbers)
  ToString          ← /$"_\n_" ⍚/$"_\t_"
└─╴

DaySeries!(
  New 6 1
  ⊸(
    &fras FileName
    ToTable
    DiscardNotWorking
    OnlyRelevantCols
  
    ≡(⍜▽⋅(□"23:59") ⊸≡≍ □"0:00")
  )
  PrependDate
  ToString
  ⊸°&clip
)
