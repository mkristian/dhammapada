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
	
for faster startup (only unix like OS) setup your load_path from the Gemfile.lock which is used by `bin/run_ruby` (without bundler startup)

    bin/gemfile_to_bin_load_path

now use the run-ruby script

    bin/run_ruby -S rackup

or shutgun

    bin/run_ruby -S shotgun

URLs
----

both translators complete

* wget http://localhost:9292/dhammapada -O - --header='Accept: application/x-yaml'

only Max Müller's version

* wget http://localhost:9292/dhammapada/max_muller -O - --header='Accept: application/x-yaml'

chapter 3 of John Richard's translaton

* wget http://localhost:9292/dhammapada/john_richards/chapter/3 -O - --header='Accept: application/x-yaml'

verse 333 from Max Müller

* wget http://localhost:9292/dhammapada/max_muller/verse/333 -O - --header='Accept: application/json'

random verse from either translator

* wget http://localhost:9292/dhammapada/random -O - --header='Accept: application/x-yaml'

**note1**: onle json and yaml output is supported (did not find a suitable xml library for providing Hash to XML conversion - ActiveSupport feels to big for such a thing)

**note2**: extension will take preference before Accept header.

**note3**: there is not dhammapada.json or dhammapada.yaml !!

Password protected part
--------------

password for development
========================

running on localhost allows to login with an empty password and the following sernames:

* root
* guest


passwords with external authentication
======================================

using authentication from ixtlan-users you need to start that server first:

    cd ../ixtlan-users
    rails s
	
in another terminal start you application with

	cd ../ixtlan-translatons
	SSO=true bin/run-ruby -S rackup
	
for the password just use **password forgotten** and look out for the email text in the ixtlan-users console. there you will find a new password :)	

URL
---

before login without cookie

* wget http://localhost:9292/session/reset_password -S -O - --header='Accept: application/x-yaml' --save-cookies cookies.txt --keep-session-cookies --post-data='login=root'

* wget http://localhost:9292/session -S -O - --header='Accept: application/x-yaml' --save-cookies cookies.txt --keep-session-cookies --post-data='login=root&password='

after login with cookie

* wget http://localhost:9292/audits -S -O - --header='Accept: application/x-yaml' --save-cookies cookies.txt --load-cookies cookies.txt --keep-session-cookies

* wget http://localhost:9292/audits/2.json -S -O - --save-cookies cookies.txt --load-cookies cookies.txt --keep-session-cookies

* wget http://localhost:9292/errors.yaml -O - --save-cookies cookies.txt --load-cookies cookies.txt --keep-session-cookies

* wget http://localhost:9292/errors/2 -O - --header='Accept: application/json' --header='Accept: application/x-yaml' --save-cookies cookies.txt --load-cookes cookes.txt --keep-session-cookies

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

