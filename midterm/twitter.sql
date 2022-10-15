create table User (
  userID numeric primary key,
  userName varchar not null unique,
  email varchar not null unique,
  password varchar not null unique
);

create table Tweet (
  tweetID numeric primary key,
  retweetFromID numeric unique,
  userID numeric not null,
  text varchar not null,
  postTime date not null unique,
  views numeric,
  promoted boolean,
  foreign key(userID) references User(userID)
);

create table Likes (
  likeID numeric primary key,
  tweetID numeric not null,
  userID numeric not null,
  foreign key(tweetId) references Tweet(tweetID),
  foreign key(userId) references User(userID)
);

create table UserMention(
  userMentionID numeric primary key,
  tweetID numeric not null unique,
  text varchar
);

create table HashTag (
  hashTagID numeric primary key,
  hashTagName varchar not null unique
);

create table HashTagConnection(
  hashTagConnectionID numeric primary key,
  tweetID numeric not null,
  hashTagID numeric not null,
  foreign key(tweetID) references Tweet(tweetID),
  foreign key(hashTagID) references HashTag(hashTagID)
);

create table FollowList (
  followListID numeric primary key,
  followerID numeric,
  followeeID numeric,
  foreign key(followerID) references User(userID),
  foreign key(followeeID) references User(userID)
);

create table Profile (
  profileID numberic primary key,
  userID numeric not null unique,
  joinedDate date not null,
  location varchar not null,
  profilePic varchar,
  backgroudPic varchar,
  foreign key(userID) references User(userID)
);

INSERT INTO User (userID, userName, email, password)
VALUES
	(1, "Jessica Park", "jessi.park@byu.edu", 371124269),
	(2, "John Kim", "john.kim@byu.edu", 9873232),
	(3, "Amy John", "amy.john@byu.edu", 3713293),
  (4, "Elizabeth", "elizabeth@byu.edu", 238216),
  (5, "ZambaJuice", "jambajuice@byu.edu", 3719213),
  (6, "Thomas", "thomas@byu.edu", 309124223),
  (7, "Strawberry", "strawberry@byu.edu", 283712421),
  (8, "RemoteControl", "remotecontrol@byu.edu", 1124122732),
  (9, "Computer", "computer@byu.edu", 387193);

INSERT INTO Tweet (tweetID, retweetFromID, userID, text, postTime, views)
  VALUES
  (100001, null, 3, "The newly planted trees were held up by wooden frames in hopes they could survive the next storm. #GoCougars", "2013-12-21", 23),
  (100002, null, 5, "He found rain fascinating yet unpleasant.", "2020-01-15", 45),
  (100003, null, 1, "Dolores wouldn't have eaten the meal if she had known what it actually was.", "2011-11-11", 12),
  (100004, null, 7, "The book is in front of the table.", "2013-11-20", 25),
  (100005, 100003, 9, "Dolores wouldn't have eaten the meal if she had known what it actually was.", "2014-12-23", 177),
  (100006, null, 1, "There's a message for you if you look up.", "2011-07-09", 1124),
  (100007, null, 2, "Love is not like pizza.", "2016-03-18", 124),
  (100008, 100001, 2, "The newly planted trees were held up by wooden frames in hopes they could survive the next storm. #GoCougars", "2014-01-23", 3242),
  (100009, null, 6, "Thirty years later, she still thought it was okay to put the toilet paper roll under rather than over.", "2012-03-27", 12),
  (100010, null, 9, "Karen realized the only way she was getting into heaven was to cheat.", "2012-11-12", 10),
  (100011, null, 7, "She wore green lipstick like a fashion icon.", "2021-11-23", 2),
  (100012, 100014, 4, "Each person who knows you has a different perception of who you are.", "2013-03-02", 124),
  (100013, null, 2, "He learned the hardest lesson of his life and had the scars, both physical and mental, to prove it.", "2021-03-12", 231),
  (100014, null, 3, "Cursive writing is the best way to build a race track.", "2022-11-08", 1),
  (100015, null, 1, "Their argument could be heard across the parking lot.", "2021-11-02", 122);

insert into Likes (likeID, tweetID, userID)
  values
  (101, 100009, 3),
  (102, 100007, 4),
  (103, 100002, 5),
  (104, 100002, 6),
  (105, 100001, 7),
  (106, 100003, 9),
  (107, 100001, 2),
  (108, 100002, 3),
  (109, 100003, 4);

insert into FollowList (followListID, followerID, followeeID)
  values
  (1001, 1, 3),
  (1002, 2, 4),
  (1003, 1, 6),
  (1004, 3, 2),
  (1005, 2, 5),
  (1006, 5, 1);

insert into UserMention (userMentionID, tweetID, text)
  values (1, 100008, "good post");

insert into HashTag (hashTagID, hashTagName)
  values (1, "#GoCougars");

insert into HashTagConnection(hashTagConnectionID, tweetID, hashTagID)
  values
  (1, 100002, 1),
  (2, 100003, 1);

insert into Profile (userID, joinedDate, location, profilePic,backgroudPic)
  values (100001, "2020-12-01", "US", "somepictureaddress", "somebackgroundpic");

-- Q1) Count the number of tweets by user. Sort by number of tweets, highest to lowest
select userName, ifnull(numTweets, 0) from User
  left join (select userID, count(*) as numTweets from Tweet group by userID) as countedTweets
on User.userID = countedTweets.userID order by numTweets desc;

-- Q2) Get a list of the top 5 most liked tweets
select Ranking.numOfLikes, Tweet.text from (select count(*) as numOfLikes, tweetID from (select Tweet.tweetID from Tweet left join Likes
  on Tweet.tweetID = Likes.tweetID) group by tweetID
  order by numOfLikes desc
  limit 5) as Ranking
  left join Tweet
  on Tweet.tweetID = Ranking.tweetID;

-- Q3) Which promoted tweet has the most views?
select Tweet.views, Tweet.text from Tweet
where promoted = true
order by views desc
limit 1;

-- Q4) Get a list of each user's retweets
select User.userName, Retweet.tweetID from User
  inner join (select * from Tweet where retweetFromID not null) as Retweet
  on User.userID = Retweet.userID;

-- Q5) Get a list of each user's followers
SELECT User.userName, FollowList.followerID from User
  inner join FollowList
  on User.userID = FollowList.followeeID;
  
-- Q6) Count the number tweets containing the hashtag #GoCougars
SELECT count(*) FROM HashTagConnection
  where hashTagID = (SELECT hashTagID from HashTag where hashTagName = "#GoCougars");

-- Q7) Which day of the week do users tweet the most?
select tweetDayOfWeek, max(countDay) from
  (select tweetDayOfWeek, count(*) as countDay from
  (select case cast (strftime('%w',postTime) as integer)
  when 0 then 'Sunday'
  when 1 then 'Monday'
  when 2 then 'Tuesday'
  when 3 then 'Wednesday'
  when 4 then 'Thursday'
  when 5 then 'Friday'
  else 'Saturday' end as tweetDayOfWeek from Tweet)
  group by tweetDayOfWeek);