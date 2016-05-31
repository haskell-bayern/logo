{-# LANGUAGE NoMonomorphismRestriction #-}

module Main where

import Diagrams.Prelude
import Diagrams.Backend.SVG.CmdLine
import Data.Colour.SRGB (sRGB24read)
import Data.List.Split (splitEvery)

--- from Wikipedia
bav_white = sRGB24read "#ffffff"
bav_blue = sRGB24read "#0098d4"

other c | c == bav_white = bav_blue
other _ = bav_white

lambdawidth = 3

raute :: Colour Double -> Diagram B
raute c = ((trailLike $ trailFromSegments [straight $ r2 (-0.5, -0.5)]
                          `at` p2 (0,0)) # lc (other c)) # lw lambdawidth
          <> vrule 1 # lc (other c) # lw lambdawidth
          <> square 1 # fc c # lw 0

grid :: Diagram B
grid = foldl1 (|||) $
         map (foldl1 (===)) $
           splitEvery 11 $ concat $ replicate 55
                                      [raute bav_white, raute bav_blue]

shear :: Diagram B -> Diagram B
shear = scaleX 2 `underT` rotation (1/8 @@ turn)

logo :: Diagram B
logo = shear grid

box :: Diagram B
box = shear (rect 4 4 # alignTL # translate (r2 (2.5,-2.5)))

logopreview :: Diagram B
logopreview = boundingRect (boundingBox box) <> box <> logo

logocut :: Diagram B
logocut = logo # clipTo (boundingRect (boundingBox box))

main = mainWith [("preview", logopreview),
                 ("logo", logocut)]
