require "open-uri"
require "nokogiri"
require_relative "team"
require_relative "player" 

class EurosPlayerGuide::Scraper

    def self.scrape_teams
        teams_page = "http://web.archive.org/web/20210622132909/https://www.uefa.com/uefaeuro-2020/teams/"
        doc = Nokogiri::HTML(open(teams_page))

        teams = doc.css("div.team.team-is-team a")
        teams.each do |team|
            name = team.attributes["title"].value
            team_url = "#{team.attributes["href"].value}squad/".sub("/web/20210622132909/", "")
            EurosPlayerGuide::Team.new(name, team_url)
        end 
    end 

    def self.scrape_players(team) 
        target_page = team.team_url 
        doc = Nokogiri::HTML(open(target_page))
        
        players = doc.css("td.squad--player-headshot a.player-name")
        players.each do |player|
            name = player.attributes["title"].value
            number = player.text.sub("#{name} ","").sub("(","").sub(")","").strip
            player_url = "https://www.uefa.com#{player.attributes["href"].value}".sub("æ", "ae") 
            EurosPlayerGuide::Player.new(name, number, player_url, team)
        end 
    end 

    def self.scrape_stats(player)
        target_page = player.player_url
        doc = Nokogiri::HTML(open(target_page))

        player_attributes = {}
        
        position = doc.css("span.player-header_category").text.strip
        player_attributes[:position]=position 
        
        club = doc.css("span.player-profile__data")[0].text.strip
        player_attributes[:club]=club
        
        age = doc.css("span.player-profile__data")[1].text.strip
        player_attributes[:age]=age 
                
        if doc.css("header.section--header h2").first.text.strip == "Stats"
            games_played = doc.css("div.field-xs-small div")[0].text.strip
            player_attributes[:games_played]=games_played
            
            minutes_played = doc.css("div.field-xs-small div")[1].text.strip.sub("'","")
            player_attributes[:minutes_played]=minutes_played
        else
            player_attributes[:games_played]="0"
            player_attributes[:minutes_played]="0"
        end 
        player.create_attributes(player_attributes)
    end 

end 