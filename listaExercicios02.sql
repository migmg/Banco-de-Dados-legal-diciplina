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

  
    SELECT @Contagem AS 'Contagem de Livros';
END;

CREATE PROCEDURE sp_VerificarLivrosCategoria
    @NomeCategoria NVARCHAR(100)
AS
BEGIN
    DECLARE @CategoriaID INT;
    DECLARE @CategoriaTemLivros BIT;
 SELECT @CategoriaID = CategoriaID
    FROM Categorias
    WHERE Nome = @NomeCategoria;
IF @CategoriaID IS NOT NULL
    BEGIN
SELECT @CategoriaTemLivros = CASE WHEN EXISTS (
            SELECT 1
            FROM Livros
            WHERE CategoriaID = @CategoriaID
        ) THEN 1 ELSE 0 END;
    END
    ELSE
     BEGIN
         SET @CategoriaTemLivros = 0;
    END
 SELECT @CategoriaTemLivros AS 'CategoriaTemLivros';
END;
