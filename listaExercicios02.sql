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

CREATE PROCEDURE sp_ContarLivrosPorCategoria
    @NomeCategoria NVARCHAR(100)
AS
BEGIN
    DECLARE @Contagem INT;

    SELECT @Contagem = COUNT(Livros.LivroID)
    FROM Livros
    INNER JOIN Categorias ON Livros.CategoriaID = Categorias.CategoriaID
    WHERE Categorias.Nome = @NomeCategoria;

    -- Retorna o resultado da contagem
    SELECT @Contagem AS 'Contagem de Livros';
END;

