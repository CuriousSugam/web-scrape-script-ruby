# web-scrape-script-ruby

### Clone the repository
Clone the repository as:
```shell
git clone git@github.com:CuriousSugam/web-scrape-script-ruby.git
```

### Run the script
```shell
docker build -t scraper .
```
After the docker build is complete, you can the run the container as:
```shell
docker run -i scraper bash
```
This will interactively execute the docker container and you'll be able to run commands in bash.
Now, run the script as:
* Fetch and save the urls in an html file.
```shell
./app.rb stackoverflow.com http://www.google.com
```
* Display the metadata for the given urls along with fetching and saving the urls:
```shell
./app.rb --metadata stackoverflow.com http://www.google.com
```

### Run specs
```shell
rspec spec/
```

### Enhancements
1. I have not added in the specs for the all services. This is a must for a production grade code.
2. I have assumed there won't be much of a data so intead of using a database I've stored the information in a file.
3. The generated html files could be saved in a folder so that these files are not scattered in root path.
4. I've not fetched all the assets of the web page so that it could be run locally without breaking the pages.



