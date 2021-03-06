
module FlightData where

import qualified Data.Map as Map
import Data.Map(Map(..))
import Data.Time
import Data.Function

-- i suppose we could import this from Control.Lens.Operator but it seems a bit
-- heavyweight for just this purpose
-- *grumble* why isn't this in Data.Function anyway
-- Anyway, this doesn't really belong here -- we should move it out to a generic Utils module
(<&>) :: (Functor f) => f a -> (a -> b) -> f b
a <&> b = b <$> a

data DistanceUnits = Meters | Kilometers | Miles deriving (Eq, Show)
data TemperatureUnits = Kelvin | Celsius | Fahrenheit deriving (Eq, Show)

type Timestamp = UTCTime

data Location = Location {
  lUnits :: DistanceUnits,
  lx :: Double,
  ly :: Double
  } deriving (Eq, Show)

data Temperature = Temperature {
  tUnits :: TemperatureUnits,
  tValue :: Double
  } deriving (Eq, Show)

instance Ord Temperature where
  compare temp1 temp2
    | tUnits temp1 /= tUnits temp2 = error $ "not implemented: cross-unit comparisons! " ++ show (tUnits temp1) ++ " vs " ++ show (tUnits temp2)
    | otherwise = compare (tValue temp1) (tValue temp2)

data ObservatoryID = ObservatoryID String deriving (Eq, Show, Ord)

data Observation = Observation {
  timestamp :: Timestamp,
  location :: Location,
  temperature :: Temperature,
  observatoryID :: ObservatoryID
  } deriving (Eq, Show)
