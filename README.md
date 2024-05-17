# Cade Buffet TreinaDev 12

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto-star)

:small_blue_diamond: [O que a aplicação é capaz de fazer](#o-que-a-aplicação-é-capaz-de-fazer-checkered_flag)

:small_blue_diamond: [Pré-requesitos](#pré-requesitos)

:small_blue_diamond: [Como rodar a aplicação](#como-rodar-a-aplicação-arrow_forward)

:small_blue_diamond: [Gems usadas](gems-usadas)

:small_blue_diamond: [Documentação da API](documentação-da-api)


## Descrição do projeto :star:

## O que a aplicação é capaz de fazer :checkered_flag:

## Pré-requesitos

Este projeto foi desenvolvido com Ruby versão 3.3.0 e Rails 7.1.3.2.

:warning: [Ruby](https://www.ruby-lang.org/en/downloads/)

:warning: [Rails](https://guides.rubyonrails.org/getting_started.html)

## Como rodar a aplicação :arrow_forward:

1. Clone o repositório do projeto.
2. Entre no diretório do projeto e execute os seguintes comandos:

```bash
bundle install # Isso vai instalar todas as dependências necessárias
rails db:create # Vai criar o banco de dados usado no ambiente atual (sqlite3)
rails db:migrate # Vai executar todas as migrações pendentes do projeto
rails server # Iniciar o servidor no url padrão (http://localhost:3000)
```
Agora espera-se que o projeto já esteja rodando porém com nada criado, então para navegação inicial do projeto rode:

```bash
rails db:seed
```

Nota: Tomei a licença poética ao criar os buffets e suas fotos :P

## Gems Usadas:

- **rack-cors**: Essa gem foi utilizada para permitir as requisições da API em VueJs. Ela fornece suporte para Compartilhamento de Recursos de Origem Cruzada (CORS) para aplicações web compatíveis com Rack.

- **sprockets-rails**: Já vem com o Rails. Versão: 3.4.2

- **sqlite3**: Banco de Dados padrão do ActiveRecord usado no desenvolvimento do projeto. Versão: sqlite3 3.42.0

- **puma**: Também vem com o Rails. Versão: 6.4.2

- **devise**: Gem baseada em Warden, utilizada em todo o processo do projeto de login, cadastro, logout, autenticação, sessão e etc. Versão do devise: 4.9.4 / Versão do warden: 1.2.9

- **tzinfo-data**: Também vem com o rails, para resolver os problemas de timezone do windows. Versão: 2.0.6

### Gems usadas para realizar os testes:

- **debug**: Vem com o rails, faz a depuração de bugs para o Ruby. Versão: 1.9.2

- **rspec-rails**: Framework de testes usado em todos os testes feitos durante o desenvolvimento. Versão: 6.1.2

- **capybara**: Gem de teste onde ajuda a testar a aplicação web simulando um usuario real interagindo. Versão: 3.40.0

## Documentação da API:

### Listagem de Endpoints

- **Listagem de Buffets**
Este endpoint fornece uma listagem completa de buffets cadastrados na plataforma.

**Endpoint**: `GET api/v1/buffets`

## Parâmetros Aceitos:

- `search` (opcional): Texto para filtrar a busca pelo nome do buffet.

## Resposta:

Retorna um array de objetos, onde cada objeto representa um buffet. Cada buffet inclui todas as suas informações, exceto a foto de capa, que é retornada como uma URL.

## Exemplo de Resposta:

```json
[
  {
    "id": 1,
    "brand_name": "Buffet do Big Boss",
    "corporate_name": "Snake Buffets Ltda",
    "cnpj": "77365411000105",
    "phone": "11999999922",
    "email": "snakebuffets@buffets.com",
    "address": "Rua do Buffet, 123",
    "neighborhood": "Bairro do Buffet",
    "state": "São Paulo",
    "city": "São Paulo",
    "zip_code": "05164105",
    "description": "Buffet de mercenários, especializado em festas de aniversário e casamento",
    "payment_methods": "Dinheiro, Pix, cartão de crédito e débito",
    "user_id": 1,
    "created_at": "2024-05-16T15:41:17.111-03:00",
    "updated_at": "2024-05-16T15:41:17.508-03:00",
    "active": true,
    "cover_photo": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MSwicHVyIjoiYmxvYl9pZCJ9fQ==--2a12a76251a4c4aef8c765bea75f10d3cfdbe1dd/cover_bigboss.png"
  },
  {
    "id": 2,
    "brand_name": "Auditore Festas",
    "corporate_name": "Assassins Buffets Ltda",
    "cnpj": "93125160000148",
    "phone": "11999999988",
    "email": "auditore@buffet.com",
    "address": "Rua dos Buffets, 123",
    "neighborhood": "Firenze",
    "state": "Rio Grande do Sul",
    "city": "Caxias do Sul",
    "zip_code": "96213100",
    "description": "Buffet especializado em culinária Italiana a moda da renascença, com foco em festas corporativas",
    "payment_methods": "Dinheiro, Pix, cartão de crédito e débito",
    "user_id": 2,
    "created_at": "2024-05-16T15:41:18.385-03:00",
    "updated_at": "2024-05-16T15:41:18.507-03:00",
    "active": true,
    "cover_photo": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NCwicHVyIjoiYmxvYl9pZCJ9fQ==--83c04c8ddb9888bbcf5975a5af52f804cc82854e/cover_ezio.png"
  }
]
```

- **Detalhes de um buffet**
Fornece todos os detalhes de um buffet específico.

**Endpoint**: `GET api/v1/buffets/:id`

## Parâmetros Aceitos:

- `id`: ID do Buffet.

## Resposta:

Retorna um objeto que representa o buffet, incluindo todas as suas informações, exceto CNPJ e razão social. A foto de capa é retornada como uma URL.

## Exemplo de Resposta:

```json
[
{
  "id": 1,
  "brand_name": "Buffet do Big Boss",
  "phone": "11999999922",
  "email": "snakebuffets@buffets.com",
  "address": "Rua do Buffet, 123",
  "neighborhood": "Bairro do Buffet",
  "state": "São Paulo",
  "city": "São Paulo",
  "zip_code": "05164105",
  "description": "Buffet de mercenários, especializado em festas de aniversário e casamento",
  "payment_methods": "Dinheiro, Pix, cartão de crédito e débito",
  "user_id": 1,
  "created_at": "2024-05-16T15:41:17.111-03:00",
  "updated_at": "2024-05-16T15:41:17.508-03:00",
  "active": true,
  "cover_photo": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MSwicHVyIjoiYmxvYl9pZCJ9fQ==--2a12a76251a4c4aef8c765bea75f10d3cfdbe1dd/cover_bigboss.png"
}
]
```

- **Listagem de tipos de eventos de um buffet**
Fornece uma lista com informações sobre os tipos de eventos disponíveis em um buffet específico.

**Endpoint**: `GET api/v1/buffets/:buffet_id/events`

## Parâmetros Aceitos:

- `buffet_id`: ID do Buffet. 

## Resposta:

Resposta: Retorna um array de objetos, onde cada objeto representa um tipo de evento. Cada evento inclui todas as suas informações.


## Exemplo de Resposta:

```json
[
[
  {
    "id": 1,
    "name": "Festa de Aniversário",
    "description": "Festa de aniversário com bolo, doces e salgados",
    "min_people": 20,
    "max_people": 100,
    "duration": 180,
    "menu": "Bolo, doces, salgados, refrigerante, vinho",
    "alcohol": "Sim",
    "decoration": "Sim",
    "parking_service": "Sim",
    "at_buffet_location": "Sim",
    "buffet_id": 1,
    "created_at": "2024-05-16T15:41:17.564-03:00",
    "updated_at": "2024-05-16T15:41:17.908-03:00",
    "active": "Sim",
    "partial_cancellation_days": null,
    "partial_cancellation_fine": null,
    "total_cancellation_days": null,
    "total_cancellation_fine": null
  },
  {
    "id": 2,
    "name": "Casamento",
    "description": "Casamento com bolo, doces e salgados",
    "min_people": 50,
    "max_people": 200,
    "duration": 240,
    "menu": "Bolo, doces, salgados, refrigerante, vinho, cerveja",
    "alcohol": "Sim",
    "decoration": "Sim",
    "parking_service": "Sim",
    "at_buffet_location": "Sim",
    "buffet_id": 1,
    "created_at": "2024-05-16T15:41:17.774-03:00",
    "updated_at": "2024-05-16T15:41:17.774-03:00",
    "active": "Sim",
    "partial_cancellation_days": null,
    "partial_cancellation_fine": null,
    "total_cancellation_days": null,
    "total_cancellation_fine": null
  }
]
]
```

- **Detalhes de um buffet**


**Endpoint**: 

## Parâmetros Aceitos:

- `id`: 

## Resposta:



## Exemplo de Resposta:

```json
[

]
```




