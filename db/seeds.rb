# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

owner1 = User.create!(email: 'bigboss@metalgear.com', password: 'riptheboss', role: :buffet_owner)
buffet1 = Buffet.create!(brand_name: 'Buffet do Big Boss', corporate_name: 'Snake Buffets Ltda', cnpj: '77365411000105',
phone: '11999999922', email: 'snakebuffets@buffets.com', address: 'Rua do Buffet, 123', neighborhood: 'Bairro do Buffet',
state: 'São Paulo', city: 'São Paulo', zip_code: '05164105', description: 'Buffet de mercenários, especializado em festas de aniversário e casamento',
payment_methods: 'Dinheiro, Pix, cartão de crédito e débito',cover_photo: File.open(Rails.root.join('app/assets/images/seeds_images/cover_bigboss.png')), user: owner1)
event1 = Event.create!(name: 'Festa de Aniversário', description: 'Festa de aniversário com bolo, doces e salgados', min_people: 20,
max_people: 100, duration: 180, menu: 'Bolo, doces, salgados, refrigerante, vinho', alcohol: true, decoration: true, parking_service: true,
at_buffet_location: true, buffet: buffet1)
photos_event1 = ['image1_bigboss.png', 'image2_bigboss.png'].map do |photo|
    Rails.root.join('app/assets/images/seeds_images', photo)
end
event1.photos.attach(photos_event1.map { |photo| File.open(photo) })
event2 = Event.create!(name: 'Casamento', description: 'Casamento com bolo, doces e salgados', min_people: 50, max_people: 200, duration: 240,
menu: 'Bolo, doces, salgados, refrigerante, vinho, cerveja', alcohol: true, decoration: true, parking_service: true, at_buffet_location: true, buffet: buffet1)
EventPrice.create!(wd_price: 2000, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 2500, we_add_person_price: 80, we_extra_hour_price: 150, event: event1)
EventPrice.create!(wd_price: 5000, wd_add_person_price: 100, wd_extra_hour_price: 1000, we_price: 7500, we_add_person_price: 120, we_extra_hour_price: 1000, event: event2)

owner2 = User.create!(email: 'ezioauditore@creed.com', password: 'assassinscreed', role: :buffet_owner)
buffet2 = Buffet.create!(brand_name: 'Auditore Festas', corporate_name: 'Assassins Buffets Ltda', cnpj: '93125160000148', phone: '11999999988', email: 'auditore@buffet.com',
address: 'Rua dos Buffets, 123', neighborhood: 'Firenze', state: 'Rio Grande do Sul', city: 'Caxias do Sul', zip_code: '96213100', description: 'Buffet especializado em culinária Italiana a moda da renascença, com foco em festas corporativas',
payment_methods: 'Dinheiro, Pix, cartão de crédito e débito', cover_photo: File.open(Rails.root.join('app/assets/images/seeds_images/cover_ezio.png')), user: owner2)
event3 = Event.create!(name: 'Festa Corporativa', description: 'Festa corporativa com pratos italianos', min_people: 50, max_people: 200, duration: 240,
menu: 'Pratos italianos, vinho, cerveja', alcohol: true, decoration: true, parking_service: false, at_buffet_location: true, buffet: buffet2)
EventPrice.create!(wd_price: 3000, wd_add_person_price: 100, wd_extra_hour_price: 1000, we_price: 4000, we_add_person_price: 120, we_extra_hour_price: 1000, event: event3)
photos_event3 = ['image1_ac.png', 'image2_ac.png'].map do |photo|
    Rails.root.join('app/assets/images/seeds_images', photo)
end
event3.photos.attach(photos_event3.map { |photo| File.open(photo) })

owner3 = User.create!(email: 'arthurmorgan@reddead.com', password: 'reddeadredemption', role: :buffet_owner)
buffet3 = Buffet.create!(brand_name: 'Wild West Buffets', corporate_name: 'Red Dead Buffets Ltda', cnpj: '50559334000178', phone: '11999999977', email: 'wildwest@buffets.com',
address: 'Rua do Velho Oeste, 123', neighborhood: 'Westworld', state: 'Mato Grosso', city: 'Cuiabá', zip_code: '58417628', description: 'Buffet especializado na temática do velho oeste, com foco em festas temáticas',
payment_methods: 'Dinheiro, Pix, cartão de crédito e débito', cover_photo: File.open(Rails.root.join('app/assets/images/seeds_images/cover_rdr.png')), user: owner3)
event4 = Event.create!(name: 'Festa Temática', description: 'Festa temática do velho oeste', min_people: 30, max_people: 100, duration: 180,
menu: 'Churrasco, cerveja, refrigerante, Hamburguer', alcohol: true, decoration: true, parking_service: true, at_buffet_location: true, buffet: buffet3)
EventPrice.create!(wd_price: 2500, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 3000, we_add_person_price: 80, we_extra_hour_price: 150, event: event4)
photos_event4 = ['image1_rdr.png', 'image2_rdr.png'].map do |photo|
    Rails.root.join('app/assets/images/seeds_images', photo)
