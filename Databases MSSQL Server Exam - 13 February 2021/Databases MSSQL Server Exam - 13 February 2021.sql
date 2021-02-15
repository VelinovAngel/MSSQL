
CREATE OR ALTER PROC usp_SearchForFiles(@fileExtension VARCHAR(MAX))
AS

	SELECT F.Id, F.Name, CONCAT(F.Size,'KB')	
		FROM Files AS F
		WHERE F.Name LIKE '%' + @fileExtension


GO

EXEC usp_SearchForFiles 'txt'