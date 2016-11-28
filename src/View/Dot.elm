module View.Dot exposing (dot)

import Svg exposing (Svg, circle)
import Svg.Attributes exposing (fill, cx, cy, r)
import Model
import Model.Tile as Tile


radius : Float
radius =
    1


dot : Model.World -> ( ( Int, Int ), Tile.Tile ) -> Svg msg
dot world ( ( x, y ), tile ) =
    let
        center =
            Model.tileSize world // 2
    in
        circle
            [ fill "#fff"
            , cx <| toString <| x + center
            , cy <| toString <| y + center
            , r <| toString radius
            ]
            []
