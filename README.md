## ContAT, frankly, turdy, and sprankly friendly contact app.

#### Disclosure

I know deadline has taken the horse and passed through Uskudar, 
but I enjoyed the development, learned some new bunch of stuff, and satisfied with the result. 
Although there are plenty of things to improve, I think current state will be just enough.

I have noted the things that I would do next if this was a long-term project, please check by.(below)

#### Getting Started

Bootstraping application is pretty straightforward. There is no external dependency.

- Clone repository; `git clone https://github.com/monkegjinni/contat.git`
- Cd into it;	  `cd contat`
- Bootstrap;	  `bundle install && rake db:migrate`
- Run tests;	  `rake db:test:prepare && rspec`
- Run server;	  `rails s`


#### Further Improvements

* More test coverage for importing contacts from file.
* Add async js integrations tests that covers front-end backbone functionality.
* Cleanup unused metrostrap styles.
* Refactor inline modules at Contact Model to their own files.
* Improve UX on updating contacts.
* Start to write chef and capistrano recipes for early-stage environment.


### Ok, Hope that It's not too late. Just Don't Panic!
