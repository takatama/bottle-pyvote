<h1>{{name}}</h1>
<p>{{description}}</p>
<dl>
%for team in teams:
  %if team['score']:
    <form method="post" action="/users/vote/{{id}}/{{team['id']}}/0">
      <dt>{{team['name']}} [voted] <input type="submit" value="cancel" /></dt>
      <dd>{{team['description']}}</dd>
    </form>
  %else:
    <form method="post" action="/users/vote/{{id}}/{{team['id']}}/1">
      <dt>{{team['name']}}<input type="submit" value="vote" /></dt>
      <dd>{{team['description']}}</dd>
    </form>
  %end
%end
</dl>
<form method="get" action="/teams/new/{{id}}">
  <input type="submit" value="add a team" />
</form>
