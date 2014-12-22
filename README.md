LinkedIn-PublicProfile-Scraper
=====================

> A scraper written in ruby using Nokogiri to get the data available in public profile. User can add various seed urls and the scraped data is stored in a output json file. 

Version
----
0.1

Installation
--------------

```sh
git clone git@github.com:drreddy/linkedin_public_profile_scraper.git
cd linkedin_public_profile_scraper
bundle install
ruby scrape.rb
```

##### The output will be generated as a full_name.json file in 'output' folder (the program will create the folder if not exists)
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

License
----

MIT

**Free Software, Hell Yeah!**
