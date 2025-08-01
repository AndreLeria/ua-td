# Experimental!
Args ← &args

ArgsToTable ← ⧈∘ 2

# Creates an Extractor function.
# Expects 4 arguments: UnionValue, Keyword, UnionNone, and UnionInvalid.
#
# Example: given the following Union:
# ```uiua
#     ┌─╴Union
#       |None
#       |Invalid
#       |Valid {Value}
#     └─╴
# ```
# To extract the value from `uiua main.ua --value x`, use:
# ```uiua
# Union!(Extract!!!!(Value|"--value"|None|Invalid))
# ```
#
# Extract!!!!(UnionValue|Keyword|UnionNone|UnionInvalid)
Extract‼‼ ← (
  ArgsToTable
  ⍢(⊙(+1) ◡(⨬(⋅⋅^2|⍣(^0°{^1 ∘} ⊡|^3)) :⟜>⊙⊸⧻) ◌
  | ≍ ^3
  ) ^3 0
  ⊙(◌◌)
)

┌─╴KwArg
  |None
  |Invalid
  |Month {Month}
  |Day {Day}
  |StopAtDay {Stop}

  Extract‼     ← Extract‼‼(^0|^1|None|Invalid)
  ExtractMonth ← Extract‼(Month|"--month")
  ExtractDay   ← Extract‼(Day|"--day")
  ExtractStop  ← Extract‼(StopAtDay|"--stop-at-day")

  IsNil ← ↥ ⊃(≍ None|≍ Invalid)

  # ? Value Key
  Require! ← (
    ⊙$"Kwarg _ is mandatory" # Value ErrMsg ? Value Key
    ⊸IsNil                   # Check Value ? Value
    ⍥(&exit 1 ⊙&p)           # ? Check Value ErrMsg
    °^0                      # ? Value
  )
└─╴

KwArg!(⊃(ExtractMonth|ExtractDay|ExtractStop) Args)
KwMonth ←
KwDay   ←
KwStop  ←

KwArg!(
  $Month Require!Month KwMonth "--month"
  $Day Require!Day KwDay "--day"
  ⍣(∩⋕
  | &exit 2 &p "Month and day must be parseable numbers"
  )
)

Day   ←
Month ←

DayInterval ← ⍣(+1 -Day⋕ °KwArg~StopAtDay|7) KwStop
