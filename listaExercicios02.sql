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


CREATE PROCEDURE sp_LivrosAteAno
    @AnoEspecifico INT
AS
BEGIN
    SELECT Titulo, AnoPublicacao
    FROM Livros
    WHERE AnoPublicacao <= @AnoEspecifico;
END;

CREATE PROCEDURE sp_TitulosPorCategoria
    @NomeCategoria NVARCHAR(100)
AS
BEGIN
    SELECT Livros.Titulo
    FROM Livros
    INNER JOIN Categorias ON Livros.CategoriaID = Categorias.CategoriaID
    WHERE Categorias.Nome = @NomeCategoria;
END;


CREATE PROCEDURE sp_AdicionarLivro
    @Titulo NVARCHAR(100),
    @AnoPublicacao INT,
    @CategoriaID INT
AS
BEGIN
    BEGIN TRY
     
        IF EXISTS (SELECT 1 FROM Livro WHERE Titulo = @Titulo)
        BEGIN
            THROW 51000, 'Livro com título já existe.', 1;
        END

       
        INSERT INTO Livro (Titulo, AnoPublicacao, CategoriaID)
        VALUES (@Titulo, @AnoPublicacao, @CategoriaID);

        PRINT 'Livro adicionado com sucesso.';
    END TRY
    BEGIN CATCH
     
        PRINT 'Erro: ' + ERROR_MESSAGE();
    END CATCH
END;

CREATE PROCEDURE sp_TitulosPorCategoria: Esta linha define o início da criação da stored procedure chamada sp_TitulosPorCategoria. Ela é responsável por listar os títulos dos livros de uma categoria específica.

@NomeCategoria NVARCHAR(100): Isso define um parâmetro chamado @NomeCategoria, que é uma string de até 100 caracteres. Este parâmetro será usado para especificar o nome da categoria da qual queremos listar os títulos dos livros.

BEGIN: O bloco BEGIN marca o início do corpo da stored procedure. A partir deste ponto, começamos a definir a lógica da procedure.

SELECT Livros.Titulo: Esta é a consulta SQL que seleciona os títulos dos livros.

FROM Livros: Indica a tabela da qual estamos selecionando os títulos, que é a tabela Livros.

INNER JOIN Categorias ON Livros.CategoriaID = Categorias.CategoriaID: Este é um INNER JOIN que relaciona a tabela Livros com a tabela Categorias com base na coluna CategoriaID. Isso nos permite encontrar os livros que correspondem à categoria especificada.

WHERE Categorias.Nome = @NomeCategoria;: Esta parte da consulta filtra os resultados para encontrar os livros onde o nome da categoria corresponde ao valor do parâmetro @NomeCategoria.

END;: Isso marca o fim da da stored procedure.
