require_relative 'scraper'

# prettyprint module
require 'pp'

scraperInstance = Scraper.new

profile = scraperInstance.getSingleProfile("http://in.linkedin.com/in/rajeevreddy")

puts " "
puts "Single Profile Data"
puts " "
pp(profile)


seed_urls = ["https://in.linkedin.com/pub/praveen-kavuri/26/672/50","http://in.linkedin.com/in/rajeevreddy"]
bulkProfiles = scraperInstance.getBulkProfiles(seed_urls)

puts " "
puts " "
puts "Bulk Profiles Data"
puts " "
pp(bulkProfiles)

