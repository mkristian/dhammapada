ixtlan-translations
-------------

* [![Build Status](https://secure.travis-ci.org/mkristian/dhammapada-app.png)](http://travis-ci.org/mkristian/dhammapada-app) - pending no tests yet
* [![Dependency Status](https://gemnasium.com/mkristian/dhammapada-app.png)](https://gemnasium.com/mkristian/dhammapada-app)
* [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/mkristian/dhammapada-app)

getting started - developement
==============================

install your gems

    bundle install

get the development database in place

    rake db:automigrate db:seed
	
start rackup

	rackup
	
or shotgun
   
    shutgun
	
for faster startup (only unix like OS) setup your load_path from the Gemfile.lock

    bin/gemfile_to_bin_load_path

now use the run-ruby script

    bin/run_ruby -S rackup

or shutgun

    bin/run_ruby -S shotgun

URLs
----

* wget http://localhost:9292/dhammapada -O - --header='Accept: application/x-yaml'

* wget http://localhost:9292/dhammapada/max_muller -O - --header='Accept: application/x-yaml'

* wget http://localhost:9292/dhammapada/john_richards/chapter/3 -O - --header='Accept: application/x-yaml'

* wget http://localhost:9292/dhammapada/max_muller/verse/333 -O - --header='Accept: application/json'

**note1**: onle json and yaml output is supported (did not find a suitable xml library for providing Hash to XML conversion - ActiveSupport feels to big for such a thing)

**note2**: extension will take preference before Accept header.

**note3**: there is not dhammapada.json or dhammapada.yaml !!

Protected URLs
--------------

after login with cookie

* wget http://localhost:9292/audits -O - --header='Accept: application/x-yaml'

* wget http://localhost:9292/audits/2.json -O -

* wget http://localhost:9292/errors.yaml -O -

* wget http://localhost:9292/errors/2 -O - --header='Accept: application/json'

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

meta-fu
-------

enjoy :) 

