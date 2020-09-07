# Log parser

Ruby script that parses log entries of the following format: "<webpage_url> <ip_address>".

To run tests simply call
```
rspec
```

To run script itself run:
```
ruby parser.rb <path_to_log_file>
```

There is a log file in root directory so script can be called as:
```
ruby parser.rb webserver.log
```

Script produces 2 files: `sorted_by_page_views.txt` and `sorted_by_unique_views.txt` which contain list of page views and list of unique page views sorted by views number in a descending order.

**parser.rb**

`Parser` class is an entry point of the script. It calls `LogParser` class with command-line arguments.

**app/log_parser.rb**

`LogParser` class checks if there are any command-line arguments for script to work on and checks if provided file exists. Logs an error message and stops the executon. In case if there is a file to work on calls `LogProcessor` class passing file path to it.


**app/log_processor.rb**

`LogProcessor` class is the brains of the script. This class reads given file line by line. For every log entry from the log file it aggregates visits and unique visits and then saves results into 2 files.

**app/entry_parser.rb**

`EntryParser` class is basically a `LogEntry` object. It splits a given string by space character and treats first part as an page URL and second as an IP address.

**app/entry_counter.rb**

`EntryCounter` class adds a log entry to a given hash of entries or updates visits number if there the web page was seen previously. `#count!` method mutates a given hash object.

**app/page_visits_sorter.rb**

`PageVisitsSorter` class sorts a given array of arrays by last value in a reverse order. `#sort` method produces sorted copy of a given array.

**app/output_saver.rb**

`OutputSaver` class formats and saves given data into a file line by line.

## Ways to improve
- Introduce a `LogEntry` class model and work with a model rather than random arrays. This will help to improve code readability. Also, it would be a right place to add a validations for log entry format.
- add validations for log format. Right now there is a spit by space character only. I think it would be better to have a regex for to detect a page url and an IP address. Script then will be more flexible and will be able to work with more complex log files.
