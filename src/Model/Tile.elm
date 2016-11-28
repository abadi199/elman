module Model.Tile
    exposing
        ( Tile(..)
        , Item(..)
        , PathType(..)
        )


type Tile
    = Wall
    | Path PathType Item


type PathType
    = LRC
    | LUC
    | LURC
    | LDRC
    | URC
    | DRC
    | LDC
    | UDC
    | LURDC
    | ULDC
    | URDC


type Item
    = Dot
    | Cherry
    | Power
