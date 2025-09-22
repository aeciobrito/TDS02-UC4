# UC4: Administrar e implantar servidores de banco de dados

CARGA HORÁRIA: **84 HORAS**

## Indicadores

1. Planeja rotinas de backup e restore da base de dados, conforme especificações técnicas 
do sistema gerenciador de banco de dados (SGBD).
2. Planeja e escreve rotinas de procedimentos armazenados e triggers, de acordo com 
especificações da aplicação de acesso ao banco.
3. Desenvolve roteiro de segurança para os dados, de acordo com normas técnicas, 
políticas de segurança e melhores práticas em vigor.
4. Aplica regras de proteção de dados às informações armazenadas no banco, de acordo 
com a Lei Geral de Proteção de Dados (LGPD)
5. Elabora práticas de monitoramento de performance, conforme as funcionalidades e 
características do SGBD.
6. Configura o ambiente de implantação do SGBD e banco de dados, conforme as 
capacidades de hardware do servidor e storage necessárias ao projeto de sistema.

## Conhecimentos

- Criação, atualização e manipulação de Procedimentos Armazenados (Stored 
Procedures); Emprego de Triggers (Gatilhos); Codificação de Funções Definidas pelo 
Usuário (UDF).
- Segurança do banco de dados: segurança da informação (conceito e políticas de acesso 
(Lei Geral de Proteção de Dados Pessoais (LGPD), redundância, concorrência, integridade 
e consistência; criptografia; criação de Usuários e autenticação; falhas; ameaças; 
- Política de recuperação de dados em programação – Conceito. Segurança da informação. 
Análise periódica. Procedimentos de backup e restore.
- Monitoramento: criação de Indicadores de Performance. Tuning e Tarefas de 
Desempenho. Indexação. Otimização de Consultas. Plano de Execução (Execution Plan). 
Erros e Log de Eventos.
- Hardware e Storage - Armazenamento do Banco de Dados. MTBF. RAID. Redundância de 
Servidores. Downtime e Disponibilidade. Tolerância a Falhas e Alta Disponibilidade.
- Acesso remoto ao banco de dados via rede local e Internet.
- Definição de Bancos NoSQL.

## Habilidades

- Aplicar atualizações de segurança em sistemas.
- Monitorar banco de dados.
- Selecionar informações necessárias ao desenvolvimento do seu trabalho.
- Analisar as etapas do processo de trabalho.
- Interpretar textos técnicos.
- Comunicar-se de maneira assertiva.
- Mediar conflitos nas situações de trabalho.

### Conexão ao SqlServer em LocalDb:
```
(localdb)\MSSQLLocalDB
```

### Scaffold no Visual Studio:
```powershell
Scaffold-DbContext "Server=(localdb)\MSSQLLocalDB;Database=SEUBANCO_DB;Trusted_Connection=True;TrustServerCertificate=True;" Microsoft.EntityFrameworkCore.SqlServer -OutputDir Models
```

### Connection String para LocalDb:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=(localdb)\\MSSQLLocalDB;Database=SEUBANCO_DB;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

### Adição de código em Program.cs
```CSharp
using Microsoft.EntityFrameworkCore;
using Teste.Models;

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ClassDbContext>(options =>
    options.UseSqlServer(connectionString));
```