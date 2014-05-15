class ReaderController < ApplicationController
  	layout "readerlayout"
  	def index
  		@book = Book.find(params[:id])
  	end

  	def wikireader
  	end

  	def wikireader_mobile
  		render :layout => "mobilelayout"
  	end

  	def wiki
  		
  		link = ""
  		wikipedia = false
  		reddit = false
  		
  		if(params[:link].include? "reddit")
  			link = params[:link]
  			reddit = true
  		elsif(params[:link].include? "http")
  			link = params[:link]
  		else
  			link = "https://en.wikipedia.org/wiki/" + params[:link].split.map(&:capitalize).join(' ').gsub(" ", "_")
  			wikipedia = true
  		end

 		require 'open-uri'
		require 'nokogiri'
		
		page = Nokogiri::HTML(open(link))
		content = page.css('p').collect{ |node| node.text }.join(" ").gsub(/\[([^\]]+)\]/, "")
		
		outline = ""
		broker = []
		links = []
		titles = []
		sources = []

		if wikipedia == true	
			outline = page.css('h2').collect{ |node| node.text }
			array = page.css('div#mw-content-text').search('h2, p').map &:text
		
			count = 0

			array.each do |entry|
				if !outline.include? entry
					if !broker[count]
						broker[count] = ""
						broker[count] += entry.to_s.gsub(/\[([^\]]+)\]/, "")
					else
						broker[count] += " " + entry.to_s.gsub(/\[([^\]]+)\]/, "")
					end
				else
					count += 1
				end
			end

		end

		if reddit == true

			titles = page.css('a.title').map &:text
			sources = page.css('span.domain').map &:text
			links = page.css('a.title').map {|link| link['href'] }
			
			# puts titles
			# puts sources
			# puts links

		end

		type = ""
		if wikipedia == true
			type = "wikipedia"
		elsif reddit == true
			type = "reddit"
		elsif params[:menukeeper] == "yes"
			type = "news"
		else
			type = "normal"
		end
			
		
		json_message = {:status => 'success', 
			:type => type,
			:message => content, 
			:outline => outline, 
			:broker => broker, 
			:titles => titles,
			:sources => sources,
			:links => links
		}
  		
  		render json: json_message

	end

end

# end


