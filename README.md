## In the Wild

There's lots of good code out there to look at when you're learning. The problem is, if you're a learner, how do you know what's good? In the Wild is a web app to help surface good code.

The initial focus is on RSpec.

### Configuration

The project is setup to use Postgres in all environment contexts. If you'd prefer to use SQLite, the gem and database.yml config are included, but commented out.

### How does it work?

Spin up the application or try: http://rspecinthewild.herokuapp.com/

Sign in with your GitHub account or create an account using an email address and password.

Find a GitHub project which includes some good RSpec tests. Post the repo link into the submit box.

In the Wild will ask the RepoFetcher class to hit the GitHub API and collect the project name, description, owner details and iterate through the /spec directory to generate tags based on the sub-directories. eg. Controllers, Features, Models might be generated as tags. This tagging method isn't perfect, but it gives an indication of the scope of the tests used by each project.

Your submission will be listed on the home page.

With submitted repos you can:
- Star to mark the repos you think have great RSpec/test examples.
- More features to come!


### Which features haven't been built yet?

See the Issues list on GitHub for upcoming enhancements and bug fixes.

Something you'd like to see? Do a pull request or raise a request through Issues.