# Temper

A gem for a slightly smarter temporary file and temporary directory maintenance. It combines the best parts of Upfile from paperclip and Rack::Multipart::UploadedFile from rack.

## Installation

Add this line to your application's Gemfile:

    gem 'temper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install temper

## Usage

If you want a tempfile that can hold an `original_filename` and `content_type` just do this:

	Temper::File.new(:original_filename => "my_file.txt")

or

	Temper::File.new(:original_filename => "foo.xls", :content_type => "application/vnd.ms-excel")
	
or if you want to use an existing file as a base:

	Temper::File.new(:content => "/path/to/a/file", :original_filename => "foo.xls", :content_type => "application/vnd.ms-excel")
	
There's also a StringIO wrapper:

	Temper:StringIO.new("some content", :original_filename => "foobar.csv")
	
There's a handy shortcut for both of the above:

	Temper::Fi.new(:original_filename => "my_file.txt")
	Temper::Si.new("some content", :original_filename => "foobar.csv")

There's also a `fingerprint` method that will calculate the MD5 hash of the content.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