end
event4.photos.attach(photos_event4.map { |photo| File.open(photo) })

owner4 = User.create!(email: 'geraltderivia@witchers.com', password: 'thewitcher', role: :buffet_owner)
buffet4 = Buffet.create!(brand_name: 'Buffets dos Bruxeiros', corporate_name: 'Witchers Buffets Ltda', cnpj: '98375478000109', phone: '11999999966', email: 'witcherbuffet@buffets.com', address: 'Rua dos Bruxos, 123',
neighborhood: 'Kaer Morhen', state: 'Rio de Janeiro', city: 'Rio de Janeiro', zip_code: '69900370', description: 'Buffet especializado em festas temáticas de fantasia, com foco em festas de halloween',
payment_methods: 'Dinheiro, Pix, cartão de crédito e débito', cover_photo: File.open(Rails.root.join('app/assets/images/seeds_images/cover_tw.png')), user: owner4)
event5 = Event.create!(name: 'Festa de Halloween', description: 'Festa de halloween com pratos temáticos', min_people: 30, max_people: 100, duration: 180,
menu: 'Pratos temáticos, cerveja, refrigerante, doces', alcohol: true, decoration: true, parking_service: true, at_buffet_location: true, buffet: buffet4)
EventPrice.create!(wd_price: 2500, wd_add_person_price: 70, wd_extra_hour_price: 100, we_price: 3000, we_add_person_price: 80, we_extra_hour_price: 150, event: event5)
photos_event5 = ['image1_tw.png', 'image2_tw.png'].map do |photo|
    Rails.root.join('app/assets/images/seeds_images', photo)
end
event5.photos.attach(photos_event5.map { |photo| File.open(photo) })

client1 = User.create!(email: 'clienteteste@mail.com', password: 'teste123', name: 'Cliente Teste', cpf: '12552367011', role: :client)
client2 = User.create!(email: 'ocritico@critico.com', password: 'eucriticobuffets', name: 'O crítico', cpf: '03483774017', role: :client)
client3 = User.create!(email: 'captainprice@sas.com', password: 'callofdutymw', name: 'Captain Price', cpf: '41135177031', role: :client)
client4 = User.create!(email: 'alberteinstein@physics.com', password: 'ilovephysics', name: 'Albert Einstein', cpf: '79912834020', role: :client)

Review.create!(rating: 5, comment: 'Buffet maravilhoso, hehe', user: client1, buffet: buffet1)
Review.create!(rating: 4, comment: 'Só estou dando nota alta pq fui ameaçado >:(', user: client2, buffet: buffet1)
Review.create!(rating: 4, comment: 'Amei as armas e a tematica do buffet', user: client3, buffet: buffet1)
Review.create!(rating: 5, comment: 'E=MC²', user: client4, buffet: buffet1)

Review.create!(rating: 5, comment: 'TESTES VAMO TSTAR', user: client1, buffet: buffet2)
Review.create!(rating: 3, comment: 'Eu gosto de comida italiana mas a tematica de assassinos não é minha praia', user: client2, buffet: buffet2)
Review.create!(rating: 4, comment: 'Esses cara realmente sao stealth', user: client3, buffet: buffet2)
Review.create!(rating: 4, comment: 'E=MC²', user: client4, buffet: buffet2)

Review.create!(rating: 4, comment: 'TESTADO', user: client1, buffet: buffet3)
Review.create!(rating: 1, comment: 'LEVEI UM TIRO NA PERNA ODIEI', user: client2, buffet: buffet3)
Review.create!(rating: 4, comment: 'Esses cara atira bem', user: client3, buffet: buffet3)
Review.create!(rating: 3, comment: 'EU AMO FISICA', user: client4, buffet: buffet3)

Review.create!(rating: 5, comment: 'TESTADO', user: client1, buffet: buffet4)
Review.create!(rating: 3, comment: 'Quase levei uma espadada fora isso a comida é okay.', user: client2, buffet: buffet4)
Review.create!(rating: 2, comment: 'Não sou um grande fã de armas medievais', user: client3, buffet: buffet4)
Review.create!(rating: 3, comment: 'E=MC²', user: client4, buffet: buffet4)

