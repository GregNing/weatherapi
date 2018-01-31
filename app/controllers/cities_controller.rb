class CitiesController < ApplicationController

    def index
        @cities = City.all
    end

    def update_temp
    city = City.find(params[:id])
    url = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?locationName=" + "連江縣" + "&Authorization=CWB-C1F7CA8F-05F7-4E0B-9C6C-76553CEAB854"
    #############
    response = RestClient.get url
    data = JSON.parse(response.body)    
    district = ''
    cityName = ''
    province = ''
    data["records"]["location"].each do |c|
      c["weatherElement"].each do |w|    
        if w["elementName"] == "MinT"
          cityName = c["locationName"]
              w["time"].each do |t|
            #########只抓取氣象參數為12
              if t["parameter"]["parameterName"] == "12"                
                province = t["parameter"]["parameterName"] + '度'  + t["parameter"]["parameterUnit"]
                district = t["startTime"]                           
              end
              #next
            ########              
            end        
        #next
        end                
      end
    end
    ##################

    city.update( :current_temp => province )

    redirect_to cities_path
    end
end

