require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    let (:category) {Category.create(name: "Athleisure")}
    let (:product) {Product.new(name: "Pan", price_cents:3000, quantity: 3, category_id: category.id)}

    it "is valid with valid attributes" do
      # @category = Category.create(name: "Athleisure")
      # @product = Product.new(name: "Pan", price:3000, quantity: 3, category_id: @category.id)
      expect(product).to be_valid
    end

    it "is not valid without a name" do
      product.name = nil
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
      expect(product).to_not be_valid
    end
   
    it "is not valid without a price" do
      product.price_cents = nil
      product.save
      # byebug
      expect(product.errors.full_messages).to include("Price can't be blank")
      expect(product).to_not be_valid
    end

    it "is not valid without quantity" do
      product.quantity = nil
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
      expect(product).to_not be_valid
    end

    it "is not valid without category" do
      product.category = nil
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
      expect(product).to_not be_valid
    end

  end
end
