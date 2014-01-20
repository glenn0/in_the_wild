Fabricator(:project) do
  url { ["https://github.com/glenn0/in_the_wild",
         "https://github.com/jnicklas/capybara/blob/master/spec/basic_node_spec.rb",
         "https://github.com/rspec/rspec/tree/2-99-maintenance",
         "https://github.com/bblimke/webmock/graphs/contributors"].sample }
end