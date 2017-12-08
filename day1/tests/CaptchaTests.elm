module CaptchaTests exposing (..)

import Expect exposing (equal)
import Test exposing (..)
import Captcha exposing (check)


suite : Test
suite =
    describe "Captcha"
        [ test "digits" <|
            \() -> equal (Captcha.digits 123) [ 1, 2, 3 ]
        , test "rotate" <|
            \() -> equal (Captcha.rotate [ 1, 2, 3 ]) [ 2, 3, 1 ]
        , test "zip" <|
            \() -> equal (Captcha.zip [ 1, 2, 3 ] [ 4, 5, 6 ]) [ ( 1, 4 ), ( 2, 5 ), ( 3, 6 ) ]
        , test "chunk" <|
            \() -> equal (Captcha.chunk [ 1, 2, 3 ]) [ ( 1, 2 ), ( 2, 3 ), ( 3, 1 ) ]
        , test "examples" <|
            \() -> equal (List.map Captcha.check [ 1122, 1111, 1234, 91212129 ]) [ 3, 4, 0, 9 ]
        ]
