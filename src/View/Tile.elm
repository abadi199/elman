module View.Tile exposing (tile)

import Model
import Model.Tile as Tile
import Svg exposing (Svg)


tile : Model.World -> ( ( Int, Int ), Tile.Tile ) -> Svg msg
tile world ( ( x, y ), tile ) =
    let
        center =
            Model.tileSize world // 2
    in
        case tile of
            Tile.Path pathType item ->
                path world x y pathType item

            _ ->
                Debug.crash ""
