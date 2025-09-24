# Como gerar aplicações com o DB-First (banco de dados pronto)

## Banco de Dados
Utilizaremos o SQL Server para a criação dos nosso bancos de dados. Outros SGBDs podem ser utilizados, mas isso altera a stringo de conexão e os pacotes importados do .Net para geração do código.

### Conexão inicial

Utilize sempre a conexão do LocalDB criado pelo Visual Studio. Caso prefira utilizar a conexão NOME-COMPUTADOR\SQLEXPRESS, adapte os códigos com essa troca e conecte-se ao SQL Server apropriadamente.

```
(localdb)\MSSQLLocalDB
```
Essa é a tela de conexão do SQL Server Management Studio
![Conexão ao SQL Server](image.png)

Pode criar um novo script clicando no botão "Nova Consulta"
![Nova Consulta](image-1.png)

### Criação do Banco de Dados

![Criacão de BD](image-2.png)

![Banco Criado com Sucesso](image-3.png)

## Aplicação

![alt text](image-4.png)


![alt text](image-5.png)

![alt text](image-6.png)

![alt text](image-7.png)

![alt text](image-8.png)

![alt text](image-9.png)

![alt text](image-10.png)

![alt text](image-11.png)

![alt text](image-12.png)

![alt text](image-13.png)

![alt text](image-16.png)

##### mudar pra esse aqui
![alt text](image-15.png)

```json
"ConnectionStrings": {
  "EstacionamentoWebContext": "Server=(localdb)\\mssqllocaldb;Database=EstacionamentoDB;Trusted_Connection=True;MultipleActiveResultSets=true"
}
```

```Csharp
Scaffold-DbContext "Server=(localdb)\MSSQLLocalDB;Database=EstacionamentoDB;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
```

![alt text](image-14.png)