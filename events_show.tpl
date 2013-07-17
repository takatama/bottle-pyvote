<h1>{{name}}</h1>
<p>{{description}}</p>
<dl>
%for team in teams:
  %if team['score']:
    <form method="post" action="/users/vote/{{id}}/{{team['id']}}/0">
      <dt><a href="/teams/edit/{{team['id']}}">{{team['name']}}</a> [voted] <input type="submit" value="cancel" /></dt>
      <dd>{{team['description']}}</dd>
    </form>
  %else:
    <form method="post" action="/users/vote/{{id}}/{{team['id']}}/1">
      <dt><a href="/teams/edit/{{team['id']}}">{{team['name']}}</a> <input type="submit" value="vote" /></dt>
      <dd>{{team['description']}}</dd>
    </form>
  %end
%end
</dl>
<form method="get" action="/teams/new/{{id}}">
  <input type="submit" value="add a team" />
</form>
%rebase layout title='Event details'
