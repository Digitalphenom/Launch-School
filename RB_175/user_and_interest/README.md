### Basic Code Challenge
This app uses Sinatra and Rake to create a basic page that lists users and they're interests and dynamically displays them on the page.

The page uses `yaml` as the means for displaying and determining total users.

*YAML Format*

To add a new user/interest, add to the `user.yaml` in the following format
*First line of email must contain first name and match :Name:*

:Name:
  :email: first_name.last_name@email_provider.com
  :interests:
  - one
  - two
  - three

Then enter *rake add_user* from terminal.
