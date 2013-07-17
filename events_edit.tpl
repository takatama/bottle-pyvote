<h1>Modify the event:</h1>
<form method="post" action="/events/edit/{{event['id']}}">
  <p>Name: <input type="text" name="name" size="30" value="{{event['name']}}" /></p>
  <p>Description:</p><p><textarea name="description" cols="40" rows="10">{{event['description']}}</textarea></p>
  <p>User score:<input type="text" name="user_score" size="2" value="{{event['user_score']}}" /></p>
  <p>Team score:<input type="text" name="team_score" size="2" value="{{event['team_score']}}" /></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
<form method="post" action="/events/delete/{{event['id']}}" onsubmit="return confirm('Are you really delete this event?');">
  <p><input class="btn btn-danger" type="submit" value="Delete this event"></p>
</form>
%rebase layout title="Edit the event"
