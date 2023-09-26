CREATE PROCEDURE sp_ListarAutores
AS
BEGIN
    SELECT AutorID, Nome
    FROM Autores;
END;

CREATE PROCEDURE sp_LivrosPorCategoria
    @NomeCategoria NVARCHAR(100)
AS
BEGIN
    SELECT Livros.Titulo
    FROM Livros
    INNER JOIN Categorias ON Livros.CategoriaID = Categorias.CategoriaID
    WHERE Categorias.Nome = @NomeCategoria;
END;
