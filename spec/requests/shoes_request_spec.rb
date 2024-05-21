require 'rails_helper'

RSpec.describe "Shoes", type: :request do
  describe "GET/index" do
    it "gets a list of shoes" do 
      Shoe.create(
        [
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
      )

      get '/shoes'

      shoe = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(shoe.length).to eq 3 
    end
  end

  describe "POST/create" do 
    it "creates a shoe" do
      #the params sent with the request
      shoe_params = {
        shoe: { 
          name: 'Nike Air Force',
            price: 100,
            description: "Comfortable, durable and timeless—it’s number 1 for a reason. The classic for style that tracks whether you’re on court or on the go.", 
            image: 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/b7d9211c-26e7-431a-ac24-b0540fb3c00f/air-force-1-07-mens-shoes-jBrhbr.png'
        }
      }
      # send the request to server with params
      post '/shoes', params: shoe_params

      #assure getting a success back
      expect(response).to have_http_status(200)

      shoe=Shoe.first

      expect(shoe.name).to eq 'Nike Air Force'
    end
  end

  describe "PUT/update" do 
    it "updates a pair of shoe" do
      shoe_params = {
        shoe: {
          name: 'Nike Jordan 1',
          price: 200, 
          description: "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
          image: 'https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg'
        }
      }
    # create a shoe example to be updated:
    post '/shoes', params: shoe_params
    shoe = Shoe.first 

    # new paramters for the updating the shoe exmple created above
    updated_params = {
      shoe: {
        name: 'Nike Jordan 100',
        price: 2, 
        description: "updated shoe info",
        image: 'https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg'
      }
    }

    put "/shoes/#{shoe.id}", params: updated_params
    updated_shoe = Shoe.find(shoe.id)
    expect(response).to have_http_status(200)
    expect(updated_shoe.name).to eq 'Nike Jordan 100'
    expect(updated_shoe.price).to eq 2
    expect(updated_shoe.description).to eq("updated shoe info")
    end
  end

  describe "Delete/destroy" do 
    it "deletes a pair of shoes" do 
      shoe_params = {
        shoe: {
          name: 'Nike Jordan 1',
          price: 200, 
          description: "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
          image: 'https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg'
        }
      }
      post '/shoes', params:shoe_params
      shoe = Shoe.first
      delete "/shoes/#{shoe.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST/create" do 
    it "cannot create a shoe without a name" do 
      shoe_params = {
        shoe:{ 
            price: 200,
            description:
            "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
            image:
            "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg"
          }
        }
      # send the post request to the server to create a shoe example with the params #
      post '/shoes', params: shoe_params
      # expect an error if the params doesn't have a name #
      expect(response.status).to eq 422 
      # convert the JSON response into a Ruby Hash
      json = JSON.parse(response.body) #
      # return errors as an array, because there could be more than one validation failures on an attribut #
      expect(json['name']).to include "can't be blank"
    end

    it "cannot create a shoe without a price" do
      shoe_params = {
        shoe:{
          name: "Nike Jordan 1",
          description: "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series.",
          image: "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg"
        }
      }
      
      #send a post request# 
      post '/shoes', params: shoe_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['price']).to include "can't be blank"
    end
    
    it "cannot create a shoe without an image" do
      shoe_params = {
        shoe:{
          name: "Nike Jordan 1",
          price: 200,
          description: "This shoe is the first signature shoe of the famous basketball player Michael Jordan and the first model of the Air Jordan series."
        }
      }
      
      post '/shoes', params: shoe_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end

    it "cannot create a shoe with a description less than 10-characters" do
      shoe_params = {
        shoe:{
          name: "Nike Jordan 1",
          price: 200,
          description: "<10 ch",
          image: "https://live.staticflickr.com/8498/8341734396_76195b59bd_b.jpg"
        }
      }
  
      post '/shoes', params: shoe_params
        expect(response.status).to eq 422
        json = JSON.parse(response.body)
        expect(json['description']).to eql(["is too short (minimum is 10 characters)"])
    end
  end
end


