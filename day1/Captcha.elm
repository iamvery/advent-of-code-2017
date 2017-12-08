module Captcha exposing (..)


digits : Int -> List Int
digits =
    digits_into []


digits_into : List Int -> Int -> List Int
digits_into list n =
    case n of
        0 ->
            list

        _ ->
            digits_into (n % 10 :: list) (n // 10)


rotate : List a -> List a
rotate list =
    case list of
        [] ->
            list

        head :: tail ->
            List.concat [ tail, [ head ] ]


repeat : (a -> a) -> Int -> a -> a
repeat fun until value =
    case until of
        0 ->
            value

        _ ->
            repeat fun (until - 1) (fun value)


zip : List a -> List b -> List ( a, b )
zip =
    -- https://groups.google.com/forum/#!topic/elm-discuss/CymE5cijGpc
    List.map2 (,)


chunk : Int -> List a -> List ( a, a )
chunk shift list =
    zip list (repeat rotate shift list)


check : Int -> Int
check number =
    number |> digits |> (chunk 1) |> sum


sum : List ( Int, Int ) -> Int
sum =
    List.foldl add 0


add : ( Int, Int ) -> Int -> Int
add ( x, y ) sum =
    if x == y then
        sum + x
    else
        sum
