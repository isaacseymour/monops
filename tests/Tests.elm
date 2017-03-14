module Tests exposing (..)

import Test exposing (..)
import GameTests


all : Test
all =
    describe "A Test Suite"
        [ GameTests.all ]
