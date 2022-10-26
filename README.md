With this project you can learn any language.
here website: https://run-language.herokuapp.com/articles/5/renglish

launch:     
1) for translate text using amazon translate(gem 'aws-sdk-translate',) so you need to register account,
set up IAM, generate pair of aws access key  and set them as environment variables(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY,
AWS_REGION), guide: https://docs.aws.amazon.com/translate/latest/dg/getting-started.html.
2) run standard bundle install and rails db:migrate

Deployment: there shouldn`t be any problem to deploy it on heroku, just dont forget set up environment variables, aws give you 
free 2 million character per month so  recommend to set up threshold alarm, to do this search in aws console - CloudWatch.
Also in production avatars storing in aws s3 so you need create there bucket and add environment variable AWS_BUCKET.
