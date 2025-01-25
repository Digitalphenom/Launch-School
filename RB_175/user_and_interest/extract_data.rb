# frozen_string_literal: true

require 'yaml'

EMAILS = %w[hotmail yahoo google gmail].freeze

def extract_data
  @yaml = YAML.load_file('users.yaml')

  [
    find_data(:name),
    find_data(:email),
    find_data(:interests)
  ]
end

def find_names_from_email
  email = find_data(:email)
  extract_full_name(email)
end

def find_data(type)
  return find_names_from_email if type == :name

  @yaml.map { |_name, hash| hash[type] }
end

def extract_full_name(list_of_emails)
  user_names = []

  list_of_emails.each do |email|
    EMAILS.each do |provider|
      user_names << segment_and_capitalize(provider, email) if email.include?(provider)
    end
  end
  user_names
end

def segment_and_capitalize(provider, email)
  seperate_names = email.split(/@#{provider}.com/).join
  seperate_names.split('.').map(&:capitalize).join('-')
end
