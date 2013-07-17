<h1>Edit the team:</h1>
<form method="post" action="/teams/edit/{{team['id']}}">
  <p>Name: <input type="text" name="name" size="30" value="{{team['name']}}"/></p>
  <p>Description:</p><p><textarea name="description" cols="50" rows="10">{{team['description']}}</textarea></p>
%if message:
  <p>{{message}}</p>
%end
  <p><input type="submit" value="Update"></p>
</form>
<form method="post" action="/teams/delete/{{team['id']}}" onsubmit="return confirm('Are you really delete this team?');">
  <p><input class="btn btn-danger" type="submit" value="Delete this team" /></p>
</form>
%rebase layout title="Edit the team"
