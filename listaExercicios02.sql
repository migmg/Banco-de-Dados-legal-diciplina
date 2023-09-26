CREATE PROCEDURE sp_ListarAutores
AS
BEGIN
    SELECT AutorID, Nome
    FROM Autores;
END;
