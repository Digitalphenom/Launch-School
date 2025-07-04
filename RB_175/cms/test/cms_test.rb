ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'
require 'fileutils'

Minitest::Reporters.use!

require_relative '../cms'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end
ff
  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = '')
    File.open(File.join(data_path, name), 'w') do |file|
      file.write(content)
    end
  end

  def admin_session
    { 'rack.session' => { user_state: true} }
  end

  def invalid_session
    { 'rack.session' => { user_state: false} }
  end


  #◟◅◸◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◅▻◞

  def test_index
    create_document 'about.md'
    create_document 'changes.txt'

    get '/'


    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'about.md'
    assert_includes last_response.body, 'changes.txt'
  end

  def test_viewing_text_document
    create_document 'history.txt', 'Ruby 0.95 released'

    get '/history.txt'

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    assert_includes last_response.body, 'Ruby 0.95 released'
  end

  def test_viewing_markdown_document
    create_document 'about.md', '# Ruby is...'

    get '/about.md'

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<h1>Ruby is...</h1>'
  end

  def test_document_not_found
    get '/notafile.ext'

    assert_equal 302, last_response.status
    assert_equal 'notafile.ext does not exist.', session[:message]
  end

  def test_editing_document
    create_document 'changes.txt'

    get 'changes.txt/edit', {}, admin_session

    assert_equal 200, last_response.status

    post '/changes.txt', document: 'new content'
    assert_equal 302, last_response.status

    get '/'
    assert_includes last_response.body, 'changes.txt has been updated.'
  end

 #def test_updating_document
 #  post '/changes.txt', content: 'new content'

 #  assert_equal 302, last_response.status
 #  assert_equal 'changes.txt has been updated.', session[:message]

 #  follow_redirect!t

 #  get '/changes.txt'
 #  assert_equal 200, last_response.status
 #  assert_includes last_response.body, 'new content'
 #end

  def test_new
    get '/new', {}, admin_session

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, '<input'
    assert_includes last_response.body, 'Add a new document'
    
    get '/new', {}, invalid_session
    assert_equal 302, last_response.status

    follow_redirect!
    assert_includes last_response.body, 'You must login'
  end

  def test_create_document
    post '/create', document: 'test.txt'
    assert_equal 302, last_response.status
    assert_equal 'test.txt has been created.', session[:message]

    follow_redirect!

    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'test.txt'
  end

  def test_create_empty_document
    post '/create', {document: ''}, admin_session
    assert_equal 422, last_response.status

    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'A name is required'
  end

  def test_valid_extension
    post '/create', document: 'invalid'
    assert_equal 422, last_response.status

    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_includes last_response.body, 'Enter a valid extension'
  end

  def test_delete_document
    create_document 'document.txt'

    post '/document.txt/delete', {}, admin_session

    assert_equal 302, last_response.status
    assert_equal 'document.txt has been deleted.', session[:message]
    
    follow_redirect!

    refute_includes last_response.body, 'test.txt'
  end

  def test_login_page
    get '/users/login'
    assert_equal 200, last_response.status
    assert_includes last_response.body, '>Sign In</button>'
  end

  def test_valid_login    

    post '/users/login', username: 'Admin', password: 'secret'
    assert_equal 302, last_response.status
    assert_equal session[:message], 'Welcome!'
    
    follow_redirect!
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'Admin'
  end

  def test_incorrect_login
    load_user_credentials

    post '/users/login', username: 'sedrick', password: 'max'
    assert_equal 422, last_response.status

    refute session[:user_state]
    assert_includes last_response.body , 'Invalid credentials'
  end

  def test_logout
    get '/', {}, { 'rack.session' => { user_state: true, username: 'Admin' } } 
    assert_includes last_response.body, 'Admin'

    post '/users/logout'
    assert_equal 'You have been loged out.', session[:message]

    follow_redirect!
    refute session[:user_state]
    assert_includes last_response.body, 'Sign In'
  end
end
