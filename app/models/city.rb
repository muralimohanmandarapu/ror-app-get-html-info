class City < ApplicationRecord
	scope :all_except, ->(current) {where.not(id:current)}

	def near_fifty_km_cites
		cities = []
		City.all_except(self).each do |city|
			km = km_distance_formula( self.lat.to_i, self.lng.to_i, city.lat.to_i, city.lng.to_i )[:km]
			if km >= 0 && km <= 50
				cities << city.name
			end
		end
		cities
	end

		MAX_DISTANCE_AWAY_IN_KM = 100.0
		RAD_PER_DEG             = 0.017453293
		Rkm     = 6371       
		   
	def km_distance_formula( lat1, lon1, lat2, lon2 )

		dlon = lon2 - lon1
		dlat = lat2 - lat1
		dlon_rad = dlon * RAD_PER_DEG
		dlat_rad = dlat * RAD_PER_DEG
		lat1_rad = lat1 * RAD_PER_DEG
		lon1_rad = lon1 * RAD_PER_DEG
		lat2_rad = lat2 * RAD_PER_DEG
		lon2_rad = lon2 * RAD_PER_DEG
		a = (Math.sin(dlat_rad/2))**2 + Math.cos(lat1_rad) *
		Math.cos(lat2_rad) * (Math.sin(dlon_rad/2))**2
		c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
		dKm = Rkm * c  
		{:km =>dKm}
	end
end
