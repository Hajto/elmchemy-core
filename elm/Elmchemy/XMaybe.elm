module Elmchemy.XMaybe exposing
    ( Maybe(Just, Nothing)
    , andThen
    , map
    , map2
    , map3
    , map4
    , map5
    , withDefault
    )

{-| This library fills a bunch of important niches in Elm. A `Maybe` can help
you with optional arguments, error handling, and records with optional fields.


# Definition

@docs Maybe


# Common Helpers

@docs withDefault, map, map2, map3, map4, map5


# Chaining Maybes

@docs andThen

-}


{-| Represent values that may or may not exist. It can be useful if you have a
record field that is only filled in sometimes. Or if a function takes a value
sometimes, but does not absolutely need it.
-}
type Maybe a
    = Just a
    | Nothing


{-| Provide a default value, turning an optional value into a normal
value. This comes in handy when paired with functions like
[`Dict.get`](Dict#get) which gives back a `Maybe`.

    withDefault 100 (Just 42)   == 42
    withDefault 100 Nothing     == 100

-}
withDefault : a -> Maybe a -> a
withDefault default maybe =
    case maybe of
        Nothing ->
            default

        Just value ->
            value



{- flag
   nospec:+map
   nospec:+map2
   nospec:+map3
   nospec:+map4
   nospec:+map5
-}


{-| Transform a `Maybe` value with a given function:

    map ((+) 2) (Just 9) == Just 11
    map ((+) 2) Nothing == Nothing

-}
map : (a -> b) -> Maybe a -> Maybe b
map f maybe =
    case maybe of
        Nothing ->
            Nothing

        Just value ->
            Just (f value)


{-| Apply a function if all the arguments are `Just` a value.

    map2 (+) (Just 3) (Just 4) == Just 7
    map2 (+) (Just 3) Nothing == Nothing
    map2 (+) Nothing (Just 4) == Nothing

-}
map2 : (a -> b -> value) -> Maybe a -> Maybe b -> Maybe value
map2 func ma mb =
    case ( ma, mb ) of
        ( Just a, Just b ) ->
            Just (func a b)

        _ ->
            Nothing


{-| -}
map3 : (a -> b -> c -> value) -> Maybe a -> Maybe b -> Maybe c -> Maybe value
map3 func ma mb mc =
    case ( ma, mb, mc ) of
        ( Just a, Just b, Just c ) ->
            Just (func a b c)

        _ ->
            Nothing


{-| -}
map4 : (a -> b -> c -> d -> value) -> Maybe a -> Maybe b -> Maybe c -> Maybe d -> Maybe value
map4 func ma mb mc md =
    case ( ma, mb, mc, md ) of
        ( Just a, Just b, Just c, Just d ) ->
            Just (func a b c d)

        _ ->
            Nothing


{-| -}
map5 : (a -> b -> c -> d -> e -> value) -> Maybe a -> Maybe b -> Maybe c -> Maybe d -> Maybe e -> Maybe value
map5 func ma mb mc md me =
    case ( ma, mb, mc, md, me ) of
        ( Just a, Just b, Just c, Just d, Just e ) ->
            Just (func a b c d e)

        _ ->
            Nothing


{-| Chain together many computations that may fail. It is helpful to see its
definition:

This means we only continue with the callback if things are going well. For
example, say you need to use (`head : List Int -> Maybe Int`) to get the
first month from a `List` and then make sure it is between 1 and 12:

If `head` fails and results in `Nothing` (because the `List` was `empty`),
this entire chain of operations will short-circuit and result in `Nothing`.
If `toValidMonth` results in `Nothing`, again the chain of computations
will result in `Nothing`.

-}



{- flag nospec:+andThen -}


andThen : (a -> Maybe b) -> Maybe a -> Maybe b
andThen callback maybeValue =
    case maybeValue of
        Just value ->
            callback value

        Nothing ->
            Nothing
