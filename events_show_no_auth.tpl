<h1>{{name}}</h1>
<p>{{description}}</p>
<p>Voting needs <a href="/users/login?to=/events/show/{{id}}">login</a>.</p>
<dl>
%for team in teams:
    <form method="post" action="/users/vote/{{id}}/{{team['id']}}/1">
      <dt>{{team['name']}}<input type="submit" value="vote" /></dt>
      <dd>{{team['description']}}</dd>
    </form>
%end
</dl>
<form method="post" action="/teams/new/{{id}}">
  <input type="submit" value="add a team" />
</form>
