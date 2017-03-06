namespace :task do
  desc "Creates fake task object"
  task :create, [:count] => :environment do |_, args|
    args.with_defaults(count: 1)
    count = args[:count].to_i
    counter = 0
    users_ids = all_users_ids

    abort("Error! Count must be Integer and greater than 0") if count < 1
    abort("No users in database") if users_ids.empty?

    count.times do
      counter += 1 if create_task(users_ids)
    end

    puts "Was created #{counter} tasks"
  end

  private

  def all_users_ids
    User.pluck(:id)
  end

  def create_task(users_ids)
    states = %w(new started finished)
    files = %w(ruby.jpeg simple.txt)

    params = {
      name: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      user_id: users_ids.sample,
      state: states.sample,
      attachment_attributes: { file: File.open("#{Rails.root}/spec/files/#{files.sample}") }
    }

    Task.new(params).save
  end
end
