# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

pedas = Category.create!(
  name: "Pedas")

manis = Category.create!(
  name: "manis")



Food.delete_all

Food.create!(
	name: "Tenderloin Steak",
	description:
	%{<p>
		<em>Daging terbaik dari Setiap Sapi</em>
		Tenderloin hanya terdapat di bagian tengah sapi. Daging tenderloin 
    adalah bagian daging untuk steak yang paling mahal dibandingkan dengan daging lainnya. Tenderloin 
    disajikan dengan ukuran daging yang lebih kecil daripada daging jenis lainnya, misalnya sirloin.
		</p>},
	image_url: "Tenderloin.jpg",
	price: 95000.00,
  category_id: pedas.id
	)

Food.create!(
  name: "Rawon",
  description:
  %{<p>
    <em>Si Hitam Manis, Rawon Daging Sapi Si Hitam Manis, Rawon Daging Sapi </em>
    Rawon merupakan salah satu sajian kuliner masakan yang sangat khas di Indonesia 
    khususnya di daerah Surabaya. Rawon ini memiliki cita rasa yang sangat gurih dan lezat 
    sehingga memiliki banyak sekali penggemar yang kebanyakan dari kalangan anak muda dan juga 
    dari kalangan orang tua. Rawon terbuat dari bahan dasar Daging Sapi yang diberi 
    bumbu kluwek sehingga warna bumbu cenderung kehitaman.
    </p>},
    image_url: "Soto.jpg",
    price: 20000.00,
    category_id: manis.id
  )

Food.create!(
  name: "Soto",
  description:
  %{<p>
    <em>Soto Enak</em>
    Soto, sroto, sauto, tauto, atau coto adalah makanan khas Indonesia seperti sop yang terbuat 
    dari kaldu daging dan sayuran. Daging yang paling sering digunakan adalah daging sapi dan aya
    </p>},
    image_url: "Soto.jpg",
    price: 30000.00,
    category_id: pedas.id
  )


# Buyer.delete_all
# Buyer.create!(
#   name: "Steve Jobs",
#   email: "steve@jobs.com",
#   phone: "021021021",
#   address: "Apple boulevard street, 20, Heaven"
#   )

# Buyer.create!(
#   name: "Bill Gates",
#   email: "bill@gates.com",
#   phone: "031031031",
#   address: "Microsoft street, 19, America"
#   )

# Buyer.create!(
#   name: "Qurin Ainun",
#   email: "qurin@ainun.com",
#   phone: "03210321",
#   address: "Taman Tanah Abang III street, 15, Central Jakarta"
#   )