##Zendesk - Ticketing Viewer

The most exciting console app you'll ever find! (Other than the toy-robot)

###ABOUT

This was a technical test done for zendesk. It involves connecting to the zendesk ticketing API and then showing the results in the format of all tickets and then one particular ticket.

###REQUIREMENTS AND BASIC APPROACH

######Connect to the zendesk API
- The Zendesk ruby gem was used to connect to the API.
- Initially I was going to use HTTParty however, the gem was simpler and I figured best to use Zendesk's own code

######List out all 100 results.
- This was done used a method called 'index'.
- Index was chosen as the name as to follow RESTful design
- This method calls the Zendesk API - returns the results to the index controller and stores them as @tickets. The view 'tickets/index' then iterates through the results using the .each method.

3. The 100 results needed to be capped at 25 and have a way to page through the results
- This was a touch tricky. I looked into building my own code for it but found the gem for 'will_paginate'
- will_paginate was initially a touch tricky as I wasn't passing a class but rather an array. I found I had to require 'will_paginate/array' to fix the issues I was having
- In the end the gem works well. It allows you to select the starting page, the results per page as well providing a nice method to tab through the pages.
- The limitation in using 'will_paginate' is it seems the solution is asking the API for 100 tickets on every request rather than 25. I decided trying to fix this would be overcomplicating the solution so I didn't look into it!

4. List 1 results
- Similar to above yet with a method called 'show'.
- 1 answer is shown by calling the API and asking it for the params[:id]

5. Must handle the API being offline (checked by turning WI-FI off)
- With the WI-FI off the program needed to not crash and ideally give a meaningful error
- The WI-FI being off caused this error 'ZendeskAPI::Error::NetworkError'
- The solution used was to rescue this error with a function called zendesk_offline
- This function renders this zendesk_offline page
- This is a contentious solution. I like it however, I know not everyone like rescue statements!  
- I feel this is highly unlikely in it's use to hide an error.
- The other considered solution was to render an alert saying 'zendesk_offline'


###HOW TO RUN

1. Download this repo by clicking the download as zip button
2. Unzip the file
4. Ensure you have at least v2.2.2 of ruby installed. You can check by running ruby -v in your terminal/console. Ruby can be downloaded at https://www.ruby-lang.org/en/downloads/
5. With ruby installed navigate to the downloaded unzipped file with your terminal
6. Once in the folder type ruby 'rails s' to start the servers
7. In your browser navigate to 'http://localhost:3000/'
8. You can play around with the program here.
9. To see how the program functions with the API offline you can turn off your internet and do the same.

Note it's a little slow due to the nature of constantly fetching data. I didn't want
to overcomplicate the solution by looking into caching or a database

###CHALLENGES

- Learning rspec properly :)
- Learning about error handling
- Learning how to use the 'will_paginate' gem

## HAVE FUN!
