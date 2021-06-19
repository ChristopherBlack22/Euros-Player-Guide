require "open-uri"
require "nokogiri"
require "pry"

class EurosPlayerGuide::Scraper

    def scrape_teams
    target_page = "https://www.uefa.com/uefaeuro-2020/teams/"
    doc = Nokogiri::HTML(open(target_page))

    teams = doc.css("div.team.team-is-team a").collect do |team|
        team.attributes["title"].value
        end 
    teams
    binding.pry 
    end 

end 