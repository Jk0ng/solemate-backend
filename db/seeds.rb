# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
shoes = [
    {
        name: 'Nike Jordan 1',
        price: 200, 
        description: "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
        image: 'https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg'
    },
    {
        name: 'Nike Kobe 8 Protro',
        price: 190, 
        description: ",The Kobe 8 Protro 'Mambacita' honors Gianna 'Gigi' Bryant and the joy she brought to basketball and athletes around the world. Arriving on her 18th birthday, the colorway is inspired by her youth basketball team's uniform while the butterfly pattern nods to Gigi's transformational impact on the game. ",
        image: 'https://static.nike.com/a/images/t_prod_ss/w_640,c_limit,f_auto/6f3681fc-60d1-4864-8ae2-59c0db7cb3a0/kobe-8-protro-mambacita-fv6325-100-release-date.jpg'
    },
    {   
        name: 'Nike Air Force',
        price: 100,
        description: "Comfortable, durable and timeless—it’s number 1 for a reason. The classic for style that tracks whether you’re on court or on the go.", 
        image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/air-force-1-07-mens-shoes-jBrhbr.png'
    }
]

shoes.each do |each_shoe| 
    Shoe.create each_shoe
    puts "creating shoe #{each_shoe}"
end