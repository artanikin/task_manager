if ENV["RAILS_ENV"] == "test"
  require "simplecov"
  SimpleCov.start("rails") do
    coverage_dir("public/coverage")

    add_filter do |source_file|
      source_file.lines.count < 5
    end
  end
end

%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
).each { |path| Spring.watch(path) }
