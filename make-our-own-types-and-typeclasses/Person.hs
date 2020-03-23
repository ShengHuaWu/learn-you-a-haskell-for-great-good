-- By using record syntax to create this data type, 
-- Haskell automatically made these functions: 
-- firstName, lastName, age, height, phoneNumber and flavor.
data Person = Person {
    firstName :: String,
    lastName :: String,
    age :: Int,
    height :: Float,
    phoneNumber :: String
    flavor :: String
} deriving (Show) -- The `Show` will display all the field names and values respectively.

-- When creating a new `Person`,
-- we don't have to necessarily put the fields in the proper order, as long as we list all of them. 