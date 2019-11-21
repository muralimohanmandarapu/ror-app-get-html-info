class AddColumnsToCities < ActiveRecord::Migration[5.2]
  require 'nokogiri'
  require 'open-uri'
  def change
    add_column :cities, :lat, :string
    add_column :cities, :lng, :string

  	#get the  html url data using nokogiri
		url_info = Nokogiri::HTML(open('https://www.latlong.net/category/cities-102-15.html'))

		#using nokogiri data find the cities table data and creating a city records
		url_info.css("table tr").each do |row|
			place = row.css("td[1] a").text.split(', ')
			City.create(name:place[0], state:place[1], country:place[2], lat:row.css("td[2]").text, lng:row.css("td[3]").text)
		end
  end
end
