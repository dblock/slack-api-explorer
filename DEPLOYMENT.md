### Slack-Metabot

[![Add to Slack](https://platform.slack-edge.com/img/add_to_slack@2x.png)](http://slack-metabot.herokuapp.com)

## Deploy Your Own Slack-Metabot

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/dblock/slack-metabot)

### MongoDB

Deploy slack-metabot to Heroku and add a MongoLab or Compose MongoDB provider. You can use both free and paid tiers.

### Environment

#### SLACK_API_TOKEN

If your bot servces one team, create a new bot integration on Slack and set `SLACK_API_TOKEN` from the bot integration settings on Slack. The first time you start the service it will automatically create a team using this token.

```
heroku config:add SLACK_API_TOKEN=...
```

#### Database Backups

MongoLab and MongoHQ ensure a system-level backup. You might find it handy to backup the data elsewhere occasionally. If you can run `rake db:heroku:backup[app]` locally as long as you can execute `heroku config --app=...` as well. This creates a `.tar.gz` file from a MongoDB database configured on the Heroku `app` application.