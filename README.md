# [Strive][1]

[![Build Status](https://travis-ci.org/tfausak/strive.svg?branch=master)](https://travis-ci.org/tfausak/strive)

A Haskell client for the [Strava V3 API][2].

-   [Usage](#usage)
    -   [Authentication](#authentication)
        -   [Request Access](#request-access)
        -   [Token Exchange](#token-exchange)
        -   [Deauthorization](#deauthorization)
    -   [Athletes](#athletes)
        -   [Retrieve Current Athlete](#retrieve-current-athlete)
        -   [Retrieve Another Athlete](#retrieve-another-athlete)
        -   [Update Current Athlete](#update-current-athlete)
        -   [List Athlete K/QOMs/CRs](#list-athlete-kqomscrs)
    -   [Friends and Followers](#friends-and-followers)
        -   [List Athlete Friends](#list-athlete-friends)
        -   [List Athlete Followers](#list-athlete-followers)
        -   [List Both Following](#list-both-following)
    -   [Activities](#activities)
        -   [Create an Activity](#create-an-activity)
        -   [Retrieve an Activity](#retrieve-an-activity)
        -   [Update an Activity](#update-an-activity)
        -   [Delete an Activity](#delete-an-activity)
        -   [List Athlete Activities](#list-athlete-activities)
        -   [List Friends' Activities](#list-friends-activities)
        -   [List Activity Zones](#list-activity-zones)
        -   [List Activity Laps](#list-activity-laps)
    -   [Comments](#comments)
        -   [List Activity Comments](#list-activity-comments)
    -   [Kudos](#kudos)
        -   [List Activity Kudoers](#list-activity-kudoers)
    -   [Photos](#photos)
        -   [List Activity Photos](#list-activity-photos)
    -   [Clubs](#clubs)
        -   [Retrieve a Club](#retrieve-a-club)
        -   [List Athlete Clubs](#list-athlete-clubs)
        -   [List Club Members](#list-club-members)
        -   [List Club Activities](#list-club-activities)
    -   [Gear](#gear)
        -   [Retrieve Gear](#retrieve-gear)
    -   [Segments](#segments)
        -   [Retrieve a Segment](#retrieve-a-segment)
        -   [List Starred Segments](#list-starred-segments)
        -   [List Efforts](#list-efforts)
        -   [Segment Leaderboard](#segment-leaderboard)
        -   [Segment Explorer](#segment-explorer)
        -   [Segment Efforts](#segment-efforts)
        -   [Retrieve a Segment Effort](#retrieve-a-segment-effort)
    -   [Streams](#streams)
        -   [Retrieve Activity Streams](#retrieve-activity-streams)
        -   [Retrieve Effort Streams](#retrieve-effort-streams)
        -   [Retrieve Segment Streams](#retrieve-segment-streams)
    -   [Uploads](#uploads)
        -   [Upload an Activity](#upload-an-activity)
        -   [Check Upload Status](#check-upload-status)

## Usage

To use the API, you'll need an access token. Once you have that, create a new
client using the default HTTP manager.

~~~ {.haskell .ignore}
import Strive
let token = "..."
client <- newClient token
-- Client {..}
~~~

Note: This file is executable. Compile and run it with these commands.

~~~ {.sh}
$ cabal exec ghc -- -pgmL markdown-unlit -x lhs README.md
$ ./README ACCESS_TOKEN
~~~

<!--
~~~ {.haskell}
import           Data.Maybe         (fromMaybe, listToMaybe)
import           Data.Time.Calendar (fromGregorian)
import           Data.Time.Clock    (UTCTime (UTCTime))
import           Strive
import           System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    let token = fromMaybe "" (listToMaybe args)
    client <- newClient token
~~~
-->

Many of the examples use the same parameters.

~~~ {.haskell}
    let activityId        = 141273622
    let activityType      = Just "riding"
    let after             = UTCTime (fromGregorian 1970 0 0) 0
    let ageGroup          = Just "0_24"
    let approvalPrompt    = Just "force"
    let athleteId         = 65516
    let before            = UTCTime (fromGregorian 2020 0 0) 0
    let bounds            = (32, -96, 33, -95)
    let clientId          = 1790
    let clientSecret      = "..."
    let clubId            = 11193
    let code              = "..."
    let effortId          = 1595370098
    let following         = Just False
    let gearId            = "b387855"
    let gender            = Just 'F'
    let includeAllEfforts = Just True
    let includeMarkdown   = Just False
    let maxCat            = Just 5
    let minCat            = Just 0
    let page              = Just 1
    let perPage           = Just 200
    let range             = Just "this_year"
    let redirectURL       = "http://localhost"
    let resolution        = Just "low"
    let scope             = Just ["view_private", "write"]
    let segmentId         = 4773104
    let seriesType        = Just "time"
    let state             = Nothing
    let streamTypes       = ["time"]
    let weightClass       = Just "55_64"
~~~

### Authentication

#### Request Access

~~~ {.haskell}
    let authorizeURL = buildAuthorizeURL clientId redirectURL approvalPrompt scope state
    print authorizeURL
    -- ""https://www.strava.com/oauth/authorize?.."
~~~

#### Token Exchange

~~~ {.haskell}
    response <- postToken clientId clientSecret code
    print response
    -- Right (Object ..)
~~~

#### Deauthorization

~~~ {.haskell}
    response' <- postDeauthorize client
    print response'
    -- Right (Object ..)
~~~

### Athletes

#### Retrieve Current Athlete

~~~ {.haskell}
    currentAthlete <- getCurrentAthlete client
    print currentAthlete
    -- Right (AthleteDetailed {..})
~~~

#### Retrieve Another Athlete

~~~ {.haskell}
    athlete <- getAthlete client athleteId
    print athlete
    -- Right (AthleteSummary {..})
~~~

#### Update Current Athlete

<https://github.com/tfausak/strive/issues/7>

#### List Athlete K/QOMs/CRs

~~~ {.haskell}
    athleteCRs <- getAthleteCRs client athleteId page perPage
    print athleteCRs
    -- Right [EffortSummary {..},..]
~~~

### Friends and Followers

#### List Athlete Friends

~~~ {.haskell}
    currentFriends <- getCurrentFriends client page perPage
    print currentFriends
    -- Right [AthleteSummary {..},..]
~~~

#### List Athlete Followers

~~~ {.haskell}
    currentFollowers <- getCurrentFollowers client page perPage
    print currentFollowers
    -- Right [AthleteSummary {..},..]
~~~

#### List Both Following

~~~ {.haskell}
    commonFriends <- getCommonFriends client athleteId page perPage
    print commonFriends
    -- Right [AthleteSummary {..},..]
~~~

### Activities

#### Create an Activity

<https://github.com/tfausak/strive/issues/12>

#### Retrieve an Activity

~~~ {.haskell}
    activity <- getActivity client activityId includeAllEfforts
    print activity
    -- Right (ActivitySummary {..})
~~~

#### Update an Activity

<https://github.com/tfausak/strive/issues/14>

#### Delete an Activity

<https://github.com/tfausak/strive/issues/15>

#### List Athlete Activities

~~~ {.haskell}
    currentActivities <- getCurrentActivities client (Just before) (Just after) page perPage
    print currentActivities
    -- Right [ActivitySummary {..},..]
~~~

#### List Friends' Activities

~~~ {.haskell}
    feed <- getFeed client page perPage
    print feed
    -- Right [ActivitySummary {..},..]
~~~

#### List Activity Zones

~~~ {.haskell}
    activityZones <- getActivityZones client activityId
    print activityZones
    -- Right [ZoneSummary {..},..]
~~~

#### List Activity Laps

~~~ {.haskell}
    activityLaps <- getActivityLaps client activityId
    print activityLaps
    -- Right [ZoneSummary {..},..]
~~~

### Comments

#### List Activity Comments

~~~ {.haskell}
    activityComments <- getActivityComments client activityId includeMarkdown page perPage
    print activityComments
    -- Right [CommentSummary {..},..]
~~~

### Kudos

#### List Activity Kudoers

~~~ {.haskell}
    activityKudoers <- getActivityKudoers client activityId page perPage
    print activityKudoers
    -- Right [AthleteSummary {..},..]
~~~

### Photos

#### List Activity Photos

~~~ {.haskell}
    activityPhotos <- getActivityPhotos client activityId
    print activityPhotos
    -- Right [PhotoSummary {..},..]
~~~

### Clubs

#### Retrieve a Club

~~~ {.haskell}
    club <- getClub client clubId
    print club
    -- Right (ClubDetailed {..})
~~~

#### List Athlete Clubs

~~~ {.haskell}
    currentClubs <- getCurrentClubs client
    print currentClubs
    -- Right [ClubSummary {..},..]
~~~

#### List Club Members

~~~ {.haskell}
    clubMembers <- getClubMembers client clubId page perPage
    print clubMembers
    -- Right [AthleteSummary {..},..]
~~~

#### List Club Activities

~~~ {.haskell}
    clubActivities <- getClubActivities client clubId page perPage
    print clubActivities
    -- Right [ActivitySummary {..},..]
~~~

### Gear

#### Retrieve Gear

~~~ {.haskell}
    gear <- getGear client gearId
    print gear
    -- Right (GearDetailed {..})
~~~

### Segments

#### Retrieve a Segment

~~~ {.haskell}
    segment <- getSegment client segmentId
    print segment
    -- Right (SegmentDetailed {..})
~~~

#### List Starred Segments

~~~ {.haskell}
    starredSegments <- getStarredSegments client page perPage
    print starredSegments
    -- Right [SegmentSummary {..},..]
~~~

#### List Efforts

~~~ {.haskell}
    efforts <- getSegmentEfforts client segmentId (Just athleteId) (Just (after, before)) page perPage
    print efforts
    -- Right [EffortSummary {..},..]
~~~

#### Segment Leaderboard

~~~ {.haskell}
    segmentLeaders <- getSegmentLeaderboard client segmentId gender ageGroup weightClass following (Just clubId) range page perPage
    print segmentLeaders
    -- Right [SegmentLeader {..},..]
~~~

#### Segment Explorer

~~~ {.haskell}
    segments <- exploreSegments client bounds activityType minCat maxCat
    print segments
    -- Right [SegmentExploration {..},..]
~~~

### Segment Efforts

#### Retrieve a Segment Effort

~~~ {.haskell}
    effort <- getEffort client effortId
    print effort
    -- Right (EffortSummary {..})
~~~

### Streams

#### Retrieve Activity Streams

~~~ {.haskell}
    activityStreams <- getActivityStreams client activityId streamTypes resolution seriesType
    print activityStreams
    -- Right [StreamDetailed {..},..]
~~~

#### Retrieve Effort Streams

~~~ {.haskell}
    effortStreams <- getEffortStreams client effortId streamTypes resolution seriesType
    print effortStreams
    -- Right [StreamDetailed {..},..]
~~~

#### Retrieve Segment Streams

~~~ {.haskell}
    segmentStreams <- getSegmentStreams client segmentId streamTypes resolution seriesType
    print segmentStreams
    -- Right [StreamDetailed {..},..]
~~~

### Uploads

#### Upload an Activity

<https://github.com/tfausak/strive/issues/34>

#### Check Upload Status

<https://github.com/tfausak/strive/issues/35>

[1]: https://github.com/tfausak/strive
[2]: http://strava.github.io/api/
