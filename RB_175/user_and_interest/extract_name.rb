EMAILS = %w(hotmail.com yahoo.com google.com gmail.com)

# extract data
  # find_keyword
    # find name
    # find email
    # find content

def extract_name(ele)
  count = 0
  user_name = []

  File.new('users.yaml').read.split("\n").each do |element|
    user_name << find_name(element) if element.include?("email")
  end
  user_name
end

def find_name(element)
  email = find_email(element)
  user_name = find_username(email)
  seperate_username(user_name)
end

def find_email(ele)
  ele.strip.split(/:/).select do |ele|
    ele.include?("@")
  end.join.strip
end

def find_username(email)
  user_name = ''
  EMAILS.each do |provider|
    if email.include?(provider)
      user_name << email.split(/@#{provider}/).join 
    end
  end
  user_name
end

def seperate_username(user_name)
  user_name.split.map do |name|
    name.split(".").map(&:capitalize)
  end.flatten
end
