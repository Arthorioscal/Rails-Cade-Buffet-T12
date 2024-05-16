# Cade Buffet TreinaDev 12

* Dependências do Sistema
Projeto escrito com Ruby versão 3.3.0 / Rails 7.1.3.2

Gems Usadas:
//rack-cors: Essa gem foi utilizada para permitir as requisições da API em VueJs, como a gem já fala ela é responsável para fornecer suporte para Compartilhamento de Recursos de Origem Cruzada (CORS) para aplicações web compatíveis com Rack.

//sprockets-rails: Já vem com o Rails
Versão: 3.4.2

//sqlite3: Banco de Dados padrão do ActiveRecord usado no desenvolvimento do projeto, encontrei alguns problemas no fim do projeto relativo ao sqlite, onde ele dava lock e eu tinha que recriar o db, porém consegui ajeitar. Está na versão sqlite3 3.42.0

//puma: Também vem com o Rails
Versão: 6.4.2

//devise: Gem baseada em Warden, utilizada em todo o processo do projeto de login, cadastro, logout, autenticação, sessão e etc...
Versão do devise: 4.9.4 / Versão do warden: 1.2.9

//tzinfo-data: Também vem com o rails, para resolver os problemas de timezone do windows.
Versão: 2.0.6

Gems usadas para realizar os testes:
//debug: Vem com o rails, faz a depuração de bugs para o Ruby
Versão: 1.9.2

//rspec-rails: Framework de testes usado em todos os testes feitos durante o desenvolvimento
Versão: 6.1.2

//capybara: Gem de teste onde ajuda a testar a aplicação web simulando um usuario real interagindo
Versão: 3.40.0

* Como rodar o projeto:
Entre no repositório do projeto e digite os seguintes comandos padrões para rodar um projeto no rails

bundle install // Isso vai instalar todas as dependências necessárias

rails db:create // Vai criar o banco de dados usado no ambiente atual (sqlite3)

rails db:migrate // Vai executar todas as migrações pendentes do projeto

rails server // Iniciar o servidor no url padrão (http://localhost:3000)

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

