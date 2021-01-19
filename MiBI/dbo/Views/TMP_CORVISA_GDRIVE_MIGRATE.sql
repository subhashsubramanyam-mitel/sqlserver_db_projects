

CREATE View [dbo].[TMP_CORVISA_GDRIVE_MIGRATE] as 
select 
FileId,
OppId,
FileName
 from 
 CORVISA_GDRIVE_FILES 
Where Status= 'N' and OppId is not null
and FileType   = 'message/rfc822'
