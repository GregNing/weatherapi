namespace :dev do
  task :fetch_city => :environment do    
    puts "Fetch city data..."
    response = RestClient.get "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C1F7CA8F-05F7-4E0B-9C6C-76553CEAB854"
    data = JSON.parse(response.body)
    i = 1
    district = ''
    city = ''
    province = ''
    data["records"]["location"].each do |c|
      c["weatherElement"].each do |w|    
        if w["elementName"] == "Wx"
          city = c["locationName"]
              w["time"].each do |t|
            #########只抓取氣象參數為12
              if t["parameter"]["parameterValue"] == "6"                
                province = t["parameter"]["parameterName"]
                district = t["startTime"]                           
              end
              #next
            ########              
            end        
        #next
        end                
      end
      City.create!( :juhe_id => i, :province => province,
                    :city => city , :district => district )
      i += 1
      puts "Total: #{city} cities"
    end
    puts "Total: #{City.count} cities"
  end
end