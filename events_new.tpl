<h1>Create an event:</h1>
<form method="post" action="/events/new">
  <p>Name: <input type="text" name="name" size="30" /></p>
  <p>Description:</p><p><textarea name="description" cols="40" rows="30"></textarea></p>
  <p>User score:<input type="text" name="user_score" size="2" /></p>
  <p>Team score:<input type="text" name="team_score" size="2" /></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
