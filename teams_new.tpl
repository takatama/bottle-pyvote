<h1>Create a team in the event {{event_name}}:</h1>
<form method="post" action="/teams/new/{{event_id}}">
  <p>Name: <input type="text" name="name" size="30" /></p>
  <p>Description:</p><p><textarea name="description" cols="40" rows="30"></textarea></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit"></p>
</form>
