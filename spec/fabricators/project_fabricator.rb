Fabricator(:project) do
  url { ["https://github.com/glenn0/in_the_wild",
         "https://github.com/jnicklas/capybara/blob/master/spec/basic_node_spec.rb",
         "https://github.com/ryanto/acts_as_votable/commits/master",
         "https://github.com/bblimke/webmock/graphs/contributors"].sample }
end