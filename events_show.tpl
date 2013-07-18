<h1>{{name}}</h1>
<p>{{description}}</p>
<dl>
%for team in teams:
  %if team['score']:
    <form id="vote" method="post" action="/users/vote/{{id}}/{{team['id']}}/0">
      <dt><a href="/teams/edit/{{team['id']}}">{{team['name']}}</a> [{{team['score']}} votes] <input type="submit" value="vote" onclick="score({{team['id']}}, {{team['score']}} + 1);" /> <input type="submit" value="cancel" onclick="score({{team['id']}}, 0);" /></dt>
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
<script>
function score(team_id, s) {
  document.getElementById('vote').action = '/users/vote/{{id}}/' + team_id + '/' + s;
}
</script>
%rebase layout title='Event details'
