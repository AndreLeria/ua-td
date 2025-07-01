# Experimental!

Month ← "06"
Days  ← ≡(⬚⌞@0 ↯ [2] °⋕) +1 ⇡ 31
Files ← ≡($"./data/_-_.txt" Month) Days

Diff ← -⌵

┌─╴String
  Trim⌞ ← ▽ ¬\↧ ⊸= @ 
  Trim⌟ ← ⍜⇌ Trim⌞
  Trim  ← Trim⌞ Trim⌟
└─╴

┌─╴Clock
  Parse   ← ⌅(⊜⋕ ⊸≠ @: ◇String~Trim|$"_:_" °⊟)
  Minutes ← ⌅(/+×60_1|[⊃(⌊÷60|◿60)])
└─╴

┌─╴DaySeries
  ~ [month day]
  NormalizeNumbers  ← ≡(⬚⌞@0 ↯ ¤2 °⋕)
  FileName          ← $"./data/_-_.txt" °⊟ NormalizeNumbers
  ToTable           ← ↯ ∞_5 ⊜□ ¬ ↥ ⊸⊃(=@\n|=@\r)
  DiscardNotWorking ← ▽ ⊸≡(¬ ◇≍ "Not Working" ⊏ 3)
  OnlyRelevantCols  ← ≡↙₂
  FixMidnight       ← ≡(⍜↘₁ (⍜▽ ⋅(□"23:59") ⊸≡≍ □"0:00"))
  MergeIntervals    ← ⊂ ⊓↘₋₁ ↘₁
  MergeSuccessive   ← ↯ ∞_2 /(⨬(MergeIntervals|⊂) >2 Diff ∩Clock!(Minutes Parse) ◡⊓⊡₋₁⊡₀)
  Convert           ← MergeSuccessive FixMidnight≡₀⍚String~Trim OnlyRelevantCols DiscardNotWorking ToTable &fras FileName
  PrependDate       ← ≡˜⊂ ⊙(□$"_-_-_" ⊡ 0 datetime now°⊟ NormalizeNumbers)
  ToString          ← /$"_\n_" ⍚/$"_\t_"
  GetReady          ← ⊸°&clip ToString PrependDate
└─╴

DaySeries!(
  New 6 2
  ⊸Convert
  GetReady
)
