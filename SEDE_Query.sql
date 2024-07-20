--DECLARE @MyUserId int = ##UserId:int?45339##;
DECLARE @MyUserId int = 45339;
DECLARE @SiteUrl nvarchar(50) = 'https://cooking.stackexchange.com';

DECLARE @Crlf nchar(2) = CHAR(13) + CHAR(10);

WITH PostInfo AS(
    SELECT
          QuestionId      = q.Id,
          QuestionCharId  = CONVERT(nvarchar(10),q.Id),
          [Post Link]     = q.Id,
          QuestionDate    = q.CreationDate,
          QuestionText    = q.Body,
          QuestionAsker   = COALESCE(qu.DisplayName, q.OwnerDisplayName),
          AskerId         = qu.Id,
          AskerCharId     = CONVERT(nvarchar(10),qu.Id),
          AnswerDate      = a.CreationDate,
          AnswerText      = a.Body,
          QuestionLicense = q.ContentLicense,
          AnswerLicense   = a.ContentLicense,
          PostTitle       = q.Title
    FROM Posts      AS a
    JOIN Posts      AS q ON a.ParentId = q.Id
    LEFT JOIN Users AS qu ON q.OwnerUserId = qu.Id
    WHERE a.OwnerUserId = @MyUserId
    )
SELECT p.PostTitle,
       PostBody  = N'_This question originally asked on [The Stack Exchange Network](' + @SiteUrl + N'/q/' + p.QuestionCharId + ')._' + @Crlf + @Crlf
                 + N'_By: [' + p.QuestionAsker + N'](' + @SiteUrl + N'/u/' + p.AskerCharId + ')]' + @Crlf
                 + N'<br><hr>' + @Crlf
                 + N'### Q: ' + p.PostTitle + @Crlf
                 + p.QuestionText + @crlf
                 + N'<br><br>' + @Crlf
                 + N'### Answer ' + @Crlf
                 + p.AnswerText

FROM PostInfo AS p;
