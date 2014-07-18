{-# LANGUAGE OverloadedStrings #-}

module Strive.Types.Comments
  ( CommentSummary (..)
  ) where

import Control.Applicative (empty, (<$>), (<*>))
import Data.Aeson (FromJSON, Value (Object), parseJSON, (.:))
import Data.Text (Text)
import Data.Time.Clock (UTCTime)
import Strive.Enums (ResourceState)
import Strive.Types.Athletes (AthleteSummary)

-- | <http://strava.github.io/api/v3/comments/#summary-and-detailed-representation-attributes>
data CommentSummary = CommentSummary
  { commentSummary_activityId    :: Integer
  , commentSummary_athlete       :: AthleteSummary
  , commentSummary_createdAt     :: UTCTime
  , commentSummary_id            :: Integer
  , commentSummary_resourceState :: ResourceState
  , commentSummary_text          :: Text
  } deriving Show

instance FromJSON CommentSummary where
  parseJSON (Object o) = CommentSummary
    <$> o .: "activity_id"
    <*> o .: "athlete"
    <*> o .: "created_at"
    <*> o .: "id"
    <*> o .: "resource_state"
    <*> o .: "text"
  parseJSON _ = empty