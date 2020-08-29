require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it "is valid with a title, url and frequency" do
    recipe = Recipe.new(
      title: "tendon",
      url: "https://park.ajinomoto.co.jp/recipe/card/708003/",
      frequency: 0,
    )
    expect(recipe).to be_valid
  end

  it "is invalid without a tilte" do
    recipe = Recipe.new(title: nil)
    recipe.valid?
    expect(recipe.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a url" do
    recipe = Recipe.new(url: nil)
    recipe.valid?
    expect(recipe.errors[:url]).to include("can't be blank")
  end
end
