task scrape: :environment do
  require 'open-uri'
  require 'pry'

  URL = 'https://jobs.lever.co/stackadapt'

  doc = Nokogiri::HTML(open(URL))

  postings = doc.search('div.posting')

  postings.each do |p|
    job_title = p.search('a.posting-title > h5').text
    location = p.search('a.posting-title > div > span')[0].text
    team = p.search('a.posting-title > div > span')[1].text
    url = p.search('a.posting-title')[0]['href']

    subpage = Nokogiri::HTML(open(url))
    description = subpage.css('div.section.page-centered')[1].text

    # Skip persisting job if it already exists in db
    if Job.where(:job_title => job_title, :location => location, :team => team, :url => url, :description => description).count <= 0
      Job.create(
        :job_title => job_title,
        :location => location,
        :team => team,
        :url => url,
        :description => description

      )
      puts 'Added: ' + (job_title ? job_title : '')
    else
      puts 'Skipped: ' + (job_title ? job_title : '')
    end
  end
end
