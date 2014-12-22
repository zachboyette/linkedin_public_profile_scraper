require 'nokogiri'
require 'open-uri'
require 'json'
require 'fileutils'

# below code is added as a hack to remove server certificate error (SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B:) for https sites
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
# the correct way is to add the certificates it can be done easily (google the above error)


# list of public profile urls as seed_urls
seed_urls = ["https://www.linkedin.com/in/davidsawatzke","http://in.linkedin.com/in/rajeevreddy"]

max_num_urls_before_pausing = 10

pause_time = 20																		# pause time in sec

FileUtils.mkdir_p 'output'

=begin
filename will be full name converted in '_' format (eg: 'Test User' will be 'test_user.json') and will be store in output folder

structure of json data

{
	"profile_url":"",
	"scraped_data":{
		"main_info":{
			"full_name":"",
			"haedline":"",
			"industry":"",
			"home_town":"",
			"connections":""
		},
		"profile_overview":{
			"education":
			"work":
			etc etc
			# this is dependent one each persons profile on the data they show
		},
		"groups":[],
		"organisations":[],
		"skills":[]
	}
}
=end

seed_urls.each do |url|

	temp = {}

	temp[:profile_url] = url

	temp[:scraped_data] = {}

	doc = Nokogiri::HTML(open(url))

	temp[:scraped_data][:main_info] = {}

	temp[:scraped_data][:main_info][:full_name] = fullname = doc.css('.full-name').text 
	temp[:scraped_data][:main_info][:headline] = doc.css('#headline').text								# headline/present industry
	temp[:scraped_data][:main_info][:industry] = doc.css('.industry').text								# kind of industry/ field
	temp[:scraped_data][:main_info][:home_town] = doc.css('#location .locality').text					# location as in hometown
	temp[:scraped_data][:main_info][:connections] = doc.css('.member-connections strong').first.text	# number of connections

	temp[:scraped_data][:profile_overview] = {}

	trs = doc.css('.profile-overview-content table tr')

	trs.each do |tr|
		key = tr['id'].split('-')
		key.shift
		temp[:scraped_data][:profile_overview][key.join('_').to_s] = tr.css('td').text  				# we need to check if list exists and get more info like urls also
	end

	temp[:scraped_data][:groups] = []

	groupElems = doc.css('#groups strong') if doc.css('#groups strong')									# checking if an element with that css tag exists or not

	groupElems.each do |el|
		temp[:scraped_data][:groups].push(el.text)
	end

	temp[:scraped_data][:organisations] = doc.css('.organization p').text.split(', ')

	temp[:scraped_data][:skills] = []

	skillElems = doc.css(".endorse-item-name") if doc.css(".endorse-item-name")

	skillElems.each do |el|
		temp[:scraped_data][:skills].push(el.text)
	end

	filename = fullname.downcase!.split().join('_')
	File.open("output/#{filename}.json","w") do |f|
		f.puts JSON.pretty_generate(temp)
	end

	if (seed_urls.index(url) + 1) % max_num_urls_before_pausing == 0								  	# if ten urls are scraped then wait for 20 seconds before resuming
		sleep(pause_time)
	end

end