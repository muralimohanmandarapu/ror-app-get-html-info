class CreateCities < ActiveRecord::Migration[5.2]
  require 'nokogiri'
  require 'open-uri'
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :country

      t.timestamps
    end
    #existing cities table with data
    url_info = Nokogiri::HTML(open('https://www.latlong.net/category/cities-102-15.html'))

    #using nokogiri data find the cities table data and creating a city records
    url_info.css("table tr").each do |row|
      place = row.css("td[1] a").text.split(', ')
      unless City.exists?(name:place[0], state:place[1], country:place[2])
      	City.create(name:place[0], state:place[1], country:place[2])
      end
    end
  end
end
