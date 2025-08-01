# Experimental!

KwArgs ~ "kwargs.ua"

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
  PrependDate       ← ≡˜⊂ ⊙(□$"_-_-_" ⊡ 0 datetime now°⊟ NormalizeNumbers)
  Convert ← ⍣(
    PrependDate⊸(
      &fras FileName
      ToTable
      DiscardNotWorking
      OnlyRelevantCols
      ≡₀⍚String~Trim
      FixMidnight
      MergeSuccessive
    )
  | ⋅[])
  DiscardNonExistent ← ▽ ⊸≡(¬ ◇≍ [])
  ToString           ← /$"_\n_" ⍚/$"_\t_"
  GetReady           ← ⊸°&clip ToString
└─╴

Month          ← KwArgs~Month
FirstDayOfWeek ← KwArgs~Day

⍚DaySeries!(⊸Convert New Month) + FirstDayOfWeek ⇡ KwArgs~DayInterval
DaySeries!(
  DiscardNonExistent
  /◇⊂
  GetReady
)
