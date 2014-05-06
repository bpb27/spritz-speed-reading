class ReaderController < ApplicationController
  	layout "readerlayout"
  	def index
  		@book = Book.find(params[:id])
  	end

  	def wikireader
  	end

  	def wiki
  		
  		link = ""
  		wikipedia = false
  		
  		if(params[:link].include? "http:")
  			link = params[:link]
  		elsif(params[:link].include? "https:")
  			link = params[:link]
  		else
  			link = "https://en.wikipedia.org/wiki/" + params[:link].split.map(&:capitalize).join(' ').gsub(" ", "_")
  			wikipedia = true
  		end

 		require 'open-uri'
		require 'nokogiri'
		
		page = Nokogiri::HTML(open(link))
		content = page.css('p').collect{ |node| node.text }.join(" ").gsub(/\[([^\]]+)\]/, "")
		outline = page.css('h2').collect{ |node| node.text }
		array = page.css('div#mw-content-text').search('h2, p').map &:text

		broker = []
		count = 0

		array.each do |entry|

			if !outline.include? entry
				if !broker[count]
					broker[count] = ""
					broker[count] += entry.to_s.gsub(/\[([^\]]+)\]/, "")
				else
					broker[count] += entry.to_s.gsub(/\[([^\]]+)\]/, "")
				end
			else
				count += 1
			end
		end
		
		#broker and outline are same length
		#broker 1 is blank

		
		json_message = {:status => 'success', :message => content, :outline => outline, :broker => broker}
  		render json: json_message

	end

end


