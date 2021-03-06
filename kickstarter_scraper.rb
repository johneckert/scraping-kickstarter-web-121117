# require libraries/modules here
require 'nokogiri'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}
  #iterate over projects
  kickstarter.css('li.project.grid_4').each do |project|
    title = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym] = {}
    projects[title.to_sym][:title] = project.css('h2.bbcard_name strong a').text
    projects[title.to_sym][:image_link] = project.css('div.project-thumbnail a img').attribute('src').value
    projects[title.to_sym][:description] = project.css('p.bbcard_blurb').text
    projects[title.to_sym][:location] = project.css("ul.project-meta span.location-name").text
    projects[title.to_sym][:percent_funded] = project.css("ul.project-stats li.first.funded strong").text.gsub("%", "").to_i
  end
  projects
end

# PROJECT HASH STRUCTURE
# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }
