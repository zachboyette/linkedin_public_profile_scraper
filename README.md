LinkedIn-PublicProfile-Scraper
=====================

> A scraper written in ruby using Nokogiri to get the data available in public profile.

There are two types of uses:
1. User can add various seed urls and the scraped data is stored in a output json file using the scrape.rb file.
2. In the scraperClass folder a scraper class is available which can be directly used in you project directly (an example.rb file is also provided for usage info)

#### Note: Please check the robots.txt file on linkedIn website before using this scraper regarding the legal stuff

Version
----
0.2

Installation
--------------

```sh
git clone git@github.com:drreddy/linkedin_public_profile_scraper.git
cd linkedin_public_profile_scraper
bundle install
```

##### If you use scrape.rb file, the output will be generated as a full_name.json file in 'output' folder (the program will create the folder if not exists)
---

Output Data (in full_name.json file)
--------------

```sh
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
			"education": "",
			"work": "",
			# this is dependent one each persons profile on the data they show
		},
		"groups":[],
		"organisations":[],
		"skills":[]
	}
}
```

##### If you use the scraper class in your project, a hash will be returned by the class, the schema of which is same as above.


License
----

MIT

**Free Software, Hell Yeah!**