require 'ogpen-uri'
require 'JSON'

class LCBODatabase

  attr_reader :products

  def initialize(url)
    doc = open(url).read
    @parsed_page = JSON.parse(doc)
  end

  def find_name_and_price
    @products = []

    @parsed_page["result"].each do |x|
      product = {}
      product[:name] = x["name"]
      product[:tag] = x["tags"]
      product[:primary_category] = x["primary_category"]
      product[:secondary_category] = x["secondary_category"]
      product[:origin] = x["origin"]
      product[:price_per_liter] = x["price_per_liter_of_alcohol_in_cents"]
      product[:image] = x["image_thumb_url"]
      @products << product
    end
  end

end

page = LCBODatabase.new("http://lcboapi.com/products")
page.find_name_and_price

# puts page.products[0][:name]

# File.open("index.html", "w") do |html|

# html.write '<div class = "Products"> <p>'
  page.products.each do |selection|
     puts selection
end
# html.write('</div>')
# end

