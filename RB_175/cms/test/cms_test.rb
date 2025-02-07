ENV['RACK_ENV'] = 'test'

# Dir.chdir("..") unless Dir.pwd.end_with?("cms")

require_relative '../cms'

require 'minitest/autorun'
require 'rack/test'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_equal true, last_response.body.match?(/history|changes|about/)
  end

  def test_history
    get '/history.txt'

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    contents = File.readlines('files/history.txt')
    assert_equal contents.join, last_response.body
  end

  def test_changes
    get '/changes.txt'

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    contents = File.readlines('files/changes.txt')
    assert_equal contents.join, last_response.body
  end

  def test_dynamic_filename
    get '/notafile.ext'
    assert_equal 302, last_response.status
    assert_raises StandardError do
      File.readlines("files/#{doc}")
    end

    get last_response['Location']
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'notafile.ext does not exist'

    get '/'
    refute_includes last_response.body, 'notafile.ext does not exist'
  end

  def test_viewing_markdown_document
    get '/about.md'
    assert_equal 200, last_response.status
    assert_equal 'text/html', last_response['Content-Type']

    File.readlines('files/about.md')
    assert_includes last_response.body, '<h1>Ruby is</h1>'
  end
end
